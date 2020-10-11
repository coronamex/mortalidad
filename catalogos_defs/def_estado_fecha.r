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

merge_year <- function(a1, a2){
  full_join(a1 %>%
              pivot_longer(cols = c(-fecha, -CVE_ENT)),
            a2 %>%
              pivot_longer(cols = c(-fecha, -CVE_ENT)),
            by = c("fecha", "CVE_ENT", "name")) %>%
    mutate(value.x = replace_na(value.x, 0),
           value.y = replace_na(value.y, 0)) %>%
    mutate(value = value.x + value.y) %>%
    select(-value.x, -value.y) %>%
    pivot_wider(names_from = "name", values_from = "value")
}

anios <- list.dirs("./", recursive = FALSE) %>%
  basename
anios

f1 <- file.path(anios[1],"defunciones_por_entidad.csv")
a1 <- read_csv(f1)
for(i in 1:(length(anios) - 1)){
  f2 <- file.path(anios[i + 1],"defunciones_por_entidad.csv")
  a2 <- read_csv(f2)

  a1 <- merge_year(a1, a2)
}

a1$def_registradas %>% sum()
a1$def_residentes %>% sum()
a1$def_ocurridas %>% sum()


a1 %>%
  filter(fecha >= "2012-01-01") %>%
  group_by(CVE_ENT) %>%
  summarise(def_registradas = sum(def_registradas),
            def_residentes = sum(def_residentes),
            def_ocurridas = sum(def_ocurridas)) %>%
  print(n = 50)

a1 <- a1 %>%
  filter(fecha >= "2012-01-01") %>%
  arrange(CVE_ENT, fecha)
write_tsv(a1, "defunciones_por_entidad.tsv")
