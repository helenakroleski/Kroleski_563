# ===============================================
# Script: understory_species.R
# Purpose: Load understory species data and create a
#          bar plot of top species (>5 freq)
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

# Filter species with frequency > 5
UnderFreqTop <- UnderFreq %>% +
  filter(Frequency > 5)

# Create bar plot
ggplot(UnderFreqTop, aes(x = reorder(Species, -Frequency), y = Frequency, fill = Species)) +
  geom_col() +
  scale_fill_viridis_d(option = "mako") +
  theme_bw() +
  labs(x = "Species", y = "Frequency", title = "Understory Species Frequency (>5)") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1),+ 
          legend.position = "none",+
          plot.title = element_text(hjust = 0.5))

# ===============================================

