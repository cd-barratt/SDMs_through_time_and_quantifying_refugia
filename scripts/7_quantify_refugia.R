library(raster)
library(rgbif)
library(readr)
library(dismo)
library(dplyr)
library(rgdal)
library(sf)

# Simple % stability analysis 10km rarefied

setwd('') # change this directory to where you download this DRYAD dataset
base.dir <- './model_outputs/'

########## CV #################
# all refugia identified by habitat suitability  models per pixel with CV < 3
CV <- raster('./model_outputs/stability/CV_stability.asc')
CV[CV > 3] <- NA
writeRaster( x = CV, filename = './model_outputs/quantification_of_refugia/CV.asc', overwrite = TRUE )
CV[CV] <- 1
plot(CV)
ncell(CV)
CV_pixels <- cellStats(CV, 'sum')
CV_pixels

# cycle through each of the 10 refugial polygons and calculate:
# 1 - total area in pixels of Maley's refugia
# 2 - total area in pixels of the CV < 3 raster
# 3 - % of Maley's refugia covered (i.e. 2/1*100)

# 4, then use the subspecies shapefiles and categorise how much extra refugia is available per subspecies - done once at the end

# 1 
CV <- raster('./model_outputs/stability/CV_stability.asc')
refugia <- readOGR('./map_data/REFUGIA_MALEY96_separated/1.shp')
refugia.crop <- crop(CV, refugia, snap="out")
crop <- setValues(refugia.crop, NA)
template.r <- rasterize(refugia, crop)
refugia.masked <- mask(x=refugia.crop, mask=template.r)
refugia.masked[refugia.masked] <- 1
plot(refugia.masked)
ncell(refugia.masked)
refugia_pixels_1 <- cellStats(refugia.masked, 'sum')
refugia_pixels_1

CV <- raster('./model_outputs/stability/CV_stability.asc')
CV[CV > 3] <- NA
CV[CV] <- 1

CV.crop <- crop(CV, refugia, snap="out")
crop <- setValues(CV.crop, NA)
template.r <- rasterize(refugia, crop)
CV.masked <- mask(x=CV.crop, mask=template.r)
CV.masked[CV.masked] <- 1
plot(CV.masked)
ncell(CV.masked)
CV_in_refugia_pixels_1 <- cellStats(CV.masked, 'sum')
CV_in_refugia_pixels_1

cat("Total area in Maley's refugia  = ", refugia_pixels_1,"\n")
cat("Total area with CV < 3         = ", CV_in_refugia_pixels_1,"\n")
cat("% of Maley's refugia covered   = ", (CV_in_refugia_pixels_1/refugia_pixels_1*100),"\n")



# 2 
CV <- raster('./model_outputs/stability/CV_stability.asc')
refugia <- readOGR('./map_data/REFUGIA_MALEY96_separated/2.shp')
refugia.crop <- crop(CV, refugia, snap="out")
crop <- setValues(refugia.crop, NA)
template.r <- rasterize(refugia, crop)
refugia.masked <- mask(x=refugia.crop, mask=template.r)
refugia.masked[refugia.masked] <- 1
plot(refugia.masked)
ncell(refugia.masked)
refugia_pixels_2 <- cellStats(refugia.masked, 'sum')
refugia_pixels_2

CV <- raster('./model_outputs/stability/CV_stability.asc')
CV[CV > 3] <- NA
CV[CV] <- 1

CV.crop <- crop(CV, refugia, snap="out")
crop <- setValues(CV.crop, NA)
template.r <- rasterize(refugia, crop)
CV.masked <- mask(x=CV.crop, mask=template.r)
CV.masked[CV.masked] <- 1
plot(CV.masked)
ncell(CV.masked)
CV_in_refugia_pixels_2 <- cellStats(CV.masked, 'sum')
CV_in_refugia_pixels_2

cat("Total area in Maley's refugia  = ", refugia_pixels_2,"\n")
cat("Total area with CV < 3         = ", CV_in_refugia_pixels_2,"\n")
cat("% of Maley's refugia covered   = ", (CV_in_refugia_pixels_2/refugia_pixels_2*100),"\n")


# 3 
CV <- raster('./model_outputs/stability/CV_stability.asc')
refugia <- readOGR('./map_data/REFUGIA_MALEY96_separated/3.shp')
refugia.crop <- crop(CV, refugia, snap="out")
crop <- setValues(refugia.crop, NA)
template.r <- rasterize(refugia, crop)
refugia.masked <- mask(x=refugia.crop, mask=template.r)
refugia.masked[refugia.masked] <- 1
plot(refugia.masked)
ncell(refugia.masked)
refugia_pixels_3 <- cellStats(refugia.masked, 'sum')
refugia_pixels_3

CV <- raster('./model_outputs/stability/CV_stability.asc')
CV[CV > 3] <- NA
CV[CV] <- 1

CV.crop <- crop(CV, refugia, snap="out")
crop <- setValues(CV.crop, NA)
template.r <- rasterize(refugia, crop)
CV.masked <- mask(x=CV.crop, mask=template.r)
CV.masked[CV.masked] <- 1
plot(CV.masked)
ncell(CV.masked)
CV_in_refugia_pixels_3 <- cellStats(CV.masked, 'sum')
CV_in_refugia_pixels_3

cat("Total area in Maley's refugia  = ", refugia_pixels_3,"\n")
cat("Total area with CV < 3         = ", CV_in_refugia_pixels_3,"\n")
cat("% of Maley's refugia covered   = ", (CV_in_refugia_pixels_3/refugia_pixels_3*100),"\n")


# 4 
CV <- raster('./model_outputs/stability/CV_stability.asc')
refugia <- readOGR('./map_data/REFUGIA_MALEY96_separated/4.shp')
refugia.crop <- crop(CV, refugia, snap="out")
crop <- setValues(refugia.crop, NA)
template.r <- rasterize(refugia, crop)
refugia.masked <- mask(x=refugia.crop, mask=template.r)
refugia.masked[refugia.masked] <- 1
plot(refugia.masked)
ncell(refugia.masked)
refugia_pixels_4 <- cellStats(refugia.masked, 'sum')
refugia_pixels_4

