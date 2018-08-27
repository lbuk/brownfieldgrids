#' Grid Maps of Brownfield Register 2018 and NLUD 2009-2010 Brownfields
#'
#' Function for creating grid maps of Brownfield Register 2018 and NLUD 2009-2010 brownfields for comparison.
#'
#' @param Location A location in London
#' @return Grid map of Brownfield Register and NLUD brownfields.
#' @examples
#' brownfieldgrid_register_nlud("Limehouse, London")
#' @export

brownfieldgrid_register_nlud = function(location) {
  
  # Geocode the location
  location = geocode(location)
  
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
  
  # Query Overpass API for OpenStreetMap data
  b = bb  %>% add_osm_feature(key = 'highway')
  s_b = osmdata_sp(b)
  
  st  = bb %>% add_osm_feature(key = 'landuse', value = 'brownfield')
  s_st = osmdata_sp(st)
  
  # Set CRS
  wgs84 = '+proj=longlat +datum=WGS84'
  
  highway_wgs_84 = spTransform(s_b$osm_lines, CRS(wgs84))
  if(nrow(s_st$osm_polygons) == 0) {brownfield_osm = 0} else{brownfield_wgs_84 = spTransform(s_st$osm_polygons, CRS(wgs84))}
  
  # Download Brownfield Register and NLUD data from brownfieldgrids
  data(brownfield_nlud_shp)
  london_brownfield_wgs_84 = spTransform(brownfield_nlud_shp, CRS(wgs84))
    
  data(brownfield_register_shapefile)
  brownfield_register_shapefile = spTransform(brownfield_register_shapefile, CRS(wgs84))
  
  data(brownfield_register_points)
  brownfield_register_points = spTransform(brownfield_register_points, CRS(wgs84))
  
  proj4string(london_brownfield_wgs_84) <- CRS(wgs84)
  proj4string(brownfield_register_shapefile) <- CRS(wgs84)
  proj4string(brownfield_register_points) <- CRS(wgs84)
  proj4string(highway_wgs_84) <- CRS(wgs84)
  
  # Set plot layout for comparative visualisation
  par(mfrow=c(1,2))
  
  # Plot NLUD data
  plot(highway_wgs_84)
  plot(london_brownfield_wgs_84, col = "#0056b2", add = T, main = "")
  rect(xleft=left, ybottom=bottom, xright=right, ytop=top, xpd=NA, lwd=1.7, border='black')
  
  # Titles and subtitles
  title(main = "", xlab="Data: NLUD 2009-10", cex = 0.6)
  
  # Scale bar
  addscalebar(widthhint = 0.3,
              unitcategory = "metric", htin = 0.1, padin = c(0.37, 0.6),
              style = "ticks", lwd = 0.9, plotepsg = 4326,
              linecol = "black", tick.cex = 0.7, labelpadin = 0.07, label.cex = 0.55,
              label.col = "black", pos = "bottomright")
  
  # Plot Brownfield Register data
  plot(highway_wgs_84)
  plot(brownfield_register_shapefile, col = "#67a9cf", add = T, main = "")
  plot(brownfield_register_points, col = "#67a9cf", pch=20, add = T, main = "")
  rect(xleft=left, ybottom=bottom, xright=right, ytop=top, xpd=NA, lwd=1.7, border='black')
  
  # Titles and subtitles
  title(main = "", xlab="Data: Brownfield Register 2018", cex = 0.6)
  
  # NLUD legend function
  add_legend_1 = function(...) {
    opar <- par(fig=c(0, 1, 0, 1), oma=c(0, 0, 0, 0), 
                mar=c(0, 0, 0, 0), new=TRUE)
    on.exit(par(opar))
    plot(0, 0, type='n', bty='n', xaxt='n', yaxt='n')
    legend(...)
  }
  
  # Brownfield Register legend function
  add_legend_2 = function(...) {
    opar <- par(fig=c(0, 1, 0, 1), oma=c(0, 0, 0, 0), 
                mar=c(0, 0, 0, 0), new=TRUE)
    on.exit(par(opar))
    plot(0, 0, type='n', bty='n', xaxt='n', yaxt='n')
    legend(...)
  }
  
  # Plot NLUD legend
  palette_1 = c("#0056b2", "black")
  land_1 = c("NLUD", "Streets")
  add_legend_1(-0.77, 0.8, legend=land_1, pch=19, col=palette_1, bty='n', horiz = T, cex=1.05, title = "")
  
  # Plot Brownfield Register legend
  palette_2 = c("#67a9cf", "black")
  land_2 = c("Register", "Streets")
  add_legend_2(0.25, 0.8, legend=land_2, pch=19, col=palette_2, bty='n', horiz = T, cex=1.05, title = "")
  
}
