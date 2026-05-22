# Pacotes ----

library(sf)

library(tidyverse)

library(terra)

library(tidyterra)

library(ggmagnify)

library(ggview)

library(ggspatial)

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

## Imagem de satélite da UFPE ----

### Importar ----

ufpe_sat <- terra::rast("imagens de satélite/ufpe/ufpe_imagem_sat.tif")

### Visualizar ----

ufpe_sat

ggplot() +
  tidyterra::geom_spatraster_rgb(data = ufpe_sat) +
  geom_sf(data = ufpe, color = "gold", fill = "transparent")

# Mapa ----

## Mapa do Brasil ----

mapa_br <- ggplot(data = br) +
  geom_sf(aes(color = "Brasil",
              fill = "Brasil"),
          linewidth = 1) +
  geom_sf(data = pe,
          aes(color = "Pernambuco",
              fill = "Pernambuco"),
          linewidth = 1) +
  geom_sf(data = recife,
          aes(color = "Recife",
              fill = "Recife"),
          linewidth = 1) +
  geom_sf(data = pedi,
          aes(color = "PEDI",
              fill = "PEDI"),
          linewidth = 1) +
  geom_sf(data = ufpe,
          aes(color = "UFPE",
              fill = "UFPE"),
          linewidth = 1) +
  scale_color_manual(values = c("Brasil" = "black",
                                "Pernambuco" = "black",
                                "Recife" = "black",
                                "PEDI" = "gold",
                                "UFPE" = "red"),
                     breaks = c("Brasil",
                                "Pernambuco",
                                "Recife",
                                "PEDI",
                                "UFPE")) +
  scale_fill_manual(values = c("Brasil" = "gray",
                               "Pernambuco" = "goldenrod",
                               "Recife" = "brown",
                               "PEDI" = "transparent",
                               "UFPE" = "transparent"),
                    breaks = c("Brasil",
                               "Pernambuco",
                               "Recife",
                               "PEDI",
                               "UFPE")) +
  ggmagnify::geom_magnify(from = c(-35.0167,
                                   -34.86058,
                                   -8.155123,
                                   -7.929206),
                          to = c(-40,
                                 -40 + 0.15612 * 55,
                                 -30,
                                 -30 + 0.225917 * 55),
                          colour = "darkred",
                          shape = "rect",
                          recompute = TRUE,
                          shadow = TRUE,
                          linewidth = 2,
                          expand = FALSE) +
  labs(color = NULL,
       fill = NULL) +
  coord_sf(label_graticule = "NSW") +
  theme_bw() +
  theme(axis.text = element_text(color = "black", size = 20),
        legend.text = element_text(color = "black", size = 20),
        legend.title = element_text(color = "black", size = 20),
        legend.position = "bottom") +
  ggview::canvas(height = 10, width = 12)

mapa_br

## Mapa do Parque Estadual Dois Irmãos ----