CV <- raster('./model_outputs/stability/CV_stability.asc')
CV[CV > 3] <- NA
CV[CV] <- 1

CV.crop <- crop(CV, refugia, snap="out")
crop <- setValues(CV.crop, NA)
template.r <- rasterize(refugia, crop)
CV.masked <- mask(x=CV.crop, mask=template.r)
CV.masked[CV.masked] <- 1
plot(CV.masked)
ncell(CV.masked)
CV_in_refugia_pixels_4 <- cellStats(CV.masked, 'sum')
CV_in_refugia_pixels_4

cat("Total area in Maley's refugia  = ", refugia_pixels_4,"\n")
cat("Total area with CV < 3         = ", CV_in_refugia_pixels_4,"\n")
cat("% of Maley's refugia covered   = ", (CV_in_refugia_pixels_4/refugia_pixels_4*100),"\n")


# 5 
CV <- raster('./model_outputs/stability/CV_stability.asc')
refugia <- readOGR('./map_data/REFUGIA_MALEY96_separated/5.shp')
refugia.crop <- crop(CV, refugia, snap="out")
crop <- setValues(refugia.crop, NA)
template.r <- rasterize(refugia, crop)
refugia.masked <- mask(x=refugia.crop, mask=template.r)
refugia.masked[refugia.masked] <- 1
plot(refugia.masked)
ncell(refugia.masked)
refugia_pixels_5 <- cellStats(refugia.masked, 'sum')
refugia_pixels_5

CV <- raster('./model_outputs/stability/CV_stability.asc')
CV[CV > 3] <- NA
CV[CV] <- 1

CV.crop <- crop(CV, refugia, snap="out")
crop <- setValues(CV.crop, NA)
template.r <- rasterize(refugia, crop)
CV.masked <- mask(x=CV.crop, mask=template.r)
CV.masked[CV.masked] <- 1
plot(CV.masked)
ncell(CV.masked)
CV_in_refugia_pixels_5 <- cellStats(CV.masked, 'sum')
CV_in_refugia_pixels_5

cat("Total area in Maley's refugia  = ", refugia_pixels_5,"\n")
cat("Total area with CV < 3         = ", CV_in_refugia_pixels_5,"\n")
cat("% of Maley's refugia covered   = ", (CV_in_refugia_pixels_5/refugia_pixels_5*100),"\n")


# 6 
CV <- raster('./model_outputs/stability/CV_stability.asc')
refugia <- readOGR('./map_data/REFUGIA_MALEY96_separated/6.shp')
refugia.crop <- crop(CV, refugia, snap="out")
crop <- setValues(refugia.crop, NA)
template.r <- rasterize(refugia, crop)
refugia.masked <- mask(x=refugia.crop, mask=template.r)
refugia.masked[refugia.masked] <- 1
plot(refugia.masked)
ncell(refugia.masked)
refugia_pixels_6 <- cellStats(refugia.masked, 'sum')
refugia_pixels_6

CV <- raster('./model_outputs/stability/CV_stability.asc')
CV[CV > 3] <- NA
CV[CV] <- 1

CV.crop <- crop(CV, refugia, snap="out")
crop <- setValues(CV.crop, NA)
template.r <- rasterize(refugia, crop)
CV.masked <- mask(x=CV.crop, mask=template.r)
CV.masked[CV.masked] <- 1
plot(CV.masked)
ncell(CV.masked)
CV_in_refugia_pixels_6 <- cellStats(CV.masked, 'sum')
CV_in_refugia_pixels_6

cat("Total area in Maley's refugia  = ", refugia_pixels_6,"\n")
cat("Total area with CV < 3         = ", CV_in_refugia_pixels_6,"\n")
cat("% of Maley's refugia covered   = ", (CV_in_refugia_pixels_6/refugia_pixels_6*100),"\n")


# 7 
CV <- raster('./model_outputs/stability/CV_stability.asc')
refugia <- readOGR('./map_data/REFUGIA_MALEY96_separated/7.shp')
refugia.crop <- crop(CV, refugia, snap="out")
crop <- setValues(refugia.crop, NA)
template.r <- rasterize(refugia, crop)
refugia.masked <- mask(x=refugia.crop, mask=template.r)
refugia.masked[refugia.masked] <- 1
plot(refugia.masked)
ncell(refugia.masked)
refugia_pixels_7 <- cellStats(refugia.masked, 'sum')
refugia_pixels_7

CV <- raster('./model_outputs/stability/CV_stability.asc')
CV[CV > 3] <- NA
CV[CV] <- 1

CV.crop <- crop(CV, refugia, snap="out")
crop <- setValues(CV.crop, NA)
template.r <- rasterize(refugia, crop)
CV.masked <- mask(x=CV.crop, mask=template.r)
CV.masked[CV.masked] <- 1
plot(CV.masked)
ncell(CV.masked)
CV_in_refugia_pixels_7 <- cellStats(CV.masked, 'sum')
CV_in_refugia_pixels_7

cat("Total area in Maley's refugia  = ", refugia_pixels_7,"\n")
cat("Total area with CV < 3         = ", CV_in_refugia_pixels_7,"\n")
cat("% of Maley's refugia covered   = ", (CV_in_refugia_pixels_7/refugia_pixels_7*100),"\n")


# 8 
CV <- raster('./model_outputs/stability/CV_stability.asc')
refugia <- readOGR('./map_data/REFUGIA_MALEY96_separated/8.shp')
refugia.crop <- crop(CV, refugia, snap="out")
crop <- setValues(refugia.crop, NA)
template.r <- rasterize(refugia, crop)
refugia.masked <- mask(x=refugia.crop, mask=template.r)
refugia.masked[refugia.masked] <- 1
plot(refugia.masked)
ncell(refugia.masked)
refugia_pixels_8 <- cellStats(refugia.masked, 'sum')
refugia_pixels_8

