CREATE DATABASE MovieReservationDB;

USE MovieReservationDB;

CREATE TABLE mst_Movies
(
MovieId INT PRIMARY KEY IDENTITY(1,1),
MovieName VARCHAR(100) NOT NULL,
Genre VARCHAR(50) NOT NULL,
LanguageName VARCHAR(50) NOT NULL,
TicketPrice DECIMAL(10,2) NOT NULL,

Created_On DATETIME DEFAULT GETDATE(),
Created_By VARCHAR(50),
Updated_On DATETIME,
Updated_By VARCHAR(50),
Is_Active BIT DEFAULT 1
);

CREATE TABLE mst_Theaters
(
TheaterId INT PRIMARY KEY IDENTITY(1,1),
TheaterName VARCHAR(100) NOT NULL,
City VARCHAR(50) NOT NULL,
TotalScreens INT NOT NULL,

Created_On DATETIME DEFAULT GETDATE(),
Created_By VARCHAR(50),
Updated_On DATETIME,
Updated_By VARCHAR(50),
Is_Active BIT DEFAULT 1
);

CREATE TABLE tbl_Bookings
(
BookingId INT PRIMARY KEY IDENTITY(1,1),

CustomerName VARCHAR(100) NOT NULL,
SeatNumber VARCHAR(10) NOT NULL,
BookingDate DATE NOT NULL,
City VARCHAR(50),

MovieId INT NOT NULL,

Created_On DATETIME DEFAULT GETDATE(),
Created_By VARCHAR(50),
Updated_On DATETIME,
Updated_By VARCHAR(50),
Is_Active BIT DEFAULT 1,

CONSTRAINT FK_tbl_Bookings_MovieId
FOREIGN KEY(MovieId)
REFERENCES mst_Movies(MovieId)
);

CREATE TABLE tbl_Shows
(
ShowId INT PRIMARY KEY IDENTITY(1,1),

MovieId INT NOT NULL,
TheaterId INT NOT NULL,

ShowTime DATETIME NOT NULL,
AvailableSeats INT NOT NULL,

Created_On DATETIME DEFAULT GETDATE(),
Created_By VARCHAR(50),
Updated_On DATETIME,
Updated_By VARCHAR(50),
Is_Active BIT DEFAULT 1,

CONSTRAINT FK_tbl_Shows_MovieId
FOREIGN KEY(MovieId)
REFERENCES mst_Movies(MovieId),

CONSTRAINT FK_tbl_Shows_TheaterId
FOREIGN KEY(TheaterId)
REFERENCES mst_Theaters(TheaterId)
);

CREATE TABLE tbl_Payments
(
PaymentId INT PRIMARY KEY IDENTITY(1,1),

BookingId INT UNIQUE NOT NULL,

PaymentMethod VARCHAR(50),
Amount DECIMAL(10,2),
PaymentStatus VARCHAR(50),

PaymentDate DATETIME DEFAULT GETDATE(),

Created_On DATETIME DEFAULT GETDATE(),
Created_By VARCHAR(50),
Updated_On DATETIME,
Updated_By VARCHAR(50),
Is_Active BIT DEFAULT 1,

CONSTRAINT FK_tbl_Payments_BookingId
FOREIGN KEY(BookingId)
REFERENCES tbl_Bookings(BookingId)
);

CREATE TABLE tbl_ErrorLog
(
ErrorLogId INT PRIMARY KEY IDENTITY(1,1),
ErrorMessage VARCHAR(MAX),
ErrorProcedure VARCHAR(200),
ErrorLine INT,
ErrorDate DATETIME DEFAULT GETDATE()
);

INSERT INTO mst_Movies
(MovieName, Genre, LanguageName, TicketPrice, Created_By)
VALUES
('Kantara', 'Action', 'Kannada', 250, 'Admin'),
('KGF', 'Action', 'Kannada', 300, 'Admin'),
('Leo', 'Thriller', 'Tamil', 280, 'Admin'),
('Pushpa', 'Action', 'Telugu', 270, 'Admin'),
('Jawan', 'Drama', 'Hindi', 320, 'Admin');

INSERT INTO mst_Theaters
(TheaterName, City, TotalScreens, Created_By)
VALUES
('PVR Orion', 'Bangalore', 5, 'Admin'),
('INOX Mall', 'Mysore', 4, 'Admin'),
('Cinepolis', 'Hubli', 3, 'Admin'),
('Miraj Cinema', 'Belgaum', 2, 'Admin'),
('Asian Multiplex', 'Hyderabad', 6, 'Admin');

INSERT INTO tbl_Bookings
(CustomerName, SeatNumber, BookingDate, City, MovieId, Created_By)
VALUES
('Prajwal', 'A1', '2026-05-20', 'Bangalore', 1, 'Admin'),
('Rahul', 'B2', '2026-05-20', 'Mysore', 2, 'Admin'),
('Sneha', 'C3', '2026-05-21', 'Hubli', 3, 'Admin'),
('Amit', 'D4', '2026-05-21', 'Belgaum', 4, 'Admin'),
('Keerthi', 'E5', '2026-05-22', 'Bangalore', 5, 'Admin');

