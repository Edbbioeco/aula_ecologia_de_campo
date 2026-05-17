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

## Pernambuco ----

### Filtrar ----

pe <- br |>
  dplyr::filter(nam_stt == "Pernambuco")

### Visualizar ----

pe

ggplot() +
  geom_sf(data = br, color = "black") +
  geom_sf(data = pe, color = "black", fill = "goldenrod")

## Shapefile de Recife ----

### Importar ----

recife <- sf::st_read("shapefiles/recife/recife.shp")

### Visualizar ----

recife

ggplot() +
  geom_sf(data = pe, color = "black", fill = "goldenrod") +
  geom_sf(data = recife, color = "black", fill = "brown")
