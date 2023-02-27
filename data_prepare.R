#Packages
library("readxl")
library(dplyr)

#Before loading the data, manually remove the observations with NA
#Because they may be mixed with the blanks which are zeros
wbs.data = read_excel("Vesilinnut_SYKE_Luomus_combined_20230221.xls")

#the variables needed for modelling
str(wbs.data)
names(wbs.data)
mod.data = wbs.data[,c(1,4,8:10,12,38,50:86,114)]

#re-coding habitat type
mod.data$Habitaatti = as.factor(mod.data$Habitaatti)
summary(mod.data$Habitaatti)
mod.data =
  mod.data %>% mutate(Habitat = recode(Habitaatti, 
                             "6" = "Coastal",
                             "7" = "Coastal",
                             "2" = "Inland",
                             "3" = "Inland",
                             "4" = "Inland",
                             .default = "Unknown")) 

#re-coding conservation status
mod.data$LSA = as.factor(mod.data$LSA)
summary(mod.data$LSA)
mod.data =
  mod.data %>% mutate(ProtectStatus = recode(LSA, 
                                 "0" = "Non-protect",
                                 "1" = "Non-manage",
                                 .default = "Full-protect")) 
summary(mod.data)
