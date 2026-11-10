-- VERSION FOR MICROSOFT SQL SERVER MANAGEMENT STUDIO
-- PART 1 - SIRI
-- DROP TABLES - RUN FIRST

DROP TABLE IF EXISTS VendorOrder;
DROP TABLE IF EXISTS Cart;
DROP TABLE IF EXISTS Delivery;
DROP TABLE IF EXISTS OrderDetails;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS ProductStock;
DROP TABLE IF EXISTS Product;
DROP TABLE IF EXISTS Vendor;
DROP TABLE IF EXISTS Employee;
DROP TABLE IF EXISTS Customer;

-- PART 1 - CONSULTING TABLES

SELECT * FROM VendorOrder;
SELECT * FROM Cart;
SELECT * FROM Delivery;
SELECT * FROM OrderDetails;
SELECT * FROM Orders;
SELECT * FROM ProductStock;
SELECT * FROM Product;
SELECT * FROM Vendor;
SELECT * FROM Employee;
SELECT * FROM Customer;


-- PART 1 - CREATE TABLES - SIRI 

CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY,
    FName VARCHAR(50) NOT NULL,
    LName VARCHAR(50) NOT NULL,
    StreetAddress VARCHAR(100) NOT NULL,
    City VARCHAR(50) NOT NULL,
    Province VARCHAR(50) NOT NULL,
    PostalCode VARCHAR(15) NOT NULL,
    Phone VARCHAR(15),
    IsActive BIT NOT NULL,
    MemberSince DATE NOT NULL
);

CREATE TABLE Employee (
    EmployeeID INT PRIMARY KEY,
    FName VARCHAR(50) NOT NULL,
    LName VARCHAR(50) NOT NULL,
    EmployeePosition VARCHAR(50) NOT NULL,
    EmployeeLevel VARCHAR(50) NOT NULL,
    Salary DECIMAL(10,2) NOT NULL,
    EmployeePersonalPhone VARCHAR(15),
    EmployeeWorkPhone VARCHAR(15) NOT NULL,
    DrivingLicense VARCHAR(20),
    NationalID VARCHAR(20) NOT NULL,
    HiringDate DATE NOT NULL
);

CREATE TABLE Vendor (
    VendorID VARCHAR(10) PRIMARY KEY,
    VendorName VARCHAR(50) NOT NULL,
    VendorEmail VARCHAR(50) NOT NULL,
    VendorPhone VARCHAR(15) NOT NULL,
    VendorStatus BIT NOT NULL,
    StreetAddress VARCHAR(100) NOT NULL,
    City VARCHAR(50) NOT NULL,
    Province VARCHAR(50) NOT NULL,
    PostalCode VARCHAR(15) NOT NULL
);

CREATE TABLE Product (
    ProductID VARCHAR(10) PRIMARY KEY,
    VendorID VARCHAR(10) NOT NULL,
    ProductName VARCHAR(150) NOT NULL,
    ProductDescription VARCHAR(400),
    ProductCategory VARCHAR(100) NOT NULL,
    SubCategory VARCHAR(100),
    Price DECIMAL(8,2) NOT NULL,
    Writer VARCHAR(100) NOT NULL,
    HasDeal BIT,
    DiscountAmt DECIMAL(6,2),
    FOREIGN KEY (VendorID) REFERENCES Vendor(VendorID)
        ON UPDATE CASCADE
        ON DELETE NO ACTION
);

CREATE TABLE ProductStock (
    StockID VARCHAR(10) PRIMARY KEY,
    ProductID VARCHAR(10) NOT NULL,
    QtyInStock INT CHECK (QtyInStock >= 0),
    LastRestockDate DATETIME,
    WarehouseStreet VARCHAR(100) NOT NULL,
    WarehouseCity VARCHAR(50) NOT NULL,
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT NOT NULL,
    EmployeeID INT NOT NULL,
    OrderDate DATE NOT NULL,
    OrderStatus VARCHAR(20) NOT NULL,
    IsOnline BIT NOT NULL,
    Subtotal DECIMAL(10,2) NOT NULL,
    Tax DECIMAL(10,2) NOT NULL,
    Total DECIMAL(10,2) NOT NULL,
    PaymentType VARCHAR(20) NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
        ON UPDATE CASCADE
        ON DELETE NO ACTION,
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)
        ON UPDATE CASCADE
        ON DELETE NO ACTION
);

CREATE TABLE OrderDetails (
    DetailID VARCHAR(10) PRIMARY KEY,
    OrderID INT NOT NULL,
    ProductID VARCHAR(10) NOT NULL,
    Qty INT CHECK (Qty > 0),
    UnitPriceAtPurchase DECIMAL(8,2) NOT NULL,
    HasDealApplied BIT NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
        ON UPDATE CASCADE
        ON DELETE NO ACTION
);

