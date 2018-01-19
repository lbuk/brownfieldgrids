# brownfieldgrids

## Overview
An R package for creating Mile x Mile grid maps of OpenStreetMap (OSM) brownfield land in London. The package provides functions for mapping OSM brownfield sites in London grid-by-grid and borough-by-borough. It also provides a function to compare OSM brownfied land with National Land Use Database (NLUD) 2009-2010 brownfield s.

## Installation
```
install.packages("devtools")
library(devtools)

devtools::install_github("username/packagename")
library(brownfieldgrids)
```

## Usage
Create a map of OSM grids in Limehouse and the borough outline (i.e. Tower Hamlets).
```
brownfieldgrid_osm_borough("Limehouse, London")
```
Map the OSM grid and the satellite basemap. 
```
brownfieldgrid_osm_satellite("Limehouse, London")
```
Grid map of OSM and surrounding NLUD brownfields.
```
brownfieldgrid_osm_nlud("Limehouse, London")
```
Map of OSM brownfield land at borough-level.
```
brownfield_osm_borough_nogrid("Tower Hamlets")
```
## Next Steps
I will be disseminating the project to local authorities and relevant organisations in the city. Local authorities are in the process of compiling a Brownfield Register to be published in 2018. I'd like to incorporate the data as part of the package as soon as it has been completed. I'd like to further explore how machine learning and remote sensing can be used to analyse land use, particularly brownfields, in cities.

## License
Copyright 2018 L. Bolton

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

[http://www.apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0)
