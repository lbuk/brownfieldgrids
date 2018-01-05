#' Download OSM Brownfield Land Data for Greater London
#'
#' Function for downloading OSM brownfield land use data.
#'
#' @param NA
#' @return OSM brownfield land use data
#' @examples
#' brownfieldgrid_osm_londondata()
#' @export

brownfieldgrid_osm_londondata = function() {
  
  br <- opq('Greater London, UK') %>% 
    add_osm_feature(key = "landuse", value = "brownfield", value_exact = FALSE) %>%
    osmdata_sp()
  
  br <- br$osm_polygons
  
  br@data

}