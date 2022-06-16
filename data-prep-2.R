# Title:       Data Prep
# Project:     Schools
# Date:        2022-05-04
# Author:      Clare Gibson

# LIBRARIES ##########################################################
library(tidyverse)    # for general wrangling
library(lubridate)    # for date parsing
library(janitor)      # for cleaning column headings

# READ DATA ##########################################################
# Calendar ===========================================================
# Step 1: create a list of files to read in
calendar_files <- 
  list.files(
    path = "data-in/calendar",
    pattern = "*.csv",
    full.names = TRUE
  )

# Step 2: read all files into a list of df.
calendar_list <- 
  setNames(
    lapply(
      calendar_files,
      read_csv
    ),
    calendar_files
  )

# Step 3: create a single df by binding rows from each df in the list
# above
r_calendar <- calendar_list %>% 
  bind_rows(.id = "filename")

# National Curriculum Years ==========================================
# Step 1: create a list of files to read in
nc_files <- 
  list.files(
    path = "data-in/nc",
    pattern = "*.csv",
    full.names = TRUE
  )

# Step 2: read all files into a list of df.
nc_list <- 
  setNames(
    lapply(
      nc_files,
      read_csv
    ),
    nc_files
  )

# Step 3: create a single df by binding rows from each df in the list
# above
r_nc <- nc_list %>% 
  bind_rows(.id = "filename")

# School Information =================================================
# Step 1: create a list of files to read in
info_files <- 
  list.files(
    path = "data-in/info",
    pattern = "*.csv",
    full.names = TRUE
  )

# Step 2: read all files into a list of df.
info_list <- 
  setNames(
    lapply(
      info_files,
      read_csv
    ),
    info_files
  )

# Step 3: create a single df by binding rows from each df in the list
# above
r_info <- info_list %>% 
  bind_rows(.id = "filename") %>% 
  clean_names()

# Offers by LA =======================================================
# Step 1: create a list of files to read in
offers_la_files <- 
  list.files(
    path = "data-in/offers-la",
    pattern = "*.csv",
    full.names = TRUE
  )

# Step 2: read all files into a list of df.
offers_la_list <- 
  setNames(
    lapply(
      offers_la_files,
      read_csv
    ),
    offers_la_files
  )

# Step 3: create a single df by binding rows from each df in the list
# above
r_offers_la <- offers_la_list %>% 
  bind_rows(.id = "filename") %>% 
  clean_names()

# Offers by School ===================================================
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

# Step 3: create a single df by binding rows from each df in the 
# list above
r_offers_sch <- offers_sch_list %>% 
  bind_rows(.id = "filename") %>% 
  clean_names()

# Offers by Criterion ================================================
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
  bind_rows(.id = "filename") %>% 
  clean_names()

# KS2 Performance ====================================================
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

# MODEL DATA #########################################################
# brg_school =========================================================
# This is a table to allow linking of predecessor schools with their
# successors
brg_school_pred <-
  # start with the info df
  r_info %>% 
  # keep only the open schools
  filter(
    grepl(
      "Open",
      establishment_status_name
    )
  ) %>% 
  # select the identifiers and linked establishments
  select(
    status = establishment_status_name,
    urn_1 = urn,
    starts_with("links_")
  ) %>% 
  # pivot the links
  pivot_longer(
    cols = starts_with("links_"),
    names_to = "link_number",
    values_to = "full_link_text",
    values_drop_na = TRUE
  ) %>% 
  # split the description column into useful data
  mutate(
    urn_2 = as.numeric(
      str_extract(
        full_link_text,
        "\\d+"
      )
    ),
    urn_2_type = str_trim(
      str_extract(
        full_link_text,
        "\\D+"
      )
    )
  ) %>%
  # keep only the successor records and remove the link type
  filter(
    grepl("Predecessor", urn_2_type)
  ) %>% 
  # remove redundant columns
  select(
    urn_1,
    urn_2,
    urn_2_type
  ) %>% 
  select(-urn_2_type) %>% 
  # join back the dfe_numbers from r_info
  left_join(
    select(
      r_info,
      urn_1 = urn,
      la_code,
      establishment_number
    )
  ) %>% 
  unite(
    col = dfe_1,
    la_code,
    establishment_number,
    sep = "/"
  ) %>% 
  left_join(
    select(
      r_info,
      urn_2 = urn,
      la_code,
      establishment_number
    )
  ) %>% 
  unite(
    col = dfe_2,
    la_code,
    establishment_number,
    sep = "/"
  )

