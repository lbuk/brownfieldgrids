#' Interactive Grid Maps of OSM Brownfield Land
#'
#' Function for creating interactive grid maps of OSM brownfield land.
#'
#' @param Location A location in London
#' @return Interactive grid map of OSM brownfield land.
#' @examples
#' brownfieldgrid_osm_satellite("Limehouse, London")
#' @export


brownfieldgrid_osm_satellite = function(location) {
  
  register_google(key = "AIzaSyBncLCPbi1HBUVHR5SQfqPbVqoZkwYNTbE")
  
  # Geocode the location
  location = 
    location %>%
      as.data.frame(location) %>%
      mutate(location = as.character(location)) %>%
      mutate_geocode(location)

  # Extract the latitude and longitude
  lon = location$lon
  lat = location$lat
  
  # Bounding box
  bb = center_bbox(lon, lat, 1609, 1609)
  
  # Bounding box matrix for grid plotting
  bb_mat = as.matrix(bb)
  left = bb_mat[1,1]
  bottom = bb_mat[2,1]
  right = bb_mat[3,1]
  top = bb_mat[4,1]
  
  # Query data from bounding box
  bb = opq(bbox = bb)
  
  # Query Overpass API for OpenStreetMap data
  st  = bb %>% add_osm_feature(key = 'landuse', value = 'brownfield')
  s_st = osmdata_sp(st)
  
  # Set CRS
  wgs84 = '+proj=longlat +datum=WGS84'
  
  # Print in console if there are no OpenStreetMap brownfields in the grid
  if(nrow(s_st$osm_polygons) == 0) {cat("Note: There are no OSM brownfield sites in this grid.")} else{brownfield_wgs_84 = spTransform(s_st$osm_polygons, CRS(wgs84))}
  
  proj4string(brownfield_wgs_84) <- CRS(wgs84)
  
  # Calculate area (hectares) of OpenStreetMap polygons
  if(nrow(s_st$osm_polygons) == 0) {nrow(s_st$osm_polygons) == 0} else{brownfield_wgs_84@data$area = areaPolygon(brownfield_wgs_84) / 10000}
  
  # Interactive Leaflet map of OpenStreetMap brownfields and bounding box
  leaflet() %>% addProviderTiles(providers$Esri.WorldImagery) %>%
    setView(lon, lat, zoom = 15) %>%
    addRectangles(lng1 = left, lat1 = bottom, lng2 = right, lat2 = top, color = "white", fillColor = "transparent") %>%
    addPolygons(data = brownfield_wgs_84, col = "#38f7ce", fillOpacity = 0.7,
                popup = paste0(
                  "<b>OSM Site Name: </b>"
                  , brownfield_wgs_84@data$name
                  , "<br><b>Hectares: </b>"
                  , round(brownfield_wgs_84@data$area, 2))) %>%
    addLegend("bottomright", colors=c("#38f7ce", "white"), labels=c("OSM", "Grid"), title="")
  
}
