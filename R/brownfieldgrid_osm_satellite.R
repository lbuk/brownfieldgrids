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
  
  src = osmsource_api()
  
  # Set the bounding box
  bb = center_bbox(lon, lat, 1609, 1609)
  
  # Matrix for plotting the bounding box
  bb_mat = as.matrix(bb)
  left = bb_mat[1,1]
  bottom = bb_mat[2,1]
  right = bb_mat[3,1]
  top = bb_mat[4,1]
  
  # Extract OSM data from the bounding box
  Mile = get_osm(bb, source = src)
  
  wgs84 = '+proj=longlat +datum=WGS84'
  
  # Extract OSM brownfield land as polygons
  brownfield_ids = find(Mile, way(tags(k == "landuse" & v == "brownfield")))
  brownfield_ids = find_down(Mile, way(brownfield_ids))
  if(length(brownfield_ids$node_ids) == 0) {brownfield_osm = 0} else{br = subset(Mile, ids = brownfield_ids)}
  if(length(brownfield_ids$node_ids) == 0) {brownfield_osm = 0} else{brownfield_poly = as_sp(br, "polygons")}
  
  # Extract highway lines (i.e. road network)
  highway_ids = find(Mile, way(tags(k == "highway")))
  highway_ids = find_down(Mile, way(highway_ids))
  highway = subset(Mile, ids = highway_ids)
  highway_lines = as_sp(highway, "lines")
  
  # Tranform
  highway_wgs84 = spTransform(highway_lines, CRS(wgs84))
  if(length(brownfield_ids$node_ids) == 0) {brownfield_osm = 0} else{brownfield_wgs_84 = spTransform(brownfield_poly, CRS(wgs84))}
  
  proj4string(highway_wgs84) <- CRS(wgs84)
  if(length(brownfield_ids$node_ids) == 0) {brownfield_osm = 0} else{proj4string(brownfield_wgs_84) = CRS(wgs84)}
  
  # Interactive Leaflet map of OSM brownfield land and bounding box
  leaflet() %>% addProviderTiles(providers$Esri.WorldImagery) %>%
    setView(lon, lat, zoom = 15) %>%
    addPolygons(data = brownfield_wgs_84, col = "#38f7ce", fillOpacity = 0.7) %>% 
    addRectangles(lng1 = left, lat1 = bottom, lng2 = right, lat2 = top, color = "white", fillColor = "transparent") %>%
    addLegend("bottomright", colors=c("#38f7ce", "white"), labels=c("OSM", "Grid"), title="")
  
}