#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function(input, output, session) {
  # Your application server logic

  ## Set maximum file size for upload to 100MB
  options(shiny.maxRequestSize = 100*1024^2)

  # Call the server function for the example module
  mod_example_server("example_1")
}
