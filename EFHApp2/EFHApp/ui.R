#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

ui <- dashboardPage(
  dashboardHeader(title="Essential Fish Habitat Application"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Species Profile", tabName = "sp"),
      menuItem("Habitat Association Table", tabName = "HAT"),
      menuItem("Bibliography",tabName="bib"),
      menuItem("Habitat Maps",tabName="map"),
      tags$hr(style="border-color: white;"),
      tags$head(includeCSS("efhStyle.css")),
      #div(h3("Select species"),style="text-align: center;"),
      div(
        selectInput("selectSpecies", h3("Select species:"),
                    c("Red drum" = "REDDRUM",
                      "Red snapper" = "REDSNAPPER",
                      selected = "Red drum"))),
      tags$hr(style="text-align: center;"),
    
    div(img(src="logo.png"), style="text-align: center;")
    
    
  )),
  dashboardBody(
    tabItems(
      
      ## species profiles ##
      tabItem(tabName="sp",
              fluidRow(
                
                column(width=7,
                       box(htmlOutput("prof"),
                           height=625,width=NULL)),
                
                column(width=5,
                       box(htmlOutput("leng"),height=300,width=NULL),
                       box(htmlOutput("land"),height=300,width=NULL)
                )
              )
      ),
      
      ## HAT ##
      tabItem(tabName="HAT",
              htmlOutput("HAT")
              
              # box(htmlOutput("HAT"),height=625,width=NULL))
      ),
      ## bibliography ##
      tabItem(tabName="bib",
              DT::dataTableOutput('tbl1')),
      
      ## Map ##
      tabItem(tabName='map',
              leafletOutput('map',height=600),
              absolutePanel(id = "controls", class = "panel panel-default", fixed = TRUE,
                            draggable = TRUE, top = 80, left = "auto", right = 20, bottom = "auto",
                            width = 250, height = "auto",
                            #div(img(src="expl7292.png", height=517, width=200), style="text-align: center;"),
                            div(h2("Habitat Explorer"),style="text-align: center;"),
                            div(selectizeInput("species","Species",
                                               c("Red Drum"),multiple=TRUE,selected="Red Drum"),style="text-align: center;"),
                            
                            ###Theoretically the selectInput would work like below, currently not operational ##
                            div(
                              selectInput("lifeStage", "Life Stage:",
                                          c(
                                            # c("Larvae" = "l",
                                            #   "Postlarvae"='pL',
                                            #   "Early Juveniles"="eJ",
                                            #"Late Juveniles"="lJ",
                                            #"Spawning Adults" = "spAd"),
                                            "Late Juveniles" = "redDrumLateJuvenile",
                                            "Adults" = "redDrumAdult",
                                            "Spawning Adults" = "redDrumSpawningAdult",
                                            "Spawning Adults2" = "redSnapperSpawningAdult"), ##JF
                                          multiple=FALSE, selected = "redDrumSpawningAdult"))),
              style="text-align: center;")
      
      
      
      
    )))