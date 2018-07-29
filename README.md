# brownfieldgrids

## Overview
An R package for creating grid maps of brownfield land in London.

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
Create a mile x mile OpenStreetMap (OSM) grid map of brownfield land in Woolwich Dockyard and the borough outline. The function also prints the local authority in the R console. The maps can be exported from RStudio using Plots > Export > Save as Image.
```
brownfieldgrids::brownfieldgrid_osm_borough("Woolwich Dockyard, London")
```
![OSM Borough Map](https://github.com/lbuk/brownfieldgrids/blob/master/img/brownfieldgrid_osm_borough_woolwich_dockyard.png)

Semi-interactive mile x mile grid map the OSM brownfields at Woolwich Dockyard. It can be viewed in RStudio or in your browser. The image below was exported from RStudio. 
```
brownfieldgrids::brownfieldgrid_osm_satellite("Woolwich Dockyard, London")
```
![Interactive OSM Map](https://github.com/lbuk/brownfieldgrids/blob/master/img/brownfieldgrid_osm_satellite_b_woolwich_dockyard.jpeg)

Grid map of OSM and [National Land Use Database (NLUD)](https://data.london.gov.uk/dataset/london-brownfield-sites-review) 2009-2010 brownfield land at Woolwich Dockyard.
```
brownfieldgrids::brownfieldgrid_osm_nlud("Woolwich Dockyard, London")
```
![NLUD and OSM Map](https://github.com/lbuk/brownfieldgrids/blob/master/img/brownfieldgrids_osm_nlud_woolwich_dockyard.png)

Map of NLUD 2009-2010 and [Brownfield Register](https://data.london.gov.uk/dataset/brownfield-land-register) 2018 data.
```
brownfieldgrids::brownfieldgrid_register_nlud("Silvertown, London")
```
![Brownfield Register and NLUD Map](https://github.com/lbuk/brownfieldgrids/blob/master/img/brownfieldgrid_register_nlud_woolwich_dockyard.png)

Brownfieldgrids also contains functions to produce mini interactive maps of the Brownfield Register and the NLUD in London. 
```
brownfieldgrids::brownfieldgrid_nlud_satellite("Woolwich Dockyard, London") # NLUD
brownfieldgrids::brownfieldgrid_register_satellite("Woolwich Dockyard, London") # Brownfield Register
```

Users can download the London Brownfield Register dataset (exc. London Borough of Havering). To find out more about the data, read the [Brownfield Land Registers Data Standard](https://assets.publishing.service.gov.uk/government/uploads/system/uploads/attachment_data/file/653657/BrownfieldLandRegisters_-_DataStandard.pdf). 
```
data("london_brownfield_register")
```

## Applications
The brownfieldgrids package can be used to create exploratory maps of brownfield land in London using a variety of land use datasets including: OSM, the 2018 Brownfield Register and the 2009-2010 National Land Use Database (NLUD). As London's population increases, it's important that the city makes the most of space by building on brownfields. The grid maps can be exported from R and critically used as part of reports, articles or masterplans. 

## Data
This package makes use of OpenStreetMap brownfields, which it describes as: “land scheduled for new development which was previously used for industrial purposes or some commercial uses”. OpenStreetMap is a platform for crowdsourced mapping and citizen-led geospatial data. The package also makes use of open data from the 2018 Brownfield Register and the NLUD 2009-2010. A Brownfield Register 2018 dataset has now been created that contains the locations of brownfield land at 32 of London's 33 local authorities and several development corporations. Users can now download this data.

## Limitations
Land use data – including OpenStreetMap, the NLUD and the Brownfield Register – can vary in quality and coverage. As of June 2018 not all of London's local authorities have uploaded their Brownfield Register data to the London Datastore and the London Boroughs of Havering has not published its data online. brownfieldgrids will update the Brownfield Register data from the London Datastore regularly. 

## Next Steps
An exploratory tool that utilises OpenStreetMap data in conjunction with data from Brownfield Register and the NLUD could be useful to planners, local authorities and developers. It was created as part of a Master's dissertation at the Centre for Advanced Spatial Analysis (CASA), UCL. The package and research will be disseminated in London. 

## License
Copyright 2018 Liam Bolton

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

[http://www.apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0)
