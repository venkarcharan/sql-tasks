CREATE DATABASE CinemaBookingDB;

USE CinemaBookingDB;

CREATE TABLE Movies (
    movie_id INT PRIMARY KEY IDENTITY(1,1),
    movie_name VARCHAR(100) NOT NULL,
    genre VARCHAR(50),
    language VARCHAR(50),
    ticket_price DECIMAL(10,2),

    created_on DATETIME DEFAULT GETDATE(),
    created_by VARCHAR(50),
    updated_on DATETIME,
    updated_by VARCHAR(50),
    is_active BIT DEFAULT 1
);

CREATE TABLE Bookings (
    booking_id INT PRIMARY KEY IDENTITY(1,1),
    customer_name VARCHAR(100),
    seat_number VARCHAR(10),
    booking_date DATE,
    city VARCHAR(50),

    movie_id INT,

    created_on DATETIME DEFAULT GETDATE(),
    created_by VARCHAR(50),
    updated_on DATETIME,
    updated_by VARCHAR(50),
    is_active BIT DEFAULT 1,

    CONSTRAINT FK_MovieBooking
    FOREIGN KEY (movie_id)
    REFERENCES Movies(movie_id)
);

    CREATE TABLE Theaters (
    theater_id INT PRIMARY KEY IDENTITY(1,1),
    theater_name VARCHAR(100) NOT NULL,
    city VARCHAR(50),
    total_screens INT,

    created_on DATETIME DEFAULT GETDATE(),
    created_by VARCHAR(100),
    updated_by VARCHAR(100),
    is_active BIT DEFAULT 1
);

CREATE TABLE Shows (
    show_id INT PRIMARY KEY IDENTITY(1,1),

    movie_id INT,
    theater_id INT,

    show_time DATETIME,  m
    available_seats INT,

    created_on DATETIME DEFAULT GETDATE(),
    created_by VARCHAR(50),
    updated_on DATETIME,
    updated_by VARCHAR(50),
    is_active BIT DEFAULT 1,

    CONSTRAINT FK_ShowMovie
    FOREIGN KEY (movie_id)
    REFERENCES Movies(movie_id),

    CONSTRAINT FK_ShowTheater
    FOREIGN KEY (theater_id)
    REFERENCES Theaters(theater_id),
);
CREATE TABLE Payments (
    payment_id INT PRIMARY KEY IDENTITY(1,1),

    booking_id INT UNIQUE,

    payment_method VARCHAR(50),
    amount DECIMAL(10,2),
    payment_status VARCHAR(50),

    payment_date DATETIME DEFAULT GETDATE(),

    created_on DATETIME DEFAULT GETDATE(),
    created_by VARCHAR(50),
    updated_on DATETIME,
    updated_by VARCHAR(50),
    is_active BIT DEFAULT 1,

    CONSTRAINT FK_PaymentBooking
    FOREIGN KEY (booking_id)
    REFERENCES Bookings(booking_id)
);



INSERT INTO Movies
(movie_name, genre, language, ticket_price, created_by)
VALUES
('Kantara', 'Action', 'Kannada', 250, 'Admin'),
('KGF', 'Action', 'Kannada', 300, 'Admin'),
('Leo', 'Thriller', 'Tamil', 280, 'Admin'),
('Pushpa', 'Action', 'Telugu', 270, 'Admin'),
('Jawan', 'Drama', 'Hindi', 320, 'Admin');

INSERT INTO Bookings
(customer_name, seat_number, booking_date, city, movie_id, created_by)
VALUES
('Prajwal', 'A1', '2026-05-20', 'Bangalore', 1, 'Admin'),
('Rahul', 'B2', '2026-05-20', 'Mysore', 2, 'Admin'),
('Sneha', 'C3', '2026-05-21', 'Hubli', 3, 'Admin'),
('Amit', 'D4', '2026-05-21', 'Belgaum', 4, 'Admin'),
('Keerthi', 'E5', '2026-05-22', 'Bangalore', 5, 'Admin');

INSERT INTO Theaters
(theater_name, city, total_screens, created_by)
VALUES
('PVR Orion', 'Bangalore', 5, 'Admin'),
('INOX Mall', 'Mysore', 4, 'Admin'),
('Cinepolis', 'Hubli', 3, 'Admin'),
('Miraj Cinema', 'Belgaum', 2, 'Admin'),
('Asian Multiplex', 'Hyderabad', 6, 'Admin');

INSERT INTO Shows
(movie_id, theater_id, show_time, available_seats, created_by)
VALUES
(1, 1, '2026-05-25 10:00:00', 100, 'Admin'),
(2, 2, '2026-05-25 01:00:00', 80, 'Admin'),
(3, 3, '2026-05-25 04:00:00', 120, 'Admin'),
(4, 4, '2026-05-25 07:00:00', 90, 'Admin'),
(5, 5, '2026-05-25 10:00:00', 70, 'Admin');

INSERT INTO Payments
(booking_id, payment_method, amount, payment_status, created_by)
VALUES
(1, 'UPI', 250, 'Success', 'Admin'),
(2, 'Card', 300, 'Success', 'Admin'),
(3, 'Cash', 280, 'Pending', 'Admin'),
(4, 'Net Banking', 270, 'Success', 'Admin'),
(5, 'Credit Card', 320, 'Success', 'Admin');



SELECT * FROM Movies;

SELECT * FROM Bookings;

SELECT * FROM Theaters

SELECT * FROM Payments

SELECT * FROM Shows

SELECT * 
FROM Bookings
WHERE city = 'Bangalore';


SELECT * 
FROM Movies
WHERE genre = 'Action'
AND ticket_price > 260;


SELECT * 
FROM Movies
WHERE language = 'Tamil'
OR language = 'Hindi';


SELECT * 
FROM Movies
WHERE movie_name LIKE 'K%';


SELECT * 
FROM Movies
ORDER BY ticket_price DESC;


UPDATE Movies
SET ticket_price = 350,
    updated_on = GETDATE(),
    updated_by = 'Admin'
WHERE movie_id = 2;


UPDATE Movies
SET language = 'Marathi'
WHERE movie_id = 3;


DELETE FROM Bookings
WHERE booking_id = 4;


SELECT * FROM Movies;

SELECT * FROM Bookings;

SELECT * FROM Theaters;

SELECT * FROM Shows;

SELECT * FROM Payments;



UPDATE Movies
SET is_active = 0
WHERE movie_id = 4;


SELECT COUNT(*)
FROM Movies
WHERE genre = 'Action'
AND language = 'Telugu';

SELECT
    b.booking_id,
    b.customer_name,
    m.movie_name,
    m.language,
    m.ticket_price
FROM Bookings b
JOIN Movies m
ON b.movie_id = m.movie_id;

SELECT
    s.show_id,
    m.movie_name,
    t.theater_name,
    t.city,
    s.show_time,
    s.available_seats
FROM Shows s
JOIN Movies m
ON s.movie_id = m.movie_id
JOIN Theaters t
ON s.theater_id = t.theater_id;

SELECT
    b.customer_name,
    m.movie_name,
    p.payment_method,
    p.amount,
    p.payment_status
FROM Payments p
JOIN Bookings b
ON p.booking_id = b.booking_id
JOIN Movies m
ON b.movie_id = m.movie_id;

SELECT
    b.booking_id,
    b.customer_name,
    m.movie_name,
    m.language,
    m.ticket_price
FROM Bookings b
INNER JOIN Movies m
ON b.movie_id = m.movie_id














