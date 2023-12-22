#' Example UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_example_ui <- function(id){
  ns <- NS(id)

  # UI components for selecting a dataset and displaying tabs for metadata, data, and plots

  tagList(


    # Explanation of the drop down menu
    p("The ", strong("Select a dataset"), " drop down menu allows user pick a dataset to explore.
      After selecting, the user can view the metadata, raw-data, some summary stat and plots"),

    # Add space
    br(),

    # Drop down for selecting a dataset
    selectInput(ns("dataset"),
                "Select a dataset",
                choices = c("Fatty acid"= "Fattyacid",
                            "Milk"= "Milk",
                            "Feed" = "Feed"),
                selected = "Fattyacid"
    ),

    # Add space between the dropdown and the tab box
    br(),

    # Tab box containing metadata, data, and plot tabs
    bs4Dash::tabBox(title = "",
                    width = 12,
                    collapsible = TRUE,
                    maximizable = TRUE,
                    elevation = 1,
                    solidHeader = TRUE,
                    status = "lightblue",
                    side = "right",
                    type = "tabs",
                    tabPanel("Metadata", mod_metadata_ui(ns("metadata_1"))
                    ),
                    tabPanel("Data", mod_data_ui(ns("data_1"))
                    ),
                    tabPanel("Plot", mod_plot_ui(ns("plot_1"))
                    )
    )
  )
}

#' Example Server Functions
#'
#' @noRd
mod_example_server <- function(id){
  # Define the server logic for the example module
  moduleServer( id, function(input, output, session){
    ns <- session$ns

    # Reactive expression to get the selected dataset
    exampleData <- reactive({
      input$dataset
    })

    # Call server functions for metadata, data, and plot modules
    mod_metadata_server("metadata_1", exampleData)
    mod_data_server("data_1", exampleData)
    mod_plot_server("plot_1", exampleData)
  })
}

## To be copied in the UI
# mod_example_ui("example_1")

## To be copied in the server
# mod_example_server("example_1")
