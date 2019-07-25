##############################################################################
# Testing pre-trained Nth american model on DERG pics
# Aaron Greenville
##############################################################################
library(tidyverse)
library(caret)

# load in results
#pred from model
derg.pred <- read.csv("DERG_example_results2.csv", header=T)

# add coln call file
derg.pred <- derg.pred %>% mutate(file = gsub(".*\\\\|'","", fileName))

# species ID for nth america model
Nth.amer.sp <- read.csv("speciesID.csv", header = T)

# actual results from DERG cameras
derg.species <- read.csv("desert_eg/desert_eg.csv", header=T)


# add another group for animal or not to Nth Amer
# species id

Nth.amer.sp$Group <- ifelse(Nth.amer.sp$Class.ID %in% c(27),"Empty",
                            ifelse(Nth.amer.sp$Class.ID %in% c(25),"Vehicle",
                            ifelse(Nth.amer.sp$Class.ID %in% c(11),"Human", "animal")))

#join datasets
derg.pred.species <- left_join(derg.pred, Nth.amer.sp, by = c("guess1"="Class.ID") )

derg.pred.species.pred <- full_join(derg.pred.species, derg.species, by = "file")

# remame columns for DERG actual data
derg.pred.species.pred <- derg.pred.species.pred %>% rename(Species.Actual = Species) %>% 
                          rename(Group.Actual = Group.y)

pred <- factor(derg.pred.species.pred$Group.x,
              levels = c("Human", "Vehicle", "animal", "Empty"))

Actual <- factor(derg.pred.species.pred$Group.Actual,
              levels = c("Human", "Vehicle", "animal", "Empty"))

confusion.matrix <- table(pred, Actual)

confusionMatrix(confusion.matrix)

summary.table <- data.frame(pred.group = as.character(pred), actual.group = as.character(Actual),
                            pred.species = derg.pred.species.pred$Group.name,
      actual.species = as.character(derg.species$Species))
