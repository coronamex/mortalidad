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

Dat <- read_csv("2021-02-14//base_de_datos.csv.gz",
                # n_max = 1e5,
                col_types = cols(.default = col_character(),
                                 FECHA_ACTUALIZACION = col_date("%Y-%m-%d"),
                                 FECHA_DEFUNCION = col_date("%Y-%m-%d"),
                                 FECHA_REGISTRO = col_date("%Y-%m-%d"))) %>%
  mutate(EDAD = parse_number(EDAD, na = c("NA", "", "ND", "999")))
Dat
  
Dat <- Dat %>%
  group_by(fecha = FECHA_DEFUNCION, CVE_ENT = ENTIDAD_REG) %>%
  summarise(def_registradas = length(fecha),
            .groups = "drop") 
Dat
write_csv(Dat, "defunciones_por_entidad.csv")