INSERT INTO tbl_Shows
(MovieId, TheaterId, ShowTime, AvailableSeats, Created_By)
VALUES
(1,1,'2026-05-25 10:00:00',100,'Admin'),
(2,2,'2026-05-25 01:00:00',80,'Admin'),
(3,3,'2026-05-25 04:00:00',120,'Admin'),
(4,4,'2026-05-25 07:00:00',90,'Admin'),
(5,5,'2026-05-25 10:00:00',70,'Admin');

INSERT INTO tbl_Payments
(BookingId, PaymentMethod, Amount, PaymentStatus, Created_By)
VALUES
(1,'UPI',250,'Success','Admin'),
(2,'Card',300,'Success','Admin'),
(3,'Cash',280,'Pending','Admin'),
(4,'Net Banking',270,'Success','Admin'),
(5,'Credit Card',320,'Success','Admin');

SELECT
b.CustomerName,
m.MovieName
FROM tbl_Bookings b
INNER JOIN mst_Movies m
ON b.MovieId = m.MovieId;

SELECT
b.CustomerName,
m.MovieName
FROM tbl_Bookings b
LEFT JOIN mst_Movies m
ON b.MovieId = m.MovieId;

SELECT
b.CustomerName,
m.MovieName
FROM tbl_Bookings b
RIGHT JOIN mst_Movies m
ON b.MovieId = m.MovieId;

SELECT
b.CustomerName,
m.MovieName
FROM tbl_Bookings b
FULL JOIN mst_Movies m
ON b.MovieId = m.MovieId;

SELECT
b1.CustomerName AS Customer1,
b2.CustomerName AS Customer2
FROM tbl_Bookings b1
JOIN tbl_Bookings b2
ON b1.BookingId <> b2.BookingId;

SELECT
m.MovieName,
t.TheaterName
FROM mst_Movies m
CROSS JOIN mst_Theaters t;

CREATE PROCEDURE usp_GetMovies
AS
BEGIN

SET NOCOUNT ON;

SELECT
MovieId,
MovieName,
Genre,
LanguageName,
TicketPrice
FROM mst_Movies;

END;

CREATE PROCEDURE usp_GetBookings
AS
BEGIN

SET NOCOUNT ON;

SELECT
BookingId,
CustomerName,
SeatNumber,
BookingDate,
City
FROM tbl_Bookings;

END;

CREATE PROCEDURE usp_GetPaymentDetails
AS
BEGIN

SET NOCOUNT ON;

SELECT
b.CustomerName,
m.MovieName,
p.PaymentMethod,
p.Amount,
p.PaymentStatus
FROM tbl_Payments p
INNER JOIN tbl_Bookings b
ON p.BookingId = b.BookingId
INNER JOIN mst_Movies m
ON b.MovieId = m.MovieId;

END;

CREATE TYPE Booking_Type AS TABLE
(
CustomerName VARCHAR(100),
SeatNumber VARCHAR(10),
BookingDate DATE,
City VARCHAR(50),
MovieId INT
);

CREATE PROCEDURE usp_InsertBookings
(
@Bookings Booking_Type READONLY
)
AS
BEGIN

SET NOCOUNT ON;

INSERT INTO tbl_Bookings
(
CustomerName,
SeatNumber,
BookingDate,
City,
MovieId
)

SELECT
CustomerName,
SeatNumber,
BookingDate,
City,
MovieId
FROM @Bookings;

END;

BEGIN TRY

BEGIN TRANSACTION;

INSERT INTO tbl_Bookings
(
CustomerName,
SeatNumber,
BookingDate,
City,
MovieId,
Created_By
)

VALUES
(
'Ramesh',
'F1',
GETDATE(),
'Bangalore',
100,
'Admin'
);

UPDATE mst_Movies
SET TicketPrice = 400
WHERE MovieId = 1;

COMMIT TRANSACTION;

END TRY

BEGIN CATCH

ROLLBACK TRANSACTION;

INSERT INTO tbl_ErrorLog
(
ErrorMessage,
ErrorProcedure,
ErrorLine
)

VALUES
(
ERROR_MESSAGE(),
ERROR_PROCEDURE(),
ERROR_LINE()
);

END CATCH;

EXEC usp_GetMovies;

EXEC usp_GetBookings;

EXEC usp_GetPaymentDetails;

SELECT * FROM mst_Movies;

SELECT * FROM mst_Theaters;

SELECT * FROM tbl_Bookings;

SELECT * FROM tbl_Shows;

SELECT * FROM tbl_Payments;

SELECT * FROM tbl_ErrorLog;