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
    path = "data-in/info",
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
# Dimensions =========================================================
# dim_school ---------------------------------------------------------
# Build the bridge table (current and linked establishments)
# Round 1 links
h_brg_school_1 <-
  # start with the info df
  r_info %>% 
  # select the identifiers and linked establishments
  select(
    urn,
    starts_with("links_")
  ) %>% 
  # pivot the links
  pivot_longer(
    cols = starts_with("links_"),
    names_to = "link",
    values_to = "description",
    values_drop_na = TRUE
  ) %>% 
  # split the description column into useful data
  mutate(
    linked_urn_1 = as.numeric(
      str_extract(
        description,
        "\\d+"
      )
    )
  ) %>% 
  # remove redundant columns
  select(
    -c(link,
       description)
  )

# Round 2 links
h_links_2 <- 
  h_brg_school_1 %>% 
  filter(
    !is.na(
      linked_urn_1
    )
  ) %>% 
  rename(
    linked_urn_2 = urn
  )

# Link round 2 into bridge
h_brg_school_2 <- 
  h_brg_school_1 %>% 
  left_join(h_links_2) %>% 
  distinct()

# Round 3 links
h_links_3 <- 
  h_brg_school_2 %>% 
  filter(
    !is.na(
      linked_urn_2
    )
  ) %>% 
  rename(
    linked_urn_3 = urn
  )

# Link round 3 into bridge
h_brg_school_3 <- 
  h_brg_school_2 %>% 
  left_join(h_links_3) %>% 
  distinct()

# Round 4 links
h_links_4 <- 
  h_brg_school_3 %>% 
  filter(
    !is.na(
      linked_urn_3
    )
  ) %>% 
  rename(
    linked_urn_4 = urn
  )

# Link round 4 into bridge
h_brg_school_4 <- 
  h_brg_school_3 %>% 
  left_join(h_links_4) %>% 
  distinct()

# Tidy the bridge table
brg_school <- 
  h_brg_school_4 %>% 
  # pivot the link rounds
  pivot_longer(
    cols = starts_with("linked_"),
    names_to = "link_type",
    values_to = "link_urn",
    values_drop_na = TRUE
  ) %>% 
  # remove link_type
  select(-link_type) %>% 
  # remove duplicates
  distinct() %>% 
  # remove self-joins
  filter(
    urn != link_urn
  ) %>% 
  # set parent urn as max of the 2 urns
  # set child urn as min of the 2 urns
  mutate(
    parent_urn = pmax(urn, link_urn),
    child_urn = pmin(urn, link_urn)
  ) %>% 
  # remove the original urn and link_urn columns
  select(
    parent_urn,
    child_urn
  ) %>% 
  # remove duplicates
  distinct()

# QC the bridge
brg_qc_parent <- 
  brg_school %>% 
  group_by(parent_urn) %>% 
  summarise(count = n()) %>% 
  arrange(desc(count))

brg_qc_child <- 
  brg_school %>% 
  group_by(child_urn) %>% 
  summarise(count = n()) %>% 
  arrange(desc(count))

# Bridge Attempt 2 ===================================================
h2_brg_school_1 <-
  # start with the info df
  r_info %>% 
  # select the identifiers and linked establishments
  select(
    urn,
    starts_with("links_")
  ) %>% 
  # pivot the links
  pivot_longer(
    cols = starts_with("links_"),
    names_to = "link",
    values_to = "description",
    values_drop_na = TRUE
  ) %>% 
  # split the description column into useful data
  mutate(
    linked_urn_1 = as.numeric(
      str_extract(
        description,
        "\\d+"
      )
    )
  )


# Facts ==============================================================