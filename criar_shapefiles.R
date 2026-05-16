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

sf_ref <- tibble::tibble(lon = "34°57'29\'W" |> parzer::parse_lon(),
                         lat = "08°03'10.79\"S" |> parzer::parse_lat()) |>
  sf::st_as_sf(coords = c("lon", "lat"),
               crs = 4674) |>
  sf::st_buffer(dist = 10)

sf_ref

ggplot() +
  geom_sf(data = sf_ref, color = "black")

## Criar mapa para ser visualizado ----

mapa <- leaflet::leaflet() |>
  leaflet::addProviderTiles(provider = providers$Esri.WorldImagery) |>
  leaflet.extras::addDrawToolbar(targetGroup = "draw",
                                 editOptions = leaflet.extras::editToolbarOptions()) |>
  leafem::addMouseCoordinates() |>
  leaflet::addPolygons(data = sf_ref |> sf::st_cast("POLYGON"))

## Editar mapa ----

ufpe <- mapa |> mapedit::editMap()

ufpe <- ufpe$drawn

## Visualizar Shapefile ----

ufpe

ggplot() +
  geom_sf(data = ufpe, color = "black")
