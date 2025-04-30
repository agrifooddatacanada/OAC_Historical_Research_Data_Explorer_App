# Define the home tab

explorer_list$homeTab_ui  <- tabItem(
  tabName = "home_tab", 
  
  # CSS use to custom style the carousel nav and dots
  tags$head(tags$style(HTML("
    /* Fade-in Animation */
    @keyframes fadeIn {
      from { opacity: 0; }
      to { opacity: 1; }
    }
    .animated-box {
      animation: fadeIn 5s ease-in-out;
    }

    .carousel-control-prev-icon,
    .carousel-control-next-icon {
    background-color: #3c8dbc;
    border-radius: 50%;
    background-size: 80% 80%;
  }
  .carousel-control-prev,
  .carousel-control-next {
    width: 5%;
  }
  
  .carousel-indicators li {
    background-color: #3c8dbc;
    width: 16px;
    height: 16px;
    border-radius: 50%;
    margin: 0 5px;
  }
  .carousel-indicators .active {
    background-color: #3c8dbc;
  }
  "))),
  
  #  Carousel sliders to show key app metrics and navigate to network and data tabs
  carousel(
    id = "mycarousel",
    width = "100%",
    
    # Slide 1: value boxes
    carouselItem(
      caption = NULL,
      tags$div(
        style = "width: 100%; height: 350px; display: flex; align-items: center; 
          justify-content: center;",
        fluidRow(
          id = "valueBoxes",
          class = "row justify-content-center",
          style = "gap: 20px;   width: 100%; margin: 0;",
          valueBoxOutput("total_dataverses", width = 2),
          valueBoxOutput("total_studies", width = 2),
          valueBoxOutput("unique_authors", width = 2),
          valueBoxOutput("unique_keywords", width = 2),
          valueBoxOutput("total_file", width = 2)
        )
      )
    ),
    
    # Slide 2: Explore Network
    carouselItem(
      caption = NULL,
      tags$div(
        id = "exploreNetwork", 
        
        tags$div(
          style = "display:flex; justify-content: center; align-items: center;",
          tags$img(src = "view_network.jpg", class = "img-fluid",
                   style = "width: 90%; height: 350px; object-fit: cover; border-radius: 15px;"),  
          tags$div(
            style = "position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%);
                     text-align: center; background: rgba(0, 0, 0, 0.5); padding: 20px;
                     border-radius: 10px; color: white",
            tags$h1("Explore Networks within the App", style = "font-size: 40px; font-weight: bold;"),
            tags$p("Discover relationships and connections between authors and keywords",
                   style = "font-size: 15px; font-weight: bold;"),
            actionButton("go_to_network", "Go to Network Explorer", class = "btn btn-primary")
          )
        )
      )
    ),
    
    # slide 3: Explore Data
    carouselItem(
      caption = NULL,
      tags$div(
        id = "exploreData", 
        
        tags$div(
          style = "display:flex; justify-content: center; align-items: center;",
          tags$img(src = "Explore_data.jpg", class = "img-fluid", 
                   style = "width: 90%; height: 350px; object-fit: cover; border-radius: 15px;"), 
          tags$div(
            style = "position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%);
                     text-align: center; background: rgba(0, 0, 0, 0.5); padding: 20px; 
                     border-radius: 10px; color: white",
            tags$h1("Explore and Visualize Data", style = "font-size: 40px; font-weight: bold;"),  
            tags$p("Discover various metadata and datasets for diverse studies within OAC", 
                   style = "font-size: 15px; font-weight: bold;"),
            actionButton("go_to_borealis", "Go to Data Explorer", class = "btn btn-primary")
          )
        )
      )
    ) 
  ), 
  
  br(), br(),
  tags$div(
    style = " padding: 20px;
    border-radius: 10px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    text-align: center;
    max-width: 80%;
    margin: auto;
    font-size: 20px;
    line-height: 1.6;
    color: #333333;",
    tags$h4(tags$b("Re-usable data explorer App (RED-X)")),
    tags$hr(style = "border: 2px solid #3c8dbc; width: 250px; margin: auto;"),
    
    br(),
    
    p("The reusable data explorer app, developed by Agri-food Data Canada,
        allows researchers to explore historical data in the Borealis repository.
        It provides detailed study insights and data analysis tools to help researchers
        understand past research and enhance project efficiency.")),
  
  br(), br(),
  
  tags$div(
    style = " background-color: lightgrey;
    padding: 20px;
    border-radius: 10px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    text-align: center;
    max-width: 50%;
    margin: auto;
    font-size: 20px;
    line-height: 1.6;
    color: #333333;",
    tags$h4(tags$b("Agri-food Data Canada")),
    tags$hr(style = "border: 2px solid #3c8dbc; width: 250px; margin: auto;"),
    
    br(),
    
    p("Agri-food Data Canada, based at the University of Guelph,
          enhances research data utility through tools and training aligned with FAIR principles
          (i.e., Findable, Accessible, Interoperable, and Reusable).
          Our mission is to support researchers in maximizing data impact by
          simplifying access,fostering innovation, and integrating historical research.
          Learn more about the Agric-food Data Canada at the University of Guelph,",
      tags$a(href = "https://agrifooddatacanada.ca/",
             tags$b("here."), target = "_blank", style = "color:#3c8dbc;")
    )),
  
  br(), br(),
  
  tags$div(
    style = "
      padding: 20px;
      width: 80%;
      text-align:center;
      margin: auto;
      border-radius: 10px;
      box-shadow: 2px 2px 10px rgba(0,0,0,0.1);
      font-size: 20px;
      line-height: 1.6;
      color: #333333;",
    tags$h4(tags$b("Unique Features of the App"), style = "text-align: center;"),
    tags$hr(style = "border: 2px solid #3c8dbc; width: 250px; margin: auto;"),
    br(),
    tags$div(
      style = "display: flex; justify-content: space-between; align-items: flex-start;",
      tags$div(
        style = "flex: 1; text-align: center; padding: 15px; max-width: 30%;",
        tags$h5(tags$b("Network")),
        tags$img(src = "network.png", height = "80px"),
        p("Visualizes study connections through shared keywords and authors,
            aiding discovery of related research.")
      ),
      tags$div(
        style = "flex: 1; text-align: center; padding: 15px; max-width: 30%;",
        tags$h5(tags$b("Metadata")),
        tags$img(src = "Metadata.png", height = "80px"),
        p("Provides essential details on study variables, methodology,
            and objectives for better data interpretation.")
      ),
      tags$div(
        style = "flex: 1; text-align: center; padding: 15px; max-width: 30%;",
        tags$h5(tags$b("Exploratory Data Analysis")),
        tags$img(src = "analysis.png", height = "80px"),
        p("Allow users to analyze and visualize study data to uncover trends,
            patterns, and insights.")
      )
    )
  ),
  
  br(), br(),
  
  tags$div(
    style = " background-color: lightgrey;
    padding: 20px;
    border-radius: 10px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    text-align: center;
    max-width: 50%;
    margin: auto;
    font-size: 20px;
    line-height: 1.6;
    color: #333333;",
    tags$h4(tags$b("How the App works"), style = "text-align: center;"),
    tags$hr(style = "border: 2px solid #3c8dbc; width: 100px; margin: auto;"),
    br(),
    p("The ", strong("Explore Borealis tab"),
      "lets users visualize study networks in the Agri-environmental Research Data repository based on
        keywords and author names. Users can select a keyword or author to explore
        related studies and gain deeper insights through the study overview,
        metadata, and data exploration tabs. Click ",
      tags$a(href = "https://borealisdata.ca/dataverse/ugardr",
             tags$b("here"),
             target = "_blank", style = "color:#3c8dbc;"),
      " to access the Agri-environmental Research Data dataverse in the Borealis database.")
  ),
  
  br(),br(), br(),
  
  tags$div(
    style = "text-align: center;",
    p(tags$h2(tags$strong("Have fun exploring re-usable historical data!")))
  )
)




# Server Module for Network Tab
explorer_list$homeTab_server <- function(input, output, session, study_data) {
  
  
  # Render ValueBox for 'Total Studies'
  output$total_dataverses <- renderValueBox({
    
    # Compute the value only once study_data() is available
    req(study_data())  # Ensures that the data is available
    
    valueBox(value = tags$span(class = "animated-box", 
                               style = "font-size: 60px; color: white;", 
                               tags$b(length(unique(study_data()$CollegeName)))),
             subtitle = tags$div(style = "font-size: 20px; color: white; 
                        text-align: center;", "Agri-Environment Dataverses to Explore!"),
             icon = icon("database"),
             color = "maroon",
             elevation = 2,
             gradient = TRUE)
  })
  
  # Render ValueBox for 'Total Studies'
  output$total_studies <- renderValueBox({
    
    # Compute the value only once study_data() is available
    req(study_data())  # Ensures that the data is available
    
    valueBox(value = tags$span(tags$b(class = "animated-box",
                                      style = "font-size: 60px;",
                                      nrow(study_data()))),
             subtitle = tags$div(style = "font-size: 20px; text-align: center;",
                                  "Research papers available to explore!"),
             icon = icon("book"),
             color = "info",
             elevation = 2,
             gradient = TRUE)
  })
  
  # Render ValueBox for 'Unique Authors'
  output$unique_authors <- renderValueBox({
    # Compute the value only once study_data() is available
    req(study_data())  # Ensures that the data is available
    
    # Calculate the number of unique authors once the data is ready
    author_count <- length(unique(unlist(strsplit(study_data()$Authors, ";"))))
    
    valueBox(value = tags$span(tags$b(class = "animated-box",
                                      style = "font-size: 60px;",
                                      author_count)),
             subtitle = tags$div(style = "font-size: 20px; text-align: center;",
                                 "Researchers whose work you can discover!"),
             icon = icon("user"),
             color = "purple",
             elevation = 2,
             gradient = TRUE)
  })
  # Render ValueBox for 'Unique Keywords'
  output$unique_keywords <- renderValueBox({
    
    # Compute the value only once study_data() is available
    study_data = study_data()
    req(study_data())  # Ensures that the data is available
    
    valueBox(value = tags$span(tags$b(class = "animated-box",
                                      style = "font-size: 60px;",
                                      length(unique(unlist(strsplit(study_data()$Keywords, ";")))))),
             subtitle = tags$div(style = "font-size: 20px; text-align: center;",
                                  "Topics and themes to guide your research!"),
             icon = icon("tags"),
             color = "success",
             elevation = 2,
             gradient = TRUE)
  })
  
  # Render ValueBox for 'Total Files'
  output$total_file <- renderValueBox({
    
    # Compute the value only once study_data() is available
    req(study_data())  # Ensures that the data is available
    
    valueBox(value = tags$span(tags$b(class = "animated-box",
                                      style = "font-size: 60px;",
                                      length(unique(unlist(strsplit(study_data()$FileList, ";")))))),
             subtitle = tags$div(style = "font-size: 20px; text-align: center;",
                                  "Metadata and Data files to explore!"),
             icon = icon("file"),
             color = "danger",
             elevation = 2,
             gradient = TRUE)
  })
  
  # When the 'go_to_network' image or button is clicked, navigate to the 'network_tab'
  observeEvent(input$go_to_network, {
    updateNavbarTabs(session= session,
                     inputId = "navmenu",
                     selected = "network_tab")
  })
  
  # When the 'go_to_borealis' image or button is clicked, navigate to the 'borealis_tab'
  observeEvent(input$go_to_borealis, {
    updateNavbarTabs(session= session,
                     inputId = "navmenu",
                     selected = "borealis_tab")
  })
}