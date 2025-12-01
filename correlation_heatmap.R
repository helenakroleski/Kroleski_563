# ===============================================
# Script: correlation_heatmap.R
# Purpose: Load cleaned data and create a correlation 
#           heatmap of all variables
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

# Load cleaned data located in Kroleski_GEOG563 Data folder
LHData <- read_excel("Data/fresh_n_clean_LH_Data.xlsx")

# Create matrix exlcuding sampled tree data (irrelevant)
LH_num2 <- LHData %>%
  +     dplyr::select(
    +         -Sampled_DBH_in,
    +         -Sampled_Height_ft,
    +         -Sampled_LC_percent,
    +         -Sampled_BS_ft
    +     ) %>%
  +     dplyr::select(where(is.numeric))
cor_mat2 <- cor(LH_num2, use = "pairwise.complete.obs")

# Plot matrix
corrplot(cor_mat2,
             +          method = "color",
             +          type = "upper",
             +          tl.cex = 0.65,
             +          tl.col = "black",
             +          col = colorRampPalette(c("darkred", "white", "darkblue"))(200))

# ===============================================
