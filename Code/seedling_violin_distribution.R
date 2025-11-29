# ===============================================
# Script: seedlings_per_severity.R
# Purpose: Load cleaned data and create a violin 
#         distribution of seedling counts per SBS
# Author: Helena Kroleski
# Date: Fall 2025
# ===============================================

# Install packages that may be used 
install.packages("tidyverse")
install.packages("readxl")
install.packages("viridis")

# Load libraries
library(tidyverse)   # For ggplot2, etc.
library(readxl)      # For reading excel files
library(viridis)     # For colorblind-friendly palettes

# Load cleaned data located in Kroleski_GEOG563 Data folder
LHData <- read_excel("Data/fresh_n_clean_LH_Data.xlsx")

# Compute total seedlings across species for each plot
LHData <- LHData %>%
  mutate(Seedlings_total = `100SeedDF_total` + `100SeedWH_total` + 
    `100SeedWRC_total` + `100SeedOther_total`)

# Convert Soil Burn Severity to factor with full names 
LHData$SoilSev <- factor(LHData$SoilSev,
                         levels = c("Un", "Low", "Mod", "High"),
                         labels = c("Unburned", "Low", "Moderate", "High"))

# Create violin distribtuion 

ggplot(LHData, aes(x = SoilSev, y = Seedlings_total, fill = SoilSev)) +
  geom_violin(trim = FALSE, alpha = 0.6) +
  geom_jitter(width = 0.1, alpha = 0.6) +
  scale_fill_viridis_d(option = "mako") +
  theme_bw() +
  labs(title = "Seedling Distribution by Burn Severity",
  x = "Soil Burn Severity", y = "Total Seedlings") +
  theme(legend.position = "none",
  plot.title = element_text(hjust = 0.5))

# ===============================================
