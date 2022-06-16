library(rjson)
result <- fromJSON(file = "https://webapps.bgs.ac.uk/data/webservices/CoordConvert_LL_BNG.cfc?method=BNGtoLatLng&easting=533498&northing=181201")
result_lat <- result[["LATITUDE"]]
