
# Define server for the app ----

server <- function(input, output, session) {
  
  #  Set up database connection once
  db_file <- "appData/Explorer_cache.db"
  conn <- get_db_conn(db_file)
  
  #  Create reactive value to store your study data
  study_data_val <- reactiveVal()
  
  #  Animate loading progress bar
  observe({
    # Simulated progress 0–90%
    for (i in seq(0, 90, by = 10)) {
      shinyjs::delay(i * 25, {
        shinyWidgets::updateProgressBar(session, "load_progress", value = i)
      })
    }
    
    # Finalize after delay: load real data
    shinyjs::delay(1000, {
      shinyWidgets::updateProgressBar(session, "load_progress", value = 95)
      
      # Fetch actual data
      data <- cache_raw_data(conn)
      study_data_val(data)
      
      shinyWidgets::updateProgressBar(session, "load_progress", value = 100)
      waiter_hide()
      
      # Define the final reactive study_data
      study_data <- reactive({
        req(study_data_val())
        study_data_val()
      })
      
      
      # Shared reactive values
      shared_data <- reactiveValues(
        study_choices = NULL,
        filtered_data = NULL,
        selected_dataverse = NULL,
        selected_collegeDept = NULL,
        file_list = NULL,
        full_paths = list()
      )
      
      
      # Initialize modules
      explorer_list$homeTab_server(input, output, session, study_data)
      explorer_list$networkTab_server(input, output, session, study_data, shared_data, conn)
      datareviewTab_server("data", study_data, shared_data)
      
      # Process & cache only new studies
      observeEvent(study_data(), {
        new_data <- study_data()
        
        processed_dois <- if (dbExistsTable(conn, "processed_studies")) {
          tbl(conn, "processed_studies") %>% distinct(DOI) %>% dplyr::pull(DOI)
        } else {
          character(0)
        }
        
        new_data_filtered <- new_data %>% dplyr::filter(!DOI %in% processed_dois)
        
        if (nrow(new_data_filtered) > 0) {
          message("Processing new study data...")
          process_and_cache_new_data(new_data_filtered, "Keywords", conn)
          process_and_cache_new_data(new_data_filtered, "Authors", conn)
          message("Data successfully processed and stored.")
          
          new_processed <- new_data_filtered %>% dplyr::select(DOI) %>% distinct()
          dbWriteTable(conn, "processed_studies", new_processed,
                       append = dbExistsTable(conn, "processed_studies"),
                       row.names = FALSE)
        } else {
          message("No new study data found. Skipping processing.")
        }
      })
    })
  })
  
  #  Show cache update time
  output$update_notification <- renderUI({
    if ("update_info" %in% dbListTables(conn)) {
      update_info <- dbReadTable(conn, "update_info")
      if (nrow(update_info) > 0) {
        last_update <- as.POSIXct(update_info$last_update[1])
        time_diff <- difftime(Sys.time(), last_update, units = "hours")
        
        if (!is.na(time_diff) && time_diff < 48) {
          return(notificationItem(
            text = paste0("Cache updated ", round(time_diff, 1), " hours ago")
          ))
        }
      }
    }
    
    notificationItem(
      text = "⚠️ No recent update found. Data may be outdated."
    )
  })
  
  # 5. Disconnect DB on session end
  session$onSessionEnded(function() {
    dbDisconnect(conn)
  })
}
