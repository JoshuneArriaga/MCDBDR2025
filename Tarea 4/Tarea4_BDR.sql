-- Tabla principal PAÍSES
drop TABLE if EXISTS paises;
CREATE TABLE paises (
    id_pais VARCHAR(10) PRIMARY KEY,
    nombre_pais VARCHAR(100) NOT NULL,
    region VARCHAR(50),
    continente VARCHAR(30)
);

--POBLACIÓN
DROP TABLE if EXISTS poblacion;
CREATE TABLE poblacion (
    id_pais VARCHAR(10),
    anio INT,
    poblacion_total BIGINT,
    poblacion_pobreza FLOAT,
    poblacion_pobreza_multidimensional FLOAT,
    desigualdad FLOAT,
    desigualdad_ingresos FLOAT,
    desigualdad_economica FLOAT,
    numero_emigrantes INT,
    numero_inmigrantes INT,
    PRIMARY KEY (id_pais, anio),
    FOREIGN KEY (id_pais) REFERENCES paises(id_pais)
);

-- Economia
DROP TABLE if EXISTS economia
CREATE TABLE economia (
    id_pais VARCHAR(10),
    anio INT,
    pib DECIMAL(15,2),
    ingreso_promedio DECIMAL(10,2),
    crecimiento_economico FLOAT,
    productividad FLOAT,
    indice_precios_consumidor FLOAT,
    desempleo FLOAT,
    PRIMARY KEY (id_pais, anio),
    FOREIGN KEY (id_pais) REFERENCES paises(id_pais)
);

--AGRICULTURA
DROP TABLE if EXISTS agricultura
CREATE TABLE agricultura (
    id_pais VARCHAR(10),
    anio INT,
    produccion_agricola DECIMAL(15,2),
    productividad_laboral_agricultura FLOAT,
    area_tierras_cultivo DECIMAL(12,2),
    tierra_agricola_capita FLOAT,
    uso_fertilizantes FLOAT,
    perdida_comida FLOAT,
    proteina_diaria FLOAT,
    calorias_diarias FLOAT,
    suministros_alimentos FLOAT,
    consumo_carne FLOAT,
    uso_nitrogenos FLOAT,
    uso_nutrientes FLOAT,
    PRIMARY KEY (id_pais, anio),
    FOREIGN KEY (id_pais) REFERENCES paises(id_pais)
);

--medio ambiente
DROP TABLE if EXISTS medio_ambiente
CREATE TABLE medio_ambiente (
    id_pais VARCHAR(10),
    anio INT,
    concentracion_ozono_o3 FLOAT,
    muertes_contaminacion_aire INT,
    emisiones_contaminantes_atmosfericos FLOAT,
    contaminacion_aire FLOAT,
    produccion_electricidad DECIMAL(15,2),
    emisiones_co2 DECIMAL(15,2),
    poblacion_acceso_electricidad FLOAT,
    cambio_climatico FLOAT,
    muertes_causas_frio_calor INT,
    anomalias_temperatura FLOAT,
    calentamiento_global FLOAT,
    PRIMARY KEY (id_pais, anio),
    FOREIGN KEY (id_pais) REFERENCES paises(id_pais)
);

--INSERCIÓN DE DATOS

--Insertar países
INSERT INTO paises (id_pais, nombre_pais, region, continente) VALUES
('MEX', 'México', 'America Latina y Caribe', 'America'),
('USA', 'Estados Unidos', 'America del Norte', 'America'),
('CHN', 'China', 'Asia Oriental', 'Asia'),
('DEU', 'Alemania', 'Europa Occidental', 'Europa'),
('BRA', 'Brasil', 'America Latina y Caribe', 'America');

