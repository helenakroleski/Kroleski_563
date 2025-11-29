# ===============================================
# Script: tree_bins_summary.R
# Purpose: Load cleaned data and create barplot
#          of overstory (live & dead), seedlings, 
#          and saplings by soil burn severity
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
  mutate(Seedlings_total = `SapDF_total` + `SapWH_total` + 
           `Sap_total` + `SapOther_total`)

# Compute total saplings across species for each plot
LHData <- LHData %>%
  mutate(Saplings_total = `100SeedDF_total` + `100SeedWH_total` + 
           `100SeedWRC_total` + `100SeedOther_total`)

# Convert Soil Burn Severity to factor with full names 
LHData$SoilSev <- factor(LHData$SoilSev,
  levels = c("Un", "Low", "Mod", "High"),
  labels = c("Unburned", "Low", "Moderate", "High"))

# Summarize totals by burn severity
OverSeedSum <- LHData %>%
  group_by(SoilSev) %>%
  summarize(
    OverLive = sum(OverLive, na.rm = TRUE),
    OverDead = sum(OverDead, na.rm = TRUE),
    Seedlings = sum(Seedlings_total, na.rm = TRUE),
    Saplings = sum(Saplings_total, na.rm = TRUE)
  ) %>%
  pivot_longer(cols = c(OverLive, OverDead, Seedlings, Saplings),
  names_to = "Category",
  values_to = "Count")

# Stacked bar plot with live & dead overstory, seedlings, saplings 
ggplot(OverSeedSum, aes(x = SoilSev, y = Count, fill = Category)) +
  geom_bar(stat = "identity") +
  scale_fill_viridis_d(option = "mako") +
  theme_bw() +
  labs(
    x = "Burn Severity",
    y = "Total Count",
    fill = "Category",
    title = "Overstory, Seedlings, and Saplings by Burn Severity") +
    theme(plot.title = element_text(hjust = 0.5))

