CREATE TABLE Distriutor
    primary key DistriutorID    NUMBER,
    Name    VARCHAR2(100);

CREATE TABLE Catalog
    foreign key (DistributorID + CopyID )   NUMBER,
    foreign key DistributorID    NUMBER,
    foreign key CopyID  NUMBER,
    WholesalePrice  NUMBER;

CREATE TABLE Movie
    primary key MovieID NUMBER,
    Title   VARCHAR2(150),
    Length  NUMBER,
    Type    NUMBER(50),
    Rating  VARCHAR2(5),
    ReleaseDate DATE;

CREATE TABLE MovieStaff
    primary key MovieStaffID    Number,
    foreign key StaffID     NUMBER,
    foreign key MovieID     NUMBER,
    Role    VARCHAR2(50);

CREATE TABLE Staff
    primary key StaffID     NUMBER,
    Name    VARCHAR2(100);

CREATE TABLE Award
    primary key AwardID     NUMBER,
    foreign key MovieID     NUMBER/NULL,
    foreign key StaffID     NUMBER/NULL,
    Name    VARCHAR2(100),
    Year    NUMBER(4);

CREATE TABLE Copy
    primary key CopyID      NUMBER,
    foreign key MovieID     NUMBER,
    Price       NUMBER,
    Format      VARCHAR2(3),
    Rented      VARCHAR2(5),
    SN      NUMBER;

CREATE TABLE Customer
    primary key CustomerID      NUMBER,
    Name        VARCHAR2(100),
    Address     VARCHAR2(200),
    PhoneNumber     VARCHAR2(15);

CREATE TABLE Rental
    primary key RentalID    NUMBER,
    foreign key CopyID      NUMBER,
    foreign key CustomerID      NUMBER,
    CheckoutDate        DATE,
    ReturnDate      DATE,
    SalePrice       NUMBER,
    LateFee         NUMBER,
    Discount        NUMBER,
    DamageFee       NUMBER,
    FailureToRewind     NUMBER;

    
