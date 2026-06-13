# =============================================================================
# Econometría Aplicada con R — Bloque 0
# Ejercicio: Manipulación de datos con dplyr 
# Datos: IMDB Top 250 películas
# =============================================================================

# -----------------------------------------------------------------------------
# 1. IMPORTAR DATOS
# -----------------------------------------------------------------------------
library(tidyverse)

IMDB <- read.csv("../Datos/IMDB.csv")


# -----------------------------------------------------------------------------
# 2. MANIPULAR DATOS
# -----------------------------------------------------------------------------

data_final <- IMDB |>
  filter(duration_minutes > 100) |>
  select(name, year, certificate, rating, duration_minutes) |>
  mutate(d2004 = ifelse(year > 2004, 1, 0)) |>
  rename(clasificacion = certificate) |>
  drop_na()

desc_est <- data_final |> 
  group_by(clasificacion) |>
  summarise(
    rating_promedio = mean(rating),
    rating_max      = max(rating), 
    rating_min      = min(rating), 
    n               = n()
  )
