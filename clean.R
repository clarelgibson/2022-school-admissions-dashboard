# schools
# SurreyDataGirl
# 2021-05-08

## DATA CLEANING ##

# Libraries----
library(tidyverse)
library(janitor)

# Info
c_info <- 
  r_info %>% 
  
  # clean column headings with janitor
  clean_names() %>% 
  
  # rename some of the columns for brevity and to match the ks2 df
  rename(estab = establishment_number,
         schname = establishment_name,
         lea = la_code,
         estab_type = establishment_type_group_name,
         relchar = religious_character_name,
         education_phase = phase_of_education_name,
         admin_district = district_administrative_name,
         ofsted_rating = ofsted_rating_name) %>% 
  
  # add a column for the dfe_number and laestab (combines lea and estab)
  mutate(dfe_number = paste0(lea,"/",estab),
         laestab = as.numeric(paste0(lea,estab)))

# KS2
c_ks2 <- 
  r_ks2 %>% 
  
  # clean column names with janitor
  clean_names() %>% 
  
  # remove rows where urn is null (these are just rolled up totals)
  filter(!is.na(urn)) %>% 
  
  # select required columns
  select(filename,
         urn,
         lea,
         estab,
         schname,
         readprog,
         writprog,
         matprog) %>% 
  
  # retype columns
  mutate(across(c("lea",
                  "urn",
                  "estab",
                  "readprog",
                  "writprog",
                  "matprog"),
                as.numeric)) %>% 
  
  # add a column for the dfe_number and laestab (combines lea and estab)
  mutate(dfe_number = paste0(lea,"/",estab),
         laestab = as.numeric(paste0(lea,estab))) %>% 
  
  # extract academic year from filename
  mutate(academic_year = str_extract(filename, "\\d{4}-\\d{4}"))