# TAREA 7

## 1. Revisión de Inconsistencias

### Problemas Identificados
Para detectar y facilitar el tratamiento de inconsistencias, se utilizo algunas consultas para detectar valores nulos o ausentes.

```sql
--Países tienen registros incompletos en poblacion
SELECT id_pais, anio
FROM poblacion
WHERE poblacion_pobreza IS NULL
   OR poblacion_pobreza_multidimensional IS NULL
   OR desigualdad IS NULL
 OR numero_emigrantes IS NULL
   OR numero_inmigrantes IS NULL

--Países que no estan en la tabla economia
SELECT p.id_pais, p.nombre_pais
from paises p
LEFT JOIN economia e on p.id_pais = e.id_pais
WHERE e.id_pais IS null

```

## 2. Modificaciones

### 1. Crear una tabla auxiliar para registrar años disponibles por país

```sql
CREATE TABLE anios_disponibles (
    id_pais VARCHAR(10),
    tabla_origen VARCHAR(20),
    anio INT
)

--Para población
INSERT INTO anios_disponibles (id_pais, tabla_origen, anio)
SELECT DISTINCT id_pais, 'poblacion', anio FROM poblacion

--Para economía
INSERT INTO anios_disponibles (id_pais, tabla_origen, anio)
SELECT DISTINCT id_pais, 'economia', anio FROM poblacion

--Para migtación
INSERT INTO anios_disponibles (id_pais, tabla_origen, anio)
SELECT DISTINCT id_pais, 'migracion', anio FROM poblacion

--Para agricultura
INSERT INTO anios_disponibles (id_pais, tabla_origen, anio)
SELECT DISTINCT id_pais, 'agricultura', anio FROM poblacion

--Para medio_ambiente
INSERT INTO anios_disponibles (id_pais, tabla_origen, anio)
SELECT DISTINCT id_pais, 'medio_ambiente', anio FROM poblacion

SELECT * FROM anios_disponibles WHERE id_pais = 'ARG'

```
### 2.Agregar un campo para notas o comentarios

```sql
ALTER TABLE poblacion
ADD COLUMN notas TEXT;

UPDATE poblacion
SET notas = 'Datos incompletos para este año'
WHERE id_pais = 'AFG' AND anio = 2017

```

## 3. Subconsultas

### 1. ¿Cuáles son los 5 países con mayor PIB en el último año disponible?

```sql
SELECT id_pais, pib
FROM economia
WHERE anio = (
    SELECT MAX(anio) FROM economia
)
ORDER BY pib DESC
LIMIT 5;
```
### 2. ¿Qué país tuvo el mayor ingreso promedio en 2020?

```sql
SELECT id_pais, ingreso_promedio
FROM economia
WHERE anio = 2020
  AND ingreso_promedio IS NOT NULL
ORDER BY ingreso_promedio DESC
LIMIT 1;
```
### 3. ¿Cuáles países tienen una desigualdad mayor al promedio mundial en 2015?

```sql
SELECT id_pais, desigualdad
FROM poblacion
WHERE anio = 2015
  AND desigualdad > (
    SELECT AVG(desigualdad)
   FROM poblacion
    WHERE anio = 2015
    AND desigualdad IS not NULL
)
```