# Solicitud 0000400220520

Respuesta oficial de la Secretaría de Gobernación. Contiene las defunciones
registradas por el RENAPO hasta finales de septiembre. La codificación del
archivo `2019_2020_soliciud_0000400220520.csv` fue cambiada a UTF-8 con:

```bash
iconv -f ISO-8859-1 -t UTF-8 2019_2020_soliciud_0000400220520.csv > temp.csv
mv temp.csv 2019_2020_soliciud_0000400220520.csv
```
La tabla fue comprimida con `gzip`.

El archivo [def_entidad.r](def_entidad.r) crea el archivo
[defunciones_por_entidad.csv](defunciones_por_entidad.csv). Se descartan
defunciones que ocurrieron en fechas fuera de 2020 (alrededor del 2% de los
registros). Los números muestran una tendencia descendente en fechas cada vez
más recientes sugiriendo que los registros están incompletos.
