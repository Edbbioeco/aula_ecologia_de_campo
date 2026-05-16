# Pacotes ----

library(geobr)

library(sf)

library(tidyverse)

library(parzer)

library(leaflet)

library(leaflet.extras)

library(leafem)

# Parque Estadual dois Irmãos ----

## Baixar ----

pedi <- geobr::read_conservation_units() |>
  sf::st_make_valid() |>
  dplyr::filter(name_conservation_unit |> stringr::str_detect("DOIS IRMÃOS") &
                  category == "Parque")

## Visualizar ----

pedi

ggplot() +
  geom_sf(data = pedi, color = "black")

## Exportar ----

pedi |>
  sf::st_write("pedi.shp")

# UFPE ----

## Shapefile de coordenada de referência ----

sf_ref <- tibble::tibble(lon = "34°56'46\'W" |> parzer::parse_lon(),
                         lat = "08°20'20\"S" |> parzer::parse_lat()) |>
  sf::st_as_sf(coords = c("lon", "lat"),
               crs = 4674)

sf_ref

ggplot() +
  geom_sf(data = sf_ref, color = "black")
