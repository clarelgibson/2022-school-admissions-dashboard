# schools
# SurreyDataGirl
# 2021-05-08

## READ RAW DATA INTO R ##

# Libraries----
library(tidyverse)

# Offers by LA
r_offers_la <- 
  read_csv("data-in/AppsandOffers_2020.csv")

# Info
r_info <- 
  read_csv("data-in/2021-05-07_850_936_gias.csv")

# KS2
# Step 1: create a list of files to read in
ks2_files <- 
  list.files(path = "data-in", pattern = "*ks2final.csv", full.names = TRUE)

# Step 2: read all files into a list of df. Reading all cols as character to
# avoid binding issues later
r_ks2_list <- 
  setNames(
    lapply(
      ks2_files, read_csv, col_types = cols(.default = "c")), ks2_files)

# Step 3: create a single df by binding rows from each df in the list above
r_ks2 <- r_ks2_list %>% 
  bind_rows(.id = "filename")