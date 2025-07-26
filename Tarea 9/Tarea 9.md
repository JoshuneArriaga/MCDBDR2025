# TAREA 9

## 1. Funciones

### Funcion 1:

Esta función calcula la **correlación de Pearson** entre el **PIB** (de la tabla `economia`) y la **producción agrícola** (de la tabla `agricultura`) para un país específico en un rango de años.

```sql
-- Funcion 1: Calcular correlación entre PIB y producción agrícola

DELIMITER $$

CREATE FUNCTION calcular_correlacion(idPais VARCHAR(10), anioinicio INT, aniofin INT)
RETURNS DECIMAL(10,6)
BEGIN
    DECLARE sumX DECIMAL(18,6) DEFAULT 0;
    DECLARE sumY DECIMAL(18,6) DEFAULT 0;
    DECLARE sumXY DECIMAL(18,6) DEFAULT 0;
    DECLARE sumX2 DECIMAL(18,6) DEFAULT 0;
    DECLARE sumY2 DECIMAL(18,6) DEFAULT 0;
    DECLARE n INT DEFAULT 0;
    DECLARE correlacion DECIMAL(10,6);

    SELECT 
        SUM(e.pib),
        SUM(a.produccion_agricola),
        SUM(e.pib * a.produccion_agricola),
        SUM(e.pib * e.pib),
        SUM(a.produccion_agricola * a.produccion_agricola),
        COUNT(*)
    INTO sumX, sumY, sumXY, sumX2, sumY2, n
    FROM economia e
    JOIN agricultura a ON e.id_pais = a.id_pais AND e.anio = a.anio
    WHERE e.id_pais = idPais
      AND e.anio BETWEEN anioinicio AND aniofin
      AND e.pib IS NOT NULL
      AND a.produccion_agricola IS not NULL;

    IF n= 0 THEN
        RETURN NULL;
    END IF;

    SET correlacion = (sumXY-(sumX * sumY/n))/ 
                      SQRT((sumX2-(sumX * sumX/n)) * (sumY2-(sumY * sumY/n)));

    RETURN correlacion;
END$$

DELIMITER ;

```


### Ejemplo de uso

```sql
SELECT calcular_correlacion('MEX', 2000, 2020)
```

Regresara: Un valor entre -1 y 1:

- 1: correlación perfecta positiva

- -1: correlación perfecta negativa

- 0: sin correlación

### Funcion 2:

Calcula la distancia mínima de ediciones (inserción, borrado, sustitución) para convertir una cadena en otra. Se utiliza para comparar nombres de países con errores ortográficos o acentos.

```sql
-- Funcion 2: Calcular distancia de Levenshtein entre dos cadenas
DELIMITER $$

CREATE FUNCTION levenshtein(str1 VARCHAR(255), str2 VARCHAR(255))
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE s1_len,s2_len,i, j,cost INT;
    DECLARE s1_char CHAR;
    DECLARE c, c_temp INT;
    DECLARE cv0, cv1 VARBINARY(256);

    SET s1_len = LENGTH(str1);
    SET s2_len = LENGTH(str2);

    IF s1_len = 0 THEN
        RETURN s2_len;
    END IF;
    IF s2_len = 0 THEN
        RETURN s1_len;
    END IF;

    SET cv1 = 0x00;
    SET j = 1;
    WHILE j <= s2_len DO
        SET cv1 = CONCAT(cv1, UNHEX(HEX(j)));
        SET j = j + 1;
    END WHILE;

    SET i = 1;
    WHILE i <= s1_len DO
        SET s1_char = SUBSTRING(str1, i, 1);
        SET c = i;
        SET cv0 = UNHEX(HEX(i));
        SET j = 1;
        WHILE j <= s2_len DO
            SET c = c + 1;
            SET cost = IF(s1_char = SUBSTRING(str2, j, 1), 0, 1);
            SET c_temp = CONV(HEX(SUBSTRING(cv1, j, 1)), 16, 10) + cost;
            IF c > c_temp THEN
                SET c = c_temp;
            END IF;
            SET c_temp = CONV(HEX(SUBSTRING(cv1, j + 1, 1)), 16, 10) + 1;
            IF c > c_temp THEN
                SET c = c_temp;
            END IF;
            SET cv0 = CONCAT(cv0, UNHEX(HEX(c)));
            SET j = j + 1;
        END WHILE;
        SET cv1 = cv0;
        SET i = i + 1;
    END WHILE;

    RETURN c;
END$$

DELIMITER ;
  
```


### Ejemplo de uso

```sql
SELECT comparar_nombres('Mexico', 'México');
```
Regresara:
Un número entero con el número mínimo de operaciones necesarias. Un valor más bajo indica mayor similitud entre las cadenas, mientras que un valor más alto indica mayor diferencia. 

