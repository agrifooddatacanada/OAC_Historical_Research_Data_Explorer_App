#' Metadata UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
mod_metadata_ui <- function(id){
  ns <- NS(id)
  tagList(
    fluidRow(
      column(12,
             # Box containing a data table for describing the dataset
             bs4Dash::box(
               title = "Description of the Dataset",
               status = "white",
               solidHeader = TRUE,
               collapsible = TRUE,
               elevation = 3,
               width = 12,
               collapsed = F,
               DT::dataTableOutput(ns("meta"))
             ),
             # Box containing a data table for the data schema
             bs4Dash::box(
               title = "Data Schema",
               status = "white",
               solidHeader = TRUE,
               collapsible = TRUE,
               elevation = 3,
               width = 12,
               collapsed = F,
               DT::dataTableOutput(ns("schema"))
             )
      )
    )
  )
}

#' Metadata Server Functions
#'
#' @noRd
mod_metadata_server <- function(id, exampleData){
  # Define the server logic for the metadata module
  moduleServer( id, function(input, output, session){
    ns <- session$ns

    # Reactive expression to load metadata based on the selected exampleData
    metaData <- reactive({
      req(exampleData)

      # # Load package lazy data depending on user input using get_data function
      get_data(exampleData(),TRUE)
    })

    # Render a data table for metadata
    output$meta <- DT::renderDataTable({
      DT::datatable(metaData()[1:7,],
                    rownames = FALSE,
                    colnames = c("Keys", "Values"),
                    options = list(dom = "tp",
                                   autoWidth = FALSE,
                                   scrollX = TRUE))
    })

    # Render a data table for data schema
    output$schema <- DT::renderDataTable({
      DT::datatable(metaData()[8:13,],
                    rownames = FALSE,
                    colnames = c("Keys", "Values"),
                    options = list(dom = "tp",
                                   autoWidth = FALSE,
                                   scrollX = TRUE))
    })

  })
}

## To be copied in the UI
# mod_metadata_ui("metadata_1")

## To be copied in the server
# mod_metadata_server("metadata_1")
