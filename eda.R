# schools
# SurreyDataGirl
# 2021-05-08

## EXPLORATORY DATA ANALYSIS ##

# Libraries
library(tidyverse)

# Is the laestab number unique per info record?
e_info_laestab <- 
  c_info %>% 
  group_by(laestab) %>% 
  summarise(laestab_ct = n()) %>% 
  filter(laestab_ct > 1)
# Yes it is

# Is the laestab number unique per ks2 record?
e_ks2_laestab <- 
  c_ks2 %>% 
  group_by(laestab, academic_year) %>% 
  summarise(laestab_ct = n()) %>% 
  filter(laestab_ct > 1)
# Yes it is

# Why are there records in the ks2 data where urn is null
e_ks2_na <- 
  r_ks2 %>% 
  filter(is.na(URN))

# Why are some records unmatched when joining info with performance?
e_info_unmatched <- 
  c_info %>% 
  anti_join(select(c_ks2, urn))

e_ks2_unmatched <- 
  c_ks2 %>% 
  anti_join(select(c_info, urn))