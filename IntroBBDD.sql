-- EJERCICIOS OBLIGATORIOS
-- 1. Escribe una consulta que recupere los Vuelos (flights) y su identificador que figuren con status On Time.
SELECT flight_id, route_no, status
FROM flights
WHERE status = 'On Time';

-- 2. Escribe una consulta que extraiga todas las columnas de la tabla bookings y refleje todas las reservas que han supuesto una cantidad total mayor a 1.000.000 (Unidades monetarias).
SELECT *
FROM bookings
WHERE total_amount > 1000000;

-- 3. Escribe una consulta que extraiga todas las columnas de los datos de los modelos de aviones disponibles (aircraft_data). Puede que os aparezca en alguna actualización como "aircrafts_data", revisad las tablas y elegid la que corresponda.
--Para ver los caracteres en ruso que si no me daba error
SET client_encoding TO 'UTF8';
SELECT *
FROM bookings.airplanes_data;

-- 4. Con el resultado anterior visualizado previamente, escribe una consulta que extraiga los identificadores de vuelo que han volado con un Boeing 737. (Código Modelo Avión = 733)
SELECT flight_id, route_no, airplane_code
FROM bookings.timetable
WHERE airplane_code IN ('733', '7M7');

-- 5. Escribe una consulta que te muestre la información detallada de los tickets que han comprado las personas que se llaman Irina.
SET client_encoding TO 'UTF8';
SELECT *
FROM bookings.tickets
WHERE passenger_name::text LIKE '%IRINA%'
   OR passenger_name::text LIKE '%Irina%';


-- EJERCICIOS OPCIONALES

-- 6. Mostrar las ciudades con más de un aeropuerto.
SELECT city, COUNT(*) AS numero_aeropuertos
FROM airports_data
GROUP BY city
HAVING COUNT(*) > 1;

-- 7. Mostrar el número de vuelos por modelo de avión.
SELECT airplane_code, COUNT(*) AS total_vuelos
FROM bookings.timetable
GROUP BY airplane_code;

-- 8. Reservas con más de un billete (varios pasajeros)
SELECT book_ref, COUNT(*) AS num_pasajeros
FROM tickets
GROUP BY book_ref
HAVING COUNT(*) > 1;

-- 9. Vuelos con retraso de salida superior a una hora 
SELECT flight_id, scheduled_departure, actual_departure,
       (actual_departure - scheduled_departure) AS retraso
FROM flights
WHERE actual_departure IS NOT NULL
  AND (actual_departure - scheduled_departure) > INTERVAL '1 hour';