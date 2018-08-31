# brownfieldgrids

## Overview
An R package for creating maps of brownfield land in London using a range of data sources.

## Installation
```
# Install devtools
install.packages("devtools")
library(devtools)

# Update packages
update.packages(ask=F)

# Install the dev version of osmdata
install_github("ropensci/osmdata")
library(osmdata)

# Install brownfieldgrids
devtools::install_github("lbuk/brownfieldgrids")
library(brownfieldgrids)
```
If you have any problems (e.g. installation) then email me at liam.bolton.17@ucl.ac.uk or post on the Issues page.

## Usage
Create a minimalistic mile x mile OpenStreetMap (OSM) grid map of brownfield land at Woolwich Dockyard and the borough outline.
```
brownfieldgrids::brownfieldgrid_osm_borough("Woolwich Dockyard, London")
```
![OSM Borough Map](https://github.com/lbuk/brownfieldgrids/blob/master/img/brownfieldgrid_osm_borough_woolwich_dockyard.png)

Interactive grid map of OpenStreetMap brownfields.
```
brownfieldgrids::brownfieldgrid_osm_satellite("Woolwich Dockyard, London")
```
![Interactive OSM Map](https://github.com/lbuk/brownfieldgrids/blob/master/img/brownfieldgrid_osm_satellite_b_woolwich_dockyard.jpeg)

Map of OSM and [2009-2010 National Land Use Database (NLUD)](https://data.london.gov.uk/dataset/london-brownfield-sites-review) brownfields.
```
brownfieldgrids::brownfieldgrid_osm_nlud("Woolwich Dockyard, London")
```
![NLUD and OSM Map](https://github.com/lbuk/brownfieldgrids/blob/master/img/brownfieldgrids_osm_nlud_woolwich_dockyard.png)

Comparative map of the 2009-2010 NLUD and [2018 Brownfield Register](https://data.london.gov.uk/dataset/brownfield-land-register).
```
brownfieldgrids::brownfieldgrid_register_nlud("Woolwich Dockyard, London")
```
![Brownfield Register and NLUD Map](https://github.com/lbuk/brownfieldgrids/blob/master/img/brownfieldgrid_register_nlud_woolwich_dockyard.png)

## Data
This package makes use of [OpenStreetMap](https://www.openstreetmap.org/#map=19/51.48246/-0.06890&layers=NDG) brownfields, which OpenStreetMap defines as: “land scheduled for new development which was previously used for industrial purposes or some commercial uses”. The package makes extensive use of open data from the Brownfield Register and the NLUD.

## Limitations
Land use data, in particular OpenStreetMap data, can vary in quality. As of August 2018 not all of London's local authorities have uploaded their Brownfield Register data to the London Datastore and Havering has not published its data.

## Next Steps
Brownfieldgrids could be useful to planners, developers and citizens. The maps can be exported from R and critically used as part of reports, articles and masterplans. It was created as part of a Master's dissertation at the Centre for Advanced Spatial Analysis (CASA), UCL.

## License
Copyright 2018 Liam Bolton

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

[http://www.apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0)
