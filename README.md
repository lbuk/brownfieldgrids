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
If you have any problems with the package (e.g. installation) then email me at liam.bolton.17@ucl.ac.uk or post on the Issues page of the repository. brownfieldgrid users may have to re-install the sp package, for example.

## Usage
Create a Mile x Mile OpenStreetMap (OSM) grid of brownfield land in Woolwich Dockyard and the borough outline. It also prints the borough in the console.
```
brownfieldgrids::brownfieldgrid_osm_borough("Woolwich Dockyard, London")
```

Interactive Mile x Mile grid map the OSM brownfields in Woolwich Dockyard.
```
brownfieldgrids::brownfieldgrid_osm_satellite("Woolwich Dockyard, London")
```

Grid map of OSM and [National Land Use Database (NLUD)](https://data.london.gov.uk/dataset/london-brownfield-sites-review) 2009-2010 brownfield land at Woolwich Dockyard.
```
brownfieldgrids::brownfieldgrid_osm_nlud("Woolwich Dockyard, London")
```

Map of NLUD 2009-2010 and 2018 [Brownfield Register](https://data.london.gov.uk/dataset/brownfield-land-register) data in Silvertown for comparison.
```
brownfieldgrids::brownfieldgrid_register_nlud("Silvertown, London")
```

## Applications
The brownfieldgrids package can be used to create exploratory maps of brownfield land in London using a variety of land use datasets including: OSM, the 2018 Brownfield Register and the 2009-2010 National Land Use Database (NLUD). As London's population increases, it's important that the city makes the most of space by building on brownfields. The grid maps can be exported from R and critically used as part of reports, articles or masterplans.

## Data
OpenStreetMap (OSM) is a platform for crowdsourced mapping and citizen-led geospatial data. This package makes use of OpenStreetMap brownfields, which it describes as: “land scheduled for new development which was previously used for industrial purposes or some commercial uses”. The package also makes use of open data from the 2018 Brownfield Register and the 2009-2010 NLUD. A 2018 Brownfield Register dataset has been created that contains the locations of brownfield land at 32 of London's 33 local authorities and several development corporations.

## Limitations
Land use data – including OpenStreetMap, the NLUD and the Brownfield Register – can vary in quality and coverage. As of June 2018 not all of London's local authorities have uploaded their Brownfield Register data to the London Datastore and the London Borough of Havering has not published its data online. brownfieldgrids will update the Brownfield Register data from the London Datastore regularly.

## Next Steps
OpenStreetMap data in conjunction with data from the NLUD and the Brownfield Register could be useful to planners, local authorities and developers. The package will be disseminated to organisations in London.

## License
Copyright 2018 Liam Bolton

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

[http://www.apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0)
