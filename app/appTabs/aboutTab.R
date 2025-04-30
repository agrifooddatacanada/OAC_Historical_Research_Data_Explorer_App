# UI definition for the 'About' tab 
explorer_list$aboutTab_ui <-tabItem(
  tabName = "about_tab", 
  tags$h2(tags$b("About"), style = "text-align: center;"),
  
  br(), 
  
  tags$div(
    style = " padding: 20px;
    border-radius: 10px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    text-align: center;
    max-width: 60%;
    margin: auto;
    font-size: 20px;
    line-height: 1.6;
    color: #333333;",
    tags$h4(tags$b("Our Story")),
    tags$hr(style = "border: 2px solid #3c8dbc; width: 70px; margin: auto;"),
    
    br(),
    
    p("Have you ever wondered where past research data goes and the value it holds?
        In the era of big data, AI, and machine learning, integrating historical
        datasets can drive innovation and automation."),
    
    p("This app enhances research data value by following
        FAIR principles—Findable, Accessible, Interoperable, and Reusable.
        By simplifying their application, it improves data usability for researchers,
        industry professionals, and stakeholders in the Agri-food sector."),
    
    p("Agri-food Data Canada at the University of Guelph helps researchers
        maximize data potential, fostering innovation and advancing the Agri-food sector.")
  ),
  
  br(), br(),
  
  tags$div(
    style = "background-color: lightgrey;
    padding: 20px;
    border-radius: 10px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    text-align: center;
    max-width: 80%;
    margin: auto;
    font-size: 20px;
    line-height: 1.6;
    color: #333333;",
    tags$h4(tags$b("From Workshop to Innovation: Advancing Research Data Reusability"), style = "text-align: center;"),
    tags$hr(style = "border: 2px solid #3c8dbc; width: 300px; margin: auto;"),
    
    br(),
    
    p("The University of Guelph hosted a four-day workshop focused on
            enhancing research data reusability, led by experts Michelle Edwards and Lucas Alcantara.
            This event provided hands-on training in data organization, documentation,
            and sharing, emphasizing the FAIR data principles—Findable, Accessible,
            Interoperable, and Reusable. Participants learned best practices for
            metadata creation, data governance, and exploratory data analysis
            using R and Shiny frameworks. The workshop highlighted the importance of
            integrating historical datasets into current models to drive innovation and
            automation in research."),
    
    p("By equipping researchers with practical skills and tools,
            the workshop aimed to foster a mindset of data reusability,
            ensuring that valuable research data can be effectively reused
            to support advancements in the Agri-food sector. At the end of the workshop,
            the idea to create an app that simplifies the process of accessing and
            understanding historical data was born, further supporting researchers
            in maximizing the potential of their data for future discoveries.
            This initiative was supported by Compute Ontario and
            included both online and in-person sessions at the Ontario Dairy Research Centre."),
    
    p("You can find more information about the workshop and access the workshop materials on Github",
      tags$a(href = "https://github.com/agrifooddatacanada/RRDMS_Workshop",
             tags$b("here."), target = "_blank", style = "color:#3c8dbc;")),  # Create a hyperlink
    img(src = 'workshop1.jpeg', height = 500, width = 1000,
        style = "margin-top: 10px; border-radius: 5px; box-shadow: 2px 2px 10px rgba(0,0,0,0.1);")),
  
  
  br(), br(),
  
  tags$div(
    style = "
      padding: 20px;
      max-width: 60%;
      text-align:center;
      margin: auto;
      border-radius: 10px;
      box-shadow: 2px 2px 10px rgba(0,0,0,0.1);
      font-size: 20px;
      line-height: 1.6;
      color: #333333;",
    tags$h4(tags$b("Development Team"), style = "text-align: center;"),
    tags$hr(style = "border: 2px solid #3c8dbc; width: 150px; margin: auto;"),
    
    br(),
    
    tags$div(
      style = "display: flex; justify-content: space-between; align-items: flex-start;",
      # First profile card
      tags$div(
        style = "text-align: center; max-width: 250px; margin: auto;",
        
        # Image container (circular crop)
        tags$div(
          style = "width: 200px; height: 200px; overflow: hidden; border-radius: 50%; margin: auto;",
          tags$img(
            src = "AME_2019.jpg",
            style = "width: 100%; height: auto; object-fit: cover; display: block;"
          )
        ),
        
        # Name and title below the image
        tags$br(),
        tags$h5(tags$b("Michelle Edwards")),
        tags$h6("Director, Agri-food Data Strategy")
      ),
      
      # Second profile card
      tags$div(
        style = "text-align: center; max-width: 250px; margin: auto;",
        
        # Image container (circular crop)
        tags$div(
          style = "width: 200px; height: 200px; overflow: hidden; border-radius: 50%; margin: auto;",
          tags$img(src = "lucas.jpg",
                   style = "width: 100%; height: auto; object-fit: cover; display: block;"
          )
        ),                
        
        # Name and title below the image
        br(),
        h5(tags$b("Lucas Alcantara")),
        h6("Manager, Research Centre Data")
      ),
      
      # Second profile card
      tags$div(
        style = "text-align: center; max-width: 250px; margin: auto;",
        
        # Image container (circular crop)
        tags$div(
          style = "width: 200px; height: 200px; overflow: hidden; border-radius: 50%; margin: auto;",
          tags$img(src = "bkodaolu_img.jpg",
                   style = "width: 100%; height: auto; object-fit: cover; display: block;"
          )
        ),                
        
        # Name and title below the image
        br(),
        h5(tags$b("Busayo Kodaolu")),
        h6("Research associate, Data Reusability")
      )
    )
  ),
  
  
  br(), br(),
  
  tags$div(
    style = "background-color: lightgrey;
    padding: 20px;
    border-radius: 10px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    text-align: center;
    max-width: 80%;
    margin: auto;
    font-size: 20px;
    line-height: 1.6;
    color: #333333;",
    tags$h4(tags$b("Funding")),
    tags$hr(style = "border: 2px solid #3c8dbc; width: 60px; margin: auto;"),
    
    br(),
    
    p("The Reusable Data Explorer (RED-X) app is funded by",
      tags$a(href = "https://agrifooddatacanada.ca/",
             tags$b("Agri-food Data Canada"),
             target = "_blank", style = "color:#3c8dbc;"),
      "with partial support from",
      tags$a(href = "https://www.computeontario.ca/",
             tags$b("Compute Ontario"),
             target = "_blank", style = "color:#3c8dbc;"),
      "through a workshop that laid the foundation for its development.")
  ),
  
  br(), br(),
  
  tags$div(
    style = "
    padding: 20px;
    border-radius: 10px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    text-align: center;
    max-width: 60%;
    margin: auto;
    font-size: 20px;
    line-height: 1.6;
    color: #333333;",
    tags$h4(tags$b("Licensing"), style = "text-align: center;"),
    tags$hr(style = "border: 2px solid #3c8dbc; width: 60px; margin: auto;"),
    
    br(),
    
    p("This application is released under this",
      tags$a(href = "https://github.com/agrifooddatacanada/OAC_Historical_Research_Data_Explorer_App/blob/main/LICENSE.md",
             tags$b("License"),
             target = "_blank", style = "color:#3c8dbc;"))
  )
)

