
# This script will summarise and plot all outputs from a sdm model run. 
# 1. Take the model_vars.txt file from within the ./model_outputs/variable_importance/ folder
# 2. Paste it in excel (Data > Text to columns) and clean it up a little so that you have the 5 below columns
# 3. Then save as a .csv and run the following script, which will create a composite .tiff file
# 4. It will plot permutation importance per predictor variable (AUC and COR, for ensembles, and modelling algorithms separately)
# 5. Edit the script where necessary - predictor variables will be consistent (= 5 bioclim + human), but  
#    x labels will NOT! (Species/Modelling algorithms used in final ensembles); 

# Species         Model  Covariate    AUC    COR
# Pan_troglodytes bioclim.dismo bioclim_01 0.4543 0.3144
# Pan_troglodytes bioclim.dismo bioclim_04 0.4635 0.3420
# Pan_troglodytes bioclim.dismo bioclim_12 0.3123 0.2258
# Pan_troglodytes bioclim.dismo bioclim_16 0.3549 0.2290
# Pan_troglodytes bioclim.dismo bioclim_17 0.2312 0.0344
# Pan_troglodytes bioclim.dismo      human 0.1558 0.0126

library(tidyverse)
library(viridis)
library(reshape2)
library(ggplot2)
library(plyr)
library(RColorBrewer)
library(ggpubr)

setwd('') # change this directory to where you download this DRYAD dataset

setwd("./model_outputs/variable_importance/")

#ENSEMBLE_AUC
x <- read.csv("var_imp.csv",header=TRUE)[ ,c('Species', 'Covariate', 'AUC')]
head(x)
melted <- melt(x, id.vars=c("Covariate", "Species")) # melt the data into something manageable 
head(melted)
df2 <- ddply(melted, c("Covariate","Species","variable"), summarise,
             mean = mean(value), sd = sd(value),
             sem = sd(value)/sqrt(length(value)))
head(df2)
df2
myCol <- c("darkorange","goldenrod1","aquamarine","cadetblue3","dodgerblue2","grey")
# PLOT AND FIND ERROR BARS 
#Order your variables in a certain way, or not
df2$Covariate <- factor(df2$Covariate, levels = c("bioclim_01","bioclim_04","bioclim_12","bioclim_16",
                                                  "bioclim_17","human"), ordered=TRUE)  

#Plot it already!
Ensemble_AUC <- ggplot(df2, aes(x=Species, y=mean,fill=Covariate)) + 
  geom_bar(stat="identity", #color="black", 
           position=position_dodge()) +
  geom_errorbar(aes(ymin=mean-sem, ymax=mean+sem), width=.5,
                position=position_dodge(.9) ) +
  coord_cartesian(ylim=c(0,0.9)) +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_line(colour = "black"))+
  scale_fill_manual(values=myCol,labels = c("bioclim_01","bioclim_04","bioclim_12","bioclim_16",
                                            "bioclim_17","human"))+  #### FILL COL BY COVARIATE
  scale_x_discrete(labels = c("All_models"))+ ### X LABS, MAKE SURE YOU LABEL IN SAME ORDER AS ABOVE
  theme(axis.title.x=element_blank())+
  labs(y="Permutation Importance")+
  ggtitle("Ensemble models AUC test")+
  theme(plot.title = element_text(color="black", size=18, face="bold",hjust=0.5))

#ENSEMBLE_COR
x <- read.csv("var_imp.csv",header=TRUE)[ ,c('Species', 'Covariate', 'COR')]
head(x)
melted <- melt(x, id.vars=c("Covariate", "Species")) # melt the data into something manageable 
head(melted)
df2 <- ddply(melted, c("Covariate","Species", "variable"), summarise,
             mean = mean(value), sd = sd(value),
             sem = sd(value)/sqrt(length(value)))
head(df2)
df2
myCol <- c("darkorange","goldenrod1","aquamarine","cadetblue3","dodgerblue2","grey")
# PLOT AND FIND ERROR BARS 
#Order your variables in a certain way, or not
df2$Covariate <- factor(df2$Covariate, levels = c("bioclim_01","bioclim_04","bioclim_12","bioclim_16",
                                                  "bioclim_17","human"), ordered=TRUE)  

#Order your models
df2$Model <- factor(df2$Model, levels = c("bioclim.dismo","brt","cart","fda","gam","glm","mars","maxent","maxlike","mda","rf","rpart","svm"), ordered=TRUE)

#Plot it already!
Ensemble_COR <- ggplot(df2, aes(x=Species, y=mean,fill=Covariate)) + 
  geom_bar(stat="identity", #color="black", 
           position=position_dodge()) +
  geom_errorbar(aes(ymin=mean-sem, ymax=mean+sem), width=.5,
                position=position_dodge(.9) ) +
  coord_cartesian(ylim=c(0,0.9)) +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_line(colour = "black"))+
  scale_fill_manual(values=myCol,labels = c("bioclim_01","bioclim_04","bioclim_12","bioclim_16",
                                            "bioclim_17","human"))+  #### FILL COL BY COVARIATE
  scale_x_discrete(labels = c("All_models"))+ ### X LABS, MAKE SURE YOU LABEL IN SAME ORDER AS ABOVE
  theme(axis.title.x=element_blank())+
  labs(y="Permutation Importance")+
  ggtitle("Ensemble models COR test")+
  theme(plot.title = element_text(color="black", size=18, face="bold",hjust=0.5))


