--   Question 1
-- Achieving 1NF: Split products into separate rows for each order
SELECT OrderID, CustomerName, TRIM(product) AS Product
FROM ProductDetail
CROSS APPLY STRING_SPLIT(Products, ',');


-- Question 2
-- Creating Order table (for CustomerName)
CREATE TABLE OrderDetails (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(255)
);

-- Creating OrderItems table (for Product and Quantity)
CREATE TABLE OrderItems (
    OrderID INT,
    Product VARCHAR(255),
    Quantity INT,
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (OrderID) REFERENCES OrderDetails(OrderID)
);

-- Insert data into OrderDetails
INSERT INTO OrderDetails (OrderID, CustomerName)
SELECT DISTINCT OrderID, CustomerName
FROM OrderDetails;

-- Insert data into OrderItems
INSERT INTO OrderItems (OrderID, Product, Quantity)
SELECT OrderID, Product, Quantity
FROM OrderDetails;
