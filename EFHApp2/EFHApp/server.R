#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

server <- function(input, output) {  
  
  ## Species Profiles ##
  # output$prof <- renderUI({
  #   tags$iframe(src = "reddrumSpeciesProfile.html", seamless=NA,width="100%", height = 600,frameborder=0)
  # })
  
  # output$leng <- renderUI({
  #   tags$iframe(src = "RedDrum.html", seamless=NA,  width="100%", height = 275,frameborder=0)
  # })
  
  # output$land <- renderUI({
  #   tags$iframe(src = "RDland.html", seamless=NA,  width="100%", height = 275,frameborder=0)
  # })
  
  ## Habitat Association Table ##
  
  # output$HAT <- renderUI({
  #   tags$iframe(src = "reddrum_HAT.pdf", seamless=NA,  width="100%", height = 600,frameborder=0)
  # })
  
  ## bibliography ##
  output$tbl1 <- DT::renderDataTable(y)
  
  ## map ##
  
  #### None of this works except the leaflet loaded basemap ##
  
  # Select <- reactive({
  #   switch(input$species,
  #          "Red Drum"=R1)
  #   })
  Select2 <- reactive({
    switch(input$lifeStage,
           # "l"=l,
           # 'pL'=pL,
           # "eJ"=eJ,
           # "lJ"=lJ,
           # "ad"=ad,
           # "spAd"=spAd,
           "redDrumLateJuvenile" = redDrumLateJuvenile,
           "redDrumAdult" = redDrumAdult,
           "redDrumSpawningAdult"=redDrumSpawningAdult,
           "redSnapperSpawningAdult"=redSnapperSpawningAdult)
  })
  # colorpal <- reactive({
  #   colorNumeric("BuPu",Select2()$Id)
  # })
  
  
  # colSelect <- reactive({
  #   if (Select2()=l) {
  #     fillColor = "#3B9AB2"
  #   }
  #   if (Select2()=pL) {
  #     fillColor = "#78B7C5"
  #   }
  #   if (Select2()=eJ) {
  #     fillColor = "#EBCC2A"
  #   }
  #   if (Select2()=lJ) {
  #     fillColor = "#E1AF00"
  #   }
  #   if (Select2()=ad) {
  #     fillColor = "#F21A00"
  #   }
  #   if (Select2()=spAd) {
  #     fillColor = "#fc4e2a"
  #   }
  #     })
  
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
        #redDrumSpawningAdult,
        Select2()) %>%
      
      
      
      addControl( html=
                    '<table><tr><td class="shape"><svg style="width:24px; height:22px;" xmlns="http://www.w3.org/2000/svg" version="1.1"><polygon class="plgn" style="fill: #000000; stroke: #000000; fill-opacity: 0.5; stroke-opacity: 1.0; stroke-width: 1;" points="1.5, 0.5 22.5, 11 22.5, 21.5 1.5, 21.5" /></svg></td><td class="value">Late juvenile</td></tr></table>,
                  <table><tr><td class="shape"><svg style="width:24px; height:22px;" xmlns="http://www.w3.org/2000/svg" version="1.1"><polygon class="plgn" style="fill: #5BE15D; stroke: #5BE15D; fill-opacity: 0.5; stroke-opacity: 1.0; stroke-width: 1;" points="1.5, 0.5 22.5, 11 22.5, 21.5 1.5, 21.5" /></svg></td><td class="value">Adults</td></tr></table>,
                  <table><tr><td class="shape"><svg style="width:24px; height:22px;" xmlns="http://www.w3.org/2000/svg" version="1.1"><polygon class="plgn" style="fill: #E13333; stroke: #E13333; fill-opacity: 0.5; stroke-opacity: 1.0; stroke-width: 1;" points="1.5, 0.5 22.5, 11 22.5, 21.5 1.5, 21.5" /></svg></td><td class="value">Spawning adults</td></tr></table>',
                  position=c("bottomleft"))
    
    # addLayersControl(
    #      overlayGroups = c(GROUP))
    
  })
  
  #  observe({
  # 
  #   #factpal <- colorFactor(c("#3B9AB2", "#78B7C5",
  #                             #"#EBCC2A", "#E1AF00" ,"#F21A00"), na.color="transparent",domain=Select2())
  #   #
  #   # factpal <- colorBin(c("#3B9AB2", "#78B7C5",
  #   #                        "#EBCC2A", "#E1AF00" ,"#F21A00"),
  #   #                      na.color="transparent",values(Select2()),bins=7)
  #   # factpal <- colorNumeric(c('#ffffb2','#fed976','#feb24c','#fd8d3c','#fc4e2a','#e31a1c','#b10026'),
  #   #                         na.color="transparent",values(Select2()))
  #   #pal <- colorpal()
  # 
  #   proxy <- leafletProxy("map", data =Select2())
  #   #proxy %>% clearShapes()
  # #   # proxy %>% addLegend(position = "bottomright",
  # #   #                     pal = factpal, values = ColorData)
  #   proxy %>% addPolygons(fillColor="#E1AF00", data = Select2())
  # 
  # })
  
  #####################Select HAT##########
  
  HAT <- reactive({
    switch(input$selectSpecies,
           "REDDRUM" = reddrumHat,
           "REDSNAPPER" = redsnapperHat#,
           # "redDrumSpawningAdult"=redDrumSpawningAdult)
    )
  })
  
  output$HAT <- renderUI({
    tags$iframe(src = HAT(), seamless=NA,  width="100%", height = 600,frameborder=0)
  })
  
  ############### select by species
  profile <-reactive({
    switch(input$selectSpecies,
           "REDDRUM" = reddrumProfile,
           "REDSNAPPER" = redsnapperProfile#,
           # "redDrumSpawningAdult"=redDrumSpawningAdult)
    )
  })
  
  output$prof <- renderUI({
    tags$iframe(src = profile(), seamless=NA,width="100%", height = 600,frameborder=0)
  })
  ###########
  
  ############################### age growth ########################### 
  agegrowth <-reactive({
    switch(input$selectSpecies,
           "REDDRUM" = reddrumAgeGrowth,
           "REDSNAPPER" = redsnapperAgeGrowth#,
           # add other species here)
    )
  })
  
  output$leng <- renderUI({
    tags$iframe(src = agegrowth(), seamless=NA,  width="100%", height = 275,frameborder=0)
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
    tags$iframe(src = landings(), seamless=NA,  width="100%", height = 275,frameborder=0)
  })
  ############################### end landings ########################### 
  
} ## end server
