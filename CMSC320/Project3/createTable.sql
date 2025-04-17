
DROP TABLE Distributor CASCADE CONSTRAINTS;
DROP TABLE Catalog CASCADE CONSTRAINTS;
DROP TABLE Movie CASCADE CONSTRAINTS;
DROP TABLE MovieStaff CASCADE CONSTRAINTS;
DROP TABLE Staff CASCADE CONSTRAINTS;
DROP TABLE Award CASCADE CONSTRAINTS;
DROP TABLE Copy CASCADE CONSTRAINTS;
DROP TABLE Customer CASCADE CONSTRAINTS;
DROP TABLE Rental CASCADE CONSTRAINTS;

CREATE TABLE Distributor (
    DistributorID    NUMBER     PRIMARY KEY,
    Name    VARCHAR2(100)
);

CREATE TABLE Movie(
    MovieID     NUMBER     PRIMARY KEY,
    Title   VARCHAR2(150),
    Length  NUMBER,
    Type_    NUMBER,
    Rating  VARCHAR2(5),
    ReleaseDate DATE);

CREATE TABLE Staff(
    StaffID     NUMBER     PRIMARY KEY,
    Name    VARCHAR2(100));

CREATE TABLE Customer(
    CustomerID      NUMBER     PRIMARY KEY,
    Name        VARCHAR2(100),
    Address     VARCHAR2(200),
    PhoneNumber     VARCHAR2(15));

CREATE TABLE Copy(
    CopyID      NUMBER     PRIMARY KEY,
    MovieID     NUMBER,
    Price       NUMBER,
    Format      VARCHAR2(3),
    Rented      VARCHAR2(5),
    SN      NUMBER,
    CONSTRAINT fk_Copy_Movie FOREIGN KEY (MovieID) REFERENCES Movie(MovieID));

CREATE TABLE Catalog (
    DistributorID    NUMBER,
    CopyID  NUMBER,
    WholesalePrice  NUMBER,
    CONSTRAINT pk_Catalog PRIMARY KEY (DistributorID, CopyID),
    CONSTRAINT fk_Catalog_Distributor FOREIGN KEY (DistributorID) REFERENCES Distributor(DistributorID),
    CONSTRAINT fk_Catalog_Copy FOREIGN KEY (CopyID) REFERENCES Copy(CopyID)
);

CREATE TABLE MovieStaff(
    MovieStaffID    Number     PRIMARY KEY,
    StaffID     NUMBER,
    MovieID     NUMBER,
    Role    VARCHAR2(50),
    CONSTRAINT fk_MS_Staff FOREIGN KEY (StaffID) REFERENCES Staff(StaffID),
    CONSTRAINT fk_MS_Movie FOREIGN KEY (MovieID) REFERENCES Movie(MovieID));

CREATE TABLE Award(
    AwardID     NUMBER     PRIMARY KEY,
    MovieID     NUMBER,
    StaffID     NUMBER,
    Name    VARCHAR2(100),
    Year    NUMBER(4),
    CONSTRAINT fk_Award_Movie FOREIGN KEY (MovieID) REFERENCES Movie(MovieID),
    CONSTRAINT fk_Award_Staff FOREIGN KEY (StaffID) REFERENCES Staff(StaffID));

CREATE TABLE Rental(
    RentalID    NUMBER     PRIMARY KEY,
    CopyID      NUMBER,
    CustomerID      NUMBER,
    ReturnDate      DATE,
    SalePrice       NUMBER,
    LateFee         NUMBER,
    Discount        NUMBER,
    DamageFee       NUMBER,
    FailureToRewind     NUMBER,
    CONSTRAINT fk_Rental_Copy FOREIGN KEY (CopyID) REFERENCES Copy(CopyID),
    CONSTRAINT fk_Rental_Customer FOREIGN KEY  (CustomerID) REFERENCES Customer(CustomerID));

ALTER TABLE Rental ADD (CheckoutDate     DATE);