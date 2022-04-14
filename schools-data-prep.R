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
# academic year 2014/15 through to 2021/2022. The data is aggregated 
# by local authority.
r_offers_la <- 
  read_csv("data-in/2021_appsandoffers.csv")

# 3.2 Offers by School ===============================================
# This dataset includes admissions data for each school within 
# Waverley Borough in Surrey for the academic year 2018/2019 through
# to 2021/2022. The data is aggregated by school.

# Step 1: create a list of files to read in
offers_sch_files <- 
  list.files(
    path = "data-in/offers-school",
    pattern = "*.csv",
    full.names = TRUE
  )

# Step 2: read all files into a list of df. Explicitly stating the 
# data type for each column to avoid binding issues later.
offers_sch_list <- 
  setNames(
    lapply(
      offers_sch_files,
      read_csv,
      col_types = "ncnncnnnn"
    ),
    offers_sch_files
  )

# Step 3: create a single df by binding rows from each df in the list
# above
r_offers_sch <- offers_sch_list %>% 
  bind_rows(.id = "filename")

# 3.3 Offers by Criteria =============================================
# This dataset includes admissions data for each school within
# Waverley Borough in Surrey for the academic year 2018/2019 through
# to 2021/2022. The data is aggregated by school and by admission
# criterion.

# Step 1: create a list of files to read in
offers_crit_files <- 
  list.files(
    path = "data-in/offers-criteria",
    pattern = "*.csv",
    full.names = TRUE
  )

# Step 2: read all files into a list of df. Explicitly stating the 
# data type for each column to avoid binding issues later.
offers_crit_list <- 
  setNames(
    lapply(
      offers_crit_files,
      read_csv,
      col_types = "ncnnccccnn"
    ),
    offers_crit_files
  )

# Step 3: create a single df by binding rows from each df in the list
# above
r_offers_crit <- offers_crit_list %>% 
  bind_rows(.id = "filename")

# 3.4 School Info ====================================================
# This dataset includes characteristics of each school in Surrey (LA
# code 936) and Hampshire (LA code 850). The data is aggregated by
# school.
r_info <- 
  read_csv("data-in/2021_gias.csv")

# 3.5 KS2 Performance ================================================
# This dataset includes details of primary school performance at Key
# Stage 2. Also includes some school characteristics. The data is 
# aggregated by school.

# Step 1: create a list of files to read in
ks2_files <- 
  list.files(
    path = "data-in/ks2",
    pattern = "*.csv",
    full.names = TRUE
  )

# Step 2: read all files into a list of df. Reading all cols as
# character to avoid binding issues later
ks2_list <- 
  setNames(
    lapply(
      ks2_files,
      read_csv,
      col_types = cols(.default = "c")
    ),
    ks2_files
  )

# Step 3: create a single df by binding rows from each df in the list
# above
r_ks2 <- ks2_list %>% 
  bind_rows(.id = "filename")

# 3.6 Save Raw Data
# Raw Info
save(
  r_info,
  file = "rda/r_info.rda"
)

# Raw KS2
save(
  r_ks2,
  file = "rda/r_ks2.rda"
)

# Raw Offers by Criteria
save(
  r_offers_crit,
  file = "rda/r_offers_crit.rda"
)

# Raw Offers by LA
save(
  r_offers_la,
  file = "rda/r_offers_la.rda"
)

# Raw Offers by School
save(
  r_offers_sch,
  file = "rda/r_offers_sch.rda"
)
