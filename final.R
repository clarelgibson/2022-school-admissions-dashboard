# schools
# SurreyDataGirl
# 2021-05-08

## FINAL DATA SETS ##

# Libraries
library(tidyverse)

# Performance
performance <- 
  c_info %>% 
  
  # join ks2 data
  inner_join(c_ks2,
            by = c("urn")) %>% 
  
  # tidy duplicated columns
  mutate(lea = coalesce(lea.x, lea.y),
         estab = coalesce(estab.x, estab.y),
         schname = coalesce(schname.x, schname.y),
         dfe_number = coalesce(dfe_number.x, dfe_number.y),
         laestab = laestab.x, laestab.y) %>% 
  
  # remove duplicated columns
  select(!ends_with(c(".x", ".y"))) %>% 
  
  # rearrange columns
  select(lea,
         urn,
         estab,
         dfe_number,
         laestab,
         schname,
         admin_district,
         academic_year,
         everything())

# Offers
offers <- c_offers_la

# Save rda files
save(performance, file = "rda/performance.rda")
save(offers, file = "rda/offers.rda")
save(performance,
     file = "~/Documents/learning/edx-edinburghx-statistics/data-in/performance.rda")
save(offers,
     file = "~/Documents/learning/edx-edinburghx-statistics/data-in/offers.rda")

# Write CSV files
write_csv(performance, "data-out/performance.csv", na = "")
