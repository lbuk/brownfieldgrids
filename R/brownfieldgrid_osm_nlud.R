#' Grid Maps of OSM and NLUD Brownfield Land
#'
#' Function for creating grid maps of OSM and NLUD brownfield land for comparison.
#'
#' @param Location A location in London
#' @return Grid map of OSM and NLUD brownfield land.
#' @examples
#' brownfieldgrid_osm_nlud("Limehouse, London")
#' @export


brownfieldgrid_osm_nlud = function(location) {
  
  # Geocode the location
  location = geocode(location)
  
  # Extract latitude and longitude
  lon = location$lon
  lat = location$lat
  
  src = osmsource_api()
  
  # Set the bounding box
  bb = center_bbox(lon, lat, 1609, 1609)
  
  # Matrix for plotting bounding box
  bb_mat = as.matrix(bb)
  left = bb_mat[1,1]
  bottom = bb_mat[2,1]
  right = bb_mat[3,1]
  top = bb_mat[4,1]
  
  # Extract OSM data from bounding box and OSM API
  Mile = get_osm(bb, source = src)
  
  wgs84 = '+proj=longlat +datum=WGS84'
  
  # Extract OSM brownfield land as polygons
  brownfield_ids = find(Mile, way(tags(k == "landuse" & v == "brownfield")))
  brownfield_ids = find_down(Mile, way(brownfield_ids))
  if(length(brownfield_ids$node_ids) == 0) {brownfield_osm = 0} else{br = subset(Mile, ids = brownfield_ids)}
  if(length(brownfield_ids$node_ids) == 0) {brownfield_osm = 0} else{brownfield_poly = as_sp(br, "polygons")}
  
  # Extract OSM highway lines (i.e. road network)
  highway_ids = find(Mile, way(tags(k == "highway")))
  highway_ids = find_down(Mile, way(highway_ids))
  highway = subset(Mile, ids = highway_ids)
  highway_lines = as_sp(highway, "lines")
  
  # Transform
  highway_wgs84 = spTransform(highway_lines, CRS(wgs84))
  if(length(brownfield_ids$node_ids) == 0) {brownfield_osm = 0} else{brownfield_wgs_84 = spTransform(brownfield_poly, CRS(wgs84))}
  
  # Download the NLUD 2009-2010 brownfield shapefile
  data(brownfield_nlud_shp)
  
  # Transform
  london_brownfield_wgs_84 = spTransform(brownfield_nlud_shp, CRS(wgs84))
  
  proj4string(london_brownfield_wgs_84) <- CRS(wgs84)
  proj4string(highway_wgs84) <- CRS(wgs84)
  if(length(brownfield_ids$node_ids) == 0) {brownfield_osm = 0} else{proj4string(brownfield_wgs_84) = CRS(wgs84)}
  
  # Plot the road network, OSM brownfield sites, NLUD data and bounding box
  plot(highway_wgs84)
  plot(london_brownfield_wgs_84, col = "#0056b2", add = T, main = "")
  if(length(brownfield_ids$node_ids) == 0) {brownfield_osm = 0} else{plot(brownfield_wgs_84, add = T, col = "#38f7ce", xlab = "")}
  rect(xleft=left, ybottom=bottom, xright=right, ytop=top, xpd=NA, lwd=1.7, border='black')
  
  # Scale bar and title
  addscalebar(widthhint = 0.2,
              unitcategory = "metric", htin = 0.1, padin = c(0.70, 0.1),
              style = "ticks", lwd = 0.9, 
              linecol = "black", tick.cex = 0.7, labelpadin = 0.07, label.cex = 0.6,
              label.col = "black", pos = "bottomright")
  title(main = "", xlab="Data Source: OSM Land Use, NLUD-PDL 2009-10", cex = 0.6)
  
  # Function foor plotting legend
  add_legend <- function(...) {
    opar <- par(fig=c(0, 1, 0, 1), oma=c(0, 0, 0, 0), 
                mar=c(0, 0, 0, 0), new=TRUE)
    on.exit(par(opar))
    plot(0, 0, type='n', bty='n', xaxt='n', yaxt='n')
    legend(...)
  }
  
  # Plot the legend
  palette = c("#38f7ce", "#0056b2", "black")
  land = c("OSM", "NLUD", "Street Grid")
  add_legend(-0.32, 1.1, legend=land, pch=19, col=palette, bty='n', horiz = T, cex=0.9, title = "")
  
}