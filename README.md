# brownfieldgrids

## Overview
An R package for creating maps of brownfield land in London using the [2018 Brownfield Register](https://www.gov.uk/guidance/brownfield-land-registers), [OpenStreetMap (OSM)](https://wiki.openstreetmap.org/wiki/Tag:landuse=brownfield) and the [2009-2010 NLUD](https://data.london.gov.uk/dataset/london-brownfield-sites-review). Users can download the 2018 Brownfield Register dataset for Greater London, which contains data from each borough and several development corporations. The tool was created as part of an MSc dissertation at CASA, UCL, in 2018.

## Installation
```
# Install devtools
install.packages("devtools")
library(devtools)

# Update packages
update.packages(ask=F)

# Install brownfieldgrids
devtools::install_github("lbuk/brownfieldgrids")
library(brownfieldgrids)

# Install osmdata
install_github("ropensci/osmdata")
library(osmdata)

# If you request more info or have any problems then email liam.bolton.17@ucl.ac.uk
```

## Usage
```
# Minimalistic map of OSM brownfields at Woolwich Dockyard and the local authority outline of Barnet
brownfieldgrids::brownfieldgrid_osm_borough("Brent Cross, London")
```
![OSM Borough Map](https://github.com/lbuk/brownfieldgrids/blob/master/img/brownfieldgrid_osm_borough_brent_cross.png)

```
# Interactive satellite map of OSM brownfields in RStudio
brownfieldgrids::brownfieldgrid_osm_satellite("Brent Cross, London")
```
![Interactive OSM Map](https://github.com/lbuk/brownfieldgrids/blob/master/img/brownfieldgrid_osm_satellite_brent_cross.jpeg)

```
# Map of OSM and NLUD brownfields
brownfieldgrids::brownfieldgrid_osm_nlud("Brent Cross, London")
```
![NLUD and OSM Map](https://github.com/lbuk/brownfieldgrids/blob/master/img/brownfieldgrids_osm_nlud_b_brent_cross.png)

```
# Map of 2009-2010 NLUD and 2018 Brownfield Register brownfields
brownfieldgrids::brownfieldgrid_register_nlud("Brent Cross, London")
```
![Brownfield Register and NLUD Map](https://github.com/lbuk/brownfieldgrids/blob/master/img/brownfieldgrid_register_nlud__b__brent_cross.png)

# Download the 2018 London Brownfield Register dataset as a csv file
```
data("london_brownfield_register")
write.csv(london_brownfield_register, file = "london_brownfield_register.csv")
```
