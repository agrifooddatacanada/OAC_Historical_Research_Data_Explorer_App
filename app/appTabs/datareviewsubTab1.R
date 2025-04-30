# ---- This module defines the UI and server logic for the data exploration tabsetpanel ----

dataexplorationUI_module <- function(id){
  ns <- NS(id)
  
  tagList(
    fluidRow(
      column(
        12,
        # Dropdown for selecting a dataset
        selectInput(
          ns("dataset_select"),
          "Select a Dataset to View",
          choices = NULL, # Initial choices are empty
          selected = NULL # No initial selection
        ),
        br(), # Add a line break for spacing
        
        # Tabs for exploring data files
        tags$div(
          id = ns("dataTabBlock"),
          bs4Dash::tabsetPanel(
            id = ns("datafiles"),  # Namespace-aware tabset ID
            
            # Tab for viewing all data files
            tabPanel(
              "View all Datafile",
              value = ns("view_alldata"),
              br(), # Add a line break
              DT::dataTableOutput(ns("view_alldata"))
            ),
            
            # Tab for data summary
            tabPanel(
              "Data Summary",
              style = "margin-left: 10px;",
              value = ns("filtered_data1"),
              br(),
              # Box for viewing raw data
              box(
                title = "View Data",
                status = "white",
                solidHeader = TRUE,
                collapsible = TRUE,
                elevation = 1,
                width = 12,
                collapsed = FALSE,
                DT::dataTableOutput(ns("rawtable"))
              ),
              
              br(),
              
              # Row with data structure and descriptive statistics
              fluidRow(
                column(
                  4,
                  box(
                    title = "Data Structure",
                    status = "white",
                    solidHeader = TRUE,
                    collapsible = TRUE,
                    elevation = 1,
                    width = 12,
                    collapsed = FALSE,
                    DT::dataTableOutput(ns("structure"))
                  )
                ),
                
                column(
                  8,
                  box(
                    title = "Descriptive Statistics",
                    status = "white",
                    solidHeader = TRUE,
                    collapsible = TRUE,
                    elevation = 1,
                    width = 12,
                    collapsed = FALSE,
                    DT::dataTableOutput(ns("summary"))
                  )
                )
              ),
              
              br(),
              
              # Box for missing values
              box(
                title = "Missing Values",
                status = "white",
                solidHeader = TRUE,
                collapsible = TRUE,
                elevation = 1,
                width = 12,
                collapsed = FALSE,
                maximizable = TRUE,
                plotOutput(ns("missing_value"))
                
              )
            ),
            
            # Tab for data visualization
            tabPanel(
              "Data Visualization",
              value = ns("filtered_data1"),
              br(),
              fluidRow(
                column(
                  3,
                  # Box for selecting analysis type and variables
                  box(
                    title = "Select Analysis Type",
                    status = "white",
                    solidHeader = TRUE,
                    collapsible = FALSE,
                    elevation = 1,
                    width = 12,
                    # Radio buttons for selecting analysis type
                    awesomeRadio(
                      inputId = ns("analysis_type"),
                      label = NULL,
                      choices = c(
                        "Histogram",
                        "Density Plot",
                        "QQ Plot",
                        "Heat Map",
                        "Boxplot",
                        "Linear Regression"
                      ),
                      selected = "Histogram",
                      inline = FALSE
                    ),
                    # Dynamic UI for selecting variables
                    uiOutput(ns("variable_selection_x")),
                    uiOutput(ns("variable_selection_y"))
                  )
                ),
                column(
                  9,
                  # Box for displaying the generated plot
                  box(
                    title = "Plot Viewer",
                    status = "white",
                    solidHeader = TRUE,
                    collapsible = FALSE,
                    elevation = 1,
                    width = NULL,
                    maximizable = TRUE,
                    withSpinner(uiOutput(ns("plot")))
                  )
                )
              )
            ),
            
            type = "pills",      # Use pill-style tabs
            vertical = FALSE     # Horizontal tab arrangement
          )
        )
      )
    )
  )
}


