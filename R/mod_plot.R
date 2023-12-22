#' Plot UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_plot_ui <- function(id){
  ns <- NS(id)
  tagList(
    # The plot tab with options to select plot type, X and Y variables
    fluidRow(
      bs4Dash::column(3,
                      # Box for selecting the plot type (Boxplot or Scatter plot)
                      bs4Dash::box(
                        title = "Select Plot Type",
                        status = "white",
                        solidHeader = TRUE,
                        collapsible = FALSE,
                        elevation = 3,
                        width = 12,
                        awesomeRadio(
                          inputId = ns("button"),
                          label = "Plot type",
                          choices = c("Boxplot", "Scatter plot"),
                          selected = "Boxplot",
                          inline = TRUE
                        )
                      ),
                      # Box for selecting X and Y variables
                      bs4Dash::box(
                        title = "Select Variables",
                        status = "white",
                        solidHeader = TRUE,
                        collapsible = FALSE,
                        elevation = 3,
                        width = 12,
                        selectInput(ns("Xvar"),
                                    "X",
                                    choices = ""),
                        selectInput(ns("Yvar"),
                                    "Y",
                                    choices ="")
                      )
      ),
      bs4Dash::column(9,
                      # Box for displaying the plot area
                      bs4Dash::box(
                        title = "Plot Area",
                        status = "white",
                        solidHeader = TRUE,
                        collapsible = FALSE,
                        elevation = 3,
                        width = 12,
                        plotOutput(ns("plot"))
                      )
      )
    )
  )
}

#' Plot Server Functions
#'
#' @noRd
mod_plot_server <- function(id, exampleData){
  # Define the server logic for the plot module
  moduleServer( id, function(input, output, session){
    ns <- session$ns

    # Reactive expression to load data based on the selected example data
    data_plot <- reactive({
      req(exampleData())

      # Load package lazy data depending on user input using get_data function
      get_data(exampleData())
    })

    # Update selectInput for Xvar based on selected data
    observe({
      req(data_plot())
      updateSelectInput(session,
                        inputId = 'Xvar',
                        label = 'X',
                        choices = colnames(data_plot()))
    })

    # Update selectInput for Yvar based on selected data
    observe({
      req(data_plot())
      Ychoices <- subset(colnames(data_plot()), !(colnames(data_plot()) %in% input$Xvar))
      updateSelectInput(session,
                        inputId = 'Yvar',
                        label = 'Y',
                        choices = Ychoices)
    })

    # Create a reactive plot
    output$plot <- renderPlot({
      plot_type <- input$button

      if (plot_type == "Boxplot") {
        data_plot() %>%
          ggplot2::ggplot(ggplot2::aes_string(x = input$Xvar, y = input$Yvar, group = input$Xvar, color = input$Xvar)) +
          ggplot2::geom_boxplot(size = 1) +
          ggplot2::theme_classic()
      } else if (plot_type == "Scatter plot") {
        data_plot() %>%
          ggplot2::ggplot(ggplot2::aes_string(x = input$Xvar, y = input$Yvar, color = input$Xvar)) +
          ggplot2::geom_point(size = 3) +
          ggplot2::theme_classic()
      }

    })

  })
}

## To be copied in the UI
# mod_plot_ui("plot_1")

## To be copied in the server
# mod_plot_server("plot_1")
