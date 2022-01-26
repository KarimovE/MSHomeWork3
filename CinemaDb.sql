CREATE DATABASE CinemaDb

USE CinemaDb

CREATE TABLE Genres(
Id int primary key identity,
Name nvarchar(50) not null
)

INSERT INTO Genres (Name)
VALUES ('Comedy'), ('Drama'), ('Biography'), ('Thriller'), ('Animation')


CREATE TABLE Actors(
Id int primary key identity,
Name nvarchar(50) not null
)

INSERT INTO Actors (Name)
VALUES ('Kang-ho Song'), ('Christian Bale'), ('Russel Crowe'), ('Emile Hirsch'), ('Mone Kamishiraishi')


CREATE TABLE Customers(
Id int primary key identity,
Name nvarchar(50) not null,
Surname nvarchar(50) not null
)

INSERT INTO Customers (Name, Surname)
VALUES ('Emil', 'Karimov'), ('Ceyhun', 'Shirinov'), ('Rufat', 'Abdullayev'), ('Fuad', 'Valiyev'), ('Nigar', 'Meherremov')


CREATE TABLE Halls(
Id int primary key identity,
Name nvarchar(50) not null
)

INSERT INTO Halls (Name)
VALUES ('Main'), ('Second'), ('Third')

CREATE TABLE Sessions(
Id int primary key identity,
Date datetime
)

INSERT INTO Sessions (Date)
VALUES (GETDATE())


CREATE TABLE Movies(
Id int primary key identity,
Name nvarchar(50) not null,
GenresId int references Genres(Id)
)

INSERT INTO Movies (Name, GenresId)
VALUES ('Parasite', 2), ('The Prestije', 1), ('A beautiful mind', 5), ('Into the wild', 3), ('Your', 4)


CREATE TABLE MoviesActors(
Id int primary key identity,
MoviesId int references Movies(Id),
ActorsId int references Actors(Id)
)

INSERT INTO moviesActors (MoviesId, ActorsId)
VALUES (1, 2), (3, 4), (5,1), (4,3)


CREATE TABLE HallsSessions(
Id int primary key identity,
HallsId int references Halls(Id),
SessionsId int references Sessions(Id)
)

SELECT * FROM HallsSessions

INSERT INTO HallsSessions (HallsId, SessionsId)
VALUES (1, 2), (3, 2), (2,1), (2,3)

CREATE TABLE Tickets(
Id int primary key identity,
Price int not null,
MoviesId int references Movies(Id),
HallsId int references Halls(Id),
SessionsId int references Sessions(Id),
CustomersId int references Customers(Id)
)

INSERT INTO Tickets (Price, MoviesId, HallsId, SessionsId, CustomersId)
VALUES (10.00, 1, 2, 3, 4), (11.00, 2, 3, 3, 1), (10.00, 4, 2, 3, 2), (10.00, 1, 2, 1, 3), (10.00, 3, 2, 1, 4)


CREATE VIEW v_GetTicket
AS
SELECT Tickets.Price, Movies.Name 'Movie', Halls.Name 'Hall', Sessions.Date 'Sessions', Customers.Name, Customers.Surname FROM Tickets
FULL JOIN Movies
ON MoviesId=Movies.Id
FULL JOIN Halls
ON HallsId=Halls.Id
FULL JOIN Customers
ON CustomersId=Customers.Id
FULL JOIN Sessions
ON SessionsId=Sessions.Id

SELECT * FROM v_GetTicket