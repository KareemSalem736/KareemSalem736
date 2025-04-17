SELECT 
    CustomerID AS "Account Number", 
    Name AS "Customer Name", 
    SUBSTR(Address, 1, INSTR(Address, ',') - 1) AS "Street", 
    SUBSTR(Address, -5) AS "ZIP Code"
FROM 
    Customer
ORDER BY 
    CustomerID;

SELECT 
    Rental.RentalID,
    Rental.CopyID,
    Movie.Title,
    Customer.Name AS "Customer",
    Rental.CheckoutDate
FROM 
    Rental
    JOIN Copy ON Rental.CopyID = Copy.CopyID
    JOIN Movie ON Copy.MovieID = Movie.MovieID
    JOIN Customer ON Rental.CustomerID = Customer.CustomerID
WHERE 
    CheckoutDate >= SYSDATE - 30
ORDER BY 
    CheckoutDate;

SELECT 
    DistributorID, 
    Name 
FROM 
    Distributor
ORDER BY 
    Name;

UPDATE Customer 
SET Name = 'Alice Thompson' 
WHERE CustomerID = 201;

DELETE FROM Customer 
WHERE CustomerID = 204;

ROLLBACK;
