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

SELECT * FROM Movies;

SELECT * FROM Bookings;


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


UPDATE Movies
SET is_active = 0
WHERE movie_id = 4;


SELECT COUNT(*)
FROM Movies
WHERE genre = 'Action'
AND language = 'Telugu';


