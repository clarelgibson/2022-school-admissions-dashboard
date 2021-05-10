# schools
# SurreyDataGirl
# 2021-05-10

## OFFERS BY LOCAL AUTHORITY DATA SET ##

# Libraries----
library(tidyverse)

# Offers by LA
f_offers_la <- r_offers_la

# Write CSV file
write_csv(f_offers_la, "data-out/offers_la.csv", na = "")