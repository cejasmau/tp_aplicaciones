library(tidyverse)
library(gt)
library(chromote)

resumen_final <- read_csv("output/resumen_estadistico.csv")

tabla_gt <- resumen_final |>
  gt() |>
  cols_label(X = "Variables") |>
  fmt_number(decimals = 2) |>
  
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

gtsave(tabla_gt, filename = "output/resumen_estad.png",
       vwidth = 1500,
       vheight = 1000,
       zoom = 3)