CV <- raster('./model_outputs/stability/CV_stability.asc')
CV[CV > 3] <- NA
CV[CV] <- 1

CV.crop <- crop(CV, refugia, snap="out")
crop <- setValues(CV.crop, NA)
template.r <- rasterize(refugia, crop)
CV.masked <- mask(x=CV.crop, mask=template.r)
CV.masked[CV.masked] <- 1
plot(CV.masked)
ncell(CV.masked)
CV_in_refugia_pixels_8 <- cellStats(CV.masked, 'sum')
CV_in_refugia_pixels_8

cat("Total area in Maley's refugia  = ", refugia_pixels_8,"\n")
cat("Total area with CV < 3         = ", CV_in_refugia_pixels_8,"\n")
cat("% of Maley's refugia covered   = ", (CV_in_refugia_pixels_8/refugia_pixels_8*100),"\n")


# 9 
CV <- raster('./model_outputs/stability/CV_stability.asc')
refugia <- readOGR('./map_data/REFUGIA_MALEY96_separated/9.shp')
refugia.crop <- crop(CV, refugia, snap="out")
crop <- setValues(refugia.crop, NA)
template.r <- rasterize(refugia, crop)
refugia.masked <- mask(x=refugia.crop, mask=template.r)
refugia.masked[refugia.masked] <- 1
plot(refugia.masked)
ncell(refugia.masked)
refugia_pixels_9 <- cellStats(refugia.masked, 'sum')
refugia_pixels_9

CV <- raster('./model_outputs/stability/CV_stability.asc')
CV[CV > 3] <- NA
CV[CV] <- 1

CV.crop <- crop(CV, refugia, snap="out")
crop <- setValues(CV.crop, NA)
template.r <- rasterize(refugia, crop)
CV.masked <- mask(x=CV.crop, mask=template.r)
CV.masked[CV.masked] <- 1
plot(CV.masked)
ncell(CV.masked)
CV_in_refugia_pixels_9 <- cellStats(CV.masked, 'sum')
CV_in_refugia_pixels_9

cat("Total area in Maley's refugia  = ", refugia_pixels_9,"\n")
cat("Total area with CV < 3         = ", CV_in_refugia_pixels_9,"\n")
cat("% of Maley's refugia covered   = ", (CV_in_refugia_pixels_9/refugia_pixels_9*100),"\n")


# 10 
CV <- raster('./model_outputs/stability/CV_stability.asc')
refugia <- readOGR('./map_data/REFUGIA_MALEY96_separated/10.shp')
refugia.crop <- crop(CV, refugia, snap="out")
crop <- setValues(refugia.crop, NA)
template.r <- rasterize(refugia, crop)
refugia.masked <- mask(x=refugia.crop, mask=template.r)
refugia.masked[refugia.masked] <- 1
plot(refugia.masked)
ncell(refugia.masked)
refugia_pixels_10 <- cellStats(refugia.masked, 'sum')
refugia_pixels_10

CV <- raster('./model_outputs/stability/CV_stability.asc')
CV[CV > 3] <- NA
CV[CV] <- 1

CV.crop <- crop(CV, refugia, snap="out")
crop <- setValues(CV.crop, NA)
template.r <- rasterize(refugia, crop)
CV.masked <- mask(x=CV.crop, mask=template.r)
CV.masked[CV.masked] <- 1
plot(CV.masked)
ncell(CV.masked)
CV_in_refugia_pixels_10 <- cellStats(CV.masked, 'sum')
CV_in_refugia_pixels_10

cat("Total area in Maley's refugia  = ", refugia_pixels_10,"\n")
cat("Total area with CV < 3         = ", CV_in_refugia_pixels_10,"\n")
cat("% of Maley's refugia covered   = ", (CV_in_refugia_pixels_10/refugia_pixels_10*100),"\n")


########## static #################
# all refugia identified by habitat suitability  models per pixel with static < 3
static <- raster('./model_outputs/stability/static_stability_mean.asc')
static[static < 0.97 ] <- NA
writeRaster( x = static, filename = './model_outputs/quantification_of_refugia/static.asc', overwrite = TRUE )
static[static] <- 1
plot(static)
ncell(static)
static_pixels <- cellStats(static, 'sum')
static_pixels

# cycle through each of the 10 refugial polygons and calculate:
# 1 - total area in pixels of Maley's refugia
# 2 - total area in pixels of the static < 3 raster
# 3 - % of Maley's refugia covered (i.e. 2/1*100)

# 4, then use the subspecies shapefiles and categorise how much extra refugia is available per subspecies - done once at the end

# 1 
static <- raster('./model_outputs/stability/static_stability_mean.asc')
refugia <- readOGR('./map_data/REFUGIA_MALEY96_separated/1.shp')
refugia.crop <- crop(static, refugia, snap="out")
crop <- setValues(refugia.crop, NA)
template.r <- rasterize(refugia, crop)
refugia.masked <- mask(x=refugia.crop, mask=template.r)
refugia.masked[refugia.masked] <- 1
plot(refugia.masked)
ncell(refugia.masked)
refugia_pixels_1 <- cellStats(refugia.masked, 'sum')
refugia_pixels_1

static <- raster('./model_outputs/stability/static_stability_mean.asc')
static[static < 0.97] <- NA
static[static] <- 1

static.crop <- crop(static, refugia, snap="out")
crop <- setValues(static.crop, NA)
template.r <- rasterize(refugia, crop)
static.masked <- mask(x=static.crop, mask=template.r)
static.masked[static.masked] <- 1
plot(static.masked)
ncell(static.masked)
static_in_refugia_pixels_1 <- cellStats(static.masked, 'sum')
static_in_refugia_pixels_1

cat("Total area in Maley's refugia  = ", refugia_pixels_1,"\n")
cat("Total area with static < 3         = ", static_in_refugia_pixels_1,"\n")
cat("% of Maley's refugia covered   = ", (static_in_refugia_pixels_1/refugia_pixels_1*100),"\n")



