# Title:       Schools Data Prep
# Project:     Schools
# Date:        2022-04-10
# Author:      Clare Gibson

# 1. SUMMARY #########################################################
# This script reads in the data used for this project.
# Data sources: https://www.gov.uk, https://www.surreycc.gov.uk

# 2. PACKAGES ########################################################
library(tidyverse)

# 3. READ DATA #######################################################
# 3.1 Offers by LA ===================================================
# This dataset includes details of the number of offers made by
# preference within each local authority (LA) in England for the
# academic year 2014/15 onward.
r_offers_la <- 
  read_csv("data-in/2021_appsandoffers.csv")

# 3.2 Info ===========================================================
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