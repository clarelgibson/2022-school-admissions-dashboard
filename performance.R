# schools
# SurreyDataGirl
# 2021-05-08

## PERFORMANCE DATA SET ##

# Libraries
library(tidyverse)

# Performance
f_performance <- 
  c_info %>% 
  
  # join ks2 data
  full_join(c_ks2,
            by = c("urn")) %>% 
  
  # tidy duplicated columns
  mutate(lea = coalesce(lea.x, lea.y),
         estab = coalesce(estab.x, estab.y),
         schname = coalesce(schname.x, schname.y),
         dfe_number = coalesce(dfe_number.x, dfe_number.y),
         laestab = laestab.x, laestab.y) %>% 
  
  # remove duplicated columns
  select(!ends_with(c(".x", ".y"))) %>% 
  
  # summarise progress scores as average of the three academic years
  group_by(urn) %>% 
  mutate(readprog = mean(readprog, na.rm = TRUE),
         writprog = mean(writprog, na.rm = TRUE),
         matprog = mean(matprog, na.rm = TRUE)) %>%
  select(-academic_year, -filename) %>% 
  distinct() %>% 
  
  # rearrange columns
  select(lea,
         urn,
         estab,
         dfe_number,
         laestab,
         schname,
         admin_district,
         everything())

# Save rda file
save(f_performance, file = "rda/f_performance.rda")

# Write CSV file
write_csv(f_performance, "data-out/performance.csv", na = "")
