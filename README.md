# brownfieldgrids

## Overview
An R package for creating grid maps of brownfield land in London. It was created as part of a Master's dissertation at the Centre for Advanced Spatial Analysis (CASA), UCL.

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
If you have any problems with the package (e.g. installation) then email me at liam.bolton.17@ucl.ac.uk or post on the Issues page of the repository. You may have to re-install the sp package and the brownfieldgrids package, for example. 

## Usage
Create a mile x mile OpenStreetMap (OSM) grid map of brownfield land in Woolwich Dockyard and the borough outline. The function also prints the local authority in the R console.
```
brownfieldgrids::brownfieldgrid_osm_borough("Woolwich Dockyard, London")
```
![OSM Borough Map](https://github.com/lbuk/brownfieldgrids/blob/master/img/brownfieldgrid_osm_borough_woolwich_dockyard.png)

Interactive mile x mile grid map the OSM brownfields at Woolwich Dockyard.
```
brownfieldgrids::brownfieldgrid_osm_satellite("Woolwich Dockyard, London")
```
![Interactive OSM Map](https://github.com/lbuk/brownfieldgrids/blob/master/img/brownfieldgrid_osm_satellite_woolwich_dockyard.png)

Grid map of OSM and [National Land Use Database (NLUD)](https://data.london.gov.uk/dataset/london-brownfield-sites-review) 2009-2010 brownfield land at Woolwich Dockyard.
```
brownfieldgrids::brownfieldgrid_osm_nlud("Woolwich Dockyard, London")
```
![NLUD and OSM Map](https://github.com/lbuk/brownfieldgrids/blob/master/img/brownfieldgrid_osm_nlud_woolwich_dockyard.png)

Maps of NLUD 2009-2010 and [Brownfield Register](https://data.london.gov.uk/dataset/brownfield-land-register) 2018 data at Silvertown for comparison.
```
brownfieldgrids::brownfieldgrid_register_nlud("Silvertown, London")
```
![Brownfield Register and NLUD Map](https://github.com/lbuk/brownfieldgrids/blob/master/img/brownfieldgrid_reg_nlud_silvertown.png)

Brownfieldgrids also contains functions for creating interactive maps of the Brownfield Register and NLUD. To create an interactive map of the NLUD 2009-2010 at Woolwich Dockyard, use:
```
brownfieldgrids::brownfieldgrid_nlud_satellite("Woolwich Dockyard, London")
```
![Interactive NLUD Map](https://github.com/lbuk/brownfieldgrids/blob/master/img/brownfieldgrid_nlud_satellite_woolwich_dockyard.png)

To create an interactive map of the Brownfield Register 2018 at Woolwich Dockyard:
```
brownfieldgrids::brownfieldgrid_register_satellite("Woolwich Dockyard, London")
```
![Interactive Brownfield Register Map](https://github.com/lbuk/brownfieldgrids/blob/master/img/brownfieldgrid_register_satellite_woolwich_dockyard.png)

Users can download the London Brownfield Register dataset (exc. London Borough of Havering). To find out more about the data, read the [Brownfield Land Registers Data Standard](https://assets.publishing.service.gov.uk/government/uploads/system/uploads/attachment_data/file/653657/BrownfieldLandRegisters_-_DataStandard.pdf). 
```
data("london_brownfield_register")
```

## Applications
The brownfieldgrids package can be used to create exploratory maps of brownfield land in London using a variety of land use datasets including: OSM, the 2018 Brownfield Register and the 2009-2010 National Land Use Database (NLUD). As London's population increases, it's important that the city makes the most of space by building on brownfields. The grid maps can be exported from R and critically used as part of reports, articles or masterplans.

## Data
OpenStreetMap (OSM) is a platform for crowdsourced mapping and citizen-led geospatial data. This package makes use of OpenStreetMap brownfields, which it describes as: “land scheduled for new development which was previously used for industrial purposes or some commercial uses”. The package also makes use of open data from the 2018 Brownfield Register and the 2009-2010 NLUD. A 2018 Brownfield Register dataset has now been created that contains the locations of brownfield land at 32 of London's 33 local authorities and several development corporations. Users can now download this data.

## Limitations
Land use data – including OpenStreetMap, the NLUD and the Brownfield Register – can vary in quality and coverage. As of June 2018 not all of London's local authorities have uploaded their Brownfield Register data to the London Datastore and the London Boroughs of Havering has not published its data online. brownfieldgrids will update the Brownfield Register data from the London Datastore regularly. 

## Next Steps
An exploratory tool that utilises OpenStreetMap data in conjunction with data from Brownfield Register and the NLUD could be useful to planners, local authorities and developers. The package will be disseminated to organisations and citizens in London. 

## License
Copyright 2018 Liam Bolton

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

[http://www.apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0)