CREATE TABLE Delivery (
    DeliveryID VARCHAR(10) PRIMARY KEY,
    OrderID INT NOT NULL,
    DriverID INT NOT NULL,
    Method VARCHAR(20) NOT NULL,
    DeliveryStatus VARCHAR(20) NOT NULL,
    Street VARCHAR(100) NOT NULL,
    City VARCHAR(50) NOT NULL,
    DeliveryFee DECIMAL(6,2),
    EstArrival DATETIME NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
        ON UPDATE NO ACTION
        ON DELETE CASCADE,
    FOREIGN KEY (DriverID) REFERENCES Employee(EmployeeID)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

CREATE TABLE Cart (
    CartID VARCHAR(10) PRIMARY KEY,
    CustomerID INT NOT NULL,
    ProductID VARCHAR(10) NOT NULL,
    Qty INT CHECK (Qty > 0),
    DateAdded DATETIME NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE VendorOrder (
    VendorOrderID VARCHAR(10) PRIMARY KEY,
    VendorID VARCHAR(10) NOT NULL,
    ProductID VARCHAR(10) NOT NULL,
    Qty INT CHECK (Qty > 0),
    UnitPrice DECIMAL(8,2) NOT NULL,
    Total DECIMAL(10,2) NOT NULL,
    OrderDate DATE NOT NULL,
    FOREIGN KEY (VendorID) REFERENCES Vendor(VendorID)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);


-- PART 2 - MOKSHA
-- INSERT DATA - MOKSHA

INSERT INTO Customer VALUES
(501, 'Joao', 'Silva', '123 Maple St', 'Toronto', 'ON', 'M5H2N2', '4165550101', 1, '2025-06-13'),
(502, 'Maria', 'Garcia', '456 Oak Ave', 'Vancouver', 'BC', 'V5K0A1', '6045550202', 1, '2025-02-13'),
(503, 'David', 'Lee', '789 Pine St', 'Calgary', 'AB', 'T2P1J9', '4035550303', 1, '2024-11-10'),
(504, 'Sophia', 'Brown', '321 Cedar Rd', 'Ottawa', 'ON', 'K1A0B1', '6135550404', 0, '2023-08-22'),
(505, 'Liam', 'White', '654 Birch Ln', 'Toronto', 'ON', 'M4B1B3', '4165550505', 1, '2026-01-05');

INSERT INTO Employee VALUES
(201, 'Alice', 'Wong', 'Manager', 'Senior', 65000, '4165550202', '4165551000', 'AB123456', '987654321', '2024-01-15'),
(202, 'Richard', 'Johnson', 'Cashier', 'Junior', 35000, NULL, '4165552000', NULL, '123456789', '2023-05-10'),
(203, 'Mark', 'Taylor', 'Driver', 'Mid', 40000, '4165550303', '4165553000', 'DL789456', '456123789', '2022-07-01'),
(204, 'Emily', 'Clark', 'Sales', 'Junior', 38000, NULL, '4165554000', NULL, '789456123', '2023-09-15'),
(205, 'Daniel', 'Evans', 'Support', 'Mid', 42000, '4165550505', '4165555000', NULL, '321654987', '2021-03-20');

INSERT INTO Vendor VALUES
('V101', 'TechBooks Inc', 'sales@tech.com', '8005550199', 1, '789 Industrial Way', 'Ottawa', 'ON', 'K1P5J2'),
('V102', 'EduWorld', 'contact@edu.com', '8005550111', 1, '12 Learning St', 'Toronto', 'ON', 'M1A1A1'),
('V103', 'BookHub', 'info@hub.com', '8005550222', 1, '45 Book Rd', 'Montreal', 'QC', 'H2X1Y4'),
('V104', 'ReadMore', 'support@read.com', '8005550333', 0, '78 Read St', 'Vancouver', 'BC', 'V5K0A1'),
('V105', 'GlobalBooks', 'global@books.com', '8005550444', 1, '99 Global Ave', 'Calgary', 'AB', 'T2P1J9');

INSERT INTO Product VALUES
('P01', 'V101', 'The Python Guide', 'Learn Python fast', 'Education', 'Programming', 45.00, 'J. Doe', 1, 5.00),
('P02', 'V101', 'Advanced AI', 'AI concepts', 'Education', 'AI', 75.00, 'A. Smith', 0, NULL),
('P03', 'V102', 'SQL Basics', 'Intro to SQL', 'Education', 'Database', 30.00, 'B. Lee', 1, 3.00),
('P04', 'V103', 'Data Science 101', 'Basics of DS', 'Education', 'Analytics', 55.00, 'C. Kim', 0, NULL),
('P05', 'V105', 'Business Analytics', 'Business insights', 'Education', 'Business', 50.00, 'D. Brown', 1, 5.00);

INSERT INTO ProductStock VALUES
('S901', 'P01', 150, '2026-03-25T10:00:00', '99 Warehouse Rd', 'Mississauga'),
('S902', 'P02', 100, '2026-03-20T11:00:00', '88 Storage St', 'Toronto'),
('S903', 'P03', 120, '2026-03-18T12:00:00', '77 Depot Rd', 'Brampton'),
('S904', 'P04', 80, '2026-03-15T13:00:00', '66 Supply Ln', 'Ottawa'),
('S905', 'P05', 90, '2026-03-10T14:00:00', '55 Warehouse Ave', 'Calgary');

INSERT INTO Orders VALUES
(1001, 501, 202, '2026-03-29', 'Pending', 1, 40.00, 5.20, 45.20, 'Credit'),
(1002, 502, 202, '2026-03-30', 'Completed', 1, 55.00, 3.50, 58.50, 'Cash'),
(1003, 501, 202, '2026-03-30', 'Pending', 0, 270.00, 30.50, 300.50, 'Debit'),
(1004, 503, 204, '2026-04-01', 'Completed', 1, 75.00, 7.50, 82.50, 'Credit'),
(1005, 505, 201, '2026-04-02', 'Pending', 1, 50.00, 5.00, 55.00, 'Online');

INSERT INTO OrderDetails VALUES
('D7001', 1001, 'P01', 1, 40.00, 1),
('D7002', 1002, 'P04', 1, 55.00, 0),
('D7003', 1003, 'P02', 3, 75.00, 0),
('D7004', 1003, 'P01', 1, 45.00, 1),
('D7005', 1004, 'P02', 1, 75.00, 0);

INSERT INTO Delivery VALUES
('DEL88', 1001, 203, 'Courier', 'Pending', '123 Maple St', 'Toronto', 5.00, '2026-04-01T10:00:00'),
('DEL89', 1002, 203, 'Courier', 'Delivered', '456 Oak Ave', 'Vancouver', 3.50, '2026-04-02T11:00:00'),
('DEL90', 1003, 203, 'Courier', 'Pending', '123 Maple St', 'Toronto', 6.00, '2026-04-03T12:00:00'),
('DEL91', 1004, 203, 'Courier', 'Delivered', '789 Pine St', 'Calgary', 5.00, '2026-04-04T13:00:00'),
('DEL92', 1005, 203, 'Courier', 'Pending', '654 Birch Ln', 'Toronto', 4.00, '2026-04-05T14:00:00');

INSERT INTO Cart VALUES
('C332', 501, 'P01', 1, '2026-03-29T14:00:00'),
('C333', 502, 'P03', 2, '2026-03-30T15:00:00'),
('C334', 503, 'P04', 1, '2026-03-31T16:00:00'),
('C335', 504, 'P02', 3, '2026-04-01T17:00:00'),
('C336', 505, 'P05', 2, '2026-04-02T18:00:00');

INSERT INTO VendorOrder VALUES
('VO500', 'V101', 'P01', 100, 25.00, 2500.00, '2026-03-15'),
('VO501', 'V101', 'P02', 50, 40.00, 2000.00, '2026-03-16'),
('VO502', 'V101', 'P01', 30, 25.00, 750.00, '2026-03-20'),
('VO503', 'V102', 'P03', 60, 20.00, 1200.00, '2026-03-18'),
('VO504', 'V105', 'P05', 80, 30.00, 2400.00, '2026-03-22');

-- PART 3 - DATA MANIPULATION - MARCIO
-- 3.1 INSERT - ADD A NEW CUSTMER

INSERT INTO Customer (
    CustomerID,
    FName,
    LName,
    StreetAddress,
    City,
    Province,
    PostalCode,
    Phone,
    IsActive,
    MemberSince
)
VALUES (
    506,
    'Emma',
    'Taylor',
    '22 King St',
    'Toronto',
    'ON',
    'M5V1K4',
    '4165550606',
    1,
    '2026-04-10'
);

-- CHECK INSERTED

SELECT * FROM Customer
WHERE CustomerID = 506;

-- 3.2 UPDATE - UPDATE A PRODUCT PRICE

UPDATE Product
SET Price = 48.00
WHERE ProductID = 'P01';

-- CEHCK UPDATE - UPDATE A PRODUCT

SELECT ProductID, ProductName, Price
FROM Product
WHERE ProductID = 'P01';


-- 3.3 DELETE - DELETE ONE CART ITEM

DELETE FROM Cart
WHERE CartID = 'C336';

-- CHECK IF DELETED

SELECT * FROM Cart
WHERE CartID = 'C336';

-- PART 4 - SQL QUERIES - JOÃO
-- 4.1 BASIC SELECT - SHOW ALL CUSTOMERS

SELECT * FROM Customer;

-- 4.2 INNER JOIN - ORDERS WITH CUSTOMER NAMES

SELECT
    o.OrderID,
    c.CustomerID,
    c.FName,
    c.LName,
    o.OrderDate,
    o.OrderStatus,
    o.Total
FROM Orders o
INNER JOIN Customer c
    ON o.CustomerID = c.CustomerID;


-- 4.3 LEFT JOIN - PRODUCTS WITH STOCK INFORMATION

SELECT
    p.ProductID,
    p.ProductName,
    p.Price,
    ps.QtyInStock
FROM Product p
LEFT JOIN ProductStock ps
    ON p.ProductID = ps.ProductID;


-- 4.4 GROUP BY + COUNT - Nº OF ORDERS PER CUSTOMER

SELECT
    CustomerID,
    COUNT(*) AS TotalOrders
FROM Orders
GROUP BY CustomerID;


-- 4.5 GROUP BY + SUM - TOTAL SALES BY ORDER STATUS

SELECT
    OrderStatus,
    SUM(Total) AS TotalSales
FROM Orders
GROUP BY OrderStatus;


-- 4.6 SUBQUERY - PRODUCTS ABOVE AVERAGE PRICE

SELECT
    ProductID,
    ProductName,
    Price
FROM Product
WHERE Price > (
    SELECT AVG(Price)
    FROM Product
);


-- 4.7 BUSINESS QUERY - CUSTOMER WITH MORE THAN ONE ORDER

SELECT
    c.CustomerID,
    c.FName,
    c.LName,
    COUNT(o.OrderID) AS NumberOfOrders
FROM Customer c
INNER JOIN Orders o
    ON c.CustomerID = o.CustomerID
GROUP BY
    c.CustomerID,
    c.FName,
    c.LName
HAVING COUNT(o.OrderID) > 1;


-- 4.8 BUSINESS QUERY - TOTAL QUANTITY SOLD BY PRODUCT

SELECT
    p.ProductID,
    p.ProductName,
    SUM(od.Qty) AS TotalQtySold
FROM Product p
INNER JOIN OrderDetails od
    ON p.ProductID = od.ProductID
GROUP BY
    p.ProductID,
    p.ProductName;


-- 4.9 BUSINESS QUERY - DELIVERED ORDER WITH DRIVER NAME

SELECT
    d.DeliveryID,
    o.OrderID,
    e.FName,
    e.LName,
    d.DeliveryStatus,
    d.City,
    d.DeliveryFee
FROM Delivery d
INNER JOIN Orders o
    ON d.OrderID = o.OrderID
INNER JOIN Employee e
    ON d.DriverID = e.EmployeeID
WHERE d.DeliveryStatus = 'Delivered';


-- PART 5 - TRANSACTION MANAGEMENT - MARCIO
-- 5.1 TRANSACTION WITH COMMIT - UPDATE ORDER STATUS PERMANENTLY

BEGIN TRANSACTION;

UPDATE Orders
SET OrderStatus = 'Completed'
WHERE OrderID = 1001;

COMMIT;

-- CHECK COMMITTED RESULT

SELECT OrderID, OrderStatus
FROM Orders
WHERE OrderID = 1001;


-- 5.2 TRANSACTION WITH ROLLBACK - TEMPORARY PRICE CHANGE
BEGIN TRANSACTION;

UPDATE Product
SET Price = 99.99
WHERE ProductID = 'P03';

ROLLBACK;

-- CHECK ROLLED BACK RESUL

SELECT ProductID, ProductName, Price
FROM Product
WHERE ProductID = 'P03';


-- 5.3 TRANSACTION WITH DELETE AND ROLLBACK - UNDO DELETION

BEGIN TRANSACTION;

DELETE FROM Cart
WHERE CartID = 'C333';

ROLLBACK;

-- CHECK ROLLED BACK RESULT
SELECT *
FROM Cart
WHERE CartID = 'C333';






























-- VERSION FOR MYSQL
-- PART 1 - DROP TABLES (RUN FIRST)
-- -----------------------------------------

DROP TABLE IF EXISTS VendorOrder;
DROP TABLE IF EXISTS Cart;
DROP TABLE IF EXISTS Delivery;
DROP TABLE IF EXISTS OrderDetails;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS ProductStock;
DROP TABLE IF EXISTS Product;
DROP TABLE IF EXISTS Vendor;
DROP TABLE IF EXISTS Employee;
DROP TABLE IF EXISTS Customer;

-- -----------------------------------------
-- PART 1 - CREATE TABLES - SIRI 
-- -----------------------------------------

CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY,
    FName VARCHAR(50) NOT NULL,
    LName VARCHAR(50) NOT NULL,
    StreetAddress VARCHAR(100) NOT NULL,
    City VARCHAR(50) NOT NULL,
    Province VARCHAR(50) NOT NULL,
    PostalCode VARCHAR(15) NOT NULL,
    Phone VARCHAR(15),
    IsActive BOOLEAN NOT NULL,
    MemberSince DATE NOT NULL
);

CREATE TABLE Employee (
    EmployeeID INT PRIMARY KEY,
    FName VARCHAR(50) NOT NULL,
    LName VARCHAR(50) NOT NULL,
    EmployeePosition VARCHAR(50) NOT NULL,
    EmployeeLevel VARCHAR(50) NOT NULL,
    Salary DECIMAL(10,2) NOT NULL,
    EmployeePersonalPhone VARCHAR(15),
    EmployeeWorkPhone VARCHAR(15) NOT NULL,
    DrivingLicense VARCHAR(20),
    NationalID VARCHAR(20) NOT NULL,
    HiringDate DATE NOT NULL
);

CREATE TABLE Vendor (
    VendorID VARCHAR(10) PRIMARY KEY,
    VendorName VARCHAR(50) NOT NULL,
    VendorEmail VARCHAR(50) NOT NULL,
    VendorPhone VARCHAR(15) NOT NULL,
    VendorStatus BOOLEAN NOT NULL,
    StreetAddress VARCHAR(100) NOT NULL,
    City VARCHAR(50) NOT NULL,
    Province VARCHAR(50) NOT NULL,
    PostalCode VARCHAR(15) NOT NULL
);

CREATE TABLE Product (
    ProductID VARCHAR(10) PRIMARY KEY,
    VendorID VARCHAR(10) NOT NULL,
    ProductName VARCHAR(150) NOT NULL,
    ProductDescription VARCHAR(400),
    ProductCategory VARCHAR(100) NOT NULL,
    SubCategory VARCHAR(100),
    Price DECIMAL(8,2) NOT NULL,
    Writer VARCHAR(100) NOT NULL,
    HasDeal BOOLEAN,
    DiscountAmt DECIMAL(6,2),
    CONSTRAINT fk_product_vendor
        FOREIGN KEY (VendorID) REFERENCES Vendor(VendorID)
        ON UPDATE CASCADE
        ON DELETE NO ACTION
);

CREATE TABLE ProductStock (
    StockID VARCHAR(10) PRIMARY KEY,
    ProductID VARCHAR(10) NOT NULL,
    QtyInStock INT CHECK (QtyInStock >= 0),
    LastRestockDate DATETIME,
    WarehouseStreet VARCHAR(100) NOT NULL,
    WarehouseCity VARCHAR(50) NOT NULL,
    CONSTRAINT fk_productstock_product
        FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT NOT NULL,
    EmployeeID INT NOT NULL,
    OrderDate DATE NOT NULL,
    OrderStatus VARCHAR(20) NOT NULL,
    IsOnline BOOLEAN NOT NULL,
    Subtotal DECIMAL(10,2) NOT NULL,
    Tax DECIMAL(10,2) NOT NULL,
    Total DECIMAL(10,2) NOT NULL,
    PaymentType VARCHAR(20) NOT NULL,
    CONSTRAINT fk_orders_customer
        FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
        ON UPDATE CASCADE
        ON DELETE NO ACTION,
    CONSTRAINT fk_orders_employee
        FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)
        ON UPDATE CASCADE
        ON DELETE NO ACTION
);

