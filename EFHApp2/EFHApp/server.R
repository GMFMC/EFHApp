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
  output$tbl1 <- DT::renderDataTable(x)
  

 
  ########################## LOAD MAPS ############################
  
  mapSpecies <- reactive({
    switch(input$selectSpecies,
           "REDDRUM"="REDDRUM",
           "REDSNAPPER"="REDSNAPPER",
           'BLACKGROUPER' = 'BLACKGROUPER',
           'BLACKFINSNAPPER' = 'BLACKFINSNAPPER',
           'BLUELINETILEFISH' = 'BLUELINETILEFISH',
           'BROWNSHRIMP' = 'BROWNSHRIMP',
           'COBIA' = 'COBIA',
           'CUBERASNAPPER' = 'CUBERASNAPPER',
           'GAG' = 'GAG',
           'TILEFISH' = 'TILEFISH',
           'GOLDFACETILEFISH' = 'GOLDFACETILEFISH',
           'GOLIATHGROUPER' = 'GOLIATHGROUPER',
           'GRAYTRIGGERFISH' = 'GRAYTRIGGERFISH',
           'HOGFISH' = 'HOGFISH'
    )
  })
  
  mapLifestage <- reactive({
    switch (input$lifestage,
            "spawningAdult"="spawningAdult",
            "adult"="adult",
            'earlyJuvenile' = "earlyJuvenile",
            'lateJuvenile' = "lateJuvenile",
            'larvae' = 'larvae',
            'postLarvae' = 'postLarvae'
    )
  })
  
  maplayer2 <- reactive({
    tmp <- subset(a, species==mapSpecies() & lifestage==mapLifestage())
    
    tmp <- tmp[1,3]
    
    tmp
  })
  
  output$map <- renderLeaflet({  
    
    
    map <- leaflet() %>% 
      
      addTiles('http://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}',
               options = providerTileOptions(noWrap = TRUE)) %>%
      addTiles('http://server.arcgisonline.com/ArcGIS/rest/services/Reference/World_Boundaries_and_Places/Mapserver/tile/{z}/{y}/{x}',
               options = providerTileOptions(noWrap = TRUE)) %>%
      
      setView(-85, 27.75, zoom = 6) %>% 
      addScaleBar(position="bottomright") %>% 
      #addPolygons(fillColor="#E1AF00", data =ad)
      addTiles(
        #redSnapperLateJuvenile %>%   
        maplayer2(),attribution = map_attr) %>%
     addControl( html=
                   '<table><tr><td class="shape"><svg style="width:24px; height:22px;" xmlns="http://www.w3.org/2000/svg" version="1.1"><polygon class="plgn" style="fill: #F781BF; stroke: #F781BF; fill-opacity: 0.5; stroke-opacity: 1.0; stroke-width: 1;" points="1.5, 0.5 22.5, 11 22.5, 21.5 1.5, 21.5" /></svg></td><td class="value">Eggs</td></tr></table>,
                  <table><tr><td class="shape"><svg style="width:24px; height:22px;" xmlns="http://www.w3.org/2000/svg" version="1.1"><polygon class="plgn" style="fill: #E41A1C; stroke: #E41A1C; fill-opacity: 0.5; stroke-opacity: 1.0; stroke-width: 1;" points="1.5, 0.5 22.5, 11 22.5, 21.5 1.5, 21.5" /></svg></td><td class="value">Larvae</td></tr></table>,
                  <table><tr><td class="shape"><svg style="width:24px; height:22px;" xmlns="http://www.w3.org/2000/svg" version="1.1"><polygon class="plgn" style="fill: #4DAF4A; stroke: #4DAF4A; fill-opacity: 0.5; stroke-opacity: 1.0; stroke-width: 1;" points="1.5, 0.5 22.5, 11 22.5, 21.5 1.5, 21.5" /></svg></td><td class="value">Postlarvae</td></tr></table>,
                  <table><tr><td class="shape"><svg style="width:24px; height:22px;" xmlns="http://www.w3.org/2000/svg" version="1.1"><polygon class="plgn" style="fill: #984EA3; stroke: #984EA3; fill-opacity: 0.5; stroke-opacity: 1.0; stroke-width: 1;" points="1.5, 0.5 22.5, 11 22.5, 21.5 1.5, 21.5" /></svg></td><td class="value">Early juvenile</td></tr></table>,  
                  <table><tr><td class="shape"><svg style="width:24px; height:22px;" xmlns="http://www.w3.org/2000/svg" version="1.1"><polygon class="plgn" style="fill: #FF7F00; stroke: #FF7F00; fill-opacity: 0.5; stroke-opacity: 1.0; stroke-width: 1;" points="1.5, 0.5 22.5, 11 22.5, 21.5 1.5, 21.5" /></svg></td><td class="value">Late juvenile</td></tr></table>,
                  <table><tr><td class="shape"><svg style="width:24px; height:22px;" xmlns="http://www.w3.org/2000/svg" version="1.1"><polygon class="plgn" style="fill: #ffff33; stroke: #ffff33; fill-opacity: 0.5; stroke-opacity: 1.0; stroke-width: 1;" points="1.5, 0.5 22.5, 11 22.5, 21.5 1.5, 21.5" /></svg></td><td class="value">Adults</td></tr></table>,
                  <table><tr><td class="shape"><svg style="width:24px; height:22px;" xmlns="http://www.w3.org/2000/svg" version="1.1"><polygon class="plgn" style="fill: #a65628; stroke: #a65628; fill-opacity: 0.5; stroke-opacity: 1.0; stroke-width: 1;" points="1.5, 0.5 22.5, 11 22.5, 21.5 1.5, 21.5" /></svg></td><td class="value">Spawning adults</td></tr></table>',
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
           "REDSNAPPER" = redsnapperLandings#,
           # add other species here)
    )
  })
  
  output$land <- renderUI({
    tags$iframe(src = landings(), seamless=NA,  width="100%", style = "height: 43vh",frameborder=0)
  })
  ############################### end landings ########################### 
  
  

  
} ## end server
