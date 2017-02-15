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
#### mapview is currently incompatiable with one of these other packages ####
#library(mapview)
library(rgdal)
load("globalData.RData")


## For use when we figure out how to get ESRI WMS tiles working ##
###################################################################
# library(devtools)
# if (!require('leaflet.extras')) devtools::install_github('bhaskarvk/leaflet.extras')
# if (!require('leaflet.esri')) devtools::install_github('bhaskarvk/leaflet.esri')
#URL <- "http://portal.gulfcouncil.org/arcgis/rest/services/CoralWorkingGroup/GoliathGrouper/MapServer/5"
#################################################################################

### read in references CSV (must be coded in UTF8 or search will fail when pushed to web ###

# bib<-read.csv("referencesCombined1.csv", na.strings=".")
# 
# ## remove extraneous columns ##
# x<-bib[c(2,4,6,7,8)]
# 
# x$Journal<-as.character(x$Journal)
# x$Journal[is.na(x$Journal)] <- " "
# 
# #### load Welcome Map .shp files ####
# 
# listRdata<-dir(pattern="*.RData")
# for(i in 1:8){
#   load(listRdata[i])
# }
# 
# #### This file contains code to load species profiles, HATs, and all charts ####
# source("r.R")
# #
# # #### Load CSV with map tile URLs ####
# a <- read.csv('maplayersWMS.csv')
# 
# #### Load CSV that assigns unique group IDs to fish, shrimp, spiny lobster ####
# 
# b<- read.csv('groupsID.csv')
# 
# ### MapBox Attribution##
# 
# map_attr <- "<a href='https://www.mapbox.com/map-feedback/'>Mapbox</a>"
# 
# load("ER1.RData")
# load("ER2.RData")
# load("ER3.RData")
# load("ER4.RData")
# load("ER5.RData")
# load("est.RData")
# load("near.RData")
# load("off.RData")

#ER1 <- readOGR(dsn="ER1.shp",layer="ER1")
# ER2 <- readOGR(dsn="ER2.shp",layer="ER2")
# ER3 <- readOGR(dsn="ER3.shp",layer="ER3")
# ER4 <- readOGR(dsn="ER4.shp",layer="ER4")
# ER5 <- readOGR(dsn="ER5.shp",layer="ER5")
#ERgulf <- readOGR(dsn="gulfwide.shp",layer="gulfwide")




# est <- readOGR(dsn="estuarine.shp",layer="estuarine")
# near <- readOGR(dsn="nearshore.shp",layer="nearshore")
# off <- readOGR(dsn="offshore.shp",layer="offshore")






#### This does not work because of mapview package conflicts ####
# addMouseCoordinates2 <- function (map)
# {
#   if (inherits(map, "mapview"))
#     map <- mapview2leaflet(map)
#   stopifnot(inherits(map, "leaflet"))
#   map <- htmlwidgets::onRender(map, "\nfunction(el, x, data) {\n  // we need a new div element because we have to handle\n  // the mouseover output seperately\n  debugger;\n  function addElement () {\n    // generate new div Element\n    var newDiv = $(document.createElement('div'));\n    // append at end of leaflet htmlwidget container\n    $(el).append(newDiv);\n    //provide ID and style\n    newDiv.addClass('lnlt');\n    newDiv.css({\n      'position': 'relative',\n      'bottomleft':  '0px',\n      'background-color': 'rgba(255, 255, 255, 1)',\n      'box-shadow': '0 0 2px #bbb',\n      'background-clip': 'padding-box',\n      'margin': '0',\n      'color': '#333',\n      'font': '12px/1.5 \"Helvetica Neue\", Arial, Helvetica, sans-serif',\n    });\n    return newDiv;\n  }\n\n  // check for already existing lnlt class to not duplicate\n  var lnlt = $(el).find('.lnlt');\n  if(!lnlt.length) {\n    lnlt = addElement();\n    // get the leaflet map\n    var map = HTMLWidgets.find('#' + el.id);\n\n    // grab the special div we generated in the beginning\n    // and put the mousmove output there\n    map.on('mousemove', function (e) {\n      lnlt.text(' Latitude: ' + (e.latlng.lat).toFixed(5) +\n      ' | Longitude: ' + (e.latlng.lng).toFixed(5) +\n      ' | Zoom: ' + map.getZoom() + ' '\n      );\n    })\n  };\n}\n")
#   map
# }



#### Color codes for map tiles ####
## -86,28

##  #ffff33  adults color code/ nonspawning Adult
##  #a65628  spawning adults
##  #F781BF  eggs/fertilized eggs
##  #E41A1C  larvae
##  #4DAF4A  postlarvae/puerulusPostlarvae
##  #984EA3  early juveniles/latepostlarvaejuveniles
##  #FF7F00  late juveniles/subAdult/juvenile
