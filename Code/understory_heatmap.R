# ===============================================
# Script: understory_heatmap.R
# Purpose: Load understory species data and create a
#          heatmap of top species by SBS
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

# Read the understory sheet
UnderData <- read_excel("Downloads/fresh_n_clean_LH_Data.xlsx", sheet = "Understory Species")

# Change format to long data 
UnderLong <- UnderData %>% +
  pivot_longer(cols = starts_with("UnderSp"), +                  
  names_to = "UnderSp_num", +                  
  values_to = "Species") %>% + 
  filter(!is.na(Species))  # remove empty slots

# Format species by freq
UnderFreq <- UnderLong %>% +
  group_by(Species) %>% +
  summarize(Frequency = n()) %>% +
  arrange(desc(Frequency))

# Count species by burn severity
  > Species_count <- UnderLong %>% +
    left_join(LHData %>% select(PlotNum, SoilSev), by = "PlotNum") %>% + 
    group_by(SoilSev, Species) %>% + 
    summarize(Freq = n(), .groups = "drop")

# filter to only species that appear >2 times
> Species_count <- Species_count %>% filter(Freq > 2)

# Heatmap
ggplot(Species_count, aes(x = SoilSev, y = fct_reorder(Species, Freq), fill = Freq)) +
  geom_tile(color = "white") +
  scale_fill_viridis_c(option = "mako") +
  theme_minimal() +
  labs(x = "Burn Severity", y = "Species", fill = "Plot Count", + 
  title = "Understory Species Presence by Burn Severity") +
  theme(plot.title = element_text(hjust = 0.5), + 
  axis.text.x = element_text(angle = 45, hjust = 1))

# ===============================================
