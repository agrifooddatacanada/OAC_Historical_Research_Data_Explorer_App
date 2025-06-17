# ----- Define the UI and server logic for the data review tab

# UI function for the data review tab
datareviewTab_UI <- function(id) {
  
  # Create a namespace function using the provided id for scoping the inputs/outputs
  ns <- NS(id)
  
  # Build the UI elements using tagList
  tagList(
    
    # Div containing the dropdown for selecting a study
    div(
      id = "selectDiv",
      fluidRow(
        column(3,
               box(title = "Select College / Campus / Institution",
                   status = "lightblue",
                   solidHeader = FALSE,
                   collapsible = FALSE,
                   elevation = 1,
                   width = 12,
                   collapsed = FALSE,
                   selectizeInput(
                     inputId = ns("college_select"),
                     label = NULL,
                     choices = NULL,
                     selected = NULL,
                     multiple = TRUE,
                     options = list(
                       placeholder = "Select a College ..."
                     ),
                     width = "100%" 
                   )
               )
        ),
        column(9,
               box(title = "Select a Study to Explore",
                   status = "lightblue",
                   solidHeader = FALSE,
                   collapsible = FALSE,
                   elevation = 1,
                   width = 12,
                   collapsed = FALSE,
                   selectizeInput(
                     inputId = ns("study_select"),  # Namespace-aware input ID
                     label = NULL,
                     choices = NULL,               # Initial choices are empty
                     selected = NULL,                # No initial selection
                     multiple = FALSE,              # Allow multiple selections
                     options = list(                # Allow only one selection at a time
                       placeholder = "Select a Study ...",  # Placeholder text
                       onInitialize = I('function() { this.clear(); }')  # prevents auto-select
                     ),
                     width = "100%"                # Full-width dropdown
                   )
               )
        )
      )
    ),
    
    # Line break to create space between elements
    br(),
    
    # Use shinyjs for enabling/disabling and hiding/showing elements
    shinyjs::useShinyjs(),
    shinyjs::hidden(
      # Div to hold the content of the tab once a study is selected
      div(
        id = ns("overviewBox"),
        fluidRow(
          column(12,
                 # Add a spinner to show loading while content is loading
                 withSpinner(
                   tabBox(
                     title = "",           # No title for the tabBox
                     width = 12,           # Full-width tabBox
                     collapsible = TRUE,   # Make the box collapsible
                     maximizable = TRUE,   # Allow maximizing the box
                     elevation = 1,        # Elevation style for the box
                     solidHeader = FALSE,  # Do not use a solid header
                     status = "lightblue", # Light blue styling for the box
                     
                     # Tab 1: Study Overview
                     tabPanel("Study Overview", overviewUI_module(ns("overview"))),
                     
                     # Tab 2: Metadata
                     tabPanel("Metadata", metadataUI_module(ns("metadata"))),
                     
                     # Tab 3: Data Exploration
                     tabPanel("Data Exploration", dataexplorationUI_module(ns("dataexploration")))
                   )
                 )
          )
        )
      )
    )
  )
}

# Server function for the data review tab
datareviewTab_server <- function(id, study_data, shared_data) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns
    
    
    # 1. Populate the college_select dropdown
    observe({
      req(study_data())
      
      updateSelectizeInput(
        session,
        "college_select",
        choices = sort(unique(study_data()$CollegeName)),
        selected = NULL  # always start fresh
      )
    })
    
    # 2. Update study_select based on selected colleges
    observeEvent(input$college_select, {
      data <- study_data()
      
      if (is.null(input$college_select) || length(input$college_select) == 0) {
        updateSelectizeInput(session, "study_select", choices = NULL, selected = NULL)
        shinyjs::hide("overviewBox")  # optional: also hide box when cleared
        return()
      }
      
      # Filter and split study titles by college
      filtered_data <- data %>%
        filter(CollegeName %in% input$college_select)
      
      choices <- split(filtered_data$Title, filtered_data$CollegeName)
      
      updateSelectizeInput(
        session,
        "study_select",
        choices = choices,
        selected = NULL
      )
    })
    
    
    # Observe changes in the study selection
    observeEvent(input$study_select,{
      # Check if a study is selected
      if (length(input$study_select) > 0 && nzchar(input$study_select)) {
        # Show the overviewBox if a study is selected
        shinyjs::show("overviewBox")
      } else {
        # Hide the overviewBox if no study is selected
        shinyjs::hide("overviewBox")
      }
    })
    
    # Server logic for the overview tab
    overviewServer_module("overview",
                          input_study_select = reactive(input$study_select),
                          study_data = study_data,
                          shared_data= shared_data)
    
    # Observe the study selection and update paths accordingly
    observe({
      # Ensure a study is selected before proceeding
      req(input$study_select)
      
      data <- study_data() %>%
        filter(CollegeName %in% input$college_select)
      # Fetch DOI, file lists, and update inputs accordingly
      selected_title <- input$study_select
      selected_doi <- data %>%
        filter(Title == selected_title) %>%
        pull(DOI) %>%
        unique()
      
      # Ensure only one DOI is selected
      if (length(selected_doi) != 1) {
        # Reset inputs if no valid DOI is found
        updateSelectInput(session, "metadata_select", choices = NULL, selected = NULL)
        updateSelectInput(session, "dataset_select", choices = NULL, selected = NULL)
        shared_data$full_paths <- list()  # Clear previous file paths
        return()  # Exit early if no valid DOI is selected
      }
      
      # Fetch file list for the selected study
      shared_data$file_list <- access_data(selected_doi)
      
      # Update full_paths after file list is validated
      shared_data$full_paths <- setNames(shared_data$file_list, basename(shared_data$file_list))
    })
    
    # Server logic for the metadata tab
    Metadataserver_module("metadata",
                          reactive(input$metadata_select),
                          shared_data)
    
    # Server logic for the data exploration tab
    dataexplorationserver_module("dataexploration",
                                 reactive(input$dataset_select),
                                 shared_data)
  })
}
