#' Interactive Grid Maps of NLUD Brownfield Land
#'
#' Function for creating interactive grid maps of NLUD brownfield land.
#'
#' @param Location A location in London
#' @return Interactive grid map of NLUD brownfield land.
#' @examples
#' brownfieldgrid_nlud_satellite("Limehouse, London")
#' @export

brownfieldgrid_nlud_satellite = function(location) {
  
  register_google(key = "AIzaSyBncLCPbi1HBUVHR5SQfqPbVqoZkwYNTbE")
  
  # Geocode the location
    # Geocode the location
  location = 
    location %>%
      as.data.frame(location) %>%
      mutate(location = as.character(location)) %>%
      mutate_geocode(location)

  # Extract the latitude and longitude
  lon = location$lon
  lat = location$lat
  
  # Mile by mile bounding box
  bb = center_bbox(lon, lat, 1609, 1609)
  
  bb_mat = as.matrix(bb)
  left = bb_mat[1,1]
  bottom = bb_mat[2,1]
  right = bb_mat[3,1]
  top = bb_mat[4,1]
  
  wgs84 = '+proj=longlat +datum=WGS84'
  
  data("brownfield_nlud_shp")
  
  london_brownfield_wgs_84 = spTransform(brownfield_nlud_shp, CRS(wgs84))
  
  proj4string(london_brownfield_wgs_84) <- CRS(wgs84)
  
  leaflet() %>% addProviderTiles(providers$Esri.WorldImagery) %>%
    setView(lon, lat, zoom = 15) %>%
    addRectangles(lng1 = left, lat1 = bottom, lng2 = right, lat2 = top, color = "white", fillColor = "transparent") %>%
    addPolygons(data = london_brownfield_wgs_84, col = "#0056b2", fillOpacity = 0.7, 
                popup = paste0(
                    "<b>Site Name: </b>"
                    , brownfield_nlud_shp@data$PAO
                    , "<br><b>Location: </b>"
                    , brownfield_nlud_shp@data$STREET
                    , ", "
                    , brownfield_nlud_shp@data$LOCALITY
                    , "<br><b>Site Reference: </b>"
                    , brownfield_nlud_shp@data$SITE_REF
                    , "<br><b>Hectares: </b>"
                    , round(brownfield_nlud_shp@data$AREA, 2))) %>% 
    addLegend("bottomright", colors=c("#0056b2", "white"), labels=c("NLUD", "Grid"), title="")
  
}
