# brownfieldgrids

## Overview
brownfieldgrids is an R package for creating maps of brownfield land in London using the [2017/2018 Brownfield Register](https://www.gov.uk/guidance/brownfield-land-registers), [OpenStreetMap (OSM)](https://www.openstreetmap.org/) and the [2009/2010 National Land Use Database (NLUD)](https://data.london.gov.uk/dataset/london-brownfield-sites-review).

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
```

## Usage

```
# Minimalistic map of OpenStreetMap brownfields at Brent Cross and the local authority outline
brownfieldgrids::brownfieldgrid_osm_borough("Brent Cross, London")
```
![OSM Borough Map](https://github.com/lbuk/brownfieldgrids/blob/master/img/brownfieldgrid_osm_borough_brent_cross.png)

```
# Interactive satellite map of OpenStreetMap brownfields in R
brownfieldgrids::brownfieldgrid_osm_satellite("Brent Cross, London")
```
![Interactive OSM Map](https://github.com/lbuk/brownfieldgrids/blob/master/img/brownfieldgrid_osm_satellite_brent_cross.jpeg)
