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
  
  # Mile by mile bounding box
  bb = center_bbox(lon, lat, 1609, 1609)
  
  # Bounding box matrix for grid plotting
  bb_mat = as.matrix(bb)
  left = bb_mat[1,1]
  bottom = bb_mat[2,1]
  right = bb_mat[3,1]
  top = bb_mat[4,1]
  
  # Query data from bounding box
  bb = opq(bbox = bb)
  
  # Query Overpass API for OpenStreetMap data in bounding box
  st  = bb %>% add_osm_feature(key = 'landuse', value = 'brownfield')
  s_st = osmdata_sp(st)
  
  # Set CRS
  wgs84 = '+proj=longlat +datum=WGS84'
  
  # Download data from brownfieldgrids package
  data(london_boro_shp)
  
  data = data.frame(lon, lat)
  
  london_boro_shp = spTransform(london_boro_shp, CRS(wgs84))
  
  if(nrow(s_st$osm_polygons) == 0) {brownfield_osm = 0} else{brownfield_wgs_84 = spTransform(s_st$osm_polygons, CRS(wgs84))}
  
  # Spatialpoints dataframe for the centre of bounding box
  SP = SpatialPointsDataFrame(coords = data, data = data, proj4string = CRS(wgs84))
  
  # Bounding box point in London borough polygon
  df_borough = over(SP, london_boro_shp[,"NAME"])
  
  # Extract local authority the grid is centred on
  borough = copy(london_boro_shp[london_boro_shp@data$NAME==df_borough[1]$NAME,])
  
  # Transform
  borough = spTransform(borough, CRS(wgs84))
  
  proj4string(borough) = CRS(wgs84)
  
  # Print in console if there are no OpenStreetMap brownfields in bounding box
  if(nrow(s_st$osm_polygons) == 0) {cat("Note: There are no OSM brownfield sites in this grid. ")} else{proj4string(brownfield_wgs_84) <- CRS(wgs84)}
  
  par(mfrow=c(1,1))
  
  # Plot the borough, bounding box and OSM brownfield land
  plot(borough)
  rect(xleft=left, ybottom=bottom, xright=right, ytop=top, xpd=NA, lwd=1.7, border='black')
  if(nrow(s_st$osm_polygons) == 0) {brownfield_osm = 0} else{sp::plot(brownfield_wgs_84, add = T, col = "#38f7ce", xlab = "")}
  
  # Scale bar
  addscalebar(widthhint = 0.2,
              unitcategory = "imperial", htin = 0.1, padin = c(0.85, 0.1),
              style = "ticks", lwd = 0.9, plotepsg = 4326,
              linecol = "black", tick.cex = 0.7, labelpadin = 0.07, label.cex = 0.6,
              label.col = "black", pos = "bottomright")
  
  # Titles and subtitles
  title(main = "", xlab="Data: OSM", cex = 0.6)
  
  # Function for plotting legend
  # The function should be attributed to a Stackoverflow (Van Der Laan, 2014)
  # Van Der Laan, J. 2014. Plot a Legend Outside the Legend Area in Base Graphics. [Online]. [Accessed 29 November 2017]. Available from: https://stackoverflow.com/questions/3932038/plot-a-legend-outside-of-the-plotting-area-in-base-graphics/3932558
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
  
  # Print the local authority the box is centred on in the terminal
  boro = as.character(df_borough[1]$NAME)
  
  cat("Brownfield grid centred on the London local authority of", boro)
  
}
