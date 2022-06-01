# This is an automated script to calculate static and dynamic stability surfaces from the asc model outputs, and also the Co-efficient of Variation#
# It will output the asc files with these summaries

library(magick)
library(raster)
library(rgdal)

setwd('') # change this directory to where you download this DRYAD dataset

root.dir = './model_outputs/'

dir.create('./model_outputs/stability')

asc.dir = './model_outputs/asc/'
panaf_sites = readOGR('./map_data/all_panaf_sites.shp')
shp <- readOGR('./map_data/countries_clipped_raster_extent.shp')
rivers <- readOGR('./map_data/africa_rivers.shp')

setwd(asc.dir)

timeslice_000 <- raster("000.asc") 
timeslice_001 <- raster("001.asc")
timeslice_002 <- raster("002.asc")
timeslice_003 <- raster("003.asc")
timeslice_004 <- raster("004.asc")
timeslice_005 <- raster("005.asc")
timeslice_006 <- raster("006.asc")
timeslice_007 <- raster("007.asc")
timeslice_008 <- raster("008.asc") 
timeslice_009 <- raster("009.asc")
timeslice_010 <- raster("010.asc")
timeslice_011 <- raster("011.asc") 
timeslice_012 <- raster("012.asc")
timeslice_013 <- raster("013.asc")
timeslice_014 <- raster("014.asc")
timeslice_015 <- raster("015.asc")
timeslice_016 <- raster("016.asc")
timeslice_017 <- raster("017.asc")
timeslice_018 <- raster("018.asc") 
timeslice_019 <- raster("019.asc")
timeslice_020 <- raster("020.asc")
timeslice_021 <- raster("021.asc")
timeslice_022 <- raster("022.asc")
timeslice_024 <- raster("024.asc")
timeslice_026 <- raster("026.asc")
timeslice_028 <- raster("028.asc")
timeslice_030 <- raster("030.asc")
timeslice_032 <- raster("032.asc")
timeslice_034 <- raster("034.asc")
timeslice_036 <- raster("036.asc")
timeslice_038 <- raster("038.asc")
timeslice_040 <- raster("040.asc")
timeslice_042 <- raster("042.asc")
timeslice_044 <- raster("044.asc")
timeslice_046 <- raster("046.asc")
timeslice_048 <- raster("048.asc")
timeslice_050 <- raster("050.asc")
timeslice_052 <- raster("052.asc")
timeslice_054 <- raster("054.asc")
timeslice_056 <- raster("056.asc")
timeslice_058 <- raster("058.asc")
timeslice_060 <- raster("060.asc")
timeslice_062 <- raster("062.asc")
timeslice_064 <- raster("064.asc")
timeslice_066 <- raster("066.asc")
timeslice_068 <- raster("068.asc")
timeslice_070 <- raster("070.asc")
timeslice_072 <- raster("072.asc")
timeslice_074 <- raster("074.asc")
timeslice_076 <- raster("076.asc")
timeslice_078 <- raster("078.asc")
timeslice_080 <- raster("080.asc")
timeslice_084 <- raster("084.asc")
timeslice_088 <- raster("088.asc")
timeslice_092 <- raster("092.asc")
timeslice_096 <- raster("096.asc")
timeslice_100 <- raster("100.asc")
timeslice_104 <- raster("104.asc")
timeslice_108 <- raster("108.asc")
timeslice_112 <- raster("112.asc")
timeslice_116 <- raster("116.asc")
timeslice_120 <- raster("120.asc")

######## Static, Dynamic and CV Stability ###########

# Please note the bulk of this script was provided by Jeremy VanDerWal( jjvanderwal@gmail.com ... www.jjvanderwal.com )
# GNU General Public License .. feel free to use / distribute ... no warranties

################################################################################
library(SDMTools); library(maptools)
library(rgdal)
################################################################################

#Define some directories
work.dir = asc.dir; setwd(work.dir)
out.dir = '../stability/'
fig.dir = '../../figures/'

#list the projections
sims = list.files(pattern='\\.asc'); sims = gsub('\\.asc','',sims)

