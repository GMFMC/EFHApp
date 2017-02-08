#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

server <- function(input, output) {  
  
  
  ################## BIBLIOGRAPHY ##################################
  output$tbl1 <- DT::renderDataTable({
    datatable(x,filter="top",options=list(pageLength=20),
              rownames=FALSE,colnames=c("Footnote","Common name",
                                        "Author", "Title", "Journal")) 
    
  })

 
  ########################## LOAD MAPS ############################
  
  mapSpecies <- reactive({
    switch(input$selectSpecies,
           "ALMACOJACK" = "ALMACOJACK",
           "BANDEDRUDDERFISH" = "BANDEDRUDDERFISH",
           "BLACKGROUPER" = "BLACKGROUPER",
           "BLACKFINSNAPPER" = "BLACKFINSNAPPER",
           "BLUELINETILEFISH" = "BLUELINETILEFISH",
           "BROWNSHRIMP" = "BROWNSHRIMP",
           "COBIA" = "COBIA",
           "CUBERASNAPPER" = "CUBERASNAPPER",
           "GAG" = "GAG",
           "GOLDFACETILEFISH" = "GOLDFACETILEFISH",
           "GOLIATHGROUPER" = "GOLIATHGROUPER",
           "GRAYSNAPPER" = "GRAYSNAPPER",
           "GRAYTRIGGERFISH" = "GRAYTRIGGERFISH",
           "GREATERAMBERJACK" = "GREATERAMBERJACK",
           "HOGFISH" = "HOGFISH",
           "KINGMACKEREL" = "KINGMACKEREL",
           "LANESNAPPER" = "LANESNAPPER",
           "LESSERAMBERJACK" = "LESSERAMBERJACK",
           "MUTTONSNAPPER" = "MUTTONSNAPPER",
           "PINKSHRIMP" = "PINKSHRIMP",
           "QUEENSNAPPER" = "QUEENSNAPPER",
           "REDDRUM" = "REDDRUM",
           "REDGROUPER" = 'REDGROUPER',
           "REDSNAPPER" = "REDSNAPPER",
           "ROYALREDSHRIMP" = "ROYALREDSHRIMP",
           "SCAMP" = "SCAMP",
           "SILKSNAPPER" = "SILKSNAPPER",
           "SNOWYGROUPER" = "SNOWYGROUPER",
           "SPANISHMACKEREL" = "SPANISHMACKEREL",
           "SPECKLEDHIND" = "SPECKLEDHIND",
           "SPINYLOBSTER" = 'SPINYLOBSTER',
           "VERMILIONSNAPPER" = 'VERMILIONSNAPPER',
           "WARSAWGROUPER" = 'WARSAWGROUPER',
           "WENCHMAN" = 'WENCHMAN',
           "WHITESHRIMP" = "WHITESHRIMP",
           "YELLOWEDGEGROUPER" = 'YELLOWEDGEGROUPER', 
           "YELLOWFINGROUPER" = 'YELLOWFINGROUPER',
           "YELLOWMOUTHGROUPER" = "YELLOWMOUTHGROUPER",
           "YELLOWTAILSNAPPER" = "YELLOWTAILSNAPPER"
    )
  })
  
  mapfishLifestage <- reactive({
    switch (input$fishLifestage,
            "spawningAdult"="spawningAdult",
            "adult"="adult",
            "earlyJuvenile" = "earlyJuvenile",
            "lateJuvenile" = "lateJuvenile",
            'larvae' = 'larvae',
            'postLarvae' = 'postLarvae',
            "eggs" = "eggs"
    )
  })
  
  mapshrimpLifestage <- reactive({
    switch (input$shrimpLifestage,
            "fertilizedEgg" = "fertilizedEgg",
            "latePostlarvaeJuvenile" = "latePostlarvaeJuvenile",
            "adult" = "adult",
            "spawningAdult"="spawningAdult",
            "subAdult" = "subAdult",
            "larvae" = "larvae"
            
    )
  })
  
  maplayer2 <- reactive({
     
    if(mapSpecies() == "BROWNSHRIMP"){
      tmp <- subset(a, species==mapSpecies() & lifestage==mapshrimpLifestage())
    } else {
      tmp <- subset(a,species==mapSpecies() & lifestage==mapfishLifestage())
    }

    tmp <- tmp[1,3]

    tmp
  })
  
  output$speciesTable <- renderTable(maplayer2())
  
  output$map <- renderLeaflet({  
    
    
    map <- leaflet() %>% 
      
      addTiles('http://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}',
               options = providerTileOptions(noWrap = TRUE)) %>%
      addTiles('http://server.arcgisonline.com/ArcGIS/rest/services/Reference/World_Boundaries_and_Places/Mapserver/tile/{z}/{y}/{x}',
               options = providerTileOptions(noWrap = TRUE)) %>%
      
      setView(-89.2, 27.64, zoom = 6) %>% 
      addScaleBar(position="bottomright") %>% 
      #addPolygons(fillColor="#E1AF00", data =ad)
      addTiles(
        #redSnapperLateJuvenile %>%   
        maplayer2(),attribution = map_attr) %>%
      addControl(html='<table style="width:100%"><tr>
                      <td><b>*Note</b>: If no map appears for a selected species and 
                      lifestage, then it lacks some information necessary to inform a 
                      habitat map.</td></tr></table>', position=c("bottomleft"),className="info legend note") %>%
  
 
     addControl( html=
                   '<table><tr><td class="shape"><svg style="width:24px; height:22px;" xmlns="http://www.w3.org/2000/svg" version="1.1"><polygon class="plgn" style="fill: #F781BF; stroke: #F781BF; fill-opacity: 1; stroke-opacity: 1.0; stroke-width: 1;" points="1.5, 0.5 22.5, 11 22.5, 21.5 1.5, 21.5" /></svg></td><td class="value">Eggs</td></tr></table>
                  <table><tr><td class="shape"><svg style="width:24px; height:22px;" xmlns="http://www.w3.org/2000/svg" version="1.1"><polygon class="plgn" style="fill: #E41A1C; stroke: #E41A1C; fill-opacity: 1; stroke-opacity: 1.0; stroke-width: 1;" points="1.5, 0.5 22.5, 11 22.5, 21.5 1.5, 21.5" /></svg></td><td class="value">Larvae</td></tr></table>
                  <table><tr><td class="shape"><svg style="width:24px; height:22px;" xmlns="http://www.w3.org/2000/svg" version="1.1"><polygon class="plgn" style="fill: #4DAF4A; stroke: #4DAF4A; fill-opacity: 1; stroke-opacity: 1.0; stroke-width: 1;" points="1.5, 0.5 22.5, 11 22.5, 21.5 1.5, 21.5" /></svg></td><td class="value">Postlarvae</td></tr></table>
                  <table><tr><td class="shape"><svg style="width:24px; height:22px;" xmlns="http://www.w3.org/2000/svg" version="1.1"><polygon class="plgn" style="fill: #984EA3; stroke: #984EA3; fill-opacity: 1; stroke-opacity: 1.0; stroke-width: 1;" points="1.5, 0.5 22.5, 11 22.5, 21.5 1.5, 21.5" /></svg></td><td class="value">Early juvenile</td></tr></table>  
                  <table><tr><td class="shape"><svg style="width:24px; height:22px;" xmlns="http://www.w3.org/2000/svg" version="1.1"><polygon class="plgn" style="fill: #FF7F00; stroke: #FF7F00; fill-opacity: 1; stroke-opacity: 1.0; stroke-width: 1;" points="1.5, 0.5 22.5, 11 22.5, 21.5 1.5, 21.5" /></svg></td><td class="value">Late juvenile</td></tr></table>
                  <table><tr><td class="shape"><svg style="width:24px; height:22px;" xmlns="http://www.w3.org/2000/svg" version="1.1"><polygon class="plgn" style="fill: #ffff33; stroke: #ffff33; fill-opacity: 1; stroke-opacity: 1.0; stroke-width: 1;" points="1.5, 0.5 22.5, 11 22.5, 21.5 1.5, 21.5" /></svg></td><td class="value">Adults</td></tr></table>
                  <table><tr><td class="shape"><svg style="width:24px; height:22px;" xmlns="http://www.w3.org/2000/svg" version="1.1"><polygon class="plgn" style="fill: #a65628; stroke: #a65628; fill-opacity: 1; stroke-opacity: 1.0; stroke-width: 1;" points="1.5, 0.5 22.5, 11 22.5, 21.5 1.5, 21.5" /></svg></td><td class="value">Spawning adults</td></tr></table>',
                  className="info legend shape",
                  position=c("bottomleft"))  
    
    
    # addLayersControl(
    #      overlayGroups = c(GROUP))
    
  })
  
 
  ##################### SELECT HAT ####################################
  
  HAT <- reactive({
    switch(input$selectSpecies,
           "REDDRUM" = reddrumHat,
           "REDSNAPPER" = redsnapperHat,
           "COBIA" = cobiaHat,
           "KINGMACKEREL" = kingHat,
           "SPANISHMACKEREL" = spanishHat,
           "ALMACOJACK" = almacoHat,
           "BANDEDRUDDERFISH" = rudderfishHat,
           "GREATERAMBERJACK" = greaterAJHat,
           "LESSERAMBERJACK" = lesserAJHat,
           "BROWNSHRIMP" = brownshrimpHat,
           "WHITESHRIMP" = whiteshrimpHat,
           'PINKSHRIMP' = pinkshrimpHat,
           "ROYALREDSHRIMP" = royalredHat,
           "SPINYLOBSTER" = spinyHat,
           "QUEENSNAPPER" = queenHat,
           "MUTTONSNAPPER" = muttonHat,
           "BLACKFINSNAPPER"= blackfinHat,
           "CUBERASNAPPER" = cuberaHat,
           "GRAYSNAPPER" = graysnapperHat,
           "LANESNAPPER" = laneHat,
           "SILKSNAPPER" = silkHat,
           "YELLOWTAILSNAPPER" = yellowtailsnapperHat,
           "WENCHMAN" = wenchmanHat,
           "VERMILIONSNAPPER" = vermilionHat,
           "SPECKLEDHIND" = speckledHat,
           "GOLIATHGROUPER" = goliathHat,
           "REDGROUPER" = redgrouperHat,
           "YELLOWEDGEGROUPER" = yellowedgeHat,
           "WARSAWGROUPER" = warsawHat,
           "SNOWYGROUPER" = snowyHat,
           "BLACKGROUPER" = blackHat,
           "YELLOWMOUTHGROUPER" = yellowmouthHat,
           "GAG" = gagHat,
           "SCAMP" = scampHat,
           "YELLOWFINGROUPER" = yellowfinHat,
           "GOLDFACETILEFISH" = goldfaceHat,
           "BLUELINETILEFISH" = bluelineHat,
           "TILEFISH" = tilefishHat,
           "GRAYTRIGGERFISH" = graytriggerfishHat,
           "HOGFISH" = hogfishHat
           # "redDrumSpawningAdult"=redDrumSpawningAdult)
    )
  })
  
  output$HAT <- renderUI({
    tags$iframe(src = HAT(), seamless=NA, style="height: calc(100vh - 80px)",  width="100%",frameborder=0)
  })
  
  ############### SELECT SPECIES PROFILE #######################################
  profile <-reactive({
    switch(input$selectSpecies,
           "REDDRUM" = reddrumProfile,
           "REDSNAPPER" = redsnapperProfile,
           "COBIA" = cobiaProfile,
           "KINGMACKEREL" = kingProfile,
           "SPANISHMACKEREL" = spanishProfile,
           "ALMACOJACK" = almacoProfile,
           "BANDEDRUDDERFISH" = rudderfishProfile,
           "GREATERAMBERJACK" = greaterAJProfile,
           "LESSERAMBERJACK" = lesserAJProfile,
           "BROWNSHRIMP" = brownshrimpProfile,
           "WHITESHRIMP" = whiteshrimpProfile,
           'PINKSHRIMP' = pinkshrimpProfile,
           "ROYALREDSHRIMP" = royalredProfile,
           "SPINYLOBSTER" = spinyProfile,
           "QUEENSNAPPER" = queenProfile,
           "MUTTONSNAPPER" = muttonProfile,
           "BLACKFINSNAPPER"= blackfinProfile,
           "CUBERASNAPPER" = cuberaProfile,
           "GRAYSNAPPER" = graysnapperProfile,
           "LANESNAPPER" = laneProfile,
           "SILKSNAPPER" = silkProfile,
           "YELLOWTAILSNAPPER" = yellowtailsnapperProfile,
           "WENCHMAN" = wenchmanProfile,
           "VERMILIONSNAPPER" = vermilionProfile,
           "SPECKLEDHIND" = speckledProfile,
           "GOLIATHGROUPER" = goliathProfile,
           "REDGROUPER" = redgrouperProfile,
           "YELLOWEDGEGROUPER" = yellowedgeProfile,
           "WARSAWGROUPER" = warsawProfile,
           "SNOWYGROUPER" = snowyProfile,
           "BLACKGROUPER" = blackProfile,
           "YELLOWMOUTHGROUPER" = yellowmouthProfile,
           "GAG" = gagProfile,
           "SCAMP" = scampProfile,
           "YELLOWFINGROUPER" = yellowfinProfile,
           "GOLDFACETILEFISH" = goldfaceProfile,
           "BLUELINETILEFISH" = bluelineProfile,
           "TILEFISH" = tilefishProfile,
           "GRAYTRIGGERFISH" = graytriggerfishProfile,
           "HOGFISH" = hogfishProfile
           # "redDrumSpawningAdult"=redDrumSpawningAdult)
    )
  })
  
  output$prof <- renderUI({
    tags$iframe(src = profile(), seamless=NA,width="100%", style="height: calc(100vh - 80px)",frameborder=0)
  })
  ###########
  
  ############################### age growth ########################### 
  agegrowth <-reactive({
    switch(input$selectSpecies,
           "REDDRUM" = reddrumAgeGrowth,
           "REDSNAPPER" = redsnapperAgeGrowth,
           "COBIA" = cobiaAgeGrowth,
           "KINGMACKEREL" = kingAgeGrowth,
           "SPANISHMACKEREL" = spanishAgeGrowth,
           "ALMACOJACK" = almacoAgeGrowth,
           "BANDEDRUDDERFISH" = rudderfishAgeGrowth,
           "GREATERAMBERJACK" = greaterAJAgeGrowth,
           "LESSERAMBERJACK" = lesserAJAgeGrowth,
           "BROWNSHRIMP" = brownshrimpAgeGrowth,
           "WHITESHRIMP" = whiteshrimpAgeGrowth,
           'PINKSHRIMP' = pinkshrimpAgeGrowth,
           "ROYALREDSHRIMP" = royalredAgeGrowth,
           "SPINYLOBSTER" = spinyAgeGrowth,
           "QUEENSNAPPER" = queenAgeGrowth,
           "MUTTONSNAPPER" = muttonAgeGrowth,
           "BLACKFINSNAPPER"= blackfinAgeGrowth,
           "CUBERASNAPPER" = cuberaAgeGrowth,
           "GRAYSNAPPER" = graysnapperAgeGrowth,
           "LANESNAPPER" = laneAgeGrowth,
           "SILKSNAPPER" = silkAgeGrowth,
           "YELLOWTAILSNAPPER" = yellowtailsnapperAgeGrowth,
           "WENCHMAN" = wenchmanAgeGrowth,
           "VERMILIONSNAPPER" = vermilionAgeGrowth,
           "SPECKLEDHIND" = speckledAgeGrowth,
           "GOLIATHGROUPER" = goliathAgeGrowth,
           "REDGROUPER" = redgrouperAgeGrowth,
           "YELLOWEDGEGROUPER" = yellowedgeAgeGrowth,
           "WARSAWGROUPER" = warsawAgeGrowth,
           "SNOWYGROUPER" = snowyAgeGrowth,
           "BLACKGROUPER" = blackAgeGrowth,
           "YELLOWMOUTHGROUPER" = yellowmouthAgeGrowth,
           "GAG" = gagAgeGrowth,
           "SCAMP" = scampAgeGrowth,
           "YELLOWFINGROUPER" = yellowfinAgeGrowth,
           "GOLDFACETILEFISH" = goldfaceAgeGrowth,
           "BLUELINETILEFISH" = bluelineAgeGrowth,
           "TILEFISH" = tilefishAgeGrowth,
           "GRAYTRIGGERFISH" = graytriggerfishAgeGrowth,
           "HOGFISH" = hogfishAgeGrowth
           # add other species here)
    )
  })
  
  output$leng <- renderUI({
    tags$iframe(src = agegrowth(), seamless=NA,  width="100%", style = "height: 43vh",frameborder=0)
  })
  ############################### end age growth ########################### 
  
  ############################### landings ########################### 
  landings <-reactive({
    switch(input$selectSpecies,
           "REDDRUM" = reddrumLandings,
           "REDSNAPPER" = redsnapperLandings,
           "COBIA" = cobiaLandings,
           "KINGMACKEREL" = kingLandings,
           "SPANISHMACKEREL" = spanishLandings,
           "ALMACOJACK" = almacoLandings,
           "BANDEDRUDDERFISH" = rudderfishLandings,
           "GREATERAMBERJACK" = greaterAJLandings,
           "LESSERAMBERJACK" = lesserAJLandings,
           #"BROWNSHRIMP" = brownshrimpLandings,
           #"WHITESHRIMP" = whiteshrimpLandings,
           #'PINKSHRIMP' = pinkshrimpLandings,
           #"ROYALREDSHRIMP" = royalredLandings,
           "SPINYLOBSTER" = spinyLandings,
           "QUEENSNAPPER" = queenLandings,
           "MUTTONSNAPPER" = muttonLandings,
           "BLACKFINSNAPPER"= blackfinLandings,
           "CUBERASNAPPER" = cuberaLandings,
           "GRAYSNAPPER" = graysnapperLandings,
           "LANESNAPPER" = laneLandings,
           "SILKSNAPPER" = silkLandings,
           "YELLOWTAILSNAPPER" = yellowtailsnapperLandings,
           "WENCHMAN" = wenchmanLandings,
           "VERMILIONSNAPPER" = vermilionLandings,
           "SPECKLEDHIND" = speckledLandings,
           "GOLIATHGROUPER" = goliathLandings,
           "REDGROUPER" = redgrouperLandings,
           "YELLOWEDGEGROUPER" = yellowedgeLandings,
           "WARSAWGROUPER" = warsawLandings,
           "SNOWYGROUPER" = snowyLandings,
           "BLACKGROUPER" = blackLandings,
           "YELLOWMOUTHGROUPER" = yellowmouthLandings,
           "GAG" = gagLandings,
           "SCAMP" = scampLandings,
           "YELLOWFINGROUPER" = yellowfinLandings,
           "GOLDFACETILEFISH" = goldfaceLandings,
           "BLUELINETILEFISH" = bluelineLandings,
           "TILEFISH" = tilefishLandings,
           "GRAYTRIGGERFISH" = graytriggerfishLandings,
           "HOGFISH" = hogfishLandings
           # add other species here)
    )
  })
  
  output$land <- renderUI({
    tags$iframe(src = landings(), seamless=NA,  width="100%", style = "height: 43vh",frameborder=0)
  })
  ############################### end landings ########################### 
  ################## Welcome Page ##########################
  
  
output$map2 <- renderLeaflet({

  map2 <- leaflet() %>%

  addTiles('http://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}',
           options = providerTileOptions(noWrap = TRUE)) %>%
  addTiles('http://server.arcgisonline.com/ArcGIS/rest/services/Reference/World_Boundaries_and_Places/Mapserver/tile/{z}/{y}/{x}',
           options = providerTileOptions(noWrap = TRUE)) %>%

  setView(-88.1, 27.75, zoom = 6) %>%
  addScaleBar(position="bottomright") %>%
  addPolygons(data=ER1,group="Eco-regions",color="#FF0000",fillOpacity = 0.8,stroke=FALSE) %>%
  addPolygons(data=ER2,group="Eco-regions",color="#00A08A",fillOpacity = 0.8,stroke=FALSE) %>%
  addPolygons(data=ER3,group="Eco-regions",color="#F2AD00",fillOpacity = 0.8,stroke=FALSE) %>%
  addPolygons(data=ER4,group="Eco-regions",color="#F98400",fillOpacity = 0.8,stroke=FALSE) %>%
  addPolygons(data=ER5,group="Eco-regions",color="#5BBCD6",fillOpacity = 0.8,stroke=FALSE) %>%
  addPolygons(data=est,group="Habitat zones",color="#35274A",fillOpacity = 0.8,stroke=FALSE) %>%
  addPolygons(data=near,group="Habitat zones",color="#0B775E",fillOpacity = 0.8,stroke=FALSE) %>%
  addPolygons(data=off,group="Habitat zones",color="#EABE94",fillOpacity = 0.8,stroke=FALSE) %>%
  addLayersControl(baseGroups = c("Eco-regions","Habitat zones"),
                     options=layersControlOptions(collapsed=FALSE),position="bottomright") %>%
  hideGroup("Habitat zones")
  # addLegend(colors=c("#FF0000","#00A08A","#F2AD00","#F98400","#5BBCD6"),
  #           labels=c("ER1","ER2","ER3","ER4","ER5")) %>%
  # addLegend(colors=c("#35274A","#0B775E","#EABE94"),
  #           labels=c("Estuarine","Nearshore","Offshore"))

})

observeEvent(input$map2_groups,{
  map2 <- leafletProxy("map2")
  map2 %>% clearControls()
  if (input$map2_groups == 'Eco-regions') {
    map2 %>% addLegend(colors=c("#FF0000","#00A08A","#F2AD00","#F98400","#5BBCD6"),
              labels=c("Eco-region 1","Eco-region 2","Eco-region 3","Eco-region 4","Eco-region 5"),
              opacity = 1)
  }
  if (input$map2_groups == "Habitat zones") {
    map2 %>% addLegend(colors=c("#35274A","#0B775E","#EABE94"),
      labels=c("Estuarine","Nearshore","Offshore"),opacity=1)
  }
})
    # 
  ########## doesn't work #############
  #if (input$map2_groups == "Depth zones" & input$map2_groups =='Eco-regions') {
    #   map2 %>% addLegend(colors=c("#35274A","#0B775E","#EABE94","#FF0000","#00A08A","#F2AD00","#F98400","#5BBCD6"),
    #                      labels=c("Estuarine","Nearshore","Offshore","ER1","ER2","ER3","ER4","ER5"))
    # }
 
 
  

  
} ## end server
