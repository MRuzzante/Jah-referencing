
#------------------------------------------------------------------------------#
#                               GPS Monitoring                                 #
#------------------------------------------------------------------------------#

# PURPOSE: Create a shapefile with a map of the polygons from the Journey to Jah
# NOTES:
# WRITTEN BY: Jonas Guthoff aka the brother and Matteo Ruzzante aka the sponge
# INSPIRED BY: Luiza Andardade aka the "chefa"

# Load packages
# -------------

# List packages used
packages <- c("dplyr",
              "sp", 
              "rgdal", 
              "rgeos",
              "leaflet",
              "ggplot2",
              "raster",
              "geosphere",
              "osrm",
              "readstata13",
              "ggmap",
              "leaflet",
              "mapview")

# If you selected the option to install packages, install them
if (PACKAGES = 1 ) {
  install.packages(packages,
                   dependencies = TRUE) 
}
# If the package installation fails, install separately leaflet by running 'install.packages("shiny", type="binary")' directly in the console
# Load all packages -- this is equivalent to using library(package) for each package listed before sapply(packages, library, character.only = TRUE)
invisible(sapply(packages, library, character.only = TRUE))


#PART 0: Set up folder globals --------------------------------------------------

#-------------#
# Root folder #
#-------------#

# Add your username and folder path here (for Windows computers)
# To find out what your username is, type Sys.getenv("USERNAME")
if (Sys.getenv("USERNAME") == "WB527265") {
  dropbox <- "C:/Users/WB527265/Dropbox/Jah Referencing"
  github  <- "C:/Users/WB527265/Documents/GitHub/Jah-referencing"
}

if (Sys.getenv("USERNAME") == "ruzzante.matteo") {
  dropbox <- "C:/Users/ruzzante.matteo/Dropbox/Jah Referencing"
  github  <- "C:/Users/ruzzante.matteo/Documents/GitHub/Jah-referencing"
}

if (Sys.getenv("USERNAME") == "jonasguthoff") {
  dropbox <- "/Users/jonasguthoff/Dropbox/Jah Referencing"
  github  <- "/Users/jonasguthoff/Github/Jah-referencing"
}

#--------------------#
# Project subfolders #
#--------------------#

dataWorkFolder  <- file.path(dropbox        , "DataWork")
encryptFolder   <- file.path(dataWorkFolder , "EncryptedData")
encrypt_journey <- file.path(encryptFolder  , "Round journey_to_jah Encrypted")
journey_hfc			<- file.path(encrypt_journey, "High Frequency Checks")
hfc_data				<- file.path(journey_hfc    , "Data")
raw_data       	<- file.path(journey_hfc    , "Raw Identified Data")
hfc_out         <- file.path(journey_hfc    , "Output")

# PART 1: Load polygon data -------------------------------------------------
gps <- read.dta13(file.path(hfc_data,"polygon_clean.dta"))

# PART 2: Prepare inputs ----------------------------------------------------
# Order the observations so the map is not tangled
gps <- gps[order(gps$point), ]
# Point data
class(gps) #data frame
# Find out which is the first listed ID so we can create the plot object
first <- unique(gps$polygon)[1]

# PART 3: Create shapefile -------------------------------------------------
# We will create one shapefile for each polygon, then merge them. This is necessary
# because the functions that create it don't work properly if the different plots
# have different number of vertices
for (id in unique(gps$polygon)) {
  # Keep only the vertices of that plot
  map <- subset(gps, gps$polygon == id)[, c("longitude", "latitude")]
  
  # Turn it into a shapefile
  map <- list(Polygon(map))
  map <- list(Polygons(map, id))
  map <- SpatialPolygons(map)
  
  # Save it into the final oject to merge with other polygon
  if (id == first) {
      polygons <- map
  }   else {
      polygons <- rbind(polygons, map)
  }
  
  # Remove the single polygon so we can start it again from scratch
  rm(map)
}

# PART 4: Adjust final shapefile ----------------------------------------------
# Eye check
plot(polygons)

# Merge with the rest of the data
polygons <- SpatialPolygonsDataFrame(polygons, data)
polygons@data$area <- areaPolygon(polygons) * 0.0001

# Projection
proj4string(polygons) <- CRS("+init=epsg:4326")
plot(polygons)

# PART 5: Load point data -----------------------------------------------------

# Load CSV data
point <- read.csv(file.path(hfc_data,"GPS.csv"), 
                                     header = T)

# PART 5: Real mappppping -----------------------------------------------------
leaflet() %>%
  addTiles() %>%
  addCircleMarkers(data=point,
                   lng = ~gpslongitude,
                   lat = ~gpslatitude,
                   radius = .05,
                   color = "green",
                   popup = paste0("Rasta man/woman: ", 
                                  point$rasta,
                                  "<br>", "Date: ",
                                  point$date,
                                  "<br>", "Activity: ",
                                  point$date,
                                  "<br>", "Location: ", 
                                  point$gpslongitude,
                                  ", " ,
                                  point$gpslatitude)) %>%
  addPolygons(data=polygons,
              stroke = TRUE,
              fillColor = "transparent",
              color = "yellow",
              weight = 1.35,
              popup = paste0("Rasta man/woman: ", 
                             polygons$rasta,
                             "<br>", "Date: ",
                             polygons$date,
                             "<br>", "Activity: ",
                             polygons$date,
                             "<br>", "Location: ", 
                             polygons$gpslongitude,
                             ", " ,
                             polygons$gpslatitude))
