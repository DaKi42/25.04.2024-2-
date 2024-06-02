CREATE DATABASE Barbershop;
GO

USE Barbershop;
GO

-- DROP DATABASE Barbershop;
-- GO

CREATE TABLE CustomerProfiles (
    CustomerID INT PRIMARY KEY,
    FullName NVARCHAR(255),
    ContactPhone NVARCHAR(20),
    EmailAddress NVARCHAR(255)
);


CREATE TABLE EmployeeRoles (
    RoleID INT PRIMARY KEY,
    RoleTitle NVARCHAR(255)
);


CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FullName NVARCHAR(255),
    Gender CHAR(1),
    Phone NVARCHAR(20),
    Email NVARCHAR(255),
    DateOfBirth DATE,
    StartDate DATE,
    RoleID INT FOREIGN KEY REFERENCES EmployeeRoles(RoleID)
);

CREATE TABLE ServicesOffered (
    ServiceID INT PRIMARY KEY,
    ServiceName NVARCHAR(255),
    ServiceCost DECIMAL(10, 2),
    DurationMinutes INT
);


CREATE TABLE WorkSchedules (
    ScheduleID INT PRIMARY KEY,
    EmployeeID INT FOREIGN KEY REFERENCES Employees(EmployeeID),
    WorkDate DATE,
    StartTime TIME,
    EndTime TIME,
    CustomerID INT FOREIGN KEY REFERENCES CustomerProfiles(CustomerID)
);


CREATE TABLE CustomerFeedback (
    FeedbackID INT PRIMARY KEY,
    CustomerID INT FOREIGN KEY REFERENCES CustomerProfiles(CustomerID),
    EmployeeID INT FOREIGN KEY REFERENCES Employees(EmployeeID),
    CommentText NVARCHAR(MAX),
    Rating INT
);


CREATE TABLE EmployeePerformanceReviews (
    ReviewID INT PRIMARY KEY,
    EmployeeID INT FOREIGN KEY REFERENCES Employees(EmployeeID),
    CustomerID INT FOREIGN KEY REFERENCES CustomerProfiles(CustomerID),
    ReviewText NVARCHAR(MAX),
    Score INT
);


CREATE TABLE CustomerVisits (
    VisitID INT PRIMARY KEY,
    CustomerID INT FOREIGN KEY REFERENCES CustomerProfiles(CustomerID),
    EmployeeID INT FOREIGN KEY REFERENCES Employees(EmployeeID),
    ServiceID INT FOREIGN KEY REFERENCES ServicesOffered(ServiceID),
    VisitDate DATE,
    TotalCost DECIMAL(10, 2),
    VisitScore INT,
    Feedback NVARCHAR(MAX)
);


INSERT INTO EmployeeRoles (RoleID, RoleTitle) VALUES
(1, 'Chief Barber'),
(2, 'Senior Barber'),
(3, 'Junior Barber');


INSERT INTO Employees (EmployeeID, FullName, Gender, Phone, Email, DateOfBirth, StartDate, RoleID) VALUES
(1, 'Alexei Chicken', 'M', '123-456-7890', 'alexei.chicken@barbershop.com', '1978-05-21', '2015-01-01', 1),
(2, 'Ivan Petrov', 'M', '321-654-0987', 'ivan.petrov@barbershop.com', '1988-10-12', '2017-05-15', 2),
(3, 'Olga Sokolova', 'F', '456-123-7890', 'olga.sokolova@barbershop.com', '1992-03-08', '2020-06-20', 3),
(4, 'Marina Kudryashova', 'F', '234-567-8901', 'marina.kudryashova@barbershop.com', '1982-11-08', '2018-02-15', 2),
(5, 'Georgiy Kosichkin', 'M', '345-678-9012', 'georgiy.kosichkin@barbershop.com', '1996-04-22', '2021-08-01', 3);

INSERT INTO CustomerProfiles (CustomerID, FullName, ContactPhone, EmailAddress) VALUES
(1, 'Dmitry Mironov', '789-456-1230', 'dmitry.mironov@email.com'),
(2, 'Maria Vasilieva', '678-345-0123', 'maria.vasilieva@email.com'),
(3, 'Sergey Andreev', '567-234-9012', 'sergey.andreev@email.com'),
(4, 'Anton Zhukov', '890-123-4567', 'anton.zhukov@email.com'),
(5, 'Svetlana Morozova', '901-234-5678', 'svetlana.morozova@email.com'),
(6, 'Nikita Zaitsev', '912-345-6789', 'nikita.zaitsev@email.com'),
(7, 'Anna Kuznetsova', '923-456-7890', 'anna.kuznetsova@email.com');


