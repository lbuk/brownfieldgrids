#' OSM Brownfield Land by Borough
#'
#' Function for creating maps of OSM brownfield land by borough.
#'
#' @param Location A London borough
#' @return Map of brownfield land by borough.
#' @examples
#' brownfieldgrid_osm_borough_nogrid(“Tower Hamlets")
#' @export

brownfieldgrid_osm_borough_nogrid = function(borough) {
  
  
  data(london_boro_shp)

  wgs84 = '+proj=longlat +datum=WGS84'
  
  london_borough = spTransform(london_boro_shp, CRS(wgs84))
  
  br <- opq('Greater London, UK') %>% 
    add_osm_feature(key = "landuse", value = "brownfield", value_exact = FALSE) %>%
    osmdata_sp()
  
  br <- br$osm_polygons
  
  wgs84 = '+proj=longlat +datum=WGS84'
  
  br <- spTransform(br, CRS(wgs84))
  
  borough = copy(london_boro_shp[london_boro_shp@data$NAME==borough,])
  
  borough = spTransform(borough, CRS(wgs84))
  
  clip_borough = gIntersection(br, borough, byid=TRUE, drop_lower_td=TRUE)
  
  plot(borough)
  plot(clip_borough, col = "#38f7ce", add = T, main = "Camden")
  
  addscalebar(widthhint = 0.3,
              unitcategory = "imperial", htin = 0.1, padin = c(0.9, 0.1),
              style = "ticks", lwd = 0.9, 
              linecol = "black", tick.cex = 0.7, labelpadin = 0.07, label.cex = 0.6,
              label.col = "black", pos = "bottomright")
  title(main = "", xlab="Data Source: OSM Land Use", cex = 0.6)
  
  # Plot legend
  add_legend <- function(...) {
    opar <- par(fig=c(0, 1, 0, 1), oma=c(0, 0, 0, 0), 
                mar=c(0, 0, 0, 0), new=TRUE)
    on.exit(par(opar))
    plot(0, 0, type='n', bty='n', xaxt='n', yaxt='n')
    legend(...)
  }
  
  palette = c("#38f7ce", "black")
  land = c("OSM", "Borough")
  
  add_legend(-0.15, 0.99, legend=land, pch=19, col=palette, bty='n', horiz = T, cex=0.9, title = "")
  
}