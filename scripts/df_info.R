library(tidyverse)
library(gt)

df <- read_csv("output/df_raw.csv")

info_df <- tibble(
  variable = names(df),
  tipo = sapply(df, function(x) class(x)[1]),
  valores = colSums(!is.na(df)),
  nulos = colSums(is.na(df)),
  unidad = c("-", "°C", "°C", "°C", "°C", "°C", "°C", "°C", "°C", "°C", 
             "%", "mm", "mm", "mm", "h", "%", "hPa", "%", "%", "°C", 
             "h", "km/h", "-", "km/h", "-", "km/h", "Pa", "MJ/m2", "h", "-",
             "-")) |>
  mutate(tipo = case_match(tipo,
                           "numeric"   ~ "Numérico",
                           "character" ~ "Texto",
                           "POSIXct"   ~ "Fecha/Hora"))

info_gt <- info_df |>
  select(variable, unidad, tipo, valores, nulos) |>
  gt() |>
  cols_label(variable = "Variables",
             tipo = "Tipo",
             unidad = "Expresada en (unidades)",
             valores = "Valores no nulos",
             nulos = "Valores faltantes") |>
  
  tab_options(
    table.font.size = px(14),
    table.font.names = "Serif",
    column_labels.font.weight = "bold",
    table.border.top.color = "black",
    table.border.top.width = px(2),
    table.border.bottom.color = "black",
    table.border.bottom.width = px(2),
    column_labels.border.bottom.color = "black",
    column_labels.border.bottom.width = px(1),
    data_row.padding = px(5),           
    table.width = px(600)) |>
    
    cols_align(align = "left", columns = 1) |>
    cols_align(align = "center", columns = -1)

gtsave(info_gt, filename = "output/info.png",
       vwidth = 1500,
       vheight = 1000,
       zoom = 3)


  