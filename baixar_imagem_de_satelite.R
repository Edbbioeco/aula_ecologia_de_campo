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

## Shapefile da UFPE ----

### Importar ----

ufpe <- sf::st_read("ufpe.shp")

### Visualizar ----

ufpe

ggplot() +
  geom_sf(data = pedi, color = "black") +
  geom_sf(data = ufpe, color = "black")

# Imagem de satélite ----

## PEDI ----

### Baixar ----

pedi_sat <- pedi |>
  maptiles::get_tiles(provider = "Esri.WorldImagery",
                      zoom = 15)

### Visualizar ----

ggplot() +
  tidyterra::geom_spatraster_rgb(data = pedi_sat) +
  geom_sf(data = pedi, color = "gold", fill = "transparent")

### Exportar ----

pedi_sat |> terra::writeRaster("pedi_imagem_sat.tif")
