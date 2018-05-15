# brownfieldgrids

## Overview
An R package for creating grid maps of OpenStreetMap (OSM) brownfield land in London. The package provides functions for mapping OSM brownfield sites grid-by-grid and borough-by-borough in the city. Note: you'll require the latest version of RStudio or R to download the package.

## Installation
```
install.packages("devtools")
library(devtools)

devtools::install_github("lbuk/brownfieldgrids")
library(brownfieldgrids)
```

## Usage
Check out the package functions.
```
??brownfieldgrids
```

Create a Mile x Mile OSM grid of brownfield land in Limehouse and the borough outline (i.e. Tower Hamlets). It also prints the borough in the command line. It may take some time to create the maps.
```
brownfieldgrids::brownfieldgrid_osm_borough("Limehouse")
```

Map the OSM grid with a satellite basemap.
```
brownfieldgrids::brownfieldgrid_osm_satellite("Limehouse")
```

Grid map of OSM and surrounding National Land Use Database (NLUD) brownfields.
```
brownfieldgrids::brownfieldgrid_osm_nlud("Limehouse")
```

Comparative map of [Brownfield Register 2018](https://data.london.gov.uk/dataset/brownfield-land-register) and NLUD 2009-2010 brownfields.
```
brownfieldgrids::brownfieldgrid_register_nlud("Limehouse")
```

## Applications
The functions can be used to create exploratory maps of brownfields in London using OpenStreetMap, the Brownfield Register and the NLUD. The grid maps of OpenStreetMap brownfield land can potentially be used to critically analyse and identify spaces for brownfield redevelopment anywhere in Greater London. The grid maps can, for example, be exported and critically used as part of reports, academic articles or masterplans.

## Limitations
Land use data – including data from OpenStreetMap, the National Land Use Database and the Brownfield Register – can vary in quality and coverage. Note: as of May 2018 not all London boroughs have provided Brownfield Register data to the London Datastore.

## Next Steps
I will be disseminating the project to local authorities and relevant organisations in the city. Local authorities are in the process of compiling a Brownfield Register to be published from 2018 onwards. The brownfieldgrids package provides a function to compare the latest Brownfield Register data (updated weekly) with the National Land Use Database (NLUD).

## License
Copyright 2018 Liam Bolton

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

[http://www.apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0)
