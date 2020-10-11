# (C) Copyright 2020 Sur Herrera Paredes

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

library(tidyverse)


Dat <- read_csv("respuesta/2019_2020_soliciud_0000400220520.csv.gz",
                col_types = cols(ID_ENTIDAD = col_character(),
                                 ID_MUNICIPIO = col_character(),
                                 ID_PFICIALIA = col_character(),
                                 `AÑO` = col_number(),
                                 # DEF_FECHA_DEFUNCION = col_date(format = "%d/%m/%Y"),
                                 DEF_FECHA_DEFUNCION = col_character(),
                                 DEF_FECHA_DEREGISTRO = col_date(format = "%d/%m/%Y"),
                                 DEF_SEXO = col_character()))
Dat

# Procesar año de defunción
Dat <- Dat %>%
  separate(DEF_FECHA_DEFUNCION, sep = "/", into = c("dia", "mes", "anio"))

sum(Dat$anio %in% c("2019", "2020"))
sum(Dat$anio %in% c("2019", "2020")) / nrow(Dat)
nrow(Dat) - sum(Dat$anio %in% c("2019", "2020"))

# Elegir las de 2020 y calcular defuncione registradas por día
# por entidad
Dat <- Dat %>%
  select(ID_ENTIDAD, dia, mes, anio) %>%
  filter(anio == "2020") %>%
  mutate(fecha = parse_date(x = paste(anio, mes, dia, sep = "-"),
                            format = "%Y-%m-%d")) %>%
  group_by(fecha, CVE_ENT = ID_ENTIDAD) %>%
  summarise(def_registradas = length(fecha),
            .groups = 'drop')
Dat
write_csv(Dat, "defunciones_por_entidad.csv")

 
