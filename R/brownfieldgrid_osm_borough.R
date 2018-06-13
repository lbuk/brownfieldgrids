#' Grid Maps of Brownfield Land and Borough
#'
#' Function for creating grid maps of OSM brownfield land and the borough outline.
#'
#' @param Location A location in London
#' @return Grid map of brownfield land and borough outline.
#' @examples
#' brownfieldgrid_osm_borough("Limehouse, London")
#' @export


brownfieldgrid_osm_borough = function(location) {
  
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
  
  st  = bb %>% add_osm_feature(key = 'landuse', value = 'brownfield')
  s_st <- osmdata_sp(st)
  
  wgs84 = '+proj=longlat +datum=WGS84'
  
  data(london_boro_shp)
  
  data = data.frame(lon, lat)
  
  london_boro_shp = spTransform(london_boro_shp, CRS(wgs84))
  
  if(nrow(s_st$osm_polygons) == 0) {brownfield_osm = 0} else{brownfield_wgs_84 = spTransform(s_st$osm_polygons, CRS(wgs84))}
  
  # Spatial points dataframe for the centre of bounding box
  SP = SpatialPointsDataFrame(coords = data, data = data, proj4string = CRS(wgs84))
  
  # Bounding box point in London borough polygon
  df_borough = over(SP, london_boro_shp[,"NAME"])
  
  # Borough for plotting
  borough = copy(london_boro_shp[london_boro_shp@data$NAME==df_borough[1]$NAME,])
  
  # Transform
  borough = spTransform(borough, CRS(wgs84))
  
  proj4string(borough) = CRS(wgs84)
  if(nrow(s_st$osm_polygons) == 0) {brownfield_osm = 0} else{proj4string(brownfield_wgs_84) <- CRS(wgs84)}
  
  par(mfrow=c(1,1))
  
  # Plot the borough, bounding box and OSM brownfield land
  plot(borough)
  rect(xleft=left, ybottom=bottom, xright=right, ytop=top, xpd=NA, lwd=1.7, border='black')
  if(nrow(s_st$osm_polygons) == 0) {brownfield_osm = 0} else{sp::plot(brownfield_wgs_84, add = T, col = "#38f7ce", xlab = "")}
  
  # Scale bar
  addscalebar(widthhint = 0.2,
              unitcategory = "imperial", htin = 0.1, padin = c(0.85, 0.1),
              style = "ticks", lwd = 0.9, 
              linecol = "black", tick.cex = 0.7, labelpadin = 0.07, label.cex = 0.6,
              label.col = "black", pos = "bottomright")
  title(main = "", xlab="Data Source: OSM Land Use", cex = 0.6)
  
  # Function for plotting legend
  add_legend <- function(...) {
    opar <- par(fig=c(0, 1, 0, 1), oma=c(0, 0, 0, 0), 
                mar=c(0, 0, 0, 0), new=TRUE)
    on.exit(par(opar))
    plot(0, 0, type='n', bty='n', xaxt='n', yaxt='n')
    legend(...)
  }
  
  # Plot legend
  palette = c("#38f7ce", "black")
  land = c("OSM", "Grid")
  
  add_legend(-0.91, 0.99, legend=land, pch=19, col=palette, bty='n', horiz = T, cex=0.9, title = "")
  
  # Print the borough the bounding box is centred on in the terminal
  boro = as.character(df_borough[1]$NAME)
  
  cat("Brownfield grid centred on the London local authority of... ", boro)
  
}