INSERT INTO ServicesOffered (ServiceID, ServiceName, ServiceCost, DurationMinutes) VALUES
(1, 'Haircut', 1000.00, 60),
(2, 'Shaving', 500.00, 30),
(3, 'Styling', 800.00, 40),
(4, 'Coloring', 1500.00, 90),
(5, 'Beard Modeling', 600.00, 45),
(6, 'Gray Camouflage', 700.00, 40);

INSERT INTO CustomerFeedback (FeedbackID, CustomerID, EmployeeID, CommentText, Rating) VALUES
(1, 1, 1, 'Excellent haircut, as always!', 5),
(2, 2, 2, 'Ivan handled it professionally, but it was painful.', 3),
(3, 3, 3, 'Olga did a great styling job, I recommend her!', 5),
(4, 4, 4, 'Marina created the perfect look, thank you!', 5),
(5, 5, 5, 'Georgiy did a great job with the styling, will come again.', 5);

INSERT INTO EmployeePerformanceReviews (ReviewID, EmployeeID, CustomerID, ReviewText, Score) VALUES
(1, 1, 1, 'Chief Barber Alexei is top-notch!', 5),
(2, 2, 2, 'It was fun with Ivan, but the haircut could have been better.', 4),
(3, 4, 6, 'Marina is a real master, I recommend her!', 5),
(4, 5, 7, 'Georgiy has a gentle touch, no discomfort after the haircut.', 4);

INSERT INTO CustomerVisits (VisitID, CustomerID, EmployeeID, ServiceID, VisitDate, TotalCost, VisitScore, Feedback) VALUES
(1, 1, 1, 1, '2024-04-20', 1000.00, 5, 'It`s always a pleasure to talk with Alexei and the result is great!'),
(2, 2, 2, 3, '2024-04-21', 800.00, 5, 'Loved it, Ivan took all my preferences into account.'),
(3, 6, 4, 2, '2024-03-10', 500.00, 4, 'Ivan is a master of his craft, the shave was perfect.'),
(4, 7, 5, 5, '2024-03-12', 600.00, 4, 'Georgiy did everything quickly and efficiently.'),
(5, 4, 1, 3, '2024-03-15', 800.00, 5, 'Alexei knows exactly what he`s doing, the styling lasts all week!'),
(6, 5, 2, 6, '2024-03-17', 700.00, 5, 'Thanks to Marina for the great work, the gray is invisible!');


CREATE PROCEDURE GetAllEmployees AS
BEGIN
    SELECT FullName FROM Employees;
END;
GO

CREATE PROCEDURE GetSeniorEmployees AS
BEGIN
    SELECT * FROM Employees WHERE RoleID = 2; 
END;
GO


CREATE TABLE WorkSchedules (
    ScheduleID INT PRIMARY KEY,
    EmployeeID INT FOREIGN KEY REFERENCES Employees(EmployeeID),
    WorkDate DATE,
    StartTime TIME,
    EndTime TIME,
    CustomerID INT FOREIGN KEY REFERENCES CustomerProfiles(CustomerID)
);


CREATE TABLE CustomerFeedback (
    FeedbackID INT PRIMARY KEY,
    CustomerID INT FOREIGN KEY REFERENCES CustomerProfiles(CustomerID),
    EmployeeID INT FOREIGN KEY REFERENCES Employees(EmployeeID),
    CommentText NVARCHAR(MAX),
    Rating INT
);

CREATE TABLE EmployeePerformanceReviews (
    ReviewID INT PRIMARY KEY,
    EmployeeID INT FOREIGN KEY REFERENCES Employees(EmployeeID),
    CustomerID INT FOREIGN KEY REFERENCES CustomerProfiles(CustomerID),
    ReviewText NVARCHAR(MAX),
    Score INT
);


