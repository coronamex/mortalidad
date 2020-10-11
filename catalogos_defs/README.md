# Catálogos de defunciones

Aquí se encuentran el Catálogo de defunciones generales para años
previos producidos por las autoridades mexicanas.

Cada sub-directorio corresponde a un año, y contiene los datos oficiales.

El archivo [def_estado_fecha.r](def_estado_fecha.r) contiene el código
para procesar los datos oficiales y combinar todos los datos en un sólo
archivos final ([defunciones_por_entidad.tsv](defunciones_por_entidad.tsv)).
Se descartan las defunciones que ocurrieron antes del 2012-01-01 y las
que no tienen fecha.