#define the cell size
cell.size = 0.0416666688398666  # grab this from your asc file!

#zero offset as cost of 1/value can produce Inf
zero.offset = 0.001

#define the dispersal cost type "no.cost", "linear", "quadratic"
disp.type = "linear"

#define some plot info
tcols = c(colorRampPalette(c('green','brown'))(14),colorRampPalette(c('brown','yellow'))(70),colorRampPalette(c('yellow','orange'))(119),colorRampPalette(c('orange','red'))(197))
legend.pnts = cbind(c(-1,0,0,-1),c(-7,-7,0,0)) # based on your lat/longs

################################################################################
################################################################################
# define some functions

#calculate the moving window cost 
mw.cost = function(n) {
  #define the size of the moving window
  max.dist.moved = mdd * n
  max.num.cells = round(max.dist.moved / cell.size); cat('max radius in cells is',max.num.cells,'\n')
  #create the moving window
  tt = matrix(NA,nrow=max.num.cells*2+1,ncol=max.num.cells*2+1)
  #populate the distances
  for (y in 1:(max.num.cells*2+1)){
    for (x in 1:(max.num.cells*2+1)){
      tt[y,x] = sqrt((max.num.cells+1-y)^2 + (max.num.cells+1-x)^2)
    }
  }
  #remove distance values > max.num.cells
  tt[which(tt>max.num.cells)]=NA
  #define the dispersal costs
  if (disp.type=="no.cost") {
    tt[which(is.finite(tt))]=1; tt = -log(tt)
  } else if (disp.type=="linear") {
    tt = 1-tt/max.num.cells; tt = -log(tt); tt[which(is.infinite(tt))] = -log(zero.offset)
  } else if (disp.type=="quadratic") {
    tt = (1-tt/max.num.cells)^2; tt = -log(tt); tt[which(is.infinite(tt))] = -log(zero.offset)
  }	else {exit} #Error... need to define dispersal type
  return(tt)
}
################################################################################
################################################################################
#read in and store all the data
indata = NULL
for (ii in 1:length(sims)) { sim = sims[ii]; cat(sim,'\n')
tasc = read.asc(paste(sim,'.asc',sep='')) #read in the data
#create an array to store the data and setup the base.asc object
if (is.null(indata)) { indata = array(data=NA,dim=c(dim(tasc),length(sims))); base.asc = tasc; base.asc = base.asc*0 } #base.asc is for current
indata[,,ii] = tasc #store the data
}

###create the data associated with the cost of the predicted environemtnal suitability
cost.suitability = -log(indata)
#set any Infinite values to our maximim y
cost.suitability[which(is.infinite(cost.suitability))] = -log(zero.offset)
###for calculating suitability / cost... we need to account for 'offshore' information
#to deal with this, we need to grab the maximum extent of the data and set any NA within that to 0 suitability
#that way, it will have HUGE cost and thus 
pos = NULL #setup object to track largest set of values
for (ii in 1:length(sims)) { cat(sims[ii],'\n'); # extract the maximum set of points
  if (is.null(pos)) { 
    pos = which(is.finite(cost.suitability[,,ii]),arr.ind=TRUE) 
  } else {
    if (nrow(pos) < length(which(is.finite(cost.suitability[,,ii])))) { pos = which(is.finite(cost.suitability[,,ii]),arr.ind=TRUE) }
  }
}
pos = as.data.frame(pos) #convert to a dataframe
for (ii in 1:length(sims)) { cat(sims[ii],'\n') #cycle through, change NA's associated with pos to value of -log(zero.offset) cost
  tt = cost.suitability[,,ii][cbind(pos$row,pos$col)]; tt = which(is.na(tt)) #define the NA positions
  cost.suitability[,,ii][cbind(pos$row[tt],pos$col[tt])] = -log(zero.offset) #set those NA's to -log(zero.offset)
}
#define the output data to store outputs
outdata = cost.suitability