# 2 
static <- raster('./model_outputs/stability/static_stability_mean.asc')
refugia <- readOGR('./map_data/REFUGIA_MALEY96_separated/2.shp')
refugia.crop <- crop(static, refugia, snap="out")
crop <- setValues(refugia.crop, NA)
template.r <- rasterize(refugia, crop)
refugia.masked <- mask(x=refugia.crop, mask=template.r)
refugia.masked[refugia.masked] <- 1
plot(refugia.masked)
ncell(refugia.masked)
refugia_pixels_2 <- cellStats(refugia.masked, 'sum')
refugia_pixels_2

static <- raster('./model_outputs/stability/static_stability_mean.asc')
static[static < 0.97] <- NA
static[static] <- 1

static.crop <- crop(static, refugia, snap="out")
crop <- setValues(static.crop, NA)
template.r <- rasterize(refugia, crop)
static.masked <- mask(x=static.crop, mask=template.r)
static.masked[static.masked] <- 1
plot(static.masked)
ncell(static.masked)
static_in_refugia_pixels_2 <- cellStats(static.masked, 'sum')
static_in_refugia_pixels_2

cat("Total area in Maley's refugia  = ", refugia_pixels_2,"\n")
cat("Total area with static < 3         = ", static_in_refugia_pixels_2,"\n")
cat("% of Maley's refugia covered   = ", (static_in_refugia_pixels_2/refugia_pixels_2*100),"\n")


# 3 
static <- raster('./model_outputs/stability/static_stability_mean.asc')
refugia <- readOGR('./map_data/REFUGIA_MALEY96_separated/3.shp')
refugia.crop <- crop(static, refugia, snap="out")
crop <- setValues(refugia.crop, NA)
template.r <- rasterize(refugia, crop)
refugia.masked <- mask(x=refugia.crop, mask=template.r)
refugia.masked[refugia.masked] <- 1
plot(refugia.masked)
ncell(refugia.masked)
refugia_pixels_3 <- cellStats(refugia.masked, 'sum')
refugia_pixels_3

static <- raster('./model_outputs/stability/static_stability_mean.asc')
static[static < 0.97] <- NA
static[static] <- 1

static.crop <- crop(static, refugia, snap="out")
crop <- setValues(static.crop, NA)
template.r <- rasterize(refugia, crop)
static.masked <- mask(x=static.crop, mask=template.r)
static.masked[static.masked] <- 1
plot(static.masked)
ncell(static.masked)
static_in_refugia_pixels_3 <- cellStats(static.masked, 'sum')
static_in_refugia_pixels_3

cat("Total area in Maley's refugia  = ", refugia_pixels_3,"\n")
cat("Total area with static < 3         = ", static_in_refugia_pixels_3,"\n")
cat("% of Maley's refugia covered   = ", (static_in_refugia_pixels_3/refugia_pixels_3*100),"\n")


# 4 
static <- raster('./model_outputs/stability/static_stability_mean.asc')
refugia <- readOGR('./map_data/REFUGIA_MALEY96_separated/4.shp')
refugia.crop <- crop(static, refugia, snap="out")
crop <- setValues(refugia.crop, NA)
template.r <- rasterize(refugia, crop)
refugia.masked <- mask(x=refugia.crop, mask=template.r)
refugia.masked[refugia.masked] <- 1
plot(refugia.masked)
ncell(refugia.masked)
refugia_pixels_4 <- cellStats(refugia.masked, 'sum')
refugia_pixels_4

static <- raster('./model_outputs/stability/static_stability_mean.asc')
static[static < 0.97] <- NA
static[static] <- 1

static.crop <- crop(static, refugia, snap="out")
crop <- setValues(static.crop, NA)
template.r <- rasterize(refugia, crop)
static.masked <- mask(x=static.crop, mask=template.r)
static.masked[static.masked] <- 1
plot(static.masked)
ncell(static.masked)
static_in_refugia_pixels_4 <- cellStats(static.masked, 'sum')
static_in_refugia_pixels_4

cat("Total area in Maley's refugia  = ", refugia_pixels_4,"\n")
cat("Total area with static < 3         = ", static_in_refugia_pixels_4,"\n")
cat("% of Maley's refugia covered   = ", (static_in_refugia_pixels_4/refugia_pixels_4*100),"\n")


# 5 
static <- raster('./model_outputs/stability/static_stability_mean.asc')
refugia <- readOGR('./map_data/REFUGIA_MALEY96_separated/5.shp')
refugia.crop <- crop(static, refugia, snap="out")
crop <- setValues(refugia.crop, NA)
template.r <- rasterize(refugia, crop)
refugia.masked <- mask(x=refugia.crop, mask=template.r)
refugia.masked[refugia.masked] <- 1
plot(refugia.masked)
ncell(refugia.masked)
refugia_pixels_5 <- cellStats(refugia.masked, 'sum')
refugia_pixels_5

static <- raster('./model_outputs/stability/static_stability_mean.asc')
static[static < 0.97] <- NA
static[static] <- 1

static.crop <- crop(static, refugia, snap="out")
crop <- setValues(static.crop, NA)
template.r <- rasterize(refugia, crop)
static.masked <- mask(x=static.crop, mask=template.r)
static.masked[static.masked] <- 1
plot(static.masked)
ncell(static.masked)
static_in_refugia_pixels_5 <- cellStats(static.masked, 'sum')
static_in_refugia_pixels_5

cat("Total area in Maley's refugia  = ", refugia_pixels_5,"\n")
cat("Total area with static < 3         = ", static_in_refugia_pixels_5,"\n")
cat("% of Maley's refugia covered   = ", (static_in_refugia_pixels_5/refugia_pixels_5*100),"\n")


