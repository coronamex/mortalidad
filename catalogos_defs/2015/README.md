# Defunciones generales 2015

El directorio
[defunciones_base_de_datos_2015_csv](defunciones_base_de_datos_2015_csv)
contiene los datos oficiales de defunciones descargados en:
https://datos.gob.mx/busca/dataset/defunciones-generales-2015

El archivo [def_entidad.r](def_entidad.r) contiene el código para leer la
base de datos oficial y producir el archivo
[defunciones_por_entidad.csv](defunciones_por_entidad.csv). Se descartan
defunciones que no tiene fecha de ocurrencia.

Los datos oficiales han sido comprimidos con `gzip` y probablemente
necesitan ser descomprimidos para usarlos.
