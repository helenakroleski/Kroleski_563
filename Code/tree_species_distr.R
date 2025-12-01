# ===============================================
# Script: tree_species_distr.R
# Purpose: Load cleaned data and create 3 barplots
#          of overstory live, seedlings, 
#          and saplings by soil burn severity and 
#          species
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

# Load cleaned data
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


# Summarize by species for Seedlings, Saplings, and Overstory Live
SpeciesSum <- LHData %>%
  group_by(SoilSev) %>%
  summarize(
    DF_seed = sum(`100SeedDF_total`, na.rm = TRUE),
    WH_seed = sum(`100SeedWH_total`, na.rm = TRUE),
    WRC_seed = sum(`100SeedWRC_total`, na.rm = TRUE),
    Other_seed = sum(`100SeedOther_total`, na.rm = TRUE),
    DF_sap = sum(SapDF_total, na.rm = TRUE),
    WH_sap = sum(SapWH_total, na.rm = TRUE),
    WRC_sap = sum(SapWRC_total, na.rm = TRUE),
    Other_sap = sum(SapOther_total, na.rm = TRUE),
    DF_live = sum(Over_DF_total, na.rm = TRUE), 
    WH_live = sum(Over_WH_total, na.rm = TRUE),   
    WRC_live = sum(Over_WRC_total, na.rm = TRUE), 
    Other_live = sum(Over_Other_total, na.rm = TRUE) 
  ) %>%
  pivot_longer(
    cols = -SoilSev,
    names_to = c("Species", "Stage"),
    names_sep = "_",
    values_to = "Count"
  ) %>%
  mutate(Species = recode(Species,
                          DF = "Douglas-fir",
                          WH = "Western hemlock",
                          WRC = "Western redcedar",
                          Other = "Other"),
         Stage = recode(Stage,
                        seed = "Seedlings",
                        sap = "Saplings",
                        live = "Overstory Live"))



# Create stacked bar with separate figs for each stage
ggplot(SpeciesSum, aes(x = SoilSev, y = Count, fill = Species)) +
  geom_bar(stat = "identity") +
  facet_wrap(~Stage, scales = "free_y") +
  scale_fill_viridis_d(option = "mako") +
  theme_bw() +
  labs(
    + x = "Soil Burn Severity",
    + y = "Count",
    + fill = "Species",
    + title = "Tree Species Composition by Stage and Burn Severity") +
  +     theme(plot.title = element_text(hjust = 0.5))

ggplot(SpeciesSum, aes(x = SoilSev, y = Count, fill = Species)) +
  geom_bar(stat = "identity") +
  facet_wrap(~Stage, scales = "free_y") +
  scale_fill_viridis_d(option = "mako") +
  theme_bw() +
  labs(
    + x = "Soil Burn Severity",
    + y = "Count",
    + fill = "Species",
    + title = "Tree Species Composition by Stage and Burn Severity") +
  theme(
    + plot.title = element_text(hjust = 0.5),
    + axis.text.x = element_text(angle = 45, hjust = 1)
    + )