# 6 
static <- raster('./model_outputs/stability/static_stability_mean.asc')
refugia <- readOGR('./map_data/REFUGIA_MALEY96_separated/6.shp')
refugia.crop <- crop(static, refugia, snap="out")
crop <- setValues(refugia.crop, NA)
template.r <- rasterize(refugia, crop)
refugia.masked <- mask(x=refugia.crop, mask=template.r)
refugia.masked[refugia.masked] <- 1
plot(refugia.masked)
ncell(refugia.masked)
refugia_pixels_6 <- cellStats(refugia.masked, 'sum')
refugia_pixels_6

static <- raster('./model_outputs/stability/static_stability_mean.asc')
static[static < 0.97] <- NA
static[static] <- 1

static.crop <- crop(static, refugia, snap="out")
crop <- setValues(static.crop, NA)
template.r <- rasterize(refugia, crop)
static.masked <- mask(x=static.crop, mask=template.r)
static.masked[static.masked] <- 1
plot(static.masked)
ncell(static.masked)
static_in_refugia_pixels_6 <- cellStats(static.masked, 'sum')
static_in_refugia_pixels_6

cat("Total area in Maley's refugia  = ", refugia_pixels_6,"\n")
cat("Total area with static < 3         = ", static_in_refugia_pixels_6,"\n")
cat("% of Maley's refugia covered   = ", (static_in_refugia_pixels_6/refugia_pixels_6*100),"\n")


# 7 
static <- raster('./model_outputs/stability/static_stability_mean.asc')
refugia <- readOGR('./map_data/REFUGIA_MALEY96_separated/7.shp')
refugia.crop <- crop(static, refugia, snap="out")
crop <- setValues(refugia.crop, NA)
template.r <- rasterize(refugia, crop)
refugia.masked <- mask(x=refugia.crop, mask=template.r)
refugia.masked[refugia.masked] <- 1
plot(refugia.masked)
ncell(refugia.masked)
refugia_pixels_7 <- cellStats(refugia.masked, 'sum')
refugia_pixels_7

static <- raster('./model_outputs/stability/static_stability_mean.asc')
static[static < 0.97] <- NA
static[static] <- 1

static.crop <- crop(static, refugia, snap="out")
crop <- setValues(static.crop, NA)
template.r <- rasterize(refugia, crop)
static.masked <- mask(x=static.crop, mask=template.r)
static.masked[static.masked] <- 1
plot(static.masked)
ncell(static.masked)
static_in_refugia_pixels_7 <- cellStats(static.masked, 'sum')
static_in_refugia_pixels_7

cat("Total area in Maley's refugia  = ", refugia_pixels_7,"\n")
cat("Total area with static < 3         = ", static_in_refugia_pixels_7,"\n")
cat("% of Maley's refugia covered   = ", (static_in_refugia_pixels_7/refugia_pixels_7*100),"\n")


# 8 
static <- raster('./model_outputs/stability/static_stability_mean.asc')
refugia <- readOGR('./map_data/REFUGIA_MALEY96_separated/8.shp')
refugia.crop <- crop(static, refugia, snap="out")
crop <- setValues(refugia.crop, NA)
template.r <- rasterize(refugia, crop)
refugia.masked <- mask(x=refugia.crop, mask=template.r)
refugia.masked[refugia.masked] <- 1
plot(refugia.masked)
ncell(refugia.masked)
refugia_pixels_8 <- cellStats(refugia.masked, 'sum')
refugia_pixels_8

static <- raster('./model_outputs/stability/static_stability_mean.asc')
static[static < 0.97] <- NA
static[static] <- 1

static.crop <- crop(static, refugia, snap="out")
crop <- setValues(static.crop, NA)
template.r <- rasterize(refugia, crop)
static.masked <- mask(x=static.crop, mask=template.r)
static.masked[static.masked] <- 1
plot(static.masked)
ncell(static.masked)
static_in_refugia_pixels_8 <- cellStats(static.masked, 'sum')
static_in_refugia_pixels_8

cat("Total area in Maley's refugia  = ", refugia_pixels_8,"\n")
cat("Total area with static < 3         = ", static_in_refugia_pixels_8,"\n")
cat("% of Maley's refugia covered   = ", (static_in_refugia_pixels_8/refugia_pixels_8*100),"\n")


# 9 
static <- raster('./model_outputs/stability/static_stability_mean.asc')
refugia <- readOGR('./map_data/REFUGIA_MALEY96_separated/9.shp')
refugia.crop <- crop(static, refugia, snap="out")
crop <- setValues(refugia.crop, NA)
template.r <- rasterize(refugia, crop)
refugia.masked <- mask(x=refugia.crop, mask=template.r)
refugia.masked[refugia.masked] <- 1
plot(refugia.masked)
ncell(refugia.masked)
refugia_pixels_9 <- cellStats(refugia.masked, 'sum')
refugia_pixels_9

static <- raster('./model_outputs/stability/static_stability_mean.asc')
static[static < 0.97] <- NA
static[static] <- 1

static.crop <- crop(static, refugia, snap="out")
crop <- setValues(static.crop, NA)
template.r <- rasterize(refugia, crop)
static.masked <- mask(x=static.crop, mask=template.r)
static.masked[static.masked] <- 1
plot(static.masked)
ncell(static.masked)
static_in_refugia_pixels_9 <- cellStats(static.masked, 'sum')
static_in_refugia_pixels_9

cat("Total area in Maley's refugia  = ", refugia_pixels_9,"\n")
cat("Total area with static < 3         = ", static_in_refugia_pixels_9,"\n")
cat("% of Maley's refugia covered   = ", (static_in_refugia_pixels_9/refugia_pixels_9*100),"\n")


# 10 
static <- raster('./model_outputs/stability/static_stability_mean.asc')
refugia <- readOGR('./map_data/REFUGIA_MALEY96_separated/10.shp')
refugia.crop <- crop(static, refugia, snap="out")
crop <- setValues(refugia.crop, NA)
template.r <- rasterize(refugia, crop)
refugia.masked <- mask(x=refugia.crop, mask=template.r)
refugia.masked[refugia.masked] <- 1
plot(refugia.masked)
ncell(refugia.masked)
refugia_pixels_10 <- cellStats(refugia.masked, 'sum')
refugia_pixels_10

