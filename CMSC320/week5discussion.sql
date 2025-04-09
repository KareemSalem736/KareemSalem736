CREATE TABLE Distributor (
    distributor_id NUMBER(10) PRIMARY KEY, 
    name VARCHAR2(100)
);

CREATE TABLE Movie_Copy (
    copy_id NUMBER(10) PRIMARY KEY,
    price NUMBER(5,2),
    format_ VARCHAR2(3),
    rented CHAR(1),  -- BOOLEAN
    serial_number NUMBER(12)
);

CREATE TABLE Catalog (
    distributor_id NUMBER(10),
    copy_id NUMBER(10),
    wholesale_price NUMBER(7,2),
    PRIMARY KEY(distributor_id, copy_id),
    FOREIGN KEY (distributor_id) REFERENCES Distributor(distributor_id),
    FOREIGN KEY (copy_id) REFERENCES Movie_Copy(copy_id)
);

INSERT INTO Distributor (distributor_id, name) VALUES (1, 'Marvel Studios');
INSERT INTO Movie_Copy (copy_id, price, format_, rented, serial_number) VALUES (101, 14.99, 'DVD', 'N', 123456789012);
INSERT INTO Catalog (distributor_id, copy_id, wholesale_price) VALUES (1, 101, 9.99);

SELECT * FROM Distributor;
SELECT * FROM Movie_Copy;
SELECT * FROM Catalog;
