#setwd("C:/Users/claire.GMFMC/Desktop/R (2)/R/EFHApp")

library(shiny)
library(shinydashboard)
library(highcharter)
library(markdown)
library(data.table)
library(car)
library(shinyBS)
library(leaflet)
library(RColorBrewer)
library(mapview)



bib<-read.csv("red_drum.csv", na.strings=".")
x<-bib[c(5,6,7,11)]
y<-setcolorder(x,c("Author","Year","Title","Journal"))
y$Journal<-as.character(y$Journal)
y$Journal[is.na(y$Journal)] <- " "

### this .RData file contains each of the red drum life stage shapefiles, it's causing 
## the folder to zip too slowly so I'm removing it. Not currently linked to anything##
# load("Reddrum.RData")
# colnames(l@data)[colnames(l@data)=="FID"]<-"Id"


############## JF: 10/12/2016
redDrumSpawningAdult <-  "https://api.mapbox.com/styles/v1/jfroeschke/ciu703yi500g02inzohq8u5t6/tiles/256/{z}/{x}/{y}?access_token=pk.eyJ1IjoiamZyb2VzY2hrZSIsImEiOiI5SHgwTWk4In0.J6IfXVALdDraXPBfPcyITg"
redDrumLateJuvenile <- "https://api.mapbox.com/styles/v1/jfroeschke/ciu741ln000g82jo146xsrn21/tiles/256/{z}/{x}/{y}?access_token=pk.eyJ1IjoiamZyb2VzY2hrZSIsImEiOiI5SHgwTWk4In0.J6IfXVALdDraXPBfPcyITg"
redDrumAdult <- "https://api.mapbox.com/styles/v1/jfroeschke/ciu7a0o0200002jpcl9oc0sqi/tiles/256/{z}/{x}/{y}?access_token=pk.eyJ1IjoiamZyb2VzY2hrZSIsImEiOiI5SHgwTWk4In0.J6IfXVALdDraXPBfPcyITg"
##red drum juvenile
## color code : E0E30C

##not used yet: software conflict?
addMouseCoordinates2 <- function (map)
{
  if (inherits(map, "mapview"))
    map <- mapview2leaflet(map)
  stopifnot(inherits(map, "leaflet"))
  map <- htmlwidgets::onRender(map, "\nfunction(el, x, data) {\n  // we need a new div element because we have to handle\n  // the mouseover output seperately\n  debugger;\n  function addElement () {\n    // generate new div Element\n    var newDiv = $(document.createElement('div'));\n    // append at end of leaflet htmlwidget container\n    $(el).append(newDiv);\n    //provide ID and style\n    newDiv.addClass('lnlt');\n    newDiv.css({\n      'position': 'relative',\n      'bottomleft':  '0px',\n      'background-color': 'rgba(255, 255, 255, 1)',\n      'box-shadow': '0 0 2px #bbb',\n      'background-clip': 'padding-box',\n      'margin': '0',\n      'color': '#333',\n      'font': '12px/1.5 \"Helvetica Neue\", Arial, Helvetica, sans-serif',\n    });\n    return newDiv;\n  }\n\n  // check for already existing lnlt class to not duplicate\n  var lnlt = $(el).find('.lnlt');\n  if(!lnlt.length) {\n    lnlt = addElement();\n    // get the leaflet map\n    var map = HTMLWidgets.find('#' + el.id);\n\n    // grab the special div we generated in the beginning\n    // and put the mousmove output there\n    map.on('mousemove', function (e) {\n      lnlt.text(' Latitude: ' + (e.latlng.lat).toFixed(5) +\n      ' | Longitude: ' + (e.latlng.lng).toFixed(5) +\n      ' | Zoom: ' + map.getZoom() + ' '\n      );\n    })\n  };\n}\n")
  map
}

##  #5BE15D  adults