static <- raster('./model_outputs/stability/static_stability_mean.asc')
static[static < 0.97] <- NA
static[static] <- 1

static.crop <- crop(static, refugia, snap="out")
crop <- setValues(static.crop, NA)
template.r <- rasterize(refugia, crop)
static.masked <- mask(x=static.crop, mask=template.r)
static.masked[static.masked] <- 1
plot(static.masked)
ncell(static.masked)
static_in_refugia_pixels_10 <- cellStats(static.masked, 'sum')
static_in_refugia_pixels_10

cat("Total area in Maley's refugia  = ", refugia_pixels_10,"\n")
cat("Total area with static < 3         = ", static_in_refugia_pixels_10,"\n")
cat("% of Maley's refugia covered   = ", (static_in_refugia_pixels_10/refugia_pixels_10*100),"\n")


########## dynamic #################
# all refugia identified by habitat suitability  models per pixel with dynamic < 3
dynamic <- raster('./model_outputs/stability/dynamic_stability_5.asc')
dynamic[dynamic < 0.97 ] <- NA
writeRaster( x = dynamic, filename = './model_outputs/quantification_of_refugia/dynamic.asc', overwrite = TRUE )
dynamic[dynamic] <- 1
plot(dynamic)
ncell(dynamic)
dynamic_pixels <- cellStats(dynamic, 'sum')
dynamic_pixels

# cycle through each of the 10 refugial polygons and calculate:
# 1 - total area in pixels of Maley's refugia
# 2 - total area in pixels of the dynamic < 3 raster
# 3 - % of Maley's refugia covered (i.e. 2/1*100)

# 4, then use the subspecies shapefiles and categorise how much extra refugia is available per subspecies - done once at the end

# 1 
dynamic <- raster('./model_outputs/stability/dynamic_stability_5.asc')
refugia <- readOGR('./map_data/REFUGIA_MALEY96_separated/1.shp')
refugia.crop <- crop(dynamic, refugia, snap="out")
crop <- setValues(refugia.crop, NA)
template.r <- rasterize(refugia, crop)
refugia.masked <- mask(x=refugia.crop, mask=template.r)
refugia.masked[refugia.masked] <- 1
plot(refugia.masked)
ncell(refugia.masked)
refugia_pixels_1 <- cellStats(refugia.masked, 'sum')
refugia_pixels_1

dynamic <- raster('./model_outputs/stability/dynamic_stability_5.asc')
dynamic[dynamic < 0.97] <- NA
dynamic[dynamic] <- 1

dynamic.crop <- crop(dynamic, refugia, snap="out")
crop <- setValues(dynamic.crop, NA)
template.r <- rasterize(refugia, crop)
dynamic.masked <- mask(x=dynamic.crop, mask=template.r)
dynamic.masked[dynamic.masked] <- 1
plot(dynamic.masked)
ncell(dynamic.masked)
dynamic_in_refugia_pixels_1 <- cellStats(dynamic.masked, 'sum')
dynamic_in_refugia_pixels_1

cat("Total area in Maley's refugia  = ", refugia_pixels_1,"\n")
cat("Total area with dynamic < 3         = ", dynamic_in_refugia_pixels_1,"\n")
cat("% of Maley's refugia covered   = ", (dynamic_in_refugia_pixels_1/refugia_pixels_1*100),"\n")



# 2 
dynamic <- raster('./model_outputs/stability/dynamic_stability_5.asc')
refugia <- readOGR('./map_data/REFUGIA_MALEY96_separated/2.shp')
refugia.crop <- crop(dynamic, refugia, snap="out")
crop <- setValues(refugia.crop, NA)
template.r <- rasterize(refugia, crop)
refugia.masked <- mask(x=refugia.crop, mask=template.r)
refugia.masked[refugia.masked] <- 1
plot(refugia.masked)
ncell(refugia.masked)
refugia_pixels_2 <- cellStats(refugia.masked, 'sum')
refugia_pixels_2

dynamic <- raster('./model_outputs/stability/dynamic_stability_5.asc')
dynamic[dynamic < 0.97] <- NA
dynamic[dynamic] <- 1

dynamic.crop <- crop(dynamic, refugia, snap="out")
crop <- setValues(dynamic.crop, NA)
template.r <- rasterize(refugia, crop)
dynamic.masked <- mask(x=dynamic.crop, mask=template.r)
dynamic.masked[dynamic.masked] <- 1
plot(dynamic.masked)
ncell(dynamic.masked)
dynamic_in_refugia_pixels_2 <- cellStats(dynamic.masked, 'sum')
dynamic_in_refugia_pixels_2

cat("Total area in Maley's refugia  = ", refugia_pixels_2,"\n")
cat("Total area with dynamic < 3         = ", dynamic_in_refugia_pixels_2,"\n")
cat("% of Maley's refugia covered   = ", (dynamic_in_refugia_pixels_2/refugia_pixels_2*100),"\n")


# 3 
dynamic <- raster('./model_outputs/stability/dynamic_stability_5.asc')
refugia <- readOGR('./map_data/REFUGIA_MALEY96_separated/3.shp')
refugia.crop <- crop(dynamic, refugia, snap="out")
crop <- setValues(refugia.crop, NA)
template.r <- rasterize(refugia, crop)
refugia.masked <- mask(x=refugia.crop, mask=template.r)
refugia.masked[refugia.masked] <- 1
plot(refugia.masked)
ncell(refugia.masked)
refugia_pixels_3 <- cellStats(refugia.masked, 'sum')
refugia_pixels_3

dynamic <- raster('./model_outputs/stability/dynamic_stability_5.asc')
dynamic[dynamic < 0.97] <- NA
dynamic[dynamic] <- 1

