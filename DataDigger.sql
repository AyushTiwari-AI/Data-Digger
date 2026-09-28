CREATE DATABASE DataDigger;

USE DataDigger;


-- CUSTOMERS TABLE

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Address VARCHAR(200)
);

INSERT INTO Customers (CustomerID, Name, Email, Address)
VALUES
(1, 'Ayush', 'ayush@gmail.com', 'Mumbai'),
(2, 'Raj', 'raj@gmail.com', 'Surat'),
(3, 'Alok', 'alok@gmail.com', 'Delhi'),
(4, 'Amit', 'amit@gmail.com', 'Ahmedabad'),
(5, 'Yash', 'yash@gmail.com', 'Pune');

SELECT * FROM Customers;

UPDATE Customers
SET Address = 'Bangalore'
WHERE CustomerID = 1;

SELECT *
FROM Customers
WHERE Name = 'Alice';


-- PRODUCTS TABLE

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Price DECIMAL(10,2),
    Stock INT
);

INSERT INTO Products (ProductID, ProductName, Price, Stock)
VALUES
(1, 'Saree', 1200, 10),
(2, 'Kurti', 800, 20),
(3, 'Lehenga', 2500, 5),
(4, 'Dupatta', 600, 15),
(5, 'Shirt', 1500, 0);

SELECT *
FROM Products
ORDER BY Price DESC;

UPDATE Products
SET Price = 1300
WHERE ProductID = 1;

SELECT *
FROM Products
WHERE Price BETWEEN 500 AND 2000;

SELECT MAX(Price) AS MostExpensive
FROM Products;

SELECT MIN(Price) AS Cheapest
FROM Products;


-- ORDERS TABLE

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    TotalAmount DECIMAL(10,2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

INSERT INTO Orders (OrderID, CustomerID, OrderDate, TotalAmount)
VALUES
(101, 1, '2026-09-25', 2400),
(102, 2, '2026-09-20', 1800),
(103, 3, '2026-09-15', 3200),
(104, 4, '2026-09-10', 1500),
(105, 1, '2026-08-20', 2700);

SELECT *
FROM Orders
WHERE CustomerID = 1;

UPDATE Orders
SET TotalAmount = 2500
WHERE OrderID = 101;

SELECT *
FROM Orders
WHERE OrderDate >= CURDATE() - INTERVAL 30 DAY;

SELECT MAX(TotalAmount) AS HighestOrder
FROM Orders;

SELECT MIN(TotalAmount) AS LowestOrder
FROM Orders;

SELECT AVG(TotalAmount) AS AverageOrder
FROM Orders;


-- ORDER DETAILS TABLE

CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    SubTotal DECIMAL(10,2),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

INSERT INTO OrderDetails (OrderDetailID, OrderID, ProductID, Quantity, SubTotal)
VALUES
(1, 101, 1, 2, 2600),
(2, 102, 2, 2, 1600),
(3, 103, 3, 1, 2500),
(4, 104, 4, 2, 1200),
(5, 105, 1, 1, 1200);

SELECT *
FROM OrderDetails
WHERE OrderID = 101;

SELECT SUM(SubTotal) AS TotalRevenue
FROM OrderDetails;

SELECT ProductID, SUM(Quantity) AS TotalQuantity
FROM OrderDetails
GROUP BY ProductID
ORDER BY TotalQuantity DESC
LIMIT 3;

SELECT COUNT(*) AS TimesSold
FROM OrderDetails
WHERE ProductID = 1;


-- CHECK ALL TABLES

SHOW TABLES;