--Create 3 Tables (Products, Orders, Customers)

CREATE TABLE Products
(
	ProductID INT PRIMARY KEY IDENTITY(1,1),
	Name VARCHAR(25),
	Price MONEY
);
GO

CREATE TABLE Customers
(
	CustomerID INT PRIMARY KEY IDENTITY(1,1),
	FirstName VARCHAR(25),
	LastName VARCHAR(25),
	CardNumber BIGINT
);
GO

CREATE TABLE Orders
(
	OrderID INT PRIMARY KEY IDENTITY(1,1),
	ProductID INT,
	CustomerID INT,
	FOREIGN KEY (ProductID) REFERENCES dbo.Products(ProductID),
	FOREIGN KEY (CustomerID) REFERENCES dbo.Customers(CustomerID)
);
GO
--Add records to each table
INSERT INTO dbo.Products(Name, Price)
VALUES  ('iPhone', 199.99),
		('Samsung Galaxy', 749.99),
		('HTC M8', 719.99);

INSERT INTO dbo.Customers(FirstName, LastName, CardNumber)
VALUES	('James','Thompson',2947238759384758),
		('April', 'Lopez', 9485943293049376),
		('Tina', 'Smith', 9384758443847273);

INSERT INTO dbo.Orders(ProductID, CustomerID)
VALUES	(1,2),
		(1,3),
		(3,1);

--View all Purchases made by customer Tina Smith.
SELECT c.CustomerID, c.FirstName, c.LastName, c.CardNumber, o.OrderID, o.ProductID FROM dbo.Customers as c
JOIN dbo.Orders o
On c.CustomerID = o.CustomerID
Where c.FirstName = 'Tina' AND c.LastName = 'Smith';


--View the total revenue made by the iPhone product
SELECT SUM(p.Price) AS IphoneRevenue FROM dbo.Products AS p
JOIN dbo.Orders AS o 
ON p.ProductID = o.ProductID
GROUP BY p.Name
Having p.Name = 'iPhone';

--Udate the price of iPhone product
UPDATE dbo.Products
SET Price = 249.99
WHERE Name = 'iPhone';

SELECT * FROM dbo.Products;