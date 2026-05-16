# Pacotes ----

library(geobr)

library(tidyverse)

library(sf)

library(leaflet)

library(leaflet.extras)

library(leafem)

# Parque Estadual dois Irmãos ----

## Baixar ----

pedi <- geobr::read_conservation_units() |>
  sf::st_make_valid() |>
  dplyr::filter(name_conservation_unit |> stringr::str_detect("DOIS IRMÃOS") &
                  category == "Parque")
