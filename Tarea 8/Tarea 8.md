# TAREA 8

## 1. Creación de Vistas

Consulta que combina la tabla población y economía para años comunes

### a) JOIN
```sql
CREATE VIEW consulta_1 AS
SELECT 
    p.id_pais,
    p.nombre_pais,
    po.anio,
    po.poblacion_total,
    e.pib,
    e.ingreso_promedio
FROM paises p
JOIN poblacion po ON p.id_pais = po.id_pais
JOIN economia e ON po.id_pais = e.id_pais AND po.anio = e.anio;
```
Esta vista muestra datos integrados (población + economía) solo cuando hay coincidencia en país y año,sirve para análisis de correlación entre PIB y población sin hacer joins manuales cada vez.

### b) LEFT JOIN 
Para incluir países aunque no tengan datos de migración

```sql
CREATE VIEW vista_2 AS
SELECT 
    p.nombre_pais,
    po.anio,
    po.poblacion_total,
    m.numero_emigrantes
FROM paises p
LEFT JOIN poblacion po ON p.id_pais = po.id_pais
LEFT JOIN migracion m ON p.id_pais = m.id_pais AND po.anio = m.anio
```
Muestra todos los países aunque falten datos económicos, permite identificar donde faltan datos.

### c) RIGHT JOIN 

```sql
CREATE VIEW vista_3 AS
SELECT 
    e.id_pais,
    e.anio,
    e.pib,
    po.poblacion_total
FROM economia e
RIGHT JOIN poblacion po ON e.id_pais = po.id_pais AND e.anio = po.anio
```
Garantiza que todos los registros de población aparezcan, incluso si no hay datos económicos.


### d) Vista con subconsulta

Países con PIB mayor al promedio del año más reciente.
```sql
CREATE VIEW vista_subconsulta AS
SELECT 
    p.nombre_pais,
    e.anio,
    e.pib
FROM economia e
 JOIN paises p ON e.id_pais = p.id_pais
WHERE e.anio = (select max(anio) from economia)
AND e.pib > (SELECT AVG(pib) FROM economia WHERE anio = (select max(anio) from economia))
```
Muestra países con PIB superior al promedio en el último año disponible

## 2.Trigger

Trigger para evitar duplicados en poblacion:

```sql
CREATE TRIGGER control_duplicados
BEFORE INSERT ON poblacion
FOR EACH ROW
BEGIN
    IF EXISTS (
        SELECT 1 FROM poblacion 
        WHERE id_pais = NEW.id_pais AND anio = NEW.anio
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Ya existe un registro para este país y año en poblacion';
    END IF;
END;
```

## 3.Beneficios generales de usar vistas y triggers

### Vistas:

- Simplifican consultas complejas y las encapsulan para evitar que el usuario tenga que repetirlas cada vez que sea necesario

- Mejoran la legibilidad y mantenimiento, las vistas presentan los datos con nombres claros y estructura organizada, lo que facilita su interpretación por parte de otros usuarios o sistemas

- Permiten reutilizar consultas sin reescribirlas

## Trigger:

- Asegura la integridad de los datos automáticamente

- Reduce los errores humanos ya que los usuarios no necesitan recordar las restricciones manualmente

- Hace cumplir reglas de negocio sin depender del usuario