# Find the non-linked urns and dfe numbers in r_info
brg_school_none <- 
  # start with the info df
  r_info %>% 
  # keep only the open schools
  filter(
    grepl(
      "Open",
      establishment_status_name
    )
  ) %>% 
  # select required columns
  select(
    urn_1 = urn,
    la_code,
    establishment_number
  ) %>% 
  # create the dfe number
  unite(
    col = dfe_1,
    la_code,
    establishment_number,
    sep = "/"
  ) %>% 
  # add urn_2 and dfe_2
  mutate(
    urn_2 = urn_1,
    dfe_2 = dfe_1
  )

# Bind the two tables together
brg_school <- 
  brg_school_none %>% 
  bind_rows(brg_school_pred) %>% 
  # arrange by urn_1
  arrange(urn_1) %>% 
  # count occurrences of urn_2 values
  group_by(urn_2) %>% 
  mutate(urn_2_count = n()) %>% 
  ungroup() %>% 
  # remove redundant self-joins
  filter(
    urn_2_count == 1 |
    (urn_2_count > 1 & urn_2 != urn_1)
  ) %>% 
  # count again occurrences of urn_2 values
  group_by(urn_2) %>% 
  mutate(urn_2_count = n()) %>% 
  ungroup() %>% 
  # remove groups with more than 1 member
  filter(urn_2_count == 1) %>% 
  # remove the count column
  select(-urn_2_count) %>% 
  # add the school key
  group_by(urn_1) %>% 
  mutate(school_key = cur_group_id()) %>% 
  ungroup() %>% 
  select(school_key, everything())

# Dimensions =========================================================
# dim_school ---------------------------------------------------------
dim_school <- 
  # start with the info df
  r_info %>% 
  # filter to keep only urns in the urn_1 column of the bridge table
  filter(
    urn %in% brg_school$urn_1
  ) %>% 
  # add the school key
  left_join(
    select(
      brg_school,
      urn = urn_1,
      school_key
    )
  ) %>%
  distinct() %>% 
  # create the dfe_number
  unite(
    dfe_number,
    la_code,
    establishment_number,
    sep = "/"
  ) %>% 
  # select/rename the required columns
  select(school_key,
         urn,
         dfe_number,
         school_name = establishment_name,
         establishment_type = type_of_establishment_name,
         funding_type = establishment_type_group_name,
         school_status = establishment_status_name,
         open_date,
         close_date,
         phase_type = phase_of_education_name,
         religious_character = religious_character_name,
         statutory_low_age,
         statutory_high_age,
         administrative_district = district_administrative_name,
         administrative_ward = administrative_ward_name,
         street,
         locality,
         address3,
         town,
         county = county_name,
         postcode,
         easting,
         northing,
         school_website,
         telephone_num,
         head_title = head_title_name,
         head_first_name,
         head_last_name,
         head_preferred_job_title) %>% 
  # recode funding type
  mutate(funding_type = case_when(
    grepl("maintained", funding_type) ~ "Local authority",
    grepl("Free", funding_type) ~ "Free school",
    grepl("Acad", funding_type) ~ "Academy",
    TRUE ~ funding_type
  )) %>% 
  # convert dates to date type
  mutate(
    open_date = dmy(open_date),
    close_date = dmy(close_date)
  )
