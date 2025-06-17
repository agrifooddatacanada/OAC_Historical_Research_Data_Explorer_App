
explorer_list$networkTab_ui <- tabItem(
  tabName = "network_tab",
  
  tags$head(tags$style(HTML("
  /* Style for the picker input button */
  .bootstrap-select .dropdown-toggle {
    border-radius: .25rem;
    min-height: calc(2.25rem + 2px);
    border: 1px solid #ced4da;
  }

  /* Align group headers (optgroup labels like College names) to the left */
  .dropdown-menu li.dropdown-header {
    text-align: left !important;
    font-weight: bold;
  }

  /* Align individual dropdown items (like Department names) to the left */
  .dropdown-menu.inner li a {
    text-align: left !important;
  }
  
  /* Visually hide column headers, but keep them accessible to screen reader users. */
  .hidden-column-headers .rt-thead {
  position: absolute;
  width: 1px;
  height: 1px;
  padding: 0;
  margin: -1px;
  overflow: hidden;
  clip: rect(0, 0, 0, 0);
  border: 0;
}
  "))),
  
  fluidRow(
    column(12,
           box(title = "Filter",
               status = "lightblue",
               solidHeader = FALSE,
               collapsible = FALSE,
               elevation = 1,
               width = 12,
               collapsed = FALSE,
               
               div(style ="margin-left: 10px;",
                   awesomeRadio(
                     inputId = "collegeDept_filter",
                     label = "Select One",
                     choices = c(
                       "College / Campus / Institution" = "CollegeName",
                       "Department / Research Centre" = "DepartmentName"
                     ),
                     selected = "CollegeName",
                     inline = TRUE
                   )
               ),
               
               uiOutput("dynamic_filter_ui")
           )
    )
  ),
  
  shinyjs::hidden(
    # Div to hold the content of the tab once a college/dept is selected
    div(
      id = "networkBox",
      fluidRow(
        column(12,
               box(
                 title = "Explore",
                 status = "lightblue",
                 solidHeader = FALSE,
                 collapsible = FALSE,
                 elevation = 1,
                 width = 12,
                 collapsed = FALSE,
                 
                 div(style = "margin-left: 10px;",
                     awesomeRadio(
                       inputId = "event_type",
                       label = "View Network By",
                       choices = c("Keywords", "Authors"),
                       selected = "Keywords",
                       inline = TRUE
                     )
                 ),
                 
                 hr(),
                 fluidRow(
                   column(10,
                          withSpinner(visNetworkOutput(
                            "networkPlot",
                            width = "100%",
                            height = "800px"
                          ))
                   ),
                   column(2,
                          div(class = "custom-legend",
                              uiOutput("customLegend", 
                                       style = "display: flex; justify-content: center; align-items: center;
                            position: relative; top: 120px;")
                          )
                          
                   )
                 ),
                 hr(),
                 fluidRow(
                   column(12,
                          uiOutput("nodeInfo")
                   )
                 )
               )
        )
      )
    )
  )
)
  
  
  # Server Module for Network Tab
  explorer_list$networkTab_server <- function(input, output, session, study_data, shared_data, conn) {
    
    
    output$dynamic_filter_ui <- renderUI({
      req(input$collegeDept_filter, study_data())
      
      data <- study_data()
      
      
      if (input$collegeDept_filter == "DepartmentName") {
        # Group DepartmentName by CollegeName
        grouped_choices <- split(data$DepartmentName, data$CollegeName)
        
        # Convert each group to unique, sorted list
        grouped_choices <- lapply(grouped_choices, function(x) sort(unique((x))))
        
        choice_input <- grouped_choices
      } else {
        choice_input <- sort(unique(data$CollegeName))
      }
      
      div(
        style = "margin-left: 10px; margin-bottom: 4px;",
        virtualSelectInput(
          inputId = "select_dataverse",
          label = NULL,
          choices = choice_input,
          selected = NULL,
          multiple = TRUE,
          search = TRUE,
          dropboxWrapper = "body",
          width = "100%"
        )
      )
    })
    
    
    # Sync selected college/dept with reactiveVal shared_data for further use
    observe({
      shared_data$selected_collegeDept <- input$collegeDept_filter
    })
    
    # Sync selected dataverse with shared_data for further use
    observe({
      shared_data$selected_dataverse <- input$select_dataverse
    })
    
    # Show or hide the network box depending on selection
    observe({
      
      if (!is.null(input$select_dataverse) && length(input$select_dataverse) > 0) {
        shinyjs::show("networkBox")
      } else {
        shinyjs::hide("networkBox")
      }
    })
    
    
    # Reactive expression to filter data based on selected dataverse(s)
    shared_data$filtered_data <- reactive({
      req(study_data(), shared_data$selected_dataverse, shared_data$selected_collegeDept)
      
      # Filter the data based on the selected dataverse
      study_data() %>%
        dplyr::filter(.data[[shared_data$selected_collegeDept]] %in% shared_data$selected_dataverse)
    })
    
    # Fetch nodes data from the database based on the selected event type (Keywords or Authors)
    nodes_data <- reactive({
      req(input$event_type)  # Ensure input exists
      table_name <- paste0(input$event_type, "_node") # Construct table name dynamically
      dbGetQuery(conn, paste0("SELECT * FROM ", table_name)) # Query the nodes table
    })
    
    # Fetch edges data from the database based on the selected event type (Keywords or Authors)
    edges_data <- reactive({
      req(input$event_type) # Ensure input exists
      table_name <- paste0(input$event_type, "_edge")  # Construct table name dynamically
      dbGetQuery(conn, paste0("SELECT * FROM ", table_name)) # Query the nodes table
    })
    
    # Filter nodes based on selected college(s) or department(s)
    filteredNodes <- reactive({
      req(nodes_data(), shared_data$selected_dataverse, shared_data$selected_collegeDept)
      
      if (is.null(shared_data$selected_dataverse) || length(shared_data$selected_dataverse) == 0) {
        return(NULL)
      }
      
      df <- nodes_data() %>%
        filter(
          str_detect(
            .data[[shared_data$selected_collegeDept]],
            paste(shared_data$selected_dataverse, collapse = "|")
          )
        ) %>%
        mutate(
          color = case_when(
            shared_data$selected_collegeDept == "CollegeName" ~ CollegeColor,
            shared_data$selected_collegeDept == "DepartmentName" ~ DepartmentColor
          ),
          title = paste0(
            title, "<br>Affiliation(s): ", .data[[shared_data$selected_collegeDept]]
          )
        )
    })
    
    
    # Filter edges based on valid node IDs
    filteredEdges <- reactive({
      nodes <- filteredNodes()
      if (is.null(nodes)) return(NULL)
      
      valid_ids <- nodes$id
      edges_data() %>%
        filter(from %in% valid_ids & to %in% valid_ids)
    })
    
    # Legend output for the plots
    output$customLegend <- renderUI({
      req(filteredNodes(), shared_data$selected_dataverse,
          shared_data$selected_collegeDept)
      
      legend_data <- filteredNodes() %>%
        mutate(label = dplyr::case_when(
          color == "gray" ~ "Shared Across Multiple",
          TRUE ~ .data[[shared_data$selected_collegeDept]]
        )) %>%
        distinct(label, color) %>%
        arrange(label)
      
      absolutePanel(
        width = 320,
        top = 0,
        right = 0,
        draggable = TRUE,
        
        bs4Card(
          title = tags$div(
            "Network Legend",
            style = "text-align: center; font-size: 20px; font-weight: bold;"
          ),
          collapsible = TRUE,
          width = 12,
          solidHeader = TRUE,
          status = "lightblue",
          
          reactable(
            legend_data,
            columns = list(
              label = colDef(
                name = "",
                minWidth = 200
              ),
              color = colDef(
                name = "",
                cell = function(value) {
                  div(style = paste0("background-color:", value, 
                                     "; width: 20px; height: 20px; border-radius: 4px;"))
                },
                headerStyle = list(textAlign = "center"),
                style = list(textAlign = "right"),
                minWidth = 50
              )
            ),
            # Visually hide column headers
            class = "hidden-column-headers",
            width = "100%",
            outlined = FALSE,
            borderless = TRUE,
            sortable = FALSE
          )
        )
      )
    })
    
    # Render the network plot using the reactive dataset 'network_data_reactive()'
    output$networkPlot <- renderVisNetwork({
      req(
        filteredNodes(), 
        filteredEdges(), 
        shared_data$selected_collegeDept, 
        shared_data$selected_dataverse,
        length(shared_data$selected_dataverse) > 0  # This ensures something is actually selected
      )
      
      # Dynamically assign color based on selected_collegeDept
      color <- ifelse(shared_data$selected_collegeDept == "CollegeName",
                      filteredNodes()$CollegeColor,  # Use CollegeColor if College is selected
                      ifelse(shared_data$selected_collegeDept == "DepartmentName",
                             filteredNodes()$DepartmentColor))
      
      # Create the network plot
      visNetwork(filteredNodes(), filteredEdges(), width = "100%", height = "800px", 
                 main = "Connections Between Dataverses") %>%
        visNodes(
          size = 200,  # Default node size
          shape = "ellipse",  # Node shape
          borderWidth = 2,  # Border thickness
          color = list(
            background = color,  # Assign dynamic color based on CollegeColor or DepartmentColor
            border = "black",  # Black border for nodes
            highlight = "#ff0"  # Yellow highlight when selected
          ),
          labelHighlightBold = TRUE,  # Bold text on hover
          scaling = list(
            label = list(
              enabled = TRUE,
              min = 10,  # Minimum font size
              max = 30   # Maximum font size
            )
          ),
          font = list(
            color = "black",
            face = "bold",
            size = 50  # Font size for labels
          )
        ) %>%
        
        # Edge styling
        visEdges(smooth = FALSE) %>%
        
        # Enable options for highlighting nodes and selecting by ID
        visOptions(
          highlightNearest = TRUE,  # Highlight connected nodes when a node is selected
          nodesIdSelection = list(
            enabled = TRUE,  # Enable dropdown selection for nodes
            main = paste("Select by ", input$event_type),  # Dropdown label
            style = "width: 250px; height: 26px; margin-left: 
            20px; position: relative; top: -10px;"  # Moves box to the right
          )
        ) %>%
        
        # Apply a consistent layout using a random seed
        visLayout(randomSeed = 123) %>%
        
        # Define physics properties for the network layout
        visPhysics(
          solver = "forceAtlas2Based",  # Use Force Atlas 2 layout
          forceAtlas2Based = list(
            gravitationalConstant = -150,  # Adjust repulsion force
            avoidOverlap = 0.1  # Reduce node overlap
          ),
          stabilization = list(iterations = 600),  # Increase stabilization iterations
          timestep = 0.4,
          minVelocity = 70  # Stop movement when velocity is below threshold
        ) %>%
        
        # Interaction settings
        visInteraction(
          hover = FALSE,  # Disable hover tooltips
          navigationButtons = TRUE,  # Enable zoom and pan buttons
          keyboard = TRUE,  # Enable keyboard navigation
          tooltipDelay = 0  # No delay for tooltips
        ) %>%
        
        # Define click event behavior using JavaScript
        visEvents(click = glue::glue(
                  "function(nodes) {{
            if (nodes.nodes.length > 0) {{
              Shiny.setInputValue('selectedEvent', nodes.nodes[0], {{priority: 'event'}});
            }} else {{
              Shiny.setInputValue('selectedEvent', 'none', {{priority: 'event'}});
            }}
          }}"
        ))
    })
    
    # Event: Update UI based on selected node
    observeEvent(input$selectedEvent, {
      
      if (is.null(input$selectedEvent) || input$selectedEvent == "none") {
        output$nodeInfo <- renderUI({ NULL })
        return()
      }
      
      req(shared_data$filtered_data(), shared_data$selected_dataverse, input$selectedEvent, conn)
     
      # Get filtered data based on selected dataverse(s)
      data <- shared_data$filtered_data()
      
      # Determine which table to query (Keywords or Authors)
      table_name <- switch(input$event_type,
                           "Keywords" = "keywords_node",
                           "Authors" = "authors_node")
      
      # Fetch the event name from the database using selectedEvent (ID)
      selected_event_query <- paste0("SELECT label FROM ", table_name, " WHERE id = ?")
      selected_event <- dbGetQuery(conn, selected_event_query, params = list(input$selectedEvent))$label
      
      if (length(selected_event) == 0) {
        output$nodeInfo <- renderUI({
          tags$div(class = "alert alert-warning", "No node found in the database.")
        })
        return()
      }
      
      # Determine the correct column in the data for filtering
      event_column <- if (input$event_type == "Keywords") "Keywords" else "Authors"
      
      # Filter the data based on the selected event
      selected_data <- data %>%
        dplyr::filter(stringr::str_detect(.data[[event_column]],
                                          stringr::regex(selected_event, ignore_case = TRUE)))
      
      # Store filtered results for study selection
      shared_data$study_choices <- selected_data
      
      # Retrieve study titles and unique DOIs
      studies <- selected_data %>% dplyr::pull(Title)
      dois <- selected_data %>% dplyr::pull(DOI) %>% unique()
      
      # Generate DOI links if available
      if (length(dois) == 0) {
        doi_text <- "No DOI found."
      } else {
        doi_links <- sapply(dois, function(doi) {
          paste0('<a class="badge badge-info" href="https://doi.org/', doi, '" target="_blank">', doi, '</a>')
        })
        doi_text <- paste(doi_links, collapse = ", ")
      }
      
      # Prepare UI output based on event type
      if (input$event_type == "Authors") {
        collaborators <- selected_data %>%
          dplyr::pull(Authors) %>%
          stringr::str_split(",") %>%
          unlist() %>%
          stringr::str_trim() %>%
          unique() %>%
          setdiff(selected_event) %>%
          length()
        
        info_html <- tags$div(
          tags$p(tags$b("Author: "), selected_event),
          tags$p(tags$b("Number of associated studies: "), length(unique(studies))),
          tags$p(tags$b("Number of collaborators: "), collaborators),
          tags$p(tags$b("DOIs of studies: "), HTML(doi_text))
        )
      } else {
        info_html <- tags$div(
          tags$p(tags$b("Keyword: "), selected_event),
          tags$p(tags$b("Number of associated studies: "), length(unique(studies))),
          tags$p(tags$b("DOIs of studies: "), HTML(doi_text))
        )
      }
      
      # Update UI with selected event details
      output$nodeInfo <- renderUI({ info_html })
    })
  }
  
  