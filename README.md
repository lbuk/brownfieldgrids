# brownfieldgrids

## Overview
An open source R package for creating maps of brownfield land in London using the [2018 Brownfield Register](https://www.gov.uk/guidance/brownfield-land-registers), [OpenStreetMap (OSM)](https://wiki.openstreetmap.org/wiki/Tag:landuse=brownfield) and the [2009-2010 NLUD](https://data.london.gov.uk/dataset/london-brownfield-sites-review).

## Installation
```
# Install devtools
install.packages("devtools")
library(devtools)

# Update packages
update.packages(ask=F)

# Install osmdata
install_github("ropensci/osmdata")
library(osmdata)

# Install brownfieldgrids
devtools::install_github("lbuk/brownfieldgrids")
library(brownfieldgrids)

# If you request more info or have any problems then email liam.bolton.17@ucl.ac.uk
```

## Usage
```
# Minimalistic map of OSM brownfields at Woolwich Dockyard and the local authority outline
brownfieldgrids::brownfieldgrid_osm_borough("Woolwich Dockyard, London")
```
![OSM Borough Map](https://github.com/lbuk/brownfieldgrids/blob/master/img/brownfieldgrid_osm_borough_woolwich_dockyard.png)

```
# Interactive grid map of OSM brownfields
brownfieldgrids::brownfieldgrid_osm_satellite("Woolwich Dockyard, London")
```
![Interactive OSM Map](https://github.com/lbuk/brownfieldgrids/blob/master/img/brownfieldgrid_osm_satellite_b_woolwich_dockyard.jpeg)

```
# Map of OSM and NLUD brownfields
brownfieldgrids::brownfieldgrid_osm_nlud("Woolwich Dockyard, London")
```
![NLUD and OSM Map](https://github.com/lbuk/brownfieldgrids/blob/master/img/brownfieldgrids_osm_nlud_woolwich_dockyard.png)

```
# Comparative map of the 2009-2010 NLUD and the 2018 Brownfield Register
brownfieldgrids::brownfieldgrid_register_nlud("Woolwich Dockyard, London")
```
![Brownfield Register and NLUD Map](https://github.com/lbuk/brownfieldgrids/blob/master/img/brownfieldgrid_register_nlud_woolwich_dockyard.png)

## Next Steps
Brownfieldgrids could be useful to planners, developers and citizens. It was created as part of a Master's dissertation at CASA, UCL.
