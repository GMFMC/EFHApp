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
    sidebarMenu(id = "tab",
      menuItem ("Welcome", tabName = "welcome"),
      menuItem("Species Profile", tabName = "sp"),
      menuItem("Habitat Association Table", tabName = "HAT"),
      menuItem("Bibliography",tabName="bib"),
      menuItem("Habitat Maps",tabName="map"),
      tags$hr(style="border-color: white;"),
      tags$head(includeCSS("efhStyle.css")),
      #div(h3("Select species"),style="text-align: center;"),
      div(
        selectInput("selectSpecies", h3("Select species:"),
                    c("Almaco jack" = "ALMACOJACK",
                      "Banded rudderfish" = "BANDEDRUDDERFISH",
                      "Black grouper" = "BLACKGROUPER",
                      "Blackfin snapper" = "BLACKFINSNAPPER",
                      "Blueline tilefish" = "BLUELINETILEFISH",
                      "Brown shrimp" = "BROWNSHRIMP",
                      "Cobia" = "COBIA",
                      "Cubera snapper" = "CUBERASNAPPER",
                      "Gag" = "GAG",
                      "Goldface tilefish" = "GOLDFACETILEFISH",
                      "Goliath grouper" = "GOLIATHGROUPER",
                      "Gray snapper" = "GRAYSNAPPER",
                      "Gray triggerfish" = "GRAYTRIGGERFISH",
                      "Greater amberjack" = "GREATERAMBERJACK",
                      "Hogfish" = "HOGFISH",
                      "King mackerel" = "KINGMACKEREL",
                      "Lane snapper" = "LANESNAPPER",
                      "Lesser amberjack" = "LESSERAMBERJACK",
                      "Mutton snapper" = "MUTTONSNAPPER",
                      "Pink shrimp" = "PINKSHRIMP",
                      "Queen snapper" = "QUEENSNAPPER",
                      "Red drum" = "REDDRUM",
                      "Red grouper" = 'REDGROUPER',
                      "Red snapper" = "REDSNAPPER",
                      "Royal red shrimp" = "ROYALREDSHRIMP",
                      "Scamp" = "SCAMP",
                      "Silk snapper" = "SILKSNAPPER",
                      "Snowy grouper" = "SNOWYGROUPER",
                      "Spanish mackerel" = "SPANISHMACKEREL",
                      "Speckled hind" = "SPECKLEDHIND",
                      "Spiny lobster" = 'SPINYLOBSTER',
                      "Vermilion snapper" = 'VERMILIONSNAPPER',
                      "Warsaw grouper" = 'WARSAWGROUPER',
                      "Wenchman" = 'WENCHMAN',
                      "White shrimp" = "WHITESHRIMP",
                      "Yellowedge grouper" = 'YELLOWEDGEGROUPER', 
                      "Yellowfin grouper" = 'YELLOWFINGROUPER',
                      "Yellowmouth grouper" = "YELLOWMOUTHGROUPER",
                      "Yellowtail snapper" = "YELLOWTAILSNAPPER"
                      
                    ),
                      selected = "REDDRUM")),
      conditionalPanel(
        condition = "input.tab == 'map'",
        div(
        selectInput("lifestage", h3("Select lifestage:"),
                    c("Eggs"= "eggs",
                      "Larvae" = "larvae",
                      "Postlarvae" = "postLarvae",
                      "Early juveniles" = "earlyJuvenile",
                      "Late juveniles" = "lateJuvenile",
                      "Adults" = "adult",
                      "Spawning adults" = "spawningAdult" 
                    ),
                    selected = 'adult'))),
      tags$hr(style="text-align: center;"),
    
    div(img(src="logo.png"), style="text-align: center;")
    
    
  )),
  dashboardBody(
     tags$style(type = "text/css", "#map {height: calc(100vh - 80px) !important;}"),
     #tags$style(type = "text/css", "#sp {height: calc(100vh - 80px) !important;}"),
    tabItems(
      
      ## Welcome Tab ##
      tabItem(tabName = "welcome",
        fluidRow(
          column(7, align = "center",
                 h2 ("Welcome To The Gulf of Mexico Fishery Management Council
                     Essential Fish Habitat Application"),
                 
                 h3("This site was compiled from the 2016 5-Year EFH Review. On the left, 
                    you'll see tabs for the species profiles, 
                    habitat association tables, habitat maps, 
                    and bibliography generated during the review. Selecting from the species dropdown menu
                    will populate all other tabs with the information about the species you selected. If you 
                    explore the habitat maps, an addition dropdowm menu will appear, allowing you to choose
                    both a species and life stage."),
                 h3("These habitat maps were developed to shed light on habitat use by species and life stage, 
                    but are not the officially accepted designations. These can be found in 2005 Generic 
                    Amendment 3 (GMFMC 2005) or", a("here.", 
                    href="http://portal.gulfcouncil.org/efh/"), "Species profile, habitat association table
                    and map development is further described below.")
                                                                                                
            
          ),
          column(5,
                 includeHTML("welcomeTable.html"),
                     includeCSS("welcomeTableCSS.css")
          )
        ),
      
        fluidRow(
          #column(7),
          column(5, offset = 7,
                 includeHTML("welcomeHabType.html")
                     
            
          )
        )
      ),
      
      ## species profiles ##
      tabItem(tabName="sp",
              fluidRow(
                
                column(width=7,
                       box(htmlOutput("prof"), style = "height: calc(100vh-80px)",
                           width=NULL)),
                tags$style("#leng{height: 43vh !important;}"),
                tags$style("#land{height: 43vh !important;}"),
                column(width=5,
                       box(htmlOutput("leng"),width=NULL),
                       box(htmlOutput("land"),width=NULL)
                )
              )
      ),
      
      ## HAT ##
      tabItem(tabName="HAT",
              htmlOutput("HAT",height=600)
            
              
               #box(htmlOutput("HAT"),height=625)),
      ),
      ## bibliography ##
      tabItem(tabName="bib",
              DT::dataTableOutput('tbl1')),
      
      ## Map ##
      tabItem(tabName='map',
              leafletOutput('map',height=600))#,
              # absolutePanel(id = "controls", class = "panel panel-default", fixed = TRUE,
              #               draggable = TRUE, top = 80, left = "auto", right = 20, bottom = "auto",
              #               width = 250, height = "auto",
              #               #div(img(src="expl7292.png", height=517, width=200), style="text-align: center;"),
              #               div(h2("Habitat Explorer"),style="text-align: center;"),
              #               div(selectizeInput("species","Species",
              #                                  c("Red Drum"),multiple=TRUE,selected="Red Drum"),style="text-align: center;"),
              #               
              #               ###Theoretically the selectInput would work like below, currently not operational ##
              #               div(
              #                 selectInput("lifeStage", "Life Stage:",
              #                             c(
              #                               # c("Larvae" = "l",
              #                               #   "Postlarvae"='pL',
              #                               #   "Early Juveniles"="eJ",
              #                               #"Late Juveniles"="lJ",
              #                               #"Spawning Adults" = "spAd"),
              #                               "Late Juveniles" = "redDrumLateJuvenile",
              #                               "Adults" = "redDrumAdult",
              #                               "Spawning Adults" = "redDrumSpawningAdult",
              #                               "Spawning Adults2" = "redSnapperSpawningAdult"), ##JF
              #                             multiple=FALSE, selected = "redDrumSpawningAdult"))),
              # style="text-align: center;")
      
    ))
      
      
    )