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
         totpups,
         readprog,
         writprog,
         matprog) %>% 
  
  # retype columns
  mutate(across(c("lea",
                  "urn",
                  "estab",
                  "totpups",
                  "readprog",
                  "writprog",
                  "matprog"),
                as.numeric)) %>% 
  
  # add a column for the dfe_number and laestab (combines lea and estab)
  mutate(dfe_number = paste0(lea,"/",estab),
         laestab = as.numeric(paste0(lea,estab))) %>% 
  
  # extract academic year from filename and remove filename
  mutate(academic_year = str_extract(filename, "\\d{4}-\\d{4}")) %>% 
  select(-filename)

# Offers
c_offers_la <-  
  r_offers_la %>% 
  
  # Clean column names
  clean_names() %>% 
  
  # Remove rows that are not local authority (these are just rolled up totals)
  filter(geographic_level == "Local authority") %>% 
  
  # Select columns to keep
  select(!c(time_identifier,
            geographic_level,
            country_code,
            country_name,
            region_code,
            region_name,
            new_la_code)) %>% 
  
  # rename columns for consistency with performance data set
  rename(academic_year = time_period,
         lea = old_la_code,
         education_phase = school_phase) %>% 
  
  # reformat academic_year for consistency with performance data set
  mutate(academic_year = paste0(str_sub(academic_year,1,4),
                                "-20",
                                str_sub(academic_year,5,6))) %>% 
  
  # convert no_of_preferences to numeric
  mutate(no_of_preferences = as.numeric(no_of_preferences))