dynamic.crop <- crop(dynamic, refugia, snap="out")
crop <- setValues(dynamic.crop, NA)
template.r <- rasterize(refugia, crop)
dynamic.masked <- mask(x=dynamic.crop, mask=template.r)
dynamic.masked[dynamic.masked] <- 1
plot(dynamic.masked)
ncell(dynamic.masked)
dynamic_in_refugia_pixels_3 <- cellStats(dynamic.masked, 'sum')
dynamic_in_refugia_pixels_3

cat("Total area in Maley's refugia  = ", refugia_pixels_3,"\n")
cat("Total area with dynamic < 3         = ", dynamic_in_refugia_pixels_3,"\n")
cat("% of Maley's refugia covered   = ", (dynamic_in_refugia_pixels_3/refugia_pixels_3*100),"\n")


# 4 
dynamic <- raster('./model_outputs/stability/dynamic_stability_5.asc')
refugia <- readOGR('./map_data/REFUGIA_MALEY96_separated/4.shp')
refugia.crop <- crop(dynamic, refugia, snap="out")
crop <- setValues(refugia.crop, NA)
template.r <- rasterize(refugia, crop)
refugia.masked <- mask(x=refugia.crop, mask=template.r)
refugia.masked[refugia.masked] <- 1
plot(refugia.masked)
ncell(refugia.masked)
refugia_pixels_4 <- cellStats(refugia.masked, 'sum')
refugia_pixels_4

dynamic <- raster('./model_outputs/stability/dynamic_stability_5.asc')
dynamic[dynamic < 0.97] <- NA
dynamic[dynamic] <- 1

dynamic.crop <- crop(dynamic, refugia, snap="out")
crop <- setValues(dynamic.crop, NA)
template.r <- rasterize(refugia, crop)
dynamic.masked <- mask(x=dynamic.crop, mask=template.r)
dynamic.masked[dynamic.masked] <- 1
plot(dynamic.masked)
ncell(dynamic.masked)
dynamic_in_refugia_pixels_4 <- cellStats(dynamic.masked, 'sum')
dynamic_in_refugia_pixels_4

cat("Total area in Maley's refugia  = ", refugia_pixels_4,"\n")
cat("Total area with dynamic < 3         = ", dynamic_in_refugia_pixels_4,"\n")
cat("% of Maley's refugia covered   = ", (dynamic_in_refugia_pixels_4/refugia_pixels_4*100),"\n")


# 5 
dynamic <- raster('./model_outputs/stability/dynamic_stability_5.asc')
refugia <- readOGR('./map_data/REFUGIA_MALEY96_separated/5.shp')
refugia.crop <- crop(dynamic, refugia, snap="out")
crop <- setValues(refugia.crop, NA)
template.r <- rasterize(refugia, crop)
refugia.masked <- mask(x=refugia.crop, mask=template.r)
refugia.masked[refugia.masked] <- 1
plot(refugia.masked)
ncell(refugia.masked)
refugia_pixels_5 <- cellStats(refugia.masked, 'sum')
refugia_pixels_5

dynamic <- raster('./model_outputs/stability/dynamic_stability_5.asc')
dynamic[dynamic < 0.97] <- NA
dynamic[dynamic] <- 1

dynamic.crop <- crop(dynamic, refugia, snap="out")
crop <- setValues(dynamic.crop, NA)
template.r <- rasterize(refugia, crop)
dynamic.masked <- mask(x=dynamic.crop, mask=template.r)
dynamic.masked[dynamic.masked] <- 1
plot(dynamic.masked)
ncell(dynamic.masked)
dynamic_in_refugia_pixels_5 <- cellStats(dynamic.masked, 'sum')
dynamic_in_refugia_pixels_5

cat("Total area in Maley's refugia  = ", refugia_pixels_5,"\n")
cat("Total area with dynamic < 3         = ", dynamic_in_refugia_pixels_5,"\n")
cat("% of Maley's refugia covered   = ", (dynamic_in_refugia_pixels_5/refugia_pixels_5*100),"\n")


# 6 
dynamic <- raster('./model_outputs/stability/dynamic_stability_5.asc')
refugia <- readOGR('./map_data/REFUGIA_MALEY96_separated/6.shp')
refugia.crop <- crop(dynamic, refugia, snap="out")
crop <- setValues(refugia.crop, NA)
template.r <- rasterize(refugia, crop)
refugia.masked <- mask(x=refugia.crop, mask=template.r)
refugia.masked[refugia.masked] <- 1
plot(refugia.masked)
ncell(refugia.masked)
refugia_pixels_6 <- cellStats(refugia.masked, 'sum')
refugia_pixels_6

dynamic <- raster('./model_outputs/stability/dynamic_stability_5.asc')
dynamic[dynamic < 0.97] <- NA
dynamic[dynamic] <- 1

dynamic.crop <- crop(dynamic, refugia, snap="out")
crop <- setValues(dynamic.crop, NA)
template.r <- rasterize(refugia, crop)
dynamic.masked <- mask(x=dynamic.crop, mask=template.r)
dynamic.masked[dynamic.masked] <- 1
plot(dynamic.masked)
ncell(dynamic.masked)
dynamic_in_refugia_pixels_6 <- cellStats(dynamic.masked, 'sum')
dynamic_in_refugia_pixels_6

cat("Total area in Maley's refugia  = ", refugia_pixels_6,"\n")
cat("Total area with dynamic < 3         = ", dynamic_in_refugia_pixels_6,"\n")
cat("% of Maley's refugia covered   = ", (dynamic_in_refugia_pixels_6/refugia_pixels_6*100),"\n")


# 7 
dynamic <- raster('./model_outputs/stability/dynamic_stability_5.asc')
refugia <- readOGR('./map_data/REFUGIA_MALEY96_separated/7.shp')
refugia.crop <- crop(dynamic, refugia, snap="out")
crop <- setValues(refugia.crop, NA)
template.r <- rasterize(refugia, crop)
refugia.masked <- mask(x=refugia.crop, mask=template.r)
refugia.masked[refugia.masked] <- 1
plot(refugia.masked)
ncell(refugia.masked)
refugia_pixels_7 <- cellStats(refugia.masked, 'sum')
refugia_pixels_7