################################################################################
####################Ø############################################################
# calculate the static predictions
min.asc = mean.asc = base.asc
#sum the predictions to get the average
for (ii in 1:length(sims)){ cat(sims[ii],'\n'); min.asc = pmax(min.asc,cost.suitability[,,ii],na.rm=T); mean.asc = mean.asc + cost.suitability[,,ii] }
mean.asc = mean.asc / length(sims) #calculate the mean value
mean.asc = exp(-mean.asc); min.asc = exp(-min.asc) #convert back to maxent values of 0,1
write.asc(min.asc,paste(out.dir,'static_stability_min.asc',sep=''))#write out the data
write.asc(mean.asc,paste(out.dir,'static_stability_mean.asc',sep=''))#write out the data
bins = seq(0,1,length=101); bins = cut(0.0242,bins,labels=FALSE) # get the threshold bin for cols
cols = c(colorRampPalette(c('gray30','grey80'))(40),colorRampPalette(c('grey80','yellow','orange','red'))(71))

################################################################################
################################################################################

# calculate the shifting refugia

#define cols
tcol = c(colorRampPalette(c('gray30','grey80'))(50),colorRampPalette(c('grey80','yellow','orange','red'))(61))

# calculate the static prediction
static.asc = base.asc; static.asc[,] = cost.suitability[,,1] #set the static.asc to the first cost surface

#sum the predictions to get the average
for (ii in 1:length(sims)){ cat(sims[ii],'\n'); static.asc = static.asc + cost.suitability[,,ii] }
static.asc = static.asc / (length(sims)*2-1); static.asc = exp(-static.asc)
write.asc(static.asc,paste(out.dir,'static_stability_sum_cost.asc',sep=''))#write out the data

### 5 m/ year
#define the max dispersal distance in units per year (defined by resolution of your inputs)
#e.g., if cell size is 0.002998 decimal degrees (~250m resolution) and you want 10 m dispersal distance per year
#set mdd = 10 * 0.002998 / 250 
mdd.id = 5 #m/year
mdd = mdd.id * cell.size / 5000
outdata = cost.suitability #reset the output data
#calculate the stability surfaces 
for (ii in (length(sims)-1):1){ cat(sims[ii],'...') #cycle through each of the layers starting with the last
  #define the size of the moving window
  num.years = (as.numeric(sims[ii+1]) - as.numeric(sims[ii])) *1000
  mw = mw.cost(num.years)
  #workout and store in outdata
  outdata[,,ii] = cost.suitability[,,ii] + lcmw(outdata[,,ii+1],mw,round((mdd * num.years) / cell.size))
}
#create the plot & ascii output...
tasc = base.asc; tasc[,] = outdata[,,1] #get the data
tasc[which(tasc+1>1e20)] = NA #remove the nonsense data
tasc = tasc / (length(sims)*2-1); tasc = exp(-tasc)
write.asc(tasc,paste(out.dir,'dynamic_stability_',mdd.id,'.asc',sep='')) #write out the ascii grid file

# co-efficient of variation
raster_stack <- stack(timeslice_000,timeslice_001,timeslice_002,timeslice_003,timeslice_004,timeslice_005,timeslice_006,timeslice_007,timeslice_008,timeslice_009,timeslice_010,timeslice_011,timeslice_012,timeslice_013,timeslice_014,timeslice_015,timeslice_016,timeslice_017,timeslice_018,timeslice_019,timeslice_020,timeslice_021,timeslice_022,timeslice_024,timeslice_026,timeslice_028,timeslice_030,timeslice_032,timeslice_034,timeslice_036,timeslice_038,timeslice_040,timeslice_042,timeslice_044,timeslice_046,timeslice_048,timeslice_050,timeslice_052,timeslice_054,timeslice_056,timeslice_058,timeslice_060,timeslice_062,timeslice_064,timeslice_066,timeslice_068,timeslice_070,timeslice_072,timeslice_074,timeslice_076,timeslice_078,timeslice_080,timeslice_084,timeslice_088,timeslice_092,timeslice_096,timeslice_100,timeslice_104,timeslice_108,timeslice_112,timeslice_116,timeslice_120)
cv_rasterstack <- calc(raster_stack, fun=cv)
writeRaster(cv_rasterstack,format='ascii',paste(out.dir,'CV_stability.asc',sep=''),overwrite=TRUE)








