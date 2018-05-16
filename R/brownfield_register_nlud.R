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
  
  bb = center_bbox(lon, lat, 1609, 1609)
  
  bb_mat = as.matrix(bb)
  left = bb_mat[1,1]
  bottom = bb_mat[2,1]
  right = bb_mat[3,1]
  top = bb_mat[4,1]

  bb <- opq(bbox = bb)
  b = bb  %>% add_osm_feature(key = 'highway')
  s_b <- osmdata_sp(b)
  sp::plot(s_b$osm_lines)
  
  st  = bb %>% add_osm_feature(key = 'landuse', value = 'brownfield')
  s_st <- osmdata_sp(st)
  sp::plot(s_st$osm_polygons, add = T)
  
  wgs84 = '+proj=longlat +datum=WGS84'
  
  highway_wgs_84 = spTransform(s_b$osm_lines, CRS(wgs84))
  if(nrow(s_st$osm_polygons) == 0) {brownfield_osm = 0} else{brownfield_wgs_84 = spTransform(s_st$osm_polygons, CRS(wgs84))}
  
  data(brownfield_nlud_shp)
  london_brownfield_wgs_84 = spTransform(brownfield_nlud_shp, CRS(wgs84))
  
  data(brownfield_register_shp)
  london_brownfield_reg_wgs_84 = spTransform(london_brownfield_reg_wgs_84, CRS(wgs84))
  
  proj4string(london_brownfield_wgs_84) <- CRS(wgs84)
  proj4string(london_brownfield_reg_wgs_84) <- CRS(wgs84)
  proj4string(highway_wgs_84) <- CRS(wgs84)
  
  par(mfrow=c(1,2))
  
  plot(highway_wgs_84)
  plot(london_brownfield_wgs_84, col = "#0056b2", add = T, main = "")
  rect(xleft=left, ybottom=bottom, xright=right, ytop=top, xpd=NA, lwd=1.7, border='black')
  
  addscalebar(widthhint = 0.3,
              unitcategory = "metric", htin = 0.1, padin = c(0.37, 0.99),
              style = "ticks", lwd = 0.9, 
              linecol = "black", tick.cex = 0.7, labelpadin = 0.07, label.cex = 0.6,
              label.col = "black", pos = "bottomright")
  
  plot(highway_wgs_84)
  plot(london_brownfield_reg_wgs_84, col = "#67a9cf", add = T, main = "")
  rect(xleft=left, ybottom=bottom, xright=right, ytop=top, xpd=NA, lwd=1.7, border='black')
  
  title(main = "", xlab="Data Source: NLUD 2009-10, Brownfield Register 2018", cex = 0.6)

  add_legend <- function(...) {
    opar <- par(fig=c(0, 1, 0, 1), oma=c(0, 0, 0, 0), 
                mar=c(0, 0, 0, 0), new=TRUE)
    on.exit(par(opar))
    plot(0, 0, type='n', bty='n', xaxt='n', yaxt='n')
    legend(...)
  }
  
  palette = c("#0056b2", "#67a9cf", "black")
  land = c("NLUD", "Register", "Streets")
  add_legend(-0.30, 1.1, legend=land, pch=19, col=palette, bty='n', horiz = T, cex=0.9, title = "")
  
}