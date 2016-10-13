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
      #div(h3("Select species"),style="text-align: center;"),
      div(
        selectInput("selectSpecies", h3("Select species:"),
                    c("Red drum" = "REDDRUM",
                      #"Red snapper" = "REDSNAPPER",
                      selected = "Red drum")))#,
      #style="text-align: center;")
    )
    
  ),
  dashboardBody(
    tabItems(
      
      ## species profiles ##
      tabItem(tabName="sp",
              fluidRow(
                
                column(width=7,
                       box(htmlOutput("prof")
                           ,height=625,width=NULL)),
                
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
                              
                              ############## Add radio buttons instead of SelectInput ############
              #                 selectInput("lifeStage", "Life Stage:",
              #                             c(
              #                               # c("Larvae" = "l",
              #                               #   "Postlarvae"='pL',
              #                               #   "Early Juveniles"="eJ",
              #                               #"Late Juveniles"="lJ",
              #                               #"Spawning Adults" = "spAd"),
              #                               "Late Juveniles" = "redDrumLateJuvenile",
              #                               "Adults" = "redDrumAdult",
              #                               "Spawning Adults" = "redDrumSpawningAdult"), ##JF
              #                             multiple=FALSE, selected = "redDrumSpawningAdult"))),
              # style="text-align: center;")
              
              # radioButtons("lifeStage", label = "Life Stage:",
              #              
              #              c("Late Juveniles" = "redDrumLateJuvenile",
              #                "Adults" = "redDrumAdult",
              #                "Spawning Adults" = "redDrumSpawningAdult"),
              #              selected = "redDrumSpawningAdult")),
              tags$div(HTML('
                 <div id="lifeStage" class="form-group shiny-input-radiogroup shiny-input-container">
                            <label class="control-label" for="rating">Life Stage:</label>
                            <div class="shiny-options-group">
                            <div class="radio">
                            <input type="radio" name="redDrumLateJuvenile" id="redDrumLateJuvenile" value="redDrumLateJuvenile" />
                            <label for="redDrumLateJuvenile"><table><tr><td class="shape"><svg style="width:24px; height:22px;" xmlns="http://www.w3.org/2000/svg" version="1.1"><polygon class="plgn" style="fill: #000000; stroke: #000000; fill-opacity: 0.5; stroke-opacity: 1.0; stroke-width: 1;" points="1.5, 0.5 22.5, 11 22.5, 21.5 1.5, 21.5" /></svg></td><td class="value">Late juvenile</td></tr></table></label>
                            </div>
                            <div class="radio">
                            <input type="radio" name="site" id="ad" value="stackoverflow" />
                            <label for="ad"><table><tr><td class="shape"><svg style="width:24px; height:22px;" xmlns="http://www.w3.org/2000/svg" version="1.1"><polygon class="plgn" style="fill: #5BE15D; stroke: #5BE15D; fill-opacity: 0.5; stroke-opacity: 1.0; stroke-width: 1;" points="1.5, 0.5 22.5, 11 22.5, 21.5 1.5, 21.5" /></svg></td><td class="value">Adults</td></tr></table></label>
                            </div>
                            <div class="radio">
                            <input type="radio" name="site" id="sp" value="stackoverflow" />
                            <label for="sp"><table><tr><td class="shape"><svg style="width:24px; height:22px;" xmlns="http://www.w3.org/2000/svg" version="1.1"><polygon class="plgn" style="fill: #E13333; stroke: #E13333; fill-opacity: 0.5; stroke-opacity: 1.0; stroke-width: 1;" points="1.5, 0.5 22.5, 11 22.5, 21.5 1.5, 21.5" /></svg></td><td class="value">Spawning adults</td></tr></table></label>
                            </div>
                            </div>
                            </div>
                            </div>'))),
              style = "text-align: left;")
      
      #<span><i class="fa fa-star" aria-hidden="true"></i></span></label>
      
      
    ))))