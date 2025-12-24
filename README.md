# Vehicle Rental System

### Overview

**Vehicle Rental System** with user management, vehicle inventory tracking, and booking functionality. The assignment demonstrates table design, relationships (ERD), and SQL Queries.

### Tables

- `Users(user_id, name, email, phone, role)`
- `Vehicles(vehicle_id, name, type, model, registration_number, rental_price, status)`
- `Bookings(booking_id PK, user_id FK, vehicle_id FK)`

### Relationships

- One User - Many Bookings
- One Vehicle - Many Bookings
- Each Booking is linked to exactly one User and one Vehicle

### ERD Design

![alt text](/ERD-image.png)

### SQL Queries Explanation

- **Users Table** - This table stores user account information.

```sql
CREATE TABLE Users (
    user_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(20),
    role VARCHAR(50)
);
```

- **Vehicles Table** - This table stores vehicle inventory information.

```sql
CREATE TABLE Vehicles (
    vehicle_id INT PRIMARY KEY,
    name VARCHAR(100),
    type VARCHAR(50),
    model VARCHAR(50),
    registration_number VARCHAR(20),
    rental_price INT,
    status VARCHAR(20)
);
```

- **Bookings Table** - This table stores rental reservation records.

```sql
CREATE TABLE Bookings (
    booking_id INT PRIMARY KEY,
    user_id INT REFERENCES Users(user_id),
    vehicle_id INT REFERENCES Vehicles(vehicle_id),
    start_date DATE,
    end_date DATE,
    status VARCHAR(20),
    total_cost INT
);

```

- Insert Users, Vehicles & Bookings Table's Data.

```sql
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
```

- Booking Details with Customer & Vehicle Information

```sql
SELECT b.booking_id, u.name as customer_name, v.name as vehicle_name, b.start_date, b.end_date, b.status FROM bookings as b
INNER JOIN users as u USING (user_id) INNER JOIN vehicles as v USING (vehicle_id) ORDER BY b.booking_id;
```

- Identifies vehicles that have never been rented, useful for inventory analysis and marketing decisions.

```sql
SELECT v.vehicle_id, v.name, v.type, v.model, v.registration_number, v.rental_price, v.status FROM vehicles as v
LEFT JOIN bookings as b USING (vehicle_id) WHERE b.vehicle_id IS NULL ORDER BY v.vehicle_id;
```

- Filters the vehicle inventory to show only available cars for customer browsing and reservation purposes.

```sql
SELECT vehicle_id, name, type, model, registration_number, rental_price, status FROM vehicles
WHERE status = 'available' AND type = 'car';
```

- Find the total number of bookings for each vehicle and display only those vehicles that have more than 2 bookings.

```sql
SELECT v.name as vehicle_name, COUNT(b.booking_id) as total_bookings FROM bookings as b
INNER JOIN vehicles as v ON b.vehicle_id = v.vehicle_id GROUP BY v.name HAVING COUNT(b.booking_id) > 2;
```

### How to Run

1. Create the tables using the provided `CREATE TABLE` statements.
2. Insert sample data using the `INSERT` queries.
3. Execute the `SELECT` queries to view results.
