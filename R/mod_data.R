#' data UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd

mod_data_ui <- function(id){
  # Create a namespace for Shiny inputs and outputs
  ns <- NS(id)

  # Define the UI structure using bs4Dash elements
  tagList(
    fluidRow(
      # Create a column that spans the entire width (12 columns)
      bs4Dash::column(12,
                      # Box containing a data table with the id "rawtable"
                      bs4Dash::box(
                        title = "Raw Data",
                        status = "white",
                        solidHeader = TRUE,
                        collapsible = TRUE,
                        elevation = 3,
                        width = 12,
                        collapsed = F,
                        DT::dataTableOutput(ns("rawtable"))
                      ),
                      # Box containing summary statistics with the id "summary"
                      bs4Dash::box(
                        title = "Summary statistics",
                        status = "white",
                        solidHeader = TRUE,
                        collapsible = TRUE,
                        elevation = 3,
                        width = 12,
                        collapsed = F,
                        verbatimTextOutput(ns("summary"))
                      )
      )
    )
  )
}

#' Data Server Functions
#'
#' @noRd
mod_data_server <- function(id, exampleData){
  # Define the server logic for the data module
  moduleServer( id, function(input, output, session){
    ns <- session$ns

    # Reactive expression to read and process the selected exampleData
    data <- reactive({
      req(exampleData())

      # # Load package lazy data depending on user input using get_data function
      get_data(exampleData())

    })

    # Render the raw data table
    output$rawtable <- DT::renderDataTable({
      DT::datatable(data(),
                    rownames = FALSE,
                    options = list(dom = "tp",
                                   autoWidth = FALSE,
                                   scrollX = TRUE))
    })

    # Render and output summary statistics
    output$summary <- renderPrint({
      skim(data())
    })

  })
}

## To be copied in the UI
# mod_data_ui("data_1")

## To be copied in the server
# mod_data_server("data_1")