CREATE TABLE CustomerVisits (
    VisitID INT PRIMARY KEY,
    CustomerID INT FOREIGN KEY REFERENCES CustomerProfiles(CustomerID),
    EmployeeID INT FOREIGN KEY REFERENCES Employees(EmployeeID),
    ServiceID INT FOREIGN KEY REFERENCES ServicesOffered(ServiceID),
    VisitDate DATE,
    TotalCost DECIMAL(10, 2),
    VisitScore INT,
    Feedback NVARCHAR(MAX)
);


CREATE TRIGGER PreventChiefEmployeeDeletion
ON Employees
INSTEAD OF DELETE AS
BEGIN
    IF (SELECT COUNT(*) FROM Employees WHERE RoleID = 1) = 1
    BEGIN
        PRINT 'Cannot delete the only chief employee';
        ROLLBACK;
    END
END;
GO

CREATE TRIGGER PreventUnderageEmployee
ON Employees
INSTEAD OF INSERT AS
BEGIN
    DECLARE @date_of_birth DATE, @age INT;
    SELECT @date_of_birth = i.DateOfBirth FROM inserted i;
    SET @age = DATEDIFF(YEAR, @date_of_birth, GETDATE());
    
    IF @age < 21
    BEGIN
        PRINT 'Cannot add an employee younger than 21 years old';
        ROLLBACK;
    END
END;
GO

CREATE PROCEDURE GetEmployeesByService(@serviceName VARCHAR(100)) AS
BEGIN
    SELECT DISTINCT e.*
    FROM Employees e
    JOIN CustomerVisits v ON e.EmployeeID = v.EmployeeID
    JOIN ServicesOffered s ON v.ServiceID = s.ServiceID
    WHERE s.ServiceName = @serviceName;
END;
GO

CREATE PROCEDURE GetEmployeesByExperience(@years INT) AS
BEGIN
    SELECT * FROM Employees
    WHERE DATEDIFF(YEAR, StartDate, GETDATE()) > @years;
END;
GO

CREATE PROCEDURE GetEmployeeCounts AS
BEGIN
    SELECT 
        (SELECT COUNT(*) FROM Employees WHERE RoleID = 2) AS SeniorCount,
        (SELECT COUNT(*) FROM Employees WHERE RoleID = 3) AS JuniorCount;
END;
GO

CREATE PROCEDURE GetRegularCustomers(@visits INT) AS
BEGIN
    SELECT c.*
    FROM CustomerProfiles c
    JOIN (
        SELECT CustomerID, COUNT(*) AS VisitCount
        FROM CustomerVisits
        GROUP BY CustomerID
        HAVING COUNT(*) > @visits
    ) AS Visits ON c.CustomerID = Visits.CustomerID;
END;
GO

CREATE FUNCTION GetTopEmployeeByClientFeedback()
RETURNS TABLE
AS
RETURN
(
    SELECT TOP 1
        EmployeeID AS id,
        FullName AS name,
        Gender,
        Phone,
        Email,
        DateOfBirth,
        StartDate,
        RoleID,
        AVG(Rating) AS AvgRating
    FROM Employees e
    JOIN CustomerFeedback f ON e.EmployeeID = f.EmployeeID
    GROUP BY e.EmployeeID, e.FullName, e.Gender, e.Phone, e.Email, e.DateOfBirth, e.StartDate, e.RoleID
    ORDER BY AvgRating DESC
);

CREATE FUNCTION GetTopRegularCustomer()
RETURNS TABLE
AS
RETURN
(
    SELECT TOP 1
        CustomerID AS id,
        FullName AS name,
        ContactPhone AS phone,
        EmailAddress AS email,
        COUNT(VisitID) AS VisitCount
    FROM CustomerVisits v
    JOIN CustomerProfiles c ON v.CustomerID = c.CustomerID
    GROUP BY c.CustomerID, c.FullName, c.ContactPhone, c.EmailAddress
    ORDER BY VisitCount DESC
);

CREATE FUNCTION GetMostProfitableService()
RETURNS TABLE
AS
RETURN
(
    SELECT TOP 1
        ServiceID AS id,
        ServiceName AS name,
        ServiceCost AS price,
        DurationMinutes AS duration,
        SUM(TotalCost) AS TotalRevenue
    FROM ServicesOffered s
    JOIN CustomerVisits v ON s.ServiceID = v.ServiceID
    GROUP BY s.ServiceID, s.ServiceName, s.ServiceCost, s.DurationMinutes
    ORDER BY TotalRevenue DESC
);
