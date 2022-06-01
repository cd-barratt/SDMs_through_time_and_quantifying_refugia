library(raster)
library(rgdal)
library(sp)
library(maptools)
library(SDMTools)

#Pearson's correlations of output stability maps  

setwd('') # change this directory to where you download this DRYAD dataset

verus = readOGR('./map_data/P_t_verus.shp')
elliotti = readOGR('./map_data/P_t_ellioti.shp')
troglodytes = readOGR('./map_data/P_t_troglodytes.shp')
schweinfurthii = readOGR('./map_data/P_t_schweinfurthii.shp')
refugia = readOGR('./map_data/REFUGIA_MALEY96.shp')

asc.dir = './model_outputs/asc/'
panaf_sites = readOGR('./map_data/all_panaf_sites.shp')
shp <- readOGR('./map_data/countries_clipped_raster_extent.shp')
rivers <- readOGR('./map_data/africa_rivers.shp')

#define image grid full species
image.grid = function(tasc,tfile,zlim=NULL,cols=NULL) {
  #plot the image
  tiff(tfile,height=600/100,width=1080/100,units='cm',res=500,pointsize=5)
  layout(matrix(c(rep(rep(1,8),6),1,2,2,2,2,1,1,1),nr=7,nc=8,byrow=TRUE))
  par(mar=c(0,0,0,0),cex=1)
  if (is.null(zlim)) { zlim = range(as.vector(tasc),na.rm=T) }
  image(tasc,ann=FALSE,axes=FALSE,zlim=zlim,col=cols, xlim=c(-18,32), ylim=c(-12,16))
  legend.gradient(cbind(c(-1,-0.5,-0.5,-1),c(-7,-7,0,0)),limits=cbind(0,1),title='stability',cols=cols,cex=1.2) # limits originally limits=round(zlim,2)
  plot(shp,add=T,border="black",pbg="transparent",lwd=0.08) #add the subregions		
  plot(verus,add=T,border="green",pbg="transparent",lwd=0.7)
  plot(elliotti,add=T,border="green",pbg="transparent",lwd=0.7)
  plot(troglodytes,add=T,border="green",pbg="transparent",lwd=0.7)
  plot(schweinfurthii,add=T,border="green",pbg="transparent",lwd=0.7)
  plot(refugia,add=T,border="black",pbg="black",lwd=0.6, lty=6)
  #points(panaf_sites, pch=19, cex=0.3)
    dev.off()
}

image.grid.CV = function(tasc,tfile,zlim=NULL,cols=NULL) {
  #plot the image
  tiff(tfile,height=600/100,width=1080/100,units='cm',res=500,pointsize=5)
  layout(matrix(c(rep(rep(1,8),6),1,2,2,2,2,1,1,1),nr=7,nc=8,byrow=TRUE))
  par(mar=c(0,0,0,0),cex=1)
  if (is.null(zlim)) { zlim = range(as.vector(tasc),na.rm=T) }
  image(tasc,ann=FALSE,axes=FALSE,zlim=zlim,col=CV.cols, xlim=c(-18,32), ylim=c(-12,16))
  legend.gradient(cbind(c(-1,-0.5,-0.5,-1),c(-7,-7,0,0)),limits=cbind(100,0),title='CV (%)',cols=cols,cex=1.2) # limits originally limits=round(zlim,2)
  plot(shp,add=T,border="black",pbg="transparent",lwd=0.08) #add the subregions		
  plot(verus,add=T,border="green",pbg="transparent",lwd=0.7)
  plot(elliotti,add=T,border="green",pbg="transparent",lwd=0.7)
  plot(troglodytes,add=T,border="green",pbg="transparent",lwd=0.7)
  plot(schweinfurthii,add=T,border="green",pbg="transparent",lwd=0.7)
  plot(refugia,add=T,border="black",pbg="black",lwd=0.6, lty=6)
  #points(panaf_sites, pch=19, cex=0.3)
  dev.off()
}
cols = c(colorRampPalette(c('grey70','grey80','grey90'))(125),colorRampPalette(c('grey90','lightyellow'))(100),colorRampPalette(c('lightyellow','yellow','goldenrod1'))(50),colorRampPalette(c('goldenrod1','orange','red'))(18))
CV.cols = c(colorRampPalette(c('grey70','grey80','grey90'))(125),colorRampPalette(c('grey90','lightyellow'))(100),colorRampPalette(c('lightyellow','yellow','goldenrod1'))(50),colorRampPalette(c('goldenrod1','orange','red'))(18))
CV.cols = rev(CV.cols)

############## DYNAMIC_stability ################

# full_species
#clipped_reduced
static_stability = raster('./model_outputs/stability/static_stability_mean.asc')
dynamic_stability = raster('./model_outputs/stability/dynamic_stability_5.asc')
CV_stability = raster('./model_outputs/stability/CV_stability.asc')

image.grid(static_stability,'./figures/Static_stability.tiff',col=cols) #plot the image 
image.grid(dynamic_stability,'./figures/Dynamic_stability.tiff',col=cols) #plot the image 
image.grid(CV_stability,'./figures/CV_stability.tiff',col=CV.cols) #plot the image 

