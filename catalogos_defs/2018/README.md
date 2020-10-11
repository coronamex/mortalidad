# Defunciones generales 2018

El directorio
[defunciones_base_de_datos_2018_csv](defunciones_base_de_datos_2018_csv)
contiene los datos oficiales de defunciones. Los datos para 2018 no están
disponibles en el portal de datos abiertos del gobierno de México así que
se obtuvieron del portal de la Dirección General de Información en Salud
de la Secretaría de Salud en:
http://www.dgis.salud.gob.mx/contenidos/basesdedatos/da_defunciones_gobmx.html

El archivo [def_entidad.r](def_entidad.r) contiene el código para leer la
base de datos oficial y producir el archivo
[defunciones_por_entidad.csv](defunciones_por_entidad.csv). Se descartan
defunciones que no tiene fecha de ocurrencia.

Los datos oficiales han sido comprimidos con `gzip` y probablemente
necesitan ser descomprimidos para usarlos.
