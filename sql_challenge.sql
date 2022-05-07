-- Create tables and insert data
CREATE TABLE IF NOT EXISTS aerolineas(
        id_aerolinea TINYINT(1) NOT NULL,
        nombre_aerolinea VARCHAR(20),
        PRIMARY KEY(id_aerolinea)
);

INSERT INTO aerolineas VALUES
(1, 'Volaris'), (2, 'Aeromar'), 
(3, 'Interjet'), (4, 'Aeromexico');

SELECT * FROM aerolineas;

CREATE TABLE IF NOT EXISTS aeropuertos(
        id_aeropuerto TINYINT(1) NOT NULL,
        nombre_aeropuerto VARCHAR(20),
        PRIMARY KEY(id_aeropuerto)
);

INSERT INTO aeropuertos VALUES
(1, 'Benito Juarez'), (2, 'Guanajuato'), 
(3, 'La Paz'), (4, 'Oaxaca');

SELECT * FROM aeropuertos;

CREATE TABLE IF NOT EXISTS movimientos(
        id_movimiento TINYINT(1) NOT NULL,
        descripcion VARCHAR(20),
        PRIMARY KEY(id_movimiento)
);

INSERT INTO movimientos VALUES
(1, 'Salida'), (2, 'Llegada');

SELECT * FROM movimientos;

CREATE TABLE vuelos(
        id_aerolinea TINYINT(1) NOT NULL,
        id_aeropuerto TINYINT(1) NOT NULL,
        id_movimiento TINYINT(1) NOT NULL,
        dia DATE FORMAT 'YYYY-MM-DD'
);

INSERT INTO vuelos VALUES
(1, 1, 1, '2021-05-02'), 
(2, 1, 1, '2021-05-02'), 
(3, 2, 2, '2021-05-02'), 
(4, 3, 2, '2021-05-02'), 
(1, 3, 2, '2021-05-02'), 
(2, 1, 1, '2021-05-02'), 
(2, 3, 1, '2021-05-04'), 
(3, 4, 1, '2021-05-04'), 
(3, 4, 1, '2021-05-04');

SELECT * FROM vuelos;



/** -------------- RESPUESTAS -------------- **/


-- ¿Cuál es el nombre aeropuerto que ha tenido
-- mayor movimiento durante el año?
SELECT nombre_aeropuerto
FROM aeropuertos
INNER JOIN vuelos
ON vuelos.id_aeropuerto = aeropuertos.id_aeropuerto
GROUP BY vuelos.id_aeropuerto
HAVING COUNT(vuelos.id_movimiento) = 
(
    SELECT COUNT(id_movimiento) AS mov_count
    FROM vuelos
    GROUP BY id_aeropuerto
    ORDER BY mov_count DESC 
    LIMIT 1
);


-- ¿Cuál es el nombre aerolínea que ha realizado
-- mayor número de vuelos durante el año?
SELECT nombre_aerolinea
FROM aerolineas
INNER JOIN vuelos
ON vuelos.id_aerolinea = aerolineas.id_aerolinea
GROUP BY vuelos.id_aerolinea
HAVING COUNT(vuelos.id_movimiento) = 
(
    SELECT COUNT(id_movimiento) AS mov_count
    FROM vuelos
    GROUP BY id_aerolinea
    ORDER BY mov_count DESC 
    LIMIT 1
);

-- ¿En qué día se han tenido mayor número de vuelos?
SELECT dia 
FROM vuelos
GROUP BY dia
HAVING COUNT(dia) = 
(
    SELECT COUNT(dia)
    FROM vuelos 
    GROUP BY dia
    ORDER BY dia ASC
    LIMIT 1
)

-- ¿Cuáles son las aerolíneas que tienen mas de 2 vuelos por día?
SELECT
nombre_aerolinea
FROM aerolineas
INNER JOIN vuelos
ON vuelos.id_aerolinea = aerolineas.id_aerolinea
GROUP BY vuelos.id_aerolinea
HAVING COUNT(vuelos.id_aerolinea) > 2;