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

INSERT INTO Movie_Copy (copy_id, price, format_, rented, serial_number) VALUES (102, 19.99, 'BLU', 'Y', 123456789013);
INSERT INTO Movie_Copy (copy_id, price, format_, rented, serial_number) VALUES (103, 12.50, 'DVD', 'N', 123456789014);
INSERT INTO Movie_Copy (copy_id, price, format_, rented, serial_number) VALUES (104, 9.99, 'DIG', 'Y', 123456789015);
INSERT INTO Movie_Copy (copy_id, price, format_, rented, serial_number) VALUES (101, 14.99, 'DVD', 'N', 123456789012);

SELECT * FROM Movie_Copy;