--Insertar datos de población
INSERT INTO poblacion (id_pais, anio, poblacion_total, poblacion_pobreza, poblacion_pobreza_multidimensional, desigualdad, desigualdad_ingresos, desigualdad_economica, numero_emigrantes, numero_inmigrantes) VALUES
('MEX', 2023, 129739713, 8.6, 15.2, 0.458, 45.8, 0.512,  11596529, 1726089),
('USA', 2023, 343477286, 10.5, 5.8, 0.411, 41.1, 0.434,  3186999, 52375047),
('CHN', 2023, 1422584878, 1.7, 2.1, 0.382, 38.2, 0.395,  11701619, 1638718),
('DEU', 2023, 84548184, 9.6, 3.2, 0.319, 31.9, 0.287,    4297233, 16750084),
('BRA', 2023, 211140678, 4.8, 11.4, 0.533, 53.3, 0.567,   2194325, 1406299);

truncate table poblacion;

--Insertar datos económicos 
INSERT INTO economia (id_pais, anio, pib, ingreso_promedio, crecimiento_economico, productividad, indice_precios_consumidor, desempleo) VALUES
('MEX', 2023, 22142.607, 16.59, 2.30, 78.5, 4.7, 3.4),
('USA', 2023, 74577.51, 82.01, 2.38, 156.8, 4.1, 3.7),
('CHN', 2023, 22137.6, 15.36, 5.36, 98.7, 0.2, 5.2),
('DEU', 2023, 63578.14, 70.33, 0.35, 134.2, 5.9, 3.1),
('BRA', 2023, 19018.238, 21.33, 2.50, 67.3, 4.6, 9.3);

--Insertar datos de agricultura
INSERT INTO agricultura (id_pais, anio, produccion_agricola, productividad_laboral_agricultura, area_tierras_cultivo, tierra_agricola_capita, uso_fertilizantes, perdida_comida, proteina_diaria, calorias_diarias, suministros_alimentos, consumo_carne, uso_nitrogenos, uso_nutrientes) VALUES
('MEX', 2023, 58896091000, 12.5, 24700000, 0.19, 1.8, 12.3, 88.5, 3150.0, 110.2, 64.2, 45.8, 78.9),
('USA', 2023, 362837553000, 89.2, 157700000, 0.47, 3.1, 8.7, 124.8, 3680.0, 128.5, 124.1, 67.3, 92.4),
('CHN', 2023, 1399637739000, 18.7, 119500000, 0.08, 5.2, 15.6, 112.4, 3140.0, 105.8, 62.8, 89.7, 156.3),
('DEU', 2023, 45566018000, 78.3, 11900000, 0.14, 2.8, 6.9, 95.7, 3540.0, 116.8, 85.4, 52.1, 67.8),
('BRA', 2023, 208828843000, 23.1, 33200000, 0.15, 2.4, 18.2, 92.6, 3180.0, 108.4, 98.3, 78.2, 98.7);

--Insertar datos de medio ambiente
INSERT INTO medio_ambiente (id_pais, anio, concentracion_ozono_o3, muertes_contaminacion_aire, emisiones_contaminantes_atmosfericos, contaminacion_aire, produccion_electricidad, emisiones_co2, poblacion_acceso_electricidad, cambio_climatico, muertes_causas_frio_calor, anomalias_temperatura, calentamiento_global) VALUES
('MEX', 2023, 45.8, 48600, 678.4, 35.2, 308700000000, 465800000, 100.0, 1.2, 2840, 1.3, 1.8),
('USA', 2023, 38.2, 108400, 4567.8, 28.9, 4326500000000, 4713400000, 100.0, 1.8, 18950, 1.7, 2.1),
('CHN', 2023, 67.3, 1240000, 12456.7, 58.4, 8355400000000, 10175600000, 100.0, 1.5, 43200, 1.4, 2.0),
('DEU', 2023, 32.1, 58700, 789.3, 22.8, 574500000000, 674200000, 100.0, 1.4, 12450, 1.6, 2.2),
('BRA', 2023, 28.9, 124300, 2134.6, 31.7, 567800000000, 419700000, 99.8, 1.1, 8760, 1.2, 1.6);

