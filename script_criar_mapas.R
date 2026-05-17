# Pacotes ----

library(sf)

library(tidyverse)

library(terra)

library(tidyterra)

library(ggmagnify)

library(ggspatial)

library(ggview)

library(patchwork)

# Dados ----

## Brasil ----

### Importar ----

br <- sf::st_read("shapefiles/brasil/br.shp")

### Visualizar ----

br

ggplot() +
  geom_sf(data = br)
