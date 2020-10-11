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


Dat <- read_csv("conjunto_de_datos/defunciones_generales_2016.csv",
                # n_max = 1e5,
                col_types = cols(.default = col_character())) %>%
  select(ent_regis, ent_resid,  ent_ocurr,
         dia_ocurr, mes_ocurr, anio_ocur) %>%
  mutate(dia_ocurr = parse_character(dia_ocurr, na = c("", "NA", "99")),
         mes_ocurr = parse_character(mes_ocurr, na = c("", "NA", "99")),
         anio_ocur = parse_character(anio_ocur, na = c("", "NA", "9999")))

Dat
Dat %>%
  filter(is.na(dia_ocurr) | is.na(mes_ocurr) | is.na(anio_ocur))

Dat <- Dat %>%
  filter(!is.na(dia_ocurr)) %>%
  filter(!is.na(mes_ocurr)) %>%
  filter(!is.na(anio_ocur)) %>%
  mutate(fecha = parse_date(paste(anio_ocur, mes_ocurr, dia_ocurr, sep = "-"),
                            format = "%Y-%m-%d"))
# select(-dia_ocurr, -mes_ocurr, -anio_ocur)
Dat

Dat %>%
  arrange(fecha)

Dat %>%
  filter(is.na(fecha))

Dat <- Dat %>%
  filter(!is.na(fecha))
Dat

Dat <- (Dat %>%
          group_by(fecha, CVE_ENT = ent_regis) %>%
          summarise(def_registradas = length(fecha),
                    .groups = "drop")) %>%
  full_join(Dat %>%
              group_by(fecha, CVE_ENT = ent_resid) %>%
              summarise(def_residentes = length(fecha),
                        .groups = "drop"),
            by = c("fecha", "CVE_ENT")) %>%
  full_join(Dat %>%
              group_by(fecha, CVE_ENT = ent_ocurr) %>%
              summarise(def_ocurridas = length(fecha),
                        .groups = "drop"),
            by = c("fecha", "CVE_ENT"))
Dat

write_csv(Dat, "defunciones_por_entidad.csv")
