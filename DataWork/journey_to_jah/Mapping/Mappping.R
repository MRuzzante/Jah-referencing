
#------------------------------------------------------------------------------#
#                               GPS Monitoring                                 #
#------------------------------------------------------------------------------#

# PURPOSE: Create a shapefile with a map of the polygons from the Journey to Jah
# NOTES:
# WRITTEN BY: Jonas Guthoff aka the brother and Matteo Ruzzante aka the sponge
# INSPIRED BY: Luiza Andardade aka the "chefa"


# Clear memory
# -------------
rm(list=ls())


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

# for MAC
System <- Sys.getenv(x = NULL, unset = "")
User  <- System["USER"]

if (User == "jonasguthoff") {
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
hfc_data				<- file.path(encrypt_journey, "Data")
raw_data       	<- file.path(encrypt_journey, "Raw Identified Data")
hfc_out         <- file.path(encrypt_journey, "Output")

# Part 1: Load point data -----------------------------------------------------
# Load CSV data

points.df <- read.dta13(file.path(raw_data,"clean_map.dta")) 
                                   


# Part 2: Add additional Points -----------------------------------------------

# a.) Frenchman's cove 
points.df <- rbind(points.df, c("Jonas", "2019-04-01", "Frenchman's Cove beach","Beach", 18.175543, -76.400168, ""))

# b.) Tuff Gong Record Studio
points.df <- rbind(points.df, c("Jonas", "2019-04-03" , "Tuff Gong","Cultural Sight", 17.995785, -76.826142))

# c.) Appleton Rum Estate
points.df <- rbind(points.df, c("Jonas", "2019-04-03" , "Appleton Rum Estate","Cultural Sight",18.164515, -77.729109))


# d.) Treasure Beach data points 
# Welcoming Vibes
points.df <- rbind(points.df, c("Jonas", "2019-04-03" , "Welcoming Vibes","Accomodation", 17.887482, -77.762974))

# Jack Sprat
points.df <- rbind(points.df, c("Jonas", "2019-04-03" , "Jack Sprat","Eat and Drink",17.880524,-77.764408))

# Frenchman's Reef
points.df <- rbind(points.df, c("Jonas", "2019-04-04" , "Frenchman's Reef","Eat and Drink", 17.883293, -77.765641))

# Rasta Spot 
points.df <- rbind(points.df, c("Jonas", "2019-04-04" , "Rasta Spot","Eat and Drink", 17.879219, -77.756076))

# Yellow Mellow
points.df <- rbind(points.df, c("Jonas", "2019-04-04" , "Yellow Mellow","Eat and Drink", 17.883123, -77.764583))


# Convert the long/lat variables to numeric
points.df$longitude <- as.numeric(as.character(points.df$longitude))

points.df$latitude  <- as.numeric(as.character(points.df$latitude))

# map the following type of activities
"Accomodation 
Beach 
Cultural Sight 
Eat and Drink 
No bodda"



# PART 5: Real mappppping -----------------------------------------------------
leaflet() %>%
  addTiles() %>%
  addCircleMarkers(data=points.df[points.df$activity == "Accomodation", ],
                   lng = ~longitude,
                   lat = ~latitude,
                   radius = .05,
                   color = "grey",
                   popup = paste0("Rasta man/woman: ", 
                                  points.df$rasta[points.df$activity == "Accomodation"],
                                  "<br>", "Date: ",
                                  points.df$date[points.df$activity == "Accomodation"],
                                  "<br>", "Activity: ",
                                  points.df$activity[points.df$activity == "Accomodation"],
                                  "<br>", "Info: ",
                                  points.df$whatsthepoint[points.df$activity == "Accomodation"],
                                  "<br>", "Location: ", 
                                  points.df$longitude[points.df$activity == "Accomodation"],
                                  ", " ,
                                  points.df$latitude[points.df$activity == "Accomodation"])) %>%
  addCircleMarkers(data=points.df[points.df$activity == "Cultural Sight", ],
                 lng = ~longitude,
                 lat = ~latitude,
                 radius = .05,
                 color = "green",
                 popup = paste0("Rasta man/woman: ", 
                                points.df$rasta[points.df$activity == "Cultural Sight"],
                                "<br>", "Date: ",
                                points.df$date[points.df$activity == "Cultural Sight"],
                                "<br>", "Activity: ",
                                points.df$activity[points.df$activity == "Cultural Sight"],
                                "<br>", "Info: ",
                                points.df$whatsthepoint[points.df$activity == "Cultural Sight"],
                                "<br>", "Location: ", 
                                points.df$longitude[points.df$activity == "Cultural Sight"],
                                ", " ,
                                points.df$latitude[points.df$activity == "Cultural Sight"]) ) %>%
  addCircleMarkers(data=points.df[points.df$activity == "Beach", ],
                 lng = ~longitude,
                 lat = ~latitude,
                 radius = .05,
                 color = "yellow",
                 popup = paste0("Rasta man/woman: ", 
                                points.df$rasta[points.df$activity == "Beach"],
                                "<br>", "Date: ",
                                points.df$date[points.df$activity == "Beach"],
                                "<br>", "Activity: ",
                                points.df$activity[points.df$activity == "Beach"],
                                "<br>", "Info: ",
                                points.df$whatsthepoint[points.df$activity == "Beach"],
                                "<br>", "Location: ", 
                                points.df$longitude[points.df$activity == "Beach"],
                                ", " ,
                                points.df$latitude[points.df$activity == "Beach"])) %>%
  addCircleMarkers(data=points.df[points.df$activity == "Eat and Drink", ],
                 lng = ~longitude,
                 lat = ~latitude,
                 radius = .05,
                 color = "red",
                 popup = paste0("Rasta man/woman: ", 
                                points.df$rasta[points.df$activity == "Eat and Drink"],
                                "<br>", "Date: ",
                                points.df$date[points.df$activity == "Eat and Drink"],
                                "<br>", "Activity: ",
                                points.df$activity[points.df$activity == "Eat and Drink"],
                                "<br>", "Info: ",
                                points.df$whatsthepoint[points.df$activity == "Eat and Drink"],
                                "<br>", "Location: ", 
                                points.df$longitude[points.df$activity == "Eat and Drink"],
                                ", " ,
                                points.df$latitude[points.df$activity == "Eat and Drink"])) %>%
  addCircleMarkers(data=points.df[points.df$activity == "No bodda", ],
                   lng = ~longitude,
                   lat = ~latitude,
                   radius = .05,
                   color = "orange",
                   popup = paste0("Rasta man/woman: ", 
                                  points.df$rasta[points.df$activity == "No bodda"],
                                  "<br>", "Date: ",
                                  points.df$date[points.df$activity == "No bodda"],
                                  "<br>", "Activity: ",
                                  points.df$activity[points.df$activity == "No bodda"],
                                  "<br>", "Info: ",
                                  points.df$whatsthepoint[points.df$activity == "No bodda"],
                                  "<br>", "Location: ", 
                                  points.df$longitude[points.df$activity == "No bodda"],
                                  ", " ,
                                  points.df$latitude[points.df$activity == "No bodda"]))  %>%
addLegend(
  position = "bottomright",
  colors =  c("grey","green","yellow","red","orange"),
  values = points.df$rasta,
  labels = c("Accomodation", "Cultural Sight","Beach","Red like red stripe","other")) 