CREATE TABLE OrderDetails (
    DetailID VARCHAR(10) PRIMARY KEY,
    OrderID INT NOT NULL,
    ProductID VARCHAR(10) NOT NULL,
    Qty INT CHECK (Qty > 0),
    UnitPriceAtPurchase DECIMAL(8,2) NOT NULL,
    HasDealApplied BOOLEAN NOT NULL,
    CONSTRAINT fk_orderdetails_order
        FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT fk_orderdetails_product
        FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
        ON UPDATE CASCADE
        ON DELETE NO ACTION
);

CREATE TABLE Delivery (
    DeliveryID VARCHAR(10) PRIMARY KEY,
    OrderID INT NOT NULL,
    DriverID INT NOT NULL,
    Method VARCHAR(20) NOT NULL,
    DeliveryStatus VARCHAR(20) NOT NULL,
    Street VARCHAR(100) NOT NULL,
    City VARCHAR(50) NOT NULL,
    DeliveryFee DECIMAL(6,2),
    EstArrival DATETIME NOT NULL,
    CONSTRAINT fk_delivery_order
        FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
        ON UPDATE NO ACTION
        ON DELETE CASCADE,
    CONSTRAINT fk_delivery_driver
        FOREIGN KEY (DriverID) REFERENCES Employee(EmployeeID)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

CREATE TABLE Cart (
    CartID VARCHAR(10) PRIMARY KEY,
    CustomerID INT NOT NULL,
    ProductID VARCHAR(10) NOT NULL,
    Qty INT CHECK (Qty > 0),
    DateAdded DATETIME NOT NULL,
    CONSTRAINT fk_cart_customer
        FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT fk_cart_product
        FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE VendorOrder (
    VendorOrderID VARCHAR(10) PRIMARY KEY,
    VendorID VARCHAR(10) NOT NULL,
    ProductID VARCHAR(10) NOT NULL,
    Qty INT CHECK (Qty > 0),
    UnitPrice DECIMAL(8,2) NOT NULL,
    Total DECIMAL(10,2) NOT NULL,
    OrderDate DATE NOT NULL,
    CONSTRAINT fk_vendororder_vendor
        FOREIGN KEY (VendorID) REFERENCES Vendor(VendorID)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_vendororder_product
        FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

-- -----------------------------------------
-- -- PART 2 - INSERT DATA - MOKSHA
-- -----------------------------------------

INSERT INTO Customer VALUES
(501, 'Joao', 'Silva', '123 Maple St', 'Toronto', 'ON', 'M5H2N2', '4165550101', TRUE, '2025-06-13'),
(502, 'Maria', 'Garcia', '456 Oak Ave', 'Vancouver', 'BC', 'V5K0A1', '6045550202', TRUE, '2025-02-13'),
(503, 'David', 'Lee', '789 Pine St', 'Calgary', 'AB', 'T2P1J9', '4035550303', TRUE, '2024-11-10'),
(504, 'Sophia', 'Brown', '321 Cedar Rd', 'Ottawa', 'ON', 'K1A0B1', '6135550404', FALSE, '2023-08-22'),
(505, 'Liam', 'White', '654 Birch Ln', 'Toronto', 'ON', 'M4B1B3', '4165550505', TRUE, '2026-01-05');

INSERT INTO Employee VALUES
(201, 'Alice', 'Wong', 'Manager', 'Senior', 65000, '4165550202', '4165551000', 'AB123456', '987654321', '2024-01-15'),
(202, 'Richard', 'Johnson', 'Cashier', 'Junior', 35000, NULL, '4165552000', NULL, '123456789', '2023-05-10'),
(203, 'Mark', 'Taylor', 'Driver', 'Mid', 40000, '4165550303', '4165553000', 'DL789456', '456123789', '2022-07-01'),
(204, 'Emily', 'Clark', 'Sales', 'Junior', 38000, NULL, '4165554000', NULL, '789456123', '2023-09-15'),
(205, 'Daniel', 'Evans', 'Support', 'Mid', 42000, '4165550505', '4165555000', NULL, '321654987', '2021-03-20');

INSERT INTO Vendor VALUES
('V101', 'TechBooks Inc', 'sales@tech.com', '8005550199', TRUE, '789 Industrial Way', 'Ottawa', 'ON', 'K1P5J2'),
('V102', 'EduWorld', 'contact@edu.com', '8005550111', TRUE, '12 Learning St', 'Toronto', 'ON', 'M1A1A1'),
('V103', 'BookHub', 'info@hub.com', '8005550222', TRUE, '45 Book Rd', 'Montreal', 'QC', 'H2X1Y4'),
('V104', 'ReadMore', 'support@read.com', '8005550333', FALSE, '78 Read St', 'Vancouver', 'BC', 'V5K0A1'),
('V105', 'GlobalBooks', 'global@books.com', '8005550444', TRUE, '99 Global Ave', 'Calgary', 'AB', 'T2P1J9');

INSERT INTO Product VALUES
('P01', 'V101', 'The Python Guide', 'Learn Python fast', 'Education', 'Programming', 45.00, 'J. Doe', TRUE, 5.00),
('P02', 'V101', 'Advanced AI', 'AI concepts', 'Education', 'AI', 75.00, 'A. Smith', FALSE, NULL),
('P03', 'V102', 'SQL Basics', 'Intro to SQL', 'Education', 'Database', 30.00, 'B. Lee', TRUE, 3.00),
('P04', 'V103', 'Data Science 101', 'Basics of DS', 'Education', 'Analytics', 55.00, 'C. Kim', FALSE, NULL),
('P05', 'V105', 'Business Analytics', 'Business insights', 'Education', 'Business', 50.00, 'D. Brown', TRUE, 5.00);

INSERT INTO ProductStock VALUES
('S901', 'P01', 150, '2026-03-25 10:00:00', '99 Warehouse Rd', 'Mississauga'),
('S902', 'P02', 100, '2026-03-20 11:00:00', '88 Storage St', 'Toronto'),
('S903', 'P03', 120, '2026-03-18 12:00:00', '77 Depot Rd', 'Brampton'),
('S904', 'P04', 80, '2026-03-15 13:00:00', '66 Supply Ln', 'Ottawa'),
('S905', 'P05', 90, '2026-03-10 14:00:00', '55 Warehouse Ave', 'Calgary');

INSERT INTO Orders VALUES
(1001, 501, 202, '2026-03-29', 'Pending', TRUE, 40.00, 5.20, 45.20, 'Credit'),
(1002, 502, 202, '2026-03-30', 'Completed', TRUE, 55.00, 3.50, 58.50, 'Cash'),
(1003, 501, 202, '2026-03-30', 'Pending', FALSE, 270.00, 30.50, 300.50, 'Debit'),
(1004, 503, 204, '2026-04-01', 'Completed', TRUE, 75.00, 7.50, 82.50, 'Credit'),
(1005, 505, 201, '2026-04-02', 'Pending', TRUE, 50.00, 5.00, 55.00, 'Online');

INSERT INTO OrderDetails VALUES
('D7001', 1001, 'P01', 1, 40.00, TRUE),
('D7002', 1002, 'P04', 1, 55.00, FALSE),
('D7003', 1003, 'P02', 3, 75.00, FALSE),
('D7004', 1003, 'P01', 1, 45.00, TRUE),
('D7005', 1004, 'P02', 1, 75.00, FALSE);

INSERT INTO Delivery VALUES
('DEL88', 1001, 203, 'Courier', 'Pending', '123 Maple St', 'Toronto', 5.00, '2026-04-01 10:00:00'),
('DEL89', 1002, 203, 'Courier', 'Delivered', '456 Oak Ave', 'Vancouver', 3.50, '2026-04-02 11:00:00'),
('DEL90', 1003, 203, 'Courier', 'Pending', '123 Maple St', 'Toronto', 6.00, '2026-04-03 12:00:00'),
('DEL91', 1004, 203, 'Courier', 'Delivered', '789 Pine St', 'Calgary', 5.00, '2026-04-04 13:00:00'),
('DEL92', 1005, 203, 'Courier', 'Pending', '654 Birch Ln', 'Toronto', 4.00, '2026-04-05 14:00:00');

INSERT INTO Cart VALUES
('C332', 501, 'P01', 1, '2026-03-29 14:00:00'),
('C333', 502, 'P03', 2, '2026-03-30 15:00:00'),
('C334', 503, 'P04', 1, '2026-03-31 16:00:00'),
('C335', 504, 'P02', 3, '2026-04-01 17:00:00'),
('C336', 505, 'P05', 2, '2026-04-02 18:00:00');

INSERT INTO VendorOrder VALUES
('VO500', 'V101', 'P01', 100, 25.00, 2500.00, '2026-03-15'),
('VO501', 'V101', 'P02', 50, 40.00, 2000.00, '2026-03-16'),
('VO502', 'V101', 'P01', 30, 25.00, 750.00, '2026-03-20'),
('VO503', 'V102', 'P03', 60, 20.00, 1200.00, '2026-03-18'),
('VO504', 'V105', 'P05', 80, 30.00, 2400.00, '2026-03-22');

-- -----------------------------------------
-- -- PART 3 - DATA MANIPULATION - MARCIO
-- -----------------------------------------

-- 3.1 INSERT - ADD A NEW CUSTOMER

INSERT INTO Customer (
    CustomerID,
    FName,
    LName,
    StreetAddress,
    City,
    Province,
    PostalCode,
    Phone,
    IsActive,
    MemberSince
)
VALUES (
    506,
    'Emma',
    'Taylor',
    '22 King St',
    'Toronto',
    'ON',
    'M5V1K4',
    '4165550606',
    TRUE,
    '2026-04-10'
);

-- CHECK INSERTED
SELECT * 
FROM Customer
WHERE CustomerID = 506;

-- 3.2 UPDATE - UPDATE A PRODUCT PRICE

UPDATE Product
SET Price = 48.00
WHERE ProductID = 'P01';

-- CHECK UPDATE
SELECT ProductID, ProductName, Price
FROM Product
WHERE ProductID = 'P01';

-- 3.3 DELETE - DELETE ONE CART ITEM

DELETE FROM Cart
WHERE CartID = 'C336';

-- CHECK IF DELETED
SELECT *
FROM Cart
WHERE CartID = 'C336';

-- -----------------------------------------
-- -- PART 4 - SQL QUERIES - JOÃO
-- -----------------------------------------

-- 4.1 BASIC SELECT - SHOW ALL CUSTOMERS
SELECT * FROM Customer;

-- 4.2 INNER JOIN - ORDERS WITH CUSTOMER NAMES
SELECT
    o.OrderID,
    c.CustomerID,
    c.FName,
    c.LName,
    o.OrderDate,
    o.OrderStatus,
    o.Total
FROM Orders o
INNER JOIN Customer c
    ON o.CustomerID = c.CustomerID;

-- 4.3 LEFT JOIN - PRODUCTS WITH STOCK INFORMATION
SELECT
    p.ProductID,
    p.ProductName,
    p.Price,
    ps.QtyInStock
FROM Product p
LEFT JOIN ProductStock ps
    ON p.ProductID = ps.ProductID;

-- 4.4 GROUP BY + COUNT - NUMBER OF ORDERS PER CUSTOMER
SELECT
    CustomerID,
    COUNT(*) AS TotalOrders
FROM Orders
GROUP BY CustomerID;

-- 4.5 GROUP BY + SUM - TOTAL SALES BY ORDER STATUS
SELECT
    OrderStatus,
    SUM(Total) AS TotalSales
FROM Orders
GROUP BY OrderStatus;

-- 4.6 SUBQUERY - PRODUCTS ABOVE AVERAGE PRICE
SELECT
    ProductID,
    ProductName,
    Price
FROM Product
WHERE Price > (
    SELECT AVG(Price)
    FROM Product
);

-- 4.7 BUSINESS QUERY - CUSTOMER WITH MORE THAN ONE ORDER
SELECT
    c.CustomerID,
    c.FName,
    c.LName,
    COUNT(o.OrderID) AS NumberOfOrders
FROM Customer c
INNER JOIN Orders o
    ON c.CustomerID = o.CustomerID
GROUP BY
    c.CustomerID,
    c.FName,
    c.LName
HAVING COUNT(o.OrderID) > 1;

-- 4.8 BUSINESS QUERY - TOTAL QUANTITY SOLD BY PRODUCT
SELECT
    p.ProductID,
    p.ProductName,
    SUM(od.Qty) AS TotalQtySold
FROM Product p
INNER JOIN OrderDetails od
    ON p.ProductID = od.ProductID
GROUP BY
    p.ProductID,
    p.ProductName;

-- 4.9 BUSINESS QUERY - DELIVERED ORDER WITH DRIVER NAME
SELECT
    d.DeliveryID,
    o.OrderID,
    e.FName,
    e.LName,
    d.DeliveryStatus,
    d.City,
    d.DeliveryFee
FROM Delivery d
INNER JOIN Orders o
    ON d.OrderID = o.OrderID
INNER JOIN Employee e
    ON d.DriverID = e.EmployeeID
WHERE d.DeliveryStatus = 'Delivered';

-- -----------------------------------------
-- PART 5 - TRANSACTION MANAGEMENT - MARCIO
-- -----------------------------------------

-- 5.1 TRANSACTION WITH COMMIT - UPDATE ORDER STATUS PERMANENTLY
START TRANSACTION;

UPDATE Orders
SET OrderStatus = 'Completed'
WHERE OrderID = 1001;

COMMIT;

-- CHECK COMMITTED RESULT
SELECT OrderID, OrderStatus
FROM Orders
WHERE OrderID = 1001;

-- 5.2 TRANSACTION WITH ROLLBACK - TEMPORARY PRICE CHANGE
START TRANSACTION;

UPDATE Product
SET Price = 99.99
WHERE ProductID = 'P03';

ROLLBACK;

-- CHECK ROLLED BACK RESULT
SELECT ProductID, ProductName, Price
FROM Product
WHERE ProductID = 'P03';

-- 5.3 TRANSACTION WITH DELETE AND ROLLBACK - UNDO DELETION
START TRANSACTION;

DELETE FROM Cart
WHERE CartID = 'C333';

ROLLBACK;

-- CHECK ROLLED BACK RESULT
SELECT *
FROM Cart
WHERE CartID = 'C333';

-- -----------------------------------------
-- OPTIONAL CONSULTING QUERIES (RUN AFTER EVERYTHING)
-- -----------------------------------------

SELECT * FROM VendorOrder;
SELECT * FROM Cart;
SELECT * FROM Delivery;
SELECT * FROM OrderDetails;
SELECT * FROM Orders;
SELECT * FROM ProductStock;
SELECT * FROM Product;
SELECT * FROM Vendor;
SELECT * FROM Employee;
SELECT * FROM Customer;