#' Interactive Grid Maps of Brownfield Register Brownfield Land
#'
#' Function for creating interactive grid maps of Brownfield Register brownfield land.
#'
#' @param Location A location in London
#' @return Interactive grid map of Brownfield Register brownfield land.
#' @examples
#' brownfieldgrid_register_satellite("Limehouse, London")
#' @export

brownfieldgrid_register_satellite = function(location) {
  
  # Geocode the location
  location = geocode(location)
  
  # Extract the latitude and longitude
  lon = location$lon
  lat = location$lat
  
  # Bounding box
  bb = center_bbox(lon, lat, 1609, 1609)
  
  bb_mat = as.matrix(bb)
  left = bb_mat[1,1]
  bottom = bb_mat[2,1]
  right = bb_mat[3,1]
  top = bb_mat[4,1]
  
  wgs84 = '+proj=longlat +datum=WGS84'
  
  brownfield_register_shapefile = spTransform(brownfield_register_shapefile, CRS(wgs84))
  proj4string(brownfield_register_shapefile) <- CRS(wgs84)
  
  brownfield_register_points = spTransform(brownfield_register_points, CRS(wgs84))
  proj4string(brownfield_register_points) <- CRS(wgs84)
  
  leaflet() %>% addProviderTiles(providers$Esri.WorldImagery) %>%
    setView(lon, lat, zoom = 15) %>%
    addRectangles(lng1 = left, lat1 = bottom, lng2 = right, lat2 = top, color = "white", fillColor = "transparent") %>%
    addPolygons(data = brownfield_register_shapefile, col = "#67a9cf", fillOpacity = 0.7, popup = ~brownfield_register_shapefile@data$SiteNameAddress) %>%
    addCircleMarkers(data = brownfield_register_points, lat = brownfield_register_points@data$GeoY, lng = brownfield_register_points@data$GeoX, color = "#67a9cf", 
                     stroke = F, fillOpacity = 0.9, radius = 5,
                     popup = ~brownfield_register_points@data$SiteNameAddress) %>%
    addLegend("bottomright", colors=c("#67a9cf", "white"), labels=c("Register", "Grid"), title="")
  
}