#Ind_model_AUC
x <- read.csv("var_imp.csv",header=TRUE)[ ,c('Model', 'Covariate', 'AUC')]
head(x)
melted <- melt(x, id.vars=c("Covariate", "Model")) # melt the data into something manageable 
head(melted)
df2 <- ddply(melted, c("Covariate","Model", "variable"), summarise,
             mean = mean(value), sd = sd(value),
             sem = sd(value)/sqrt(length(value)))
head(df2)
df2
myCol <- c("darkorange","goldenrod1","aquamarine","cadetblue3","dodgerblue2","grey")
# PLOT AND FIND ERROR BARS 
#Order your variables in a certain way, or not
df2$Covariate <- factor(df2$Covariate, levels = c("bioclim_01","bioclim_04","bioclim_12","bioclim_16",
                                                  "bioclim_17","human"), ordered=TRUE)  

#Order your models
df2$Model <- factor(df2$Model, levels = c("bioclim.dismo","brt","cart","fda","gam","glm","mars","maxent","maxlike","mda","rf","rpart","svm"), ordered=TRUE)

#Plot it already!
Ind_model_AUC <- ggplot(df2, aes(x=Model, y=mean,fill=Covariate)) + 
  geom_bar(stat="identity", #color="black", 
           position=position_dodge()) +
  geom_errorbar(aes(ymin=mean-sem, ymax=mean+sem), width=.5,
                position=position_dodge(.9) ) +
  coord_cartesian(ylim=c(0,0.9)) +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_line(colour = "black"))+
  scale_fill_manual(values=myCol,labels = c("bioclim_01","bioclim_04","bioclim_12","bioclim_16",
                                            "bioclim_17","human"))+  #### FILL COL BY COVARIATE
  scale_x_discrete(labels = c("bioclim.dismo","brt","cart","fda","gam","glm","mars","maxent","maxlike","mda","rf","rpart","svm"))+ ### X LABS, MAKE SURE YOU LABEL IN SAME ORDER AS ABOVE
  theme(axis.title.x=element_blank())+
  theme(axis.text.x=element_text(angle = 90, hjust=1))+
  labs(y="Permutation Importance")+ 
  ggtitle("Individual modelling algorithm AUC test") +
  theme(plot.title = element_text(color="black", size=18, face="bold",hjust=0.5))

#Ind_model_COR
x <- read.csv("var_imp.csv",header=TRUE)[ ,c('Model', 'Covariate', 'COR')]
head(x)
melted <- melt(x, id.vars=c("Covariate", "Model")) # melt the data into something manageable 
head(melted)
df2 <- ddply(melted, c("Covariate","Model", "variable"), summarise,
             mean = mean(value), sd = sd(value),
             sem = sd(value)/sqrt(length(value)))
head(df2)
df2
myCol <- c("darkorange","goldenrod1","aquamarine","cadetblue3","dodgerblue2","grey")
# PLOT AND FIND ERROR BARS 
#Order your variables in a certain way, or not
df2$Covariate <- factor(df2$Covariate, levels = c("bioclim_01","bioclim_04","bioclim_12","bioclim_16",
                                                  "bioclim_17","human"), ordered=TRUE)  

#Order your models
df2$Model <- factor(df2$Model, levels = c("bioclim.dismo","brt","cart","fda","gam","glm","mars","maxent","maxlike","mda","rf","rpart","svm"), ordered=TRUE)

#Plot it already!
Ind_model_COR <- ggplot(df2, aes(x=Model, y=mean,fill=Covariate)) + 
  geom_bar(stat="identity", #color="black", 
           position=position_dodge()) +
  geom_errorbar(aes(ymin=mean-sem, ymax=mean+sem), width=.5,
                position=position_dodge(.9) ) +
  coord_cartesian(ylim=c(0,0.9)) +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_line(colour = "black"))+
  scale_fill_manual(values=myCol,labels = c("bioclim_01","bioclim_04","bioclim_12","bioclim_16",
                                            "bioclim_17","human"))+  #### FILL COL BY COVARIATE
  scale_x_discrete(labels = c("bioclim.dismo","brt","cart","fda","gam","glm","mars","maxent","maxlike","mda","rf","rpart","svm"))+ ### X LABS, MAKE SURE YOU LABEL IN SAME ORDER AS ABOVE
  theme(axis.title.x=element_blank())+
  theme(axis.text.x=element_text(angle = 90, hjust=1))+
  labs(y="Permutation Importance")+ 
  ggtitle("Individual modelling algorithm COR test") +
  theme(plot.title = element_text(color="black", size=18, face="bold",hjust=0.5))

ggarrange(Ensemble_AUC, Ensemble_COR, Ind_model_AUC, Ind_model_COR, ncol = 2, nrow = 2) %>%
  ggexport(filename = "../../figures/Var_Importance_Pan_troglodytes.tiff", height=1000, width=1000)

