library(raster)
library(rgdal)
library(corrplot)

# CORRELATIONS 

# 10km_rarefied
setwd('') # change this directory to where you download this DRYAD dataset

palms <- raster('./correlation_matrices/10km_rarefied/palms.asc')
figs <- raster('./correlation_matrices/10km_rarefied/figs.asc')
dynamic_stability_5 <- raster('./correlation_matrices/10km_rarefied/dynamic_stability_5.asc')
static_stability <- raster('./correlation_matrices/10km_rarefied/static_stability_mean.asc')
CV_stability <- raster('./correlation_matrices/10km_rarefied/CV_stability.asc')
layers <- stack(dynamic_stability_5,static_stability, CV_stability,palms,figs)
jnk=layerStats(layers, 'pearson', na.rm=T)
corr_matrix=jnk$'pearson correlation coefficient'
corr_matrix
write.csv(corr_matrix, './correlation_matrices/10km_rarefied/10km_rarefied_correlations.csv')
corrplot(corr_matrix)
dev.copy(tiff, ('./figures/10km_rarefied_correlations.tiff'), width=15,height=15,units="cm", res=300)
dev.off()

# 25km_rarefied
setwd('') # change this directory to where you download this DRYAD dataset

palms <- raster('./correlation_matrices/25km_rarefied/palms.asc')
figs <- raster('./correlation_matrices/25km_rarefied/figs.asc')
dynamic_stability_5 <- raster('./correlation_matrices/25km_rarefied/dynamic_stability_5.asc')
static_stability <- raster('./correlation_matrices/25km_rarefied/static_stability_mean.asc')
CV_stability <- raster('./correlation_matrices/25km_rarefied/CV_stability.asc')
layers <- stack(dynamic_stability_5,static_stability, CV_stability,palms,figs)
jnk=layerStats(layers, 'pearson', na.rm=T)
corr_matrix=jnk$'pearson correlation coefficient'
corr_matrix
write.csv(corr_matrix, './correlation_matrices/25km_rarefied/25km_rarefied_correlations.csv')
corrplot(corr_matrix)
dev.copy(tiff, ('./figures/25km_rarefied_correlations.tiff'), width=15,height=15,units="cm", res=300)
dev.off()
