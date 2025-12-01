# ===============================================
# Script: cover_comp.R
# Purpose: Load cleaned data and create a cover
#         composition barplot per severity
# Author: Helena Kroleski
# Date: Fall 2025
# ===============================================

# Install packages that may be used 
install.packages("tidyverse")
install.packages("readxl")
install.packages("viridis")
install.packages("corrplot")

# Load libraries
library(tidyverse)   # For ggplot2, etc.
library(readxl)      # For reading excel files
library(viridis)     # For colorblind-friendly palettes
library(corrplot).   # For correlation matrix

# Load cleaned data
LHData <- read_excel("Data/fresh_n_clean_LH_Data.xlsx")

# Long format
cover_long <- LHData %>%
  + select(PlotNum, SoilSev,
               + Cover_Litter_avg,
               + Cover_Soil_avg,
               + Cover_Rock_avg,
               + Cover_Woody_avg,
               + Cover_Herb_avg,
               + Cover_Shrub_avg,
               + Cover_Tree_avg) %>%
  + pivot_longer(
    + cols = starts_with("Cover_"),
    + names_to = "CoverType",
    + values_to = "CoverValue")

# Create bar plot of commp per severity

ggplot(cover_long, aes(x = factor(SoilSev),
   + y = CoverValue,
   + fill = CoverType)) +
  + geom_bar(stat = "identity", position = "fill") +
  + scale_y_continuous(labels = scales::percent_format()) +
  + scale_fill_viridis_d(option = "mako") + labs(
    + title = "Cover Composition by Soil Burn Severity",
    + x = "Soil Burn Severity",
    + y = "Proportion of Cover",
    + fill = "Cover Type")
  + theme_minimal(base_size = 13)
  + theme(panel.grid.minor = element_blank(),
    + legend.position = "right")

# ===============================================
