/**
PREGUNTA 1:
¿Cuál es el nombre aeropuerto que ha tenido
mayor movimiento durante el año?

RESPUESTA 1: 
nombre_aeropuerto
-----------------
Benito Juarez
La Paz
**/
SELECT nombre_aeropuerto
FROM aeropuertos
INNER JOIN vuelos
ON vuelos.id_aeropuerto = aeropuertos.id_aeropuerto
GROUP BY nombre_aeropuerto
HAVING COUNT(vuelos.id_movimiento) = 
(
    SELECT COUNT(id_movimiento) AS mov_count
    FROM vuelos
    GROUP BY id_aeropuerto
    ORDER BY mov_count DESC 
    LIMIT 1
);




/**
PREGUNTA 2:
¿Cuál es el nombre aerolínea que ha realizado
mayor número de vuelos durante el año?

RESPUESTA 2:
nombre_aerolinea
----------------
Aeromar
Interjet
**/
SELECT nombre_aerolinea
FROM aerolineas
INNER JOIN vuelos
ON vuelos.id_aerolinea = aerolineas.id_aerolinea
GROUP BY nombre_aerolinea
HAVING COUNT(vuelos.id_movimiento) = 
(
    SELECT COUNT(id_movimiento) AS mov_count
    FROM vuelos
    GROUP BY id_aerolinea
    ORDER BY mov_count DESC 
    LIMIT 1
);




/**
PREGUNTA 3: 
¿En qué día se han tenido mayor número de vuelos?

RESPUESTA 3:
dia
----------
2021-05-02
**/
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
);




/**
PREGUNTA 4:
¿Cuáles son las aerolíneas que tienen
mas de 2 vuelos por día?

RESPUESTA 4:
nombre_aerolinea
----------------
(ninguna)

Aclaración: esto es así, ya que ninguna aerolínea
tiene más de 2 vuelos en el mismo día.
**/
SELECT
nombre_aerolinea
FROM aerolineas
INNER JOIN vuelos
ON vuelos.id_aerolinea = aerolineas.id_aerolinea
GROUP BY nombre_aerolinea, vuelos.dia
HAVING COUNT(vuelos.id_aerolinea) > 2;