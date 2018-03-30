#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

ui <- function(request){
  dashboardPage( 
  dashboardHeader(title="Essential Fish Habitat Application"),
  dashboardSidebar(
    sidebarMenu(id = "tab",
      menuItem ("Start", tabName = "welcome",icon=icon("home")),
      menuItem("Species Profile", tabName = "sp",icon=icon("file-text-o")),
      menuItem("Habitat Association Table", tabName = "HAT",
               icon=icon("table")),
      menuItem("Bibliography",tabName="bib",icon=icon("list")),
      menuItem("EFH Maps",tabName="map",icon=icon("globe")),
      tags$hr(style="border-color: white;"),
      tags$head(includeCSS("efhStyle.css")),
      
      ### Selector for species ###
      conditionalPanel(condition="input.tab != 'welcome'",
                       #tags$hr(style="border-color: white;"),
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
                      selected = "REDDRUM"))),
      
       ### conditional Panel displays when species is fish and map tab is selected ###
      conditionalPanel(condition="input.tab == 'map' && output.groupsID == '1'",
        div(
        selectInput("fishLifestage", h3("Select lifestage:"),
                    c("Eggs"= "eggs",
                      "Larvae" = "larvae",
                      "Postlarvae" = "postLarvae",
                      "Early juveniles" = "earlyJuvenile",
                      "Late juveniles" = "lateJuvenile",
                      "Adults" = "adult",
                      "Spawning adults" = "spawningAdult" 
                    ),
                    selected = 'adult'))
        ),
      
      ### conditional Panel displays when shrimp and map tab is selected ###
      conditionalPanel(condition="input.tab == 'map' && output.groupsID == '2'",
        div(
          selectInput("shrimpLifestage", h3("Select lifestage:"),
                      c("Fertilized eggs"= "fertilizedEgg",
                        "Larvae, pre-settlement postlarvae" = "larvae",
                        "Late postlarvae, juveniles" = "latePostlarvaeJuvenile",
                        
                        "Sub-adults" = "subAdult",
                        "Non-spawning adults" = "nonSpawningAdult",
                        "Spawning adults" = "spawningAdult"
                      ),
                      selected = 'adult'))
      ),
      
      ### conditional Panel displays when spiny lobster and map tab is selected ###
      conditionalPanel(condition="input.tab == 'map' && output.groupsID == '3'",
                       div(
                         selectInput("spinyLifestage", h3("Select lifestage:"),
                                     c("Phyllosome larvae" = "larvae",
                                       "Puerulus postlarvae" = "puerulusPostlarvae",
                                       "Juveniles" = "juvenile",
                                       "Adults" = "adult"
                                    
                                     ),
                                     selected = 'adult'))
      ),
      
      bookmarkButton(title=HTML('Click here to bookmark the current page with selections retained.
                                Generates a URL to return here.')),
     
      
      tags$hr(style="text-align: center;"),
    
    div(tags$a(img(src="logo.png"),href="http://gulfcouncil.org/index.php"),align='center'),
    br(),
    br(),
    div(tags$a(href="mailto: portal@gulfcouncil.org", "Contact us",style="color:white; 
               font-size:25px; "), align="center")
    
    
    
  )),
  dashboardBody(
    #bookmarkButton(),
     tags$style(type = "text/css", "#map {height: calc(100vh - 80px) !important;}"),
     #tags$style(type = "text/css", "#sp {height: calc(100vh - 80px) !important;}"),
    tabItems(
      
      ## Welcome Tab ##
      tabItem(tabName = "welcome",
        fluidRow(
          column(10, offset = 1,
                 align = "center", includeCSS("efhStyle.css"),
                 h1 (align = "center",strong("Welcome To The Gulf of Mexico Fishery Management Council", br(), "Essential Fish Habitat Portal")),
                 
                 h3(align = 'justify',"This site summarizes the findings of the Council's 2011 - 2016 review of EFH in the Gulf of Mexico. 
                    This review included the development of species profiles, updated habitat association tables, habitat maps, and the 
                    bibliography used to produce the review.  This application is interactive and can be queried by species using the 
                    selection tabs on the left.  If you explore the habitat maps, an addition dropdown menu will appear, allowing you to choose 
                    both a species and lifestage. 
                    
                    These habitat maps were developed to describe habitat use by species and life stage, 
                    but are not the officially accepted designations and should be used for descriptive purposes only.
                    The official designations can be found in", a("2005 Generic 
                    Amendment 3 (GMFMC 2005)",href="http://gulfcouncil.org/Beta/GMFMCWeb/downloads/FINAL3_EFH_Amendment.pdf"), "or", a("here.", 
                    href="http://portal.gulfcouncil.org/efh/")),
                 
                 h3(align = "justify",
                  "For each species managed by the Gulf of Mexico Fishery Management Council, a profile, habitat association table
                    and map of EFH (as identified by this process) have been created. The EFH maps were defined based on five eco-regions identified 
                    in previous EFH documents (Figure 1, Table 1). Within each eco-region, three habitat zones (estuarine, nearshore, offshore; Figure 1.) are recognized,
                    and specific habitat types (Table 2.) were mapped within each eco-region and habitat zone. These were used to develop EFH for each species and
                    lifestage, and are available here for all species managed by the Gulf of Mexico Fishery Management Council. Each of these elements highlight 
                    information regarding species distribution and habitat use, and include new information gathered during this review, along with information from
                    the", a("EFH Final Environmental Impact Statement (GMFMC 2004)",href="http://gulfcouncil.org/Beta/GMFMCWeb/downloads/Final%20EFH%20EIS.pdf"),",",
                  a("EFH Generic Amendment 3 (GMFMC 2005)",href="http://gulfcouncil.org/Beta/GMFMCWeb/downloads/FINAL3_EFH_Amendment.pdf"),
                   ", and the", a("2010 EFH 5-Year Review (GMFMC 2010)",href="http://gulfcouncil.org/Beta/GMFMCWeb/downloads/EFH%205-Year%20Review%20Final%2010-10.pdf"),
                   ".")
            )),
      
        fluidRow(
          
          
          column(7, offset = 2,align= "center",
                 leafletOutput('map2'),
                  
                  h4(strong("Figure 1."), "Spatial depiction of eco-regions and
                     habitat zones, textually described below. Use the button
                     in the map to toggle between the two layers."))
          

        ),
        
        fluidRow(
          br(),
          br(),
          column(5, offset = 1,align = "center",
                 h4(align = "left",strong("Table 1."), "Gulf of Mexico eco-regions and corresponding NOAA Statistical Grids."),
                 includeHTML("welcomeTable.html"),
                               includeCSS("welcomeTableCSS.css"),
                 h4(align = "left",strong("*Note"), ": The specific depth ranges and habitat types used by each species and life stage 
                    can be found in the habitat association table for that species.  In cases where a 
                    life stage is water column associated (WCA) only that habitat type is depicted as it 
                    overlays any other habitat types.")),
          column(5, align = "center",
                 h4(strong("Table 2."), "Twelve habitat types used throughout the habitat association tables and 
                    terms related to those habitat types."),
                 includeHTML("welcomeHabType.html"))
        )
      ),
      
  ########################## species profiles ##########################################
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
      
################################### HAT #########################################################
      tabItem(tabName="HAT",
              htmlOutput("HAT",height=600)
            
              
               #box(htmlOutput("HAT"),height=625)),
      ),

############################ bibliography #########################################################
      tabItem(tabName="bib",
              DT::dataTableOutput('tbl1')),
      
################################# EFH Map ############################################################
      tabItem(tabName='map',
              includeCSS("legendStyle.css"),
              leafletOutput('map',height=600))#,
              #tableOutput('speciesTable'),
              #textOutput('tblXX'))
              
    ))
      
      
    )}