mapa_pedi <- ggplot(data = br) +
  geom_sf(aes(color = "Brasil",
              fill = "Brasil"),
          linewidth = 1) +
  geom_sf(data = pe,
          aes(color = "Pernambuco",
              fill = "Pernambuco"),
          linewidth = 1) +
  geom_sf(data = recife,
          aes(color = "Recife",
              fill = "Recife"),
          linewidth = 1) +
  tidyterra::geom_spatraster_rgb(data = pedi_sat) +
  geom_sf(data = pedi,
          aes(color = "PEDI",
              fill = "PEDI"),
          linewidth = 1) +
  geom_sf(data = ufpe,
          aes(color = "UFPE",
              fill = "UFPE"),
          linewidth = 1) +
  scale_color_manual(values = c("Brasil" = "black",
                                "Pernambuco" = "black",
                                "Recife" = "black",
                                "PEDI" = "gold",
                                "UFPE" = "red"),
                     breaks = c("Brasil",
                                "Pernambuco",
                                "Recife",
                                "PEDI",
                                "UFPE")) +
  scale_fill_manual(values = c("Brasil" = "gray",
                               "Pernambuco" = "goldenrod",
                               "Recife" = "brown",
                               "PEDI" = "transparent",
                               "UFPE" = "transparent"),
                    breaks = c("Brasil",
                               "Pernambuco",
                               "Recife",
                               "PEDI",
                               "UFPE")) +
  labs(color = NULL,
       fill = NULL) +
  coord_sf(label_graticule = "NE",
           xlim = c(-34.98047, -34.93653),
           ylim = c(-8.015711, -7.961312),
           expand = FALSE) +
  scale_x_continuous(breaks = seq(-34.97, -34.94, 0.01)) +
  ggspatial::annotation_scale(text_cex = 2.5,
                              location = "bl",
                              bar_cols = c("black", "gold"),
                              line_width = 2,
                              text_col = "gold",
                              height = unit(0.5, "cm"),
                              width_hint = 0.1) +
  theme_bw() +
  theme(axis.text = element_text(color = "black", size = 20),
        legend.text = element_text(color = "black", size = 20),
        legend.title = element_text(color = "black", size = 20),
        legend.position = "bottom") +
  ggview::canvas(height = 10, width = 12)

mapa_pedi

## Mapa do Parque Estadual Dois Irmãos ----

mapa_ufpe <- ggplot(data = br) +
  geom_sf(aes(color = "Brasil",
              fill = "Brasil"),
          linewidth = 1) +
  geom_sf(data = pe,
          aes(color = "Pernambuco",
              fill = "Pernambuco"),
          linewidth = 1) +
  geom_sf(data = recife,
          aes(color = "Recife",
              fill = "Recife"),
          linewidth = 1) +
  geom_sf(data = pedi,
          aes(color = "PEDI",
              fill = "PEDI"),
          linewidth = 1) +
  tidyterra::geom_spatraster_rgb(data = ufpe_sat) +
  geom_sf(data = ufpe,
          aes(color = "UFPE",
              fill = "UFPE"),
          linewidth = 1) +
  scale_color_manual(values = c("Brasil" = "black",
                                "Pernambuco" = "black",
                                "Recife" = "black",
                                "PEDI" = "gold",
                                "UFPE" = "red"),
                     breaks = c("Brasil",
                                "Pernambuco",
                                "Recife",
                                "PEDI",
                                "UFPE")) +
  scale_fill_manual(values = c("Brasil" = "gray",
                               "Pernambuco" = "goldenrod",
                               "Recife" = "brown",
                               "PEDI" = "transparent",
                               "UFPE" = "transparent"),
                    breaks = c("Brasil",
                               "Pernambuco",
                               "Recife",
                               "PEDI",
                               "UFPE")) +
  labs(color = NULL,
       fill = NULL) +
  coord_sf(label_graticule = "SE",
           xlim = c(-34.9585, -34.94477),
           ylim = c(-8.061952, -8.045634),
           expand = FALSE) +
  scale_x_continuous(breaks = seq(-34.956, -34.946, 0.004)) +
  ggspatial::annotation_scale(text_cex = 2.5,
                              location = "bl",
                              bar_cols = c("black", "gold"),
                              line_width = 2,
                              text_col = "gold",
                              height = unit(0.5, "cm"),
                              width_hint = 0.1) +
  theme_bw() +
  theme(axis.text = element_text(color = "black", size = 20),
        legend.text = element_text(color = "black", size = 20),
        legend.title = element_text(color = "black", size = 20),
        legend.position = "bottom") +
  ggview::canvas(height = 10, width = 12)

mapa_ufpe

## Unir mapas ----

mapa_unido <- (mapa_br + (mapa_pedi / mapa_ufpe)) +
  patchwork::plot_layout(guides = "collect",
                         widths = c(4, 2)) &
  theme(legend.position = "bottom")

mapa_unido +
  ggview::canvas(height = 12, width = 14)

ggsave(filename = "mapa_localizacao.png",
       height = 12, width = 14)
