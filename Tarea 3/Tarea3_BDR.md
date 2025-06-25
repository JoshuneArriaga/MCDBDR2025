# TAREA 3

## Esquema Relacional 

![alt text](<Esquema e-r.png>)

## Álgebra Relacional - 4 Operaciones

### 1.Selección (σ) - Filtrar países por región


σ region = 'Americas' (PAISES)

Selecciona todos los países que pertenecen a la región de Americas, filtra las filas de una relación que en este caso es paises, que cumplen con una condición específica. 

### 2.Proyección (π) - Obtener solo nombres y PIB


π nombre_pais, pib (PAISES x ECONOMIA)

Selecciona solo ciertas columnas de una relación. Aquí estamos obteniendo únicamente los nombres de los países y su PIB. Primero se realiza un join entre las tablas PAISES y ECONOMIA para combinar los datos, y luego proyectamos solo las columnas de interes: nombre_pais y pib.

### 3.Producto cartesiano (x) - Combinar datos de países con población

PAISES x POBLACION

Combina dos relaciones basándose en atributos que tienen el mismo nombre y dominio. En este caso,se combina la tabla PAISES con POBLACION usando el campo común 'id_pais'. 

### 4.Composición -  identificar los países más contaminantes

π nombre_pais, emisiones_co2, poblacion_total (
    σ emisiones_co2 > 1000000 (
        PAISES x MEDIO_AMBIENTE x POBLACION
    )
)

Primero se combinan tres tablas (PAISES, MEDIO_AMBIENTE, POBLACION), después se filtra solo los países que tienen emisiones de CO2 mayores a 1,000,000 toneladas y finalmente se muestra solo el nombre del país, sus emisiones de CO2 y población total.