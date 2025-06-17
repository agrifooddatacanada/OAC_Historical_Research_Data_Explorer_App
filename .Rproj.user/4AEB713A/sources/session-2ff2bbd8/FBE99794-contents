# ---- This module defines the UI and server logic for the overview tabpanel

overviewUI_module <- function(id){
  ns <- NS(id)
  tagList(
    fluidRow(
      column(
        12,
        # Table output for showing study details
        withSpinner(DT::dataTableOutput(ns("study_details")))
      )
    )
  )
}

overviewServer_module <- function(id, input_study_select, study_data, shared_data) {
  moduleServer(id, function(input, output, session){
    ns <- session$ns


    #  From here, dynamically choose between study_data and shared_data$filtered_data()
    # Show study details based on selection
    output$study_details <- DT::renderDataTable({

      # Ensure that a selection has been made and study_data() is available
      req(study_data(), input_study_select())  

       

      # Filter data first before transposing
      overview_data <- study_data()  %>%
        mutate(PeriodCovered = str_replace_all(PeriodCovered, "/", " - ")) %>%
        mutate(DOI = paste0('<a class="badge badge-info" href="https://doi.org/',
                            DOI, '" target="_blank">', DOI, '</a>')) %>%
        mutate(DataLicense = paste0('<a class="badge badge-info" href="',DataLicense, 
                                    '"target="_blank">',DataLicense, '</a>')) %>% 
        filter(Title == input_study_select()) %>% # Filter data first before transposing
        rename_with(~ gsub("([a-z])([A-Z])", "\\1 \\2", .x)) %>% # Adds spaces to camel case column names  
        t() # Transpose the filtered data

      # Render the datatable
      datatable(overview_data,
                escape = FALSE,
                rownames = TRUE,
                colnames = c("Parameter", "Value"),
                options = list(dom = 'tp',
                               autoWidth = FALSE,
                               scrollX = TRUE,
                               pageLength = nrow(overview_data))  # Set page length to number of rows
      ) %>%
        formatStyle(0, whiteSpace = "nowrap")  # Ensures row names don't wrap
    })
  })
}
