#' The application User-Interface
#'
#' @param request Internal parameter for `{shiny}`.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_ui <- function(request) {

  # Add external resources to the Shiny application
  golem_add_external_resources()

  # UI interface for the explorer App
  # Create a Shiny dashboard UI
  tagList(
    # Define the dashboard structure using bs4Dash functions
    bs4Dash::dashboardPage(
      skin = "lightblue",  # Set the dashboard's skin color
      scrollToTop = TRUE,  # Enable scroll to top button
      fullscreen = TRUE,  # Enable fullscreen mode

      # Define the dashboard header
      bs4Dash::dashboardHeader(
        title = "Menu",  # Set the title of the header
        status = "white",  # Set the header's status color
        h3("Reusable data Explorer")  # Add a subheading
      ),

      # Define the dashboard sidebar
      bs4Dash::dashboardSidebar(
        collapsed = F,  # Sidebar is expanded by default
        minified = F,  # Sidebar is not minified
        skin = "light",
        status = "lightblue",
        elevation = 1,

        # Define the sidebar menu items
        bs4Dash::sidebarMenu(
          bs4Dash::menuItem("Home",  # Sidebar menu item for the home tab
                            icon = icon("house-user"),
                            tabName = "home"),

          bs4Dash::menuItem("Example",  # Sidebar menu item for the data tab
                            icon = icon("table"),
                            tabName = "data"),

          bs4Dash::menuItem("Explore borealis",  # Sidebar menu item for the owndata tab
                            icon = icon("server"),
                            tabName = "owndata")
        )
      ),

      # Define the dashboard body
      bs4Dash::dashboardBody(
        bs4Dash::tabItems(
          bs4Dash::tabItem(
            tabName = "home",  # Content for the "home" tab ----
            h5(strong("Welcome to the reusable data explorer App.")),  # Subheading

            br(),

            p("This shiny web application was developed as a part of the Reusable
        research data made shiny workshop that was
        held at the University of Guelph, Guelph Ontario Canada.",
          "You can find more information about the workshop and access the workshop materials",
              tags$a(href = "https://github.com/agrifooddatacanada/RRDMS_Workshop",
                     "here.", target = "_blank")),  # Create a hyperlink

            h5(strong("About the App")),

          p(" The ", strong("Example tab "), "demonstrates how the app works.",
            "It displays the Metadata, raw data, some summary statistics",
            "and plots of data gotten from an already published article.",
            tags$a(href = "https://doi.org/10.4141/A95-125",
                   "Click here for the publication.",
                   target = "_blank"),
            "The data used in the example tab can be found",
            tags$a(href = "https://doi.org/10.5683/SP3/WVC09T",
                   "here",
                   target = "_blank"),
            "in the Borealis database."),
          p("Finally, the ",
            strong("Explore borealis "),
            "allows you to explore data gotten from the Borealis database. Click ",
            tags$a(href = "https://borealisdata.ca/dataverse/oacHist",
                   "here",
                   target = "_blank"),
            " to access the oac repository in the Borealis database."),
          br(),
          img(src = 'www/workshop1.jpeg', height = 400, width = 700),
          br(),
          p(h4(strong("Have fun exploring reusable data!"))
          )
          ),

          bs4Dash::tabItem(
            tabName = "data",  # Content for the "data" tab ----
            mod_example_ui("example_1")  # Include a UI element for the "Example" tab
          ),

          bs4Dash::tabItem(
            tabName = "owndata",  # Content for the "owndata" tab ----
            mod_UI_ui("Borealis")  # Include a UI element for the "Borealis" tab
          )
        )
      )
    )
  )
}

#' Add external Resources to the Application
#'
#' This function is internally used to add external
#' resources inside the Shiny application.
#'
#'
#' @noRd
golem_add_external_resources <- function() {
  # Add a resource path for external files
  add_resource_path(
    "www",
    app_sys("app/www")
  )

  # Add resources to the head of the document
  tags$head(
    bundle_resources(
      path = app_sys("app/www"),
      app_title = "DataExplorer"
    )
    # Add other external resources here if needed
  )
}
