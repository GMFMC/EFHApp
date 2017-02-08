#setwd("C:/Users/claire.GMFMC/Desktop/R (2)/R/EFHwGit/EFHApp2/EFHApp")

library(shiny)
library(shinydashboard)
library(highcharter)
library(markdown)
library(data.table)
library(car)
library(shinyBS)
library(leaflet)
library(RColorBrewer)
library(DT)
#library(mapview)
library(rgdal)



bib<-read.csv("referencesCombined.csv", na.strings=".")
x<-bib[c(2,4,6,7,8)]
# y<-setcolorder(x,c("Author","Year","Title","Journal"))
x$Journal<-as.character(x$Journal)
x$Journal[is.na(x$Journal)] <- " "

#### Welcome Map .shp files ##

# listRdata<-dir(pattern="*.RData")
# for(i in 1:72){
#   load(listRdata[i])
# }

ER1 <- readOGR(dsn="ER1.shp",layer="ER1")
ER2 <- readOGR(dsn="ER2.shp",layer="ER2")
ER3 <- readOGR(dsn="ER3.shp",layer="ER3")
ER4 <- readOGR(dsn="ER4.shp",layer="ER4")
ER5 <- readOGR(dsn="ER5.shp",layer="ER5")
#ERgulf <- readOGR(dsn="gulfwide.shp",layer="gulfwide")




est <- readOGR(dsn="estuarine.shp",layer="estuarine")
near <- readOGR(dsn="nearshore.shp",layer="nearshore")
off <- readOGR(dsn="offshore.shp",layer="offshore")


### this .RData file contains each of the red drum life stage shapefiles, it's causing 
## the folder to zip too slowly so I'm removing it. Not currently linked to anything##
# load("Reddrum.RData")
# colnames(l@data)[colnames(l@data)=="FID"]<-"Id"


############## JF: 10/12/2016
# redDrumSpawningAdult <-  "https://api.mapbox.com/styles/v1/jfroeschke/ciu703yi500g02inzohq8u5t6/tiles/256/{z}/{x}/{y}?access_token=pk.eyJ1IjoiamZyb2VzY2hrZSIsImEiOiI5SHgwTWk4In0.J6IfXVALdDraXPBfPcyITg"
# redDrumLateJuvenile <- "https://api.mapbox.com/styles/v1/jfroeschke/ciu741ln000g82jo146xsrn21/tiles/256/{z}/{x}/{y}?access_token=pk.eyJ1IjoiamZyb2VzY2hrZSIsImEiOiI5SHgwTWk4In0.J6IfXVALdDraXPBfPcyITg"
# redDrumAdult <- "https://api.mapbox.com/styles/v1/jfroeschke/ciu7a0o0200002jpcl9oc0sqi/tiles/256/{z}/{x}/{y}?access_token=pk.eyJ1IjoiamZyb2VzY2hrZSIsImEiOiI5SHgwTWk4In0.J6IfXVALdDraXPBfPcyITg"
# redSnapperSpawningAdult <- "https://api.mapbox.com/styles/v1/claireroberts/ciuhh70a6000s2imlw05lzaog/tiles/256/{z}/{x}/{y}?access_token=pk.eyJ1IjoiY2xhaXJlcm9iZXJ0cyIsImEiOiJjaWtqdTFyZ3UwOGw2dnRrbTlibDd2OW9yIn0.ccw4vPRr3LiUpAcqyThNig"
# redSnapperLateJuvenile <- "https://api.mapbox.com/styles/v1/claireroberts/ciuhh3ph6001m2io26uyalgi2/tiles/256/{z}/{x}/{y}?access_token=pk.eyJ1IjoiY2xhaXJlcm9iZXJ0cyIsImEiOiJjaWtqdTFyZ3UwOGw2dnRrbTlibDd2OW9yIn0.ccw4vPRr3LiUpAcqyThNig"
##red drum juvenile
## color code : E0E30C

### MapBox Attribution##

map_attr <- "<a href='https://www.mapbox.com/map-feedback/'>Mapbox</a>"


##not used yet: software conflict?
addMouseCoordinates2 <- function (map)
{
  if (inherits(map, "mapview"))
    map <- mapview2leaflet(map)
  stopifnot(inherits(map, "leaflet"))
  map <- htmlwidgets::onRender(map, "\nfunction(el, x, data) {\n  // we need a new div element because we have to handle\n  // the mouseover output seperately\n  debugger;\n  function addElement () {\n    // generate new div Element\n    var newDiv = $(document.createElement('div'));\n    // append at end of leaflet htmlwidget container\n    $(el).append(newDiv);\n    //provide ID and style\n    newDiv.addClass('lnlt');\n    newDiv.css({\n      'position': 'relative',\n      'bottomleft':  '0px',\n      'background-color': 'rgba(255, 255, 255, 1)',\n      'box-shadow': '0 0 2px #bbb',\n      'background-clip': 'padding-box',\n      'margin': '0',\n      'color': '#333',\n      'font': '12px/1.5 \"Helvetica Neue\", Arial, Helvetica, sans-serif',\n    });\n    return newDiv;\n  }\n\n  // check for already existing lnlt class to not duplicate\n  var lnlt = $(el).find('.lnlt');\n  if(!lnlt.length) {\n    lnlt = addElement();\n    // get the leaflet map\n    var map = HTMLWidgets.find('#' + el.id);\n\n    // grab the special div we generated in the beginning\n    // and put the mousmove output there\n    map.on('mousemove', function (e) {\n      lnlt.text(' Latitude: ' + (e.latlng.lat).toFixed(5) +\n      ' | Longitude: ' + (e.latlng.lng).toFixed(5) +\n      ' | Zoom: ' + map.getZoom() + ' '\n      );\n    })\n  };\n}\n")
  map
}

source("r.R") ######### this file contains code to load species profiles, HATs, landings/von bert charts #########
a <- read.csv('maplayers.csv')


##start here: need to add server code for this

## load  others, delete test. For now test linked to red snapper
############ Species Profile ###################################
## -86,28

##  #ffff33  adults color code/ nonspawning Adult
##  #a65628  spawning adults
##  #F781BF  eggs/fertilized eggs
##  #E41A1C  larvae
##  #4DAF4A  postlarvae/puerulusPostlarvae
##  #984EA3  early juveniles/latepostlarvaejuveniles
##  #FF7F00  late juveniles/subAdult/juvenile