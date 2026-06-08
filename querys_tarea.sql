SELECT * FROM tourism.owners

--Insertar propietario
INSERT INTO tourism.owners (
first_name, 
last_name,
company_name,
email, 
phone, 
address_line1, 
city,country)
VALUES ('Henry','Alvarenga', 'henry@gmail.com', '7494969', 'Morazan', 'jocoro','El salvador');

-- Insertar un alojamiento
SELECT * FROM tourism.accommodations
INSERT INTO tourism.accommodations (owner_id, accommodation_type_id, 
location_id, name, description, max_guests,
bedroom_count, bathroom_count, base_price_per_night, is_active)
VALUES (1, 1, 1, 'cabaña del bosque', 'Hermosa cabaña rustica', 4, 2, 1, 75.00, true);

-- Registro de huesped y reserva
SELECT * FROM tourism.guests

INSERT INTO tourism.guests (first_name, last_name, email, phone, nationality,
passport_number)
VALUES ('Henry', 'Alvarenga', 'henry@gmail', '794969', 'Salvadore;a', 'xyz12345');

INSERT INTO tourism.bookings (guest_id, accommodation_id, room_id, booking_reference, booking_status_id,
check_in_date, check_out_date, adult_count, child_count, subtotal_amount, total_amount)
VALUES (1, 1, NULL, 121, 1, '2026-06-10', '2026-06-20', 2, 0, 375.00, 375.00);

-- Insertar pago
SELECT * FROM tourism.payments

INSERT INTO tourism.payments (booking_id, amount, payment_method, payment_status)
VALUES (1, 375.00, 'Tarjeta de Credito', 'Completado');

-- Filtrar activos
SELECT * FROM tourism.accommodations

SELECT owner_id, name, base_price_per_night, is_active
FROM tourism.accommodations
WHERE is_active = true;


-- Filtrar por nacionalidad
SELECT * FROM tourism.guests

SELECT guest_id, first_name, last_name, nationality
FROM tourism.guests
WHERE nationality = 'Salvadore;a'

-- Reservas por fechas
SELECT * FROM tourism.bookings

SELECT booking_id, guest_id, check_in_date, check_out_date
FROM tourism.bookings
where check_in_date BETWEEN '2020-01-01' AND '2026-12-31';

-- Actualizar precio
SELECT * FROM tourism.accommodations

SELECT accommodation_id, name 
FROM tourism.accommodations
WHERE accommodation_id = 1;

UPDATE tourism.accommodations
SET base_price_per_night = 85
WHERE accommodation_id = 1;

-- Estado reserva
SELECT * FROM tourism.bookings

UPDATE tourism.bookings
SET booking_status_id = 2
WHERE booking_id = 1 ;

-- Eliminar rese;a
SELECT * FROM tourism.reviews

DELETE FROM tourism.reviews
WHERE review_id = 1;

-- Reserva + huésped
SELECT * FROM tourism.bookings

SELECT b.booking_id AS reserva_id, 
g.first_name, 
g.last_name, 
b.check_in_date
FROM tourism.bookings b
JOIN tourism.guests g ON b.guest_id = g.guest_id;

-- Alojamiento completo
SELECT * FROM tourism.accommodations

SELECT a.name AS alojamiento, 
o.first_name AS propietario, 
loc.city, 
loc.state
FROM tourism.accommodations a
JOIN tourism.owners o ON a.owner_id = o.owner_id
JOIN tourism.locations loc ON a.location_id = loc. location_id;

-- Pagos + reservas
SELECT * FROM tourism.payments

SELECT p.payment_id AS pago_id, 
p.amount, 
b.check_in_date, 
b.total_nights
FROM tourism.payments p
JOIN tourism.bookings b ON p.booking_id = b.booking_id;

-- Sin rese;as
SELECT * FROM tourism.accommodations

SELECT a.accommodation_id, 
a.name, r.rating
FROM tourism.accommodations a
LEFT JOIN tourism.reviews r ON a. accommodation_id = r.accommodation_id
WHERE r. review_id IS NULL;

-- Sin reservas
SELECT * FROM tourism.guest

SELECT g.guest_id, 
g.first_name, 
g.last_name
FROM tourism.guests g
LEFT JOIN tourism.bookings b ON g.guest_id = b.guest_id
WHERE b.booking_id IS NULL;


-- Total de ingresos
SELECT * FROM tourism.payments

SELECT SUM(amount) AS total_ingresos_global
FROM tourism.payments;

-- Promedio
SELECT * FROM tourism.reviews

SELECT AVG(rating) AS promedio_calificaciones
FROM tourism.reviews;



-- Top alojamientos
SELECT * FROM tourism.bookings

SELECT accommodation_id, COUNT(booking_id) AS total_reservas
FROM tourism.bookings
GROUP BY accommodation_id
ORDER BY total_reservas DESC
LIMIT 10;

-- Mas de 3 reservas
SELECT *  FROM tourism.bookings

SELECT guest_id, 
COUNT(booking_id) AS cantidad_reservas
FROM tourism.bookings
GROUP BY guest_id
HAVING COUNT(booking_id) > 3;

-- Alojamiento mas caro
SELECT * FROM tourism.accommodations

SELECT accommodation_id, 
name, base_price_per_night
FROM tourism.accommodations
WHERE base_price_per_night = (SELECT MAX(base_price_per_night) 
FROM tourism.accommodations);

