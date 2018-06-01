#' Interactive Grid Maps of Brownfield Land and Borough
#'
#' Function for creating interactive grid maps of OSM brownfield land.
#'
#' @param Location A location in London
#' @return Interactive grid map of brownfield land and borough outline.
#' @examples
#' brownfieldgrid_osm_satellite("Limehouse, London")
#' @export


brownfieldgrid_osm_satellite = function(location) {
  
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
  
  bb <- opq(bbox = bb)
  b = bb  %>% add_osm_feature(key = 'highway')
  s_b <- osmdata_sp(b)
  
  st  = bb %>% add_osm_feature(key = 'landuse', value = 'brownfield')
  s_st <- osmdata_sp(st)
  sp::plot(s_st$osm_polygons, add = T)
  
  wgs84 = '+proj=longlat +datum=WGS84'
  
  highway_wgs_84 = spTransform(s_b$osm_lines, CRS(wgs84))
  if(nrow(s_st$osm_polygons) == 0) {brownfield_osm = 0} else{brownfield_wgs_84 = spTransform(s_st$osm_polygons, CRS(wgs84))}
  
  proj4string(highway_wgs_84) <- CRS(wgs84)
  proj4string(brownfield_wgs_84) <- CRS(wgs84)
  
  # Interactive Leaflet map of OSM brownfield land and bounding box
  leaflet() %>% addProviderTiles(providers$Esri.WorldImagery) %>%
    setView(lon, lat, zoom = 15) %>%
    addPolygons(data = brownfield_wgs_84, col = "#38f7ce", fillOpacity = 0.7) %>% 
    addRectangles(lng1 = left, lat1 = bottom, lng2 = right, lat2 = top, color = "white", fillColor = "transparent") %>%
    addLegend("bottomright", colors=c("#38f7ce", "white"), labels=c("OSM", "Grid"), title="")
  
}
