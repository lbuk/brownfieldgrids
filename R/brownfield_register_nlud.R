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
  
  src = osmsource_api()
  
  bb = center_bbox(lon, lat, 1609, 1609)
  
  bb_mat = as.matrix(bb)
  left = bb_mat[1,1]
  bottom = bb_mat[2,1]
  right = bb_mat[3,1]
  top = bb_mat[4,1]
  
  Mile = get_osm(bb, source = src)
  
  wgs84 = '+proj=longlat +datum=WGS84'
  
  brownfield_ids = find(Mile, way(tags(k == "landuse" & v == "brownfield")))
  brownfield_ids = find_down(Mile, way(brownfield_ids))
  if(length(brownfield_ids$node_ids) == 0) {brownfield_osm = 0} else{br = subset(Mile, ids = brownfield_ids)}
  if(length(brownfield_ids$node_ids) == 0) {brownfield_osm = 0} else{brownfield_poly = as_sp(br, "polygons")}
  
  highway_ids = find(Mile, way(tags(k == "highway")))
  highway_ids = find_down(Mile, way(highway_ids))
  highway = subset(Mile, ids = highway_ids)
  highway_lines = as_sp(highway, "lines")
  
  highway_wgs84 = spTransform(highway_lines, CRS(wgs84))
  if(length(brownfield_ids$node_ids) == 0) {brownfield_osm = 0} else{brownfield_wgs_84 = spTransform(brownfield_poly, CRS(wgs84))}
  
  data(brownfield_nlud_shp)
  london_brownfield_wgs_84 = spTransform(brownfield_nlud_shp, CRS(wgs84))
  
  data(london_brownfield_reg_wgs_84)
  london_brownfield_reg_wgs_84 = spTransform(london_brownfield_reg_wgs_84, CRS(wgs84))
  
  proj4string(london_brownfield_wgs_84) <- CRS(wgs84)
  proj4string(london_brownfield_reg_wgs_84) <- CRS(wgs84)
  proj4string(highway_wgs84) <- CRS(wgs84)
  if(length(brownfield_ids$node_ids) == 0) {brownfield_osm = 0} else{proj4string(brownfield_wgs_84) = CRS(wgs84)}
  
  par(mfrow=c(1,2))
  
  plot(highway_wgs84)
  plot(london_brownfield_wgs_84, col = "#0056b2", add = T, main = "")
  rect(xleft=left, ybottom=bottom, xright=right, ytop=top, xpd=NA, lwd=1.7, border='black')
  
  addscalebar(widthhint = 0.3,
              unitcategory = "metric", htin = 0.1, padin = c(0.37, 0.99),
              style = "ticks", lwd = 0.9, 
              linecol = "black", tick.cex = 0.7, labelpadin = 0.07, label.cex = 0.6,
              label.col = "black", pos = "bottomright")
  
  plot(highway_wgs84)
  plot(london_brownfield_reg_wgs_84, col = "#41b6c4", add = T, main = "")
  rect(xleft=left, ybottom=bottom, xright=right, ytop=top, xpd=NA, lwd=1.7, border='black')
  
  title(main = "", xlab="Data: NLUD 2009-2010, Brownfield Register 2018", cex = 0.6)

  add_legend <- function(...) {
    opar <- par(fig=c(0, 1, 0, 1), oma=c(0, 0, 0, 0), 
                mar=c(0, 0, 0, 0), new=TRUE)
    on.exit(par(opar))
    plot(0, 0, type='n', bty='n', xaxt='n', yaxt='n')
    legend(...)
  }
  
  palette = c("#0056b2", "#41b6c4", "black")
  land = c("NLUD", "Register", "Streets")
  add_legend(-0.30, 1.1, legend=land, pch=19, col=palette, bty='n', horiz = T, cex=0.9, title = "")
  
}