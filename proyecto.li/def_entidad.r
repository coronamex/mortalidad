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


Dat <- read_tsv("anexo_0000400190120.tsv",
                col_types = cols(X1 = col_character(),
                                 X2 = col_number(),
                                 .default = col_number()))
Dat <- Dat %>%
  separate(X1, into = c("CVE_ENT", "estado"), sep = "   ") %>%
  rename(anio = X2)
colnames(Dat)[-(1:3)] <- str_split(colnames(Dat)[-(1:3)], pattern = "-") %>%
  map_chr(~ .x[1])
Dat <- Dat %>%
  pivot_longer(cols = c(-CVE_ENT, -estado, -anio),
               names_to = "mes",
               values_to = "muertes") %>%
  # mutate(muertes = replace_na(muertes, NA)) %>%
  # filter(is.na(muertes)) %>%
  filter(anio == 2020) %>%
  filter(mes %in% c("01", "02", "03", "04", "05", "06", "07")) %>%
  # filter(is.na(muertes))
  select(CVE_ENT, anio, mes, muertes)
Dat

write_tsv(Dat, "def_entidades.tsv")
