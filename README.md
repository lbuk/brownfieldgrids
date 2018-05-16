# brownfieldgrids

## Overview
An R package for creating grid maps of brownfield land in London.

## Installation
```
# Install devtools
install.packages("devtools")
library(devtools)

# Install the dev version of osmdata
install_github("ropensci/osmdata")
library(osmdata)

# Install brownfieldgrids
devtools::install_github("lbuk/brownfieldgrids")
library(brownfieldgrids)
```
If you have any problems with the package (e.g. installation) then email me at liam.bolton.17@ucl.ac.uk

## Usage
Check out the package functions.
```
??brownfieldgrids
```

Create a Mile x Mile OSM grid of brownfield land in Ladbroke Grove and the borough outline. It also prints the borough in the console.
```
brownfieldgrids::brownfieldgrid_osm_borough("Ladbroke Grove, London")
```

Interactive Mile x Mile grid map the OSM brownfields in Ladbroke Grove.
```
brownfieldgrids::brownfieldgrid_osm_satellite("Ladbroke Grove, London")
```

Grid map of OSM and [National Land Use Database (NLUD)](https://data.london.gov.uk/dataset/london-brownfield-sites-review) 2009-2010 brownfield land.
```
brownfieldgrids::brownfieldgrid_osm_nlud("Ladbroke Grove, London")
```

Map of NLUD 2009-2010 and [Brownfield Register](https://data.london.gov.uk/dataset/brownfield-land-register) 2018 brownfield land in Silvertown for comparison.
```
brownfieldgrids::brownfieldgrid_register_nlud("Silvertown, London")
```

## Applications
The brownfieldgrids package can be used to create exploratory maps of brownfield land in London using a variety of land use datasets including: OSM, the NLUD and the latest Brownfield Register. The grid maps can be exported from R and critically used as part of reports, articles or masterplans.

## Limitations
Land use data – including OpenStreetMap, the National Land Use Database (NLUD) and the Brownfield Register – can vary in quality and coverage. As of May 2018 not all London boroughs have uploaded their Brownfield Register data to the London Datastore, which means the NLUD data will be temporarily used. brownfieldgrids will update the Brownfield Register data from the London Datastore weekly.

## Next Steps
OpenStreetMap data can be useful to local authorities and planners. The package will be disseminated to various organisations in London.

## License
Copyright 2018 Liam Bolton

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

[http://www.apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0)
