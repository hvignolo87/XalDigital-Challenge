-- Create tables and insert data
CREATE TABLE aerolineas(
        id_aerolinea TINYINT(1) NOT NULL,
        nombre_aerolinea VARCHAR(20),
        PRIMARY KEY(id_aerolinea)
);

INSERT INTO aerolineas VALUES
(1, 'Volaris'), (2, 'Aeromar'), 
(3, 'Interjet'), (4, 'Aeromexico');

SELECT * FROM aerolineas;

CREATE TABLE aeropuertos(
        id_aeropuerto TINYINT(1) NOT NULL,
        nombre_aeropuerto VARCHAR(20),
        PRIMARY KEY(id_aeropuerto)
);

INSERT INTO aeropuertos VALUES
(1, 'Benito Juarez'), (2, 'Guanajuato'), 
(3, 'La Paz'), (4, 'Oaxaca');

SELECT * FROM aeropuertos;

CREATE TABLE movimientos(
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


-- ¿Cuál es el nombre aeropuerto que ha tenido
-- mayor movimiento durante el año?
SELECT id_aeropuerto, MAX(id_max_mov)
FROM (
    SELECT id_aeropuerto, COUNT(id_movimiento) AS id_max_mov
    FROM vuelos GROUP BY id_aeropuerto
);