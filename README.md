# brownfieldgrids

## Overview
brownfieldgrids is an R package for creating maps of brownfield land in London using the [2017/2018 Brownfield Register](https://www.gov.uk/guidance/brownfield-land-registers), [OpenStreetMap (OSM)](https://www.openstreetmap.org/) and the [2009/2010 National Land Use Database (NLUD)](https://data.london.gov.uk/dataset/london-brownfield-sites-review).

## Installation
```
# Install devtools
install.packages("devtools")
library(devtools)

# Install brownfieldgrids
devtools::install_github("lbuk/brownfieldgrids")
library(brownfieldgrids)
```

## Usage
```
# Map of brownfield land as created by an OSM user with borough overlaid
# Note: the quality of crowdsourced OSM data can vary
brownfieldgrid_osm_borough("Limehouse, London")
```

```
# Interactive map of brownfield land from OSM
# Note: the quality of crowdsourced OSM data can vary
brownfieldgrid_osm_satellite("Limehouse, London")
```

```
# Comparative map of brownfield land from 2017/2018 Brownfield Register and the 2009/2010 NLUD
brownfieldgrid_register_nlud("Limehouse, London")
```
