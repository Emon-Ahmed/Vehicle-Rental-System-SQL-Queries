CREATE TABLE Users (
    user_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(20),
    role VARCHAR(50)
);

CREATE TABLE Vehicles (
    vehicle_id INT PRIMARY KEY,
    name VARCHAR(100),
    type VARCHAR(50),
    model VARCHAR(50),
    registration_number VARCHAR(20),
    rental_price INT,
    status VARCHAR(20)
);

CREATE TABLE Bookings (
    booking_id INT PRIMARY KEY,
    user_id INT REFERENCES Users(user_id),
    vehicle_id INT REFERENCES Vehicles(vehicle_id),
    start_date DATE,
    end_date DATE,
    status VARCHAR(20),
    total_cost INT
);


INSERT INTO Users (user_id, name, email, phone, role) VALUES
(1, 'Alice', 'alice@example.com', '1234567890', 'Customer'),
(2, 'Bob', 'bob@example.com', '0987654321', 'Admin'),
(3, 'Charlie', 'charlie@example.com', '1122334455', 'Customer');

INSERT INTO Vehicles (vehicle_id, name, type, model, registration_number, rental_price, status) VALUES
(1, 'Toyota Corolla', 'car', '2022', 'ABC-123', 50, 'available'),
(2, 'Honda Civic', 'car', '2021', 'DEF-456', 60, 'rented'),
(3, 'Yamaha R15', 'bike', '2023', 'GHI-789', 30, 'available'),
(4, 'Ford F-150', 'truck', '2020', 'JKL-012', 100, 'maintenance');

INSERT INTO Bookings (booking_id, user_id, vehicle_id, start_date, end_date, status, total_cost) VALUES
(1, 1, 2, '2023-10-01', '2023-10-05', 'completed', 240),
(2, 1, 2, '2023-11-01', '2023-11-03', 'completed', 120),
(3, 3, 2, '2023-12-01', '2023-12-02', 'confirmed', 60),
(4, 1, 1, '2023-12-10', '2023-12-12', 'pending', 120);


SELECT b.booking_id, u.name as customer_name, v.name as vehicle_name, b.start_date, b.end_date, b.status FROM bookings as b
INNER JOIN users as u USING (user_id) INNER JOIN vehicles as v USING (vehicle_id) ORDER BY b.booking_id;

SELECT v.vehicle_id, v.name, v.type, v.model, v.registration_number, v.rental_price, v.status FROM vehicles as v
LEFT JOIN bookings as b USING (vehicle_id) WHERE b.vehicle_id IS NULL ORDER BY v.vehicle_id;

SELECT vehicle_id, name, type, model, registration_number, rental_price, status FROM vehicles 
WHERE status = 'available' AND type = 'car';

SELECT v.name as vehicle_name, COUNT(b.booking_id) as total_bookings FROM bookings as b
INNER JOIN vehicles as v ON b.vehicle_id = v.vehicle_id GROUP BY v.name HAVING COUNT(b.booking_id) > 2;