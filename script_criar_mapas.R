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

## Shapefile do Brasil ----

### Importar ----

br <- sf::st_read("shapefiles/brasil/br.shp")

### Visualizar ----

br

ggplot() +
  geom_sf(data = br)

## Sahpefile de Pernambuco ----

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

## Shapefile do Parque Estadual Dois Irmãos ----

### Importar ----

pedi <- sf::st_read("shapefiles/pedi/pedi.shp")

### Visualizar ----

pedi

ggplot() +
  geom_sf(data = recife, color = "black") +
  geom_sf(data = pedi, color = "black", fill = "forestgreen")

## Shapefile da UFPE ----

ufpe <- sf::st_read("shapefiles/ufpe/ufpe.shp")

### Visualizar ----

ufpe

ggplot() +
  geom_sf(data = recife, color = "black") +
  geom_sf(data = pedi, color = "black", fill = "forestgreen") +
  geom_sf(data = ufpe, color = "black", fill = "gold")

## Imagem de satélite do Parque Estadual Dois Irmãos ----

### Importar ----

pedi_sat <- terra::rast("imagens de satélite/pedi/pedi_imagem_sat.tif")

### Visualizar ----

pedi_sat

ggplot() +
  tidyterra::geom_spatraster_rgb(data = pedi_sat) +
  geom_sf(data = pedi, color = "gold", fill = "transparent")
