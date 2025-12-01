# Soil Nutrients, Bacterial Taxa, and Nitrogen-Fixing Potential Five Years Post-Fire in the Western Cascades, OR
**This project will investigate the effects of the 2020 Lionshead burn stratified by soil burn severity and its effects on soil recovery and nutrient cycling dynamics by assessing the ecology, nutrients, microbes, and N-fixing rates at 40 plots.**
###### As of Fall 2025, this repository will contain just the field data - lab data will be available Winter 2025.
### This repository will contain four folder: Data, Code, Figs, and a Readme document to fully reproduce the code and figures contained in this project. For now, we will explore the field data with basic exploratory analysis in R.

## 1. Install and load the packages that may be used. 
* install.packages("tidyverse")
* install.packages("viridis")
* install.packages("readxl")
* install.packages("corrplot")

* library(tidyverse)
* library(viridis)
* library(readxl)
* library(corrplot)

###### If there are any additional packages you will need, they will be noted in the code.

## 2. Load the data into your R environment.
LHData <- read_excel("Data/fresh_n_clean_LH_Data.xlsx")

## 3. From here, you can optionally explore the dataset with:
* head(LHData)
* str(LHData)
* View(LHData)

## 4. You are now ready to code. 
###### For each figure you are interested in reproducing, there is a separate code file with the exact same naming convention. You should be able to copy/paste the code into R and produce the figure. Each code should have comments explaining its function.
* Ensure that when loading data in R you have the correct path as it may differ from what is given.
* Ensure that your variables are named the same as the given code, or it may not work.
* Always double-check that you have all needed packages installed and loaded.

  ### Direct questions to:
  Helena Kroleski
  kroleskh@oregonstate.edu
  Oregon State University: Forest, Engineering, and Resource Management