dataexplorationserver_module <- function(id, input_dataset_select, shared_data){
  moduleServer(id, function(input, output, session){
    ns <- session$ns
    
    observe({
      req(shared_data$file_list)
      
      # Filter non-txt data files
      datafile <- filter_filelist(shared_data$file_list, is_txt = FALSE)
      
      # Determine which files to use based on tab selection
      if (input$datafiles == "view_alldata") {
        choices <- basename(shared_data$file_list)
      } else {
        choices <- basename(datafile)
      }
      
      # Handle the case where no valid data files are found
      if (length(choices) == 0) {
        updateSelectInput(session, "dataset_select",
                          choices = c("No data files found" = ""),
                          selected = "")
        shinyjs::disable("dataset_select")
        shinyjs::hide("dataTabBlock")
      } else {
        updateSelectInput(session, "dataset_select",
                          choices = choices,
                          selected = NULL)
        shinyjs::enable("dataset_select")
        shinyjs::show("dataTabBlock")
      }
    })
    
    # ----- Exploratory data analysis tabPanel -----
    
    # ------Logic for view all file tabsetPanel ------
    
    # logic to read all the file types and render data as a data table
    output$view_alldata <- renderDataTable({
      # Ensure a file is selected
      req(input$dataset_select)
      selected_file <- shared_data$full_paths[input$dataset_select]
      
      # Determine the file extension and read accordingly
      file_ext <- tolower(tools::file_ext(selected_file))
      tryCatch({
        data <- switch(file_ext,
                       'txt' = {
                         lines <- readLines(selected_file)
                         data.frame(Text = lines, stringsAsFactors = FALSE)
                       },
                       'csv' = {
                         read.csv(selected_file, stringsAsFactors = FALSE)
                       },
                       'xlsx' = {
                         read_excel(selected_file)
                       },
                       'tab' = {
                         read.delim(selected_file, header = TRUE, sep = "\t")
                       },
                       data.frame(Message = paste("Unsupported file type:", file_ext))  # Default case
        )
        datatable(data,
                  options = list(dom = 'tp', autoWidth = FALSE, scrollX = TRUE),
                  rownames = FALSE)  # Set rownames to FALSE
      }, error = function(e) {
        datatable(data.frame(Error = "Error reading file", Message = e$message),
                  options = list(dom = 'tp', autoWidth = FALSE, scrollX = TRUE),
                  rownames = FALSE)
      })
    })
    
    # Reactive expression for loading data for the data summary and data visualization tab
    loaded_data <- reactive({
      req(input$dataset_select)  # Ensure a file is selected
      # Use the full path for reading the file
      selected_file_path_data <- shared_data$full_paths[input$dataset_select]
      
      # Attempt to read the file, handle failure
      data <- tryCatch({
        fread(selected_file_path_data, header = TRUE, quote = "\"")
      }, error = function(e) {
        # Return NULL or handle the error appropriately
        NULL
      })
      
      if (!is.null(data)) {
        
        # Convert real numeric variables identified as character into numeric variables
        data <- suppressWarnings(
          data %>%
            mutate(across(where(~ is.character(.) && !contains_letters(.)), as.numeric))%>%
            mutate(across(where(is.numeric), ~ ifelse(is.finite(.), ., NA))) %>%
            drop_na()
        )
        
        # Clean column names by keeping only letters and numbers
        # (e.g., some colnames have characters like %,*,#)
        names(data) <- gsub("[^A-Za-z0-9]", "", names(data))
      }
      
      return(data)
    })
    
    
    # ------Logic for data summary tabsetPanel ------
    
    # Logic to render the raw data table
    output$rawtable <- DT::renderDataTable({
      
      req(loaded_data())  # Ensure data is loaded
      
      DT::datatable(loaded_data(),
                    rownames = FALSE,
                    options = list(dom = "tp",
                                   autoWidth = FALSE,
                                   scrollX = TRUE))
    })
    
    # Logic to render the data structure
    output$structure <- renderDataTable({
      req(loaded_data())  # Ensure data is loaded
      
      data <- loaded_data() %>%
        introduce() %>%
        as_tibble() %>%
        rename_with(~ stringr::str_to_title(tools::toTitleCase(gsub("_", " ", .x)))) %>%
        pivot_longer(cols = everything(), names_to = "Key", values_to = "Value")
      
      DT::datatable(
        data,
        rownames = FALSE,  # Row names aren't needed since "Key" is now a column
        colnames = c("Key", "Value"),
        options = list(
          dom = "tp",
          autoWidth = FALSE,
          scrollX = TRUE,
          columnDefs = list(list(width = "200px", targets = 0))  # Adjust width for "Key" column (targets = 0 means first column)
        )
      )
    })
    
    output$missing_value <- renderPlot({
      req(loaded_data())  # Ensure data is loaded
      
      # Calculate dynamic limits for the y-axis based on data size
      missing_data <- loaded_data()  # Assuming 'loaded_data()' is a dataframe with missing values
      max_missing <- max(colSums(is.na(missing_data)))  # Get max missing count for any column
      
      # If max_missing is greater than 100, scale it down so that the plot is readable
      y_limit_upper <- ifelse(max_missing > 100, max_missing, 100)
      
      # Plot the missing values with the dynamic y-axis limit
      plot_missing(missing_data,
                   ggtheme = theme_classic(),
                   theme_config = list(axis.ticks = element_blank(),
                                       axis.line = element_line(colour = "grey50"),
                                       panel.grid.minor = element_blank(),
                                       panel.grid.major.x = element_blank(),
                                       panel.grid.major.y = element_blank(),
                                       panel.background = element_rect(fill = "#fbf9f4", color = "#fbf9f4"),
                                       plot.background = element_rect(fill = "#fbf9f4", color = "#fbf9f4"))) +
        scale_y_continuous(limits = c(0, y_limit_upper))  # Use scale_y_continuous to set dynamic limits
    })
    
    
    
    # logic for summary statistics table
    output$summary <- renderDataTable({
      req(loaded_data())  # Ensure data is loaded
      
      data_file <- loaded_data() # rename the loaded_data()
      
      #Check if the input is a data frame
      if(!is.data.frame(data_file)) stop("data needs to be a dataframe")
      
      #Convert input to data frame if it's not already
      data_file <- as.data.frame(data_file)
      
      # Filter out and subsets only logical and numeric columns
      data_file <- data_file[sapply(data_file, is.logical) | sapply(data_file, is.numeric)]
      
      # Check if the filtered data frame is suitable
      if ((ncol(data_file) < 1) | (nrow(data_file) < 2)) stop("unsuitable data frame (does it contain numerical data?)")
      
      # Compute the descriptive statistics
      data <- cbind(apply(data_file,2,function(x) as.integer(sum(!is.na(x)))),
                    apply(data_file,2,mean, na.rm=TRUE),
                    apply(data_file,2,stats::sd, na.rm=TRUE),
                    t(apply(data_file, 2, function(x)
                      stats::quantile(x,
                                      probs=c(0, 0.25, 0.5, 0.75, 1), na.rm = TRUE))))
      
      # Round up the decimal place for each column
      data <- round (data, digits = c(0, 3, 3, 3, 3, 3, 3, 3))
      
      # Assign column names
      colnames(data) <- c("N", "Mean", "Std. dev.", "Min.", "25 %", "Median", "75 %", "Max.")
      
      # output data as a datatable
      DT::datatable(data,
                    rownames = TRUE,
                    options = list(dom = "tp",
                                   autoWidth = FALSE,
                                   scrollX = TRUE))
    })
    
    
    # ------Logic for data visualization tabsetPanel ------
    
    # Dynamic UI for variable selection based on analysis type
    
    observeEvent(input$analysis_type, {
      
      req(input$analysis_type, loaded_data())
      
      analysis_type <- input$analysis_type
      
      
      if (analysis_type %in% c("Boxplot", "Linear Regression")) {
        
        output$variable_selection_x <- renderUI({
          req(loaded_data())
          var_choices <- colnames(loaded_data())
          selectInput(ns("variable_x"), "Select X Variable", choices = var_choices)
        })
        
        output$variable_selection_y <- renderUI({
          req(loaded_data(), input$variable_x)
          y_choices <- setdiff(colnames(loaded_data()), input$variable_x)
          selectInput(ns("variable_y"), "Select Y Variable", choices = y_choices)
        })
      } else {
        output$variable_selection_x <- renderUI({ NULL })
        output$variable_selection_y <- renderUI({ NULL })
      }
    })
    
    # Generate analysis output based on chosen analysis
    output$plot <- renderUI({
      
      req(input$analysis_type, loaded_data()) # Ensure these inputs are set
      
      analysis_type <- input$analysis_type
      
      if (analysis_type == "Heat Map") {
        plotlyOutput(ns("heatmap_plot"),
                     height = "600px")
      } else {
        plotOutput(ns("other_plots"),
                   height = "600px")
      }
    })
    
    # Logic to render other_plots
    
    output$other_plots <- renderPlot({
      
      # Ensure these variables are found
      req(loaded_data())
      
      analysis_type <- input$analysis_type
      
      data <- loaded_data()
      
      # set variable names
      
      if (analysis_type %in% c("Boxplot", "Linear Regression")) {
        
        req(input$variable_x, input$variable_y)
        
        variable_x <- input$variable_x
        variable_y <- input$variable_y
        
        # a. Boxplot
        if (analysis_type == "Boxplot") {
          data[[variable_x]] <- factor(data[[variable_x]])
          if (length(levels(data[[variable_x]])) > 0) {
            boxplt <- ggplot(data, aes_string(x = variable_x,
                                              y = variable_y,
                                              fill = variable_x)) +
              geom_boxplot() +
              geom_point(size = 2) +
              ggtitle("A boxplot showing individual datapoints") +
              theme_classic() +
              theme(strip.text = element_text(face = "bold", size = 12),
                    panel.grid.major.x = element_blank(),
                    panel.grid.major.y = element_blank(),
                    panel.background = element_rect(fill = "#fbf9f4", color = "#fbf9f4"),
                    plot.background = element_rect(fill = "#fbf9f4", color = "#fbf9f4"),
                    plot.caption = element_text(hjust = 0, size = 14),
                    axis.line = element_line(colour = "grey50"),
                    axis.text.x = element_text(vjust = 1.2, size = 12, color = "black"),
                    axis.text.y = element_text(color = "black", size = 12),
                    axis.title.x = element_text(vjust = 0, size = 14),
                    axis.title.y = element_text(size = 14),
                    legend.title = element_blank(),
                    legend.position = "none")
            print(boxplt)
          } else {
            warning("No levels in the factor variable for the fill aesthetic")
          }
        }
        
        # b. Linear regression
        if (analysis_type == "Linear Regression") {
          ggplot(data, aes_string(x = variable_x,
                                  y = variable_y)) +
            geom_point(size = 3.5) +
            ggtitle("Relationship between two continous variables") +
            geom_smooth(method = "lm", color = "blue", se = FALSE, formula = y ~ x) +
            theme_classic() +
            theme(strip.text = element_text(face = "bold", size = 12),
                  panel.grid.major = element_blank(),
                  panel.background = element_rect(fill = "#fbf9f4", color = "#fbf9f4"),
                  plot.background = element_rect(fill = "#fbf9f4", color = "#fbf9f4"),
                  panel.grid.minor = element_blank(),
                  plot.caption = element_text(hjust = 0, size = 10),
                  axis.line = element_line(),
                  axis.text.x = element_text(size = 12, color = "black"),
                  axis.text.y = element_text(color = "black", size = 12),
                  axis.title.x = element_text(vjust = 0, size = 16, face = "bold"),
                  axis.title.y = element_text(size = 16, face = "bold"),
                  legend.text = element_text(face = "bold", color = "black", size = 12))
        }
        
      } else {
        # For other plot types that don't need variable selection
        # c. Histogram
        if (analysis_type == "Histogram") {
          long_data <- pivot_longer(data, cols = where(is.numeric),
                                    names_to = "variable",
                                    values_to = "value")
          histogram_plot <- ggplot(long_data, aes(x = value)) +
            geom_histogram(fill = "blue", alpha = 0.5, binwidth = 2) +
            facet_wrap(~ variable, scales = "free") +
            labs(title = "Histogram plot for each numeric variable",
                 x = "Value",
                 y = "Histogram") +
            theme_classic() +
            theme(axis.ticks = element_blank(),
                  axis.line = element_line(colour = "grey50"),
                  panel.grid.minor = element_blank(),
                  panel.grid.major.x = element_blank(),
                  panel.grid.major.y = element_blank(),
                  panel.background = element_rect(fill = "#fbf9f4", color = "#fbf9f4"),
                  plot.background = element_rect(fill = "#fbf9f4", color = "#fbf9f4"))
          print(histogram_plot)
        }
        
        # d. Density plot
        if (analysis_type == "Density Plot") {
          long_data <- pivot_longer(data, cols = where(is.numeric),
                                    names_to = "variable",
                                    values_to = "value")
          density_plot <- ggplot(long_data, aes(x = value)) +
            geom_density(fill = "blue", alpha = 0.5) +
            facet_wrap(~ variable, scales = "free") +
            labs(title = "Density plot for each numeric variable",
                 x = "Value",
                 y = "Density") +
            theme_classic() +
            theme(axis.ticks = element_blank(),
                  axis.line = element_line(colour = "grey50"),
                  panel.grid.minor = element_blank(),
                  panel.grid.major.x = element_blank(),
                  panel.grid.major.y = element_blank(),
                  panel.background = element_rect(fill = "#fbf9f4", color = "#fbf9f4"),
                  plot.background = element_rect(fill = "#fbf9f4", color = "#fbf9f4"))
          
          print(density_plot)
        }
        
        # e. QQ plot
        if (analysis_type == "QQ Plot") {
          num_vars <- sum(sapply(loaded_data(), is.numeric))
          ncol <- ceiling(sqrt(num_vars))
          nrow <- ceiling(num_vars / ncol)
          plot_qq(loaded_data(), ncol = ncol, nrow = nrow,
                  title = "QQ plot for each numeric variable",
                  ggtheme = theme_classic(),
                  theme_config = list(axis.ticks = element_blank(),
                                      axis.line = element_line(colour = "grey50"),
                                      panel.grid.minor = element_blank(),
                                      panel.grid.major.x = element_blank(),
                                      panel.grid.major.y = element_blank(),
                                      panel.background = element_rect(fill = "#fbf9f4",
                                                                      color = "#fbf9f4"),
                                      plot.background = element_rect(fill = "#fbf9f4",
                                                                     color = "#fbf9f4")))
        }
      }
    })
    
    # output for the heatmap
    output$heatmap_plot <- renderPlotly({
      
      req(loaded_data(),
          input$analysis_type == "Heat Map") # Ensure data is loaded and non-null
      
      # Remove non-numeric columns and NA rows
      numeric_data <- loaded_data() %>%
        select(where(is.numeric)) %>%
        na.omit()
      
      heatmap<- heatmaply(cor(numeric_data),
                          k_col = 2,
                          k_row = 2,
                          main = " Heatmap showing relationship among the variables",
                          plot_method = "plotly")
      
      # Customize the heatmap theme
      heatmap <- heatmap %>%
        layout(
          xaxis = list(
            ticks = "",
            showline = FALSE,
            showgrid = FALSE,
            zeroline = FALSE
          ),
          yaxis = list(
            ticks = "",
            showline = FALSE,
            showgrid = FALSE,
            zeroline = FALSE
          ),
          paper_bgcolor = "#fbf9f4",
          plot_bgcolor = "#fbf9f4"
        )
      
      
      return(heatmap)
    })
    
  })
}
