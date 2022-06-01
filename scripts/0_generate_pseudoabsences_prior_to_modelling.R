library(dismo)
library(maptools)
library(rgdal)
library(raster)
library(sp)

setwd('') # change this directory to where you download this DRYAD dataset

#10km rarefied
# FULL_SPECIES
obs.data <- read.csv(file = "./occurrence_data/chimpanzee_occurrences_rarefied_10km.csv")
summary(obs.data)
# Determine geographic extent of our data
max.lat <- ceiling(max(obs.data$Y))
min.lat <- floor(min(obs.data$Y))
max.lon <- ceiling(max(obs.data$X))
min.lon <- floor(min(obs.data$X))
geographic.extent <- extent(x = c(min.lon, max.lon, min.lat, max.lat))
# Before we do any modeling, it is also a good idea to run a reality check on your occurrence data by plotting the points on a map.
# Load the data to use for our base map
wrld_simpl <- readOGR('./map_data/ne_50m_admin_0_countries_lakes.shp')
# Plot the base map
plot(wrld_simpl, 
     xlim = c(min.lon, max.lon),
     ylim = c(min.lat, max.lat),
     axes = TRUE, 
     col = "grey90")
# Add the points for individual observation
points(x = obs.data$X, 
       y = obs.data$Y, 
       col = "olivedrab", 
       pch = 20, 
       cex = 0.75)
# And draw a little box around the graph
# Pseudoabsence:
# Use the bioclim data files for sampling resolution

mask <- raster('./predictor_data/000/bioclim_01.asc') # just use any of the predictors as a mask
template <- readOGR('./map_data/0_5_deg_buff_points.shp')
mask.crop <- crop(mask, template, snap="out") 
crop <- setValues(mask.crop, NA) 
template.r <- rasterize(template, crop) 
mask.masked <- mask(x=mask.crop, mask=template.r) 
plot (mask.masked)
# Randomly sample points (same number as our observed points)
background <- randomPoints(mask = mask.masked,     # Provides resolution of sampling points
                           n = nrow(obs.data),      # Number of random points
                           ext = template)             # Expands sampling a little bit
head(background)
#We can also visualize them on a map, like we did for the observed points:
  # Plot the base map
tiff('./figures/Background_points_for_modelling_rarefied_10km.tiff', height=3000, width=5000, res=300)
  plot(wrld_simpl, 
       xlim = c(min.lon, max.lon),
       ylim = c(min.lat, max.lat),
       axes = TRUE, 
       col = "grey90",
       main = "")
# Add the background points
points(background, col = "grey30", pch = 20, cex = 0.5)
# Add the observations
points(x = obs.data$X, 
       y = obs.data$Y, 
       col = "orange", 
       pch = 19, 
       cex = 0.65)
box()
dev.off()
write.csv(background,file='./occurrence_data/Background_points_for_modelling_rarefied_10km.csv')
