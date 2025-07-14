# TAREA 5-6

## Generación de datos ficticios con Mockaroo

Se utilizó Mockaroo para generar datos ficticios para un esquema de base de datos con información de países (población, economía, agricultura y medio ambiente). La herramienta demostró ser eficaz para generar datasets realistas con algunas limitaciones específicas.

![alt text](<poblacion dataset.png>)

## Hallazgos 

- Mockaroo permite generar hasta 1000 filas por dataset
- Ofrece gran flexibilidad en la generación de distintos tipos de datos, como números, texto, fechas, secuencias,etc
- Tiene IA que te ayuda a analizar el contexto de la base de datos y sugerir campos automáticamente
- Se puede guardar y referenciar datasets creados para usar como llaves foráneas
- Con una configuración adecuada, se logró mantener la consistencia entre las tablas relacionadas.

## Dificultades

- Mockaroo no garantiza automáticamente la unicidad de las llaves primarias
- Se repetían valores en campos que deberían ser únicos (id_pais y nombre_pais)
- Se probabron varios metodos para crear las llaves primarias como sequence, concat, customlists pero al final no se ajustaban a lo que se necesitaba
- Necesité configuración explícita para evitar duplicados en llaves primarias

## Recomendaciones

- Comenzar generando la tabla principal que contenga las llaves foráneas, asegurando que sus valores sean únicos y validados
- Es importante verificar unicidad antes de usar como referencia
- Diseñar el orden de creación de tablas considerando dependencias
- Guardar los datasets base como referencia para mantener la coherencia de los datos en las tablas relacionadas
- Al generar tablas dependientes, utilizar el dataset original como fuente para las llaves foráneas, asegurando la integridad referencial


## Funciones de Agregación SQL

## Consultas

### a)Conteo de frecuencias y media
```sql
--Conteo de registros por país en la tabla poblacion
SELECT id_pais, COUNT(*) as total
FROM poblacion
GROUP BY id_pais

--Media del ingreso promedio por continente, se hace un JOIN con tabla paises
SELECT p.continente, AVG(e.ingreso_promedio) AS ingreso_promedio_medio
FROM economia e
join paises p on e.id_pais = p.id_pais
GROUP BY p.continente
```

### b)Mínimos y máximos
```sql
--PIB mínimo y máximo por año
SELECT anio, MIN(pib) AS pib_min, MAX(pib) as pib_max
FROM economia
GROUP BY anio
```

### c)Cuantil que no sea la mediana
```sql
--Primer cuartil o percenti 25%
SELECT
  anio,
  PERCENTILE_CONT(0.25) within GROUP (ORDER BY ingreso_promedio) as percentil_25
FROM economia
GROUP BY anio
```

### d)Moda
```sql
--Moda del valor de crecimiento económico
SELECT crecimiento_economico, COUNT(*) AS frecuencia
FROM economia
GROUP BY crecimiento_economico
ORDER BY frecuencia DESC
limit 1
```

---

## Hallazgos y dificultades

- **Hallazgos**:
  - El uso de funciones de agregación permite obtener información resumida útil para analisis estadístico
  - La moda puede no existir si los valores son todos únicos o continuos


- **Dificultades**:
  - Calcular percentiles en SQLite o MySQL puede requerir funciones no disponibles por defecto, pero postgresql ya la tiene localmente
  - La moda no es una función construida en muchos motores SQL, por lo que debe calcularse con un GROUP BY y ORDER BY COUNT(*)

- **Soluciones**:
  - Para percentiles, se puede usar PERCENTILE_CONT en PostgreSQL, se especifica el percentil o cuartil en el parametro
  - Se usó JOIN con la tabla paises para agrupar por continente

---