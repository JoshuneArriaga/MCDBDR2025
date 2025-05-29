# TAREA 1

## Base de datos seleccionada

En la página web "Our World in Data" se recopila y organiza información sobre indicadores sociales, económicos, de salud y medio ambiente a nivel mundial, con el objetivo de llevar a cabo análisis y visualizaciones de cómo estos factores evolucionan con el tiempo en distintas regiones o países.

Podríamos estructurar una base de datos donde cada conjunto de datos se relacione con alguna problemática global como pobreza, cambio climático, alfabetización, mortalidad infantil, etc. Cada uno de estos indicadores está ligado a un país, un año en específico, el valor puntual del indicador y su cambio porcentual absoluto.

### Supuestos sobre los tipos de datos
- Indicadores
  - id_indicador: entero
  - nombre_indicador: texto
- Países
  - id_pais: entero
  - nombre_pais: texto
- Datos
  - id_indicador 
  - id_pais: entero 
  - anio: entero
  - valor: decimal
  - var_absoluta: decimal

## Investigación SGBD

Un sistema de gestión de bases de datos (SGBD) es un software utilizado para gestionar, almacenar y recuperar bases de datos. Proporciona una interfaz que permite a los usuarios leer, crear, borrar y actualizar datos.

Los SGBD funcionan mediante comandos del sistema. Al introducir un comando, el administrador de la base de datos da instrucciones para recuperar, modificar o cargar los datos existentes.

### PostgreSQL

PostgreSQL, comúnmente pronunciado "Post-GRES", es una base de datos de código abierto que tiene una sólida reputación por su fiabilidad, flexibilidad y soporte de estándares técnicos abiertos. A diferencia de otros RDMBS (sistemas de gestión de bases de datos relacionales), PostgreSQL soporta tipos de datos relacionales y no relacionales. Esto la convierte en una de las bases de datos relacionales más compatibles, estables y maduras disponibles actualmente.

Con PostgreSQL, se pueden determinar los tipos de datos, crear funciones personalizadas y escribir código en diferentes lenguajes de programación sin necesidad de recompilar las bases de datos. El sistema compilará los datos en un formato de catálogo, utilizando tablas y columnas y añadiendo información sobre métodos de acceso y funciones.

# Referencias

- Ibm. (2023, October 2). ¿Qué es PostgreSQL?  | IBM. ibm.com. https://www.ibm.com/mx-es/topics/postgresql
- Boada, D., & Boada, D. (2025, January 16). Qué es un SGBD: Guía completa sobre los sistemas de gestión de bases de datos. Tutoriales Hostinger. https://www.hostinger.com/mx/tutoriales/sgbd
- Data Catalog. (n.d.). Our World in Data. https://ourworldindata.org/data