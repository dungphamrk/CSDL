CREATE TABLE InvoiceDetails (
    InvoiceID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL,
    PRIMARY KEY (InvoiceID, ProductID),
    FOREIGN KEY (InvoiceID) REFERENCES Bill(id),
    FOREIGN KEY (ProductID) REFERENCES product(id) 
);

SELECT 
    b.id AS InvoiceID,
    b.create_date AS CreateDate,
    c.name AS CustomerName,
    c.phoneNumber AS CustomerPhone,
    p.name AS ProductName,
    p.price AS ProductPrice,
    p.quantity AS ProductStock,
    d.Quantity AS QuantityOrdered
FROM 
    InvoiceDetails d
JOIN 
    Bill b ON d.InvoiceID = b.id
JOIN 
    Customer c ON b.customer_id = c.id
JOIN 
    product p ON d.ProductID = p.id; 
