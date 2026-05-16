# Pacotes ----

library(sf)

library(tidyverse)

library(maptiles)

library(terra)

library(tidyterra)

# Shapefiles ----

## Shapefile do Parque Estadual Dois Irmãos ----

### Importar ----

pedi <- sf::st_read("pedi.shp")

### Visualizar ----

pedi

ggplot() +
  geom_sf(data = pedi, color = "black")
