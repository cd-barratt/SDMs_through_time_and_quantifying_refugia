# SDMs_through_time_and_quantifying_refugia
Model species habitat suitability as it shifts through time and estimate stable refugia
Please cite the paper Barratt et al. 2021 if you use these scripts in your work.

https://onlinelibrary.wiley.com/doi/10.1002/ajp.23320

This DRYAD data repository contains scripts and data to repeat the analyses in Barratt et al. (2021). We provide the scripts to perform analyses for the chimpanzee dataset (full species), which can be modified to any species, subspecies or geographic area where suitable occurrence and climate data are available. We also provide the outputs of these scripts (results files and plots).

Some important points to note before use:
1. Due to the sensitive nature of the species occurrence data for chimpanzees we do not provide the input data as part of this package. The full distribution data for chimpanzees used in the analyses is available on request from the IUCN SSC A.P.E.S. database manager (http://apes.eva.mpg.de/). As a result, scripts #0 and #1 will require input data downloading (e.g. as a data request made above), or from alternative sources (e.g. the Global Biodiversity Information Facility).

2. We provide the paleoclimate predictor variables representing the present, Late Holocene, LGM and LIG (as available from the Worldclim website), in subfolders within the predictor_data folders, 000, 006, 021, 120 respectively. The full set of bioclim variables (bioclim 01,04,10,11,12,15,16,17) representing paleoclimate reconstructions for all 62 time snapshots are available on request from the authors of Bell et al. (2017) [https://onlinelibrary.wiley.com/doi/full/10.1111/mec.14260]. We do however, provide our modelled habitat suitability estimates for chimpanzees for all 62 paleoclimate snapshots, along with variable importance estimates so that scripts #2,#3,#4,#5,#6,#7 can all be run by users of this DRYAD package.


List of contents:
 
folders:
occurrence data - 			
is left empty due to data sensitivity, but is to store occurrence data for modelling distributions (csv and shapefile formats)
predictor data - 			
takes all 62 time slice data predictors as numbered folders, with each predictor named consistently between time snapshots
model outputs - 			
contains five subfolders; asc stores the raw model outputs (numbered by time snapshot, matching predictor data numbering scheme); tiff stores the images of the asc files; stability stores the modelled outputs (asc files) of stability estimates; variable importance stores the varimp() function outputs of the sdm R package, across each modelling algorithm; quantification of refugia stores temporary refugia raster files when conducting the analysis in script #7
map data - 					
contains all GIS data required for plotting, including IUCN subspecies ranges, country shapefiles, buffers around ranges for selecting background points, and known African refugia (from Maley, 1996)
correlation matrices - 		
contains two folders (one for each of the 10km rarefied and 25 km rarefied datasets). Each of these folders contains the 3 stability estimates, plus fig and palm species richness
figures - 					
folder for output images



0_generate_pseudoabsences_prior_to_modelling.R
Generate pseudoabsencess (background points) for SDM modelling prior to building models. User specifies a buffer around occurrence points (in our example 0.5 degrees), and samples a specified number of background points from within this buffer. This approach emphasizes factors locally relevant in distinguishing suitable from unsuitable habitat, while adequately sampling the range of climatic conditions for the species

1_run_sdm_R.R
Allows the user to build ensemble SDMs using a number of different algorithms available in the sdm R package, weighting each individual model by its AUC statistic. The script then projects the models back in time onto paleoclimatic predictor variables, and provides all outputs as asc files. Modelling algorithms, background data, predictors, sampling regime and number of replicates are all flexible within the script

2_summarize_variable_importance.R
Allows the variable importance outputs from script #1 above to be summarized and plotted

3_generate_stability_asc_surfaces.R
Permits the calculation of Static, Dynamic stability and the coefficient of variation across modelled SDMs across all time periods. 

4_plot_stability_surfaces.R
Plots the stability surfaces from script #3 above using the SDMTools R package

5_calculate_and_plot_correlations.R
Summarizes the correlations between modelled outputs and palm and fig species richness. Also permits correlation plots to be made across sensitivity analyses (e.g. in this case 10km vs 25 km rarefied datasets)

6_plot_animated_gif.R
Plot an animated gif of all SDMs across modelled time periods, enabling a visualization of changing habitat suitability through time

7_quantify_refugia.R
Analyze the outputs of the stability models from scripts #3 and #4 to compare them against previously known refugia. The script will polygonize known refugia based on a shapefile (Maley, 1996) then quantify the newly calculated refugia against them (in pixels and also as a percentage)
