library(tidyverse)


Dat <- read_tsv('estados.tsv')
lut_estados <- read_csv("../../datos/util/estados_lut_datos_abiertos.csv",
                        col_names = F)
lut_estados <- lut_estados %>%
  mutate(X2 = replace(X2, X2 == "México", "Estado de México"))
lut_estados <- set_names(lut_estados$X1, lut_estados$X2)

lut_meses <- set_names(c("01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12"),
                       c("Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto",
                         "Septiembre", "Octubre", "Noviembre", "Diciembre"))

Dat <- Dat %>%
  select(mes, entidad, `2020`) %>%
  rename(muertes = `2020`) %>%
  mutate(CVE_ENT = as.character(lut_estados[entidad])) %>%
  mutate(M = as.character(lut_meses[mes])) %>%
  mutate(anio = 2020) %>%
  select(CVE_ENT, anio, M, muertes) %>%
  rename(mes = M)
write_tsv(Dat, "entidades_proyecto.li.tsv")



