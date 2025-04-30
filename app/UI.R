# Define UI for the app ----

ui <- dashboardPage(
  skin = "lightblue",       # Set the skin color of the dashboard to light blue
  scrollToTop = TRUE,       # Enable scrolling to the top when navigating tabs
  fullscreen = TRUE,        # Allow the dashboard to open in fullscreen mode
  help = NULL,              # Placeholder for future help functionality (currently unused)
  dark = NULL,              # Placeholder for future dark mode functionality (currently unused)
  title = "RED-X | Re-usable Data Explorer App",
  # Define the dashboard header with a fixed position and a navbar menu module
  dashboardHeader(
    status = "lightblue",   # Set the header's color to light blue
    fixed = TRUE,           # Fix the header at the top during scrolling
    rightUi = tagList(
      # GitHub icon link
      tags$li(
        class = "nav-item dropdown",
        tags$a(
          href = "https://github.com/agrifooddatacanada/OAC_Historical_Research_Data_Explorer_App",
          target = "_blank",
          class = "nav-link",
          icon("github"),
          style = "color: white; margin-right: -10px; font-weight: bold;"  
        )
      ),
      bs4DropdownMenu(
        badgeStatus = "success",
        type = "notifications",
        uiOutput("update_notification")
      )
    ),
    
    
    # Render the navigation menu from the explorer_list 
    explorer_list$navMenu
  ),
  
  # Disable the sidebar for this dashboard layout
  dashboardSidebar(disable = TRUE),
  
  # Define the main body content of the dashboard
  dashboardBody(
    use_waiter(),  # Only need this once here
    
    # Add custom styles
    tags$head(tags$style(".nav-pills .nav-link.active {color: #fff; background-color: #3c8dbc;}")),
    tags$head(tags$style(".nav-pills .nav-link:not(.active):hover {color: #3c8dbc !important;}")),
    
    
    waiter_show_on_load(
      html = tagList(
        h5("Loading data from database...", style = "color: white;"),
        shinyWidgets::progressBar(
          id = "load_progress",
          value = 1,  # minimal value to render the bar initially
          display_pct = TRUE,
          striped = TRUE,
          status = "info"
        )
      ),
      color = "#333"
    ),
    
    
    tabItems(
      explorer_list$homeTab_ui,
     explorer_list$aboutTab_ui,
      explorer_list$networkTab_ui,
      tabItem(
        tabName = "borealis_tab",
        datareviewTab_UI("data")
      )
    ),
    
    br(), br(),
    
    # Add Footer
    tags$footer(
      style = "padding: 10px; background-color: #f8f9fa; width: 100%;",
      
      tags$div(
        h6("Powered by"),
        tags$img(
          src = "Agri-food.png", 
          style = "max-width: 300px; width: 100%; height: auto; display: block; margin-left: 10px;"
        ),
        style = "font-weight: bold; margin: 5px 0 10px 0;"
      ),
      
      tags$div(
        h6("Supported by"),
        tags$img(
          src = "Canada_first.png", 
          style = "max-width: 300px; width: 100%; height: auto; display: block; margin-left: 10px;"
        ),
        style = "font-weight: bold; margin: 5px 0 10px 0;"
      ),
      
      tags$p(
        HTML(paste0("&copy; Agri-food Data Canada ", format(Sys.Date(), "%Y"), ". All rights reserved.")),
        style = "font-size: 16px; font-weight: bold; color: #333; text-align: center;"
      )
    )
  )
)







