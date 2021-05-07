# schools
# SurreyDataGirl
# 2021-05-07

## READ RAW DATA INTO R ##

# Libraries----
library(tidyverse)

# Info
r_850_936_info <- read_csv("data-in/2021-05-07_850_936_gias.csv")

# KS2
ks2_files <- list.files(path = "data-in", pattern = "*ks2final.csv", full.names = TRUE)