dynamic <- raster('./model_outputs/stability/dynamic_stability_5.asc')
dynamic[dynamic < 0.97] <- NA
dynamic[dynamic] <- 1

dynamic.crop <- crop(dynamic, refugia, snap="out")
crop <- setValues(dynamic.crop, NA)
template.r <- rasterize(refugia, crop)
dynamic.masked <- mask(x=dynamic.crop, mask=template.r)
dynamic.masked[dynamic.masked] <- 1
plot(dynamic.masked)
ncell(dynamic.masked)
dynamic_in_refugia_pixels_7 <- cellStats(dynamic.masked, 'sum')
dynamic_in_refugia_pixels_7

cat("Total area in Maley's refugia  = ", refugia_pixels_7,"\n")
cat("Total area with dynamic < 3         = ", dynamic_in_refugia_pixels_7,"\n")
cat("% of Maley's refugia covered   = ", (dynamic_in_refugia_pixels_7/refugia_pixels_7*100),"\n")


# 8 
dynamic <- raster('./model_outputs/stability/dynamic_stability_5.asc')
refugia <- readOGR('./map_data/REFUGIA_MALEY96_separated/8.shp')
refugia.crop <- crop(dynamic, refugia, snap="out")
crop <- setValues(refugia.crop, NA)
template.r <- rasterize(refugia, crop)
refugia.masked <- mask(x=refugia.crop, mask=template.r)
refugia.masked[refugia.masked] <- 1
plot(refugia.masked)
ncell(refugia.masked)
refugia_pixels_8 <- cellStats(refugia.masked, 'sum')
refugia_pixels_8

dynamic <- raster('./model_outputs/stability/dynamic_stability_5.asc')
dynamic[dynamic < 0.97] <- NA
dynamic[dynamic] <- 1

dynamic.crop <- crop(dynamic, refugia, snap="out")
crop <- setValues(dynamic.crop, NA)
template.r <- rasterize(refugia, crop)
dynamic.masked <- mask(x=dynamic.crop, mask=template.r)
dynamic.masked[dynamic.masked] <- 1
plot(dynamic.masked)
ncell(dynamic.masked)
dynamic_in_refugia_pixels_8 <- cellStats(dynamic.masked, 'sum')
dynamic_in_refugia_pixels_8

cat("Total area in Maley's refugia  = ", refugia_pixels_8,"\n")
cat("Total area with dynamic < 3         = ", dynamic_in_refugia_pixels_8,"\n")
cat("% of Maley's refugia covered   = ", (dynamic_in_refugia_pixels_8/refugia_pixels_8*100),"\n")


# 9 
dynamic <- raster('./model_outputs/stability/dynamic_stability_5.asc')
refugia <- readOGR('./map_data/REFUGIA_MALEY96_separated/9.shp')
refugia.crop <- crop(dynamic, refugia, snap="out")
crop <- setValues(refugia.crop, NA)
template.r <- rasterize(refugia, crop)
refugia.masked <- mask(x=refugia.crop, mask=template.r)
refugia.masked[refugia.masked] <- 1
plot(refugia.masked)
ncell(refugia.masked)
refugia_pixels_9 <- cellStats(refugia.masked, 'sum')
refugia_pixels_9

dynamic <- raster('./model_outputs/stability/dynamic_stability_5.asc')
dynamic[dynamic < 0.97] <- NA
dynamic[dynamic] <- 1

dynamic.crop <- crop(dynamic, refugia, snap="out")
crop <- setValues(dynamic.crop, NA)
template.r <- rasterize(refugia, crop)
dynamic.masked <- mask(x=dynamic.crop, mask=template.r)
dynamic.masked[dynamic.masked] <- 1
plot(dynamic.masked)
ncell(dynamic.masked)
dynamic_in_refugia_pixels_9 <- cellStats(dynamic.masked, 'sum')
dynamic_in_refugia_pixels_9

cat("Total area in Maley's refugia  = ", refugia_pixels_9,"\n")
cat("Total area with dynamic < 3         = ", dynamic_in_refugia_pixels_9,"\n")
cat("% of Maley's refugia covered   = ", (dynamic_in_refugia_pixels_9/refugia_pixels_9*100),"\n")


# 10 
dynamic <- raster('./model_outputs/stability/dynamic_stability_5.asc')
refugia <- readOGR('./map_data/REFUGIA_MALEY96_separated/10.shp')
refugia.crop <- crop(dynamic, refugia, snap="out")
crop <- setValues(refugia.crop, NA)
template.r <- rasterize(refugia, crop)
refugia.masked <- mask(x=refugia.crop, mask=template.r)
refugia.masked[refugia.masked] <- 1
plot(refugia.masked)
ncell(refugia.masked)
refugia_pixels_10 <- cellStats(refugia.masked, 'sum')
refugia_pixels_10

dynamic <- raster('./model_outputs/stability/dynamic_stability_5.asc')
dynamic[dynamic < 0.97] <- NA
dynamic[dynamic] <- 1

dynamic.crop <- crop(dynamic, refugia, snap="out")
crop <- setValues(dynamic.crop, NA)
template.r <- rasterize(refugia, crop)
dynamic.masked <- mask(x=dynamic.crop, mask=template.r)
dynamic.masked[dynamic.masked] <- 1
plot(dynamic.masked)
ncell(dynamic.masked)
dynamic_in_refugia_pixels_10 <- cellStats(dynamic.masked, 'sum')
dynamic_in_refugia_pixels_10

cat("Total area in Maley's refugia  = ", refugia_pixels_10,"\n")
cat("Total area with dynamic < 3         = ", dynamic_in_refugia_pixels_10,"\n")
cat("% of Maley's refugia covered   = ", (dynamic_in_refugia_pixels_10/refugia_pixels_10*100),"\n")

