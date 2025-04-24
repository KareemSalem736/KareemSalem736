/*1.    Oracle functions alter data and return a calculated or transformed value. 
Functions can be used in SQL statements to manipulate numbers, dates, strings, or collections. */

/*2.    COS is a Numeric single-row function, it takes in a numeric value and returns the cosine of said numeric value.
        Cardinality is a Collection single-row function that accepts a nested-table and returns the number of elements in that collection.
        Add-months is a Datetime function that accepts a date and a integer, it adds or subtracts the integer to the current months and returns the new date.*/

/*3.*/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE DemoCollection';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE DemoData';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TYPE StringList';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/

-- Create nested table type
CREATE OR REPLACE TYPE StringList AS TABLE OF VARCHAR2(100);
/

-- Create table for COS and ADD_MONTHS
CREATE TABLE DemoData (
    ID NUMBER,
    Angle NUMBER,
    BaseDate DATE
);

-- Create table for CARDINALITY
CREATE TABLE DemoCollection (
    ID NUMBER,
    Items StringList
)
NESTED TABLE Items STORE AS Items_Table;

-- Insert test data
INSERT INTO DemoData VALUES (1, 0, TO_DATE('2025-01-01', 'YYYY-MM-DD'));
INSERT INTO DemoData VALUES (2, 1, TO_DATE('2025-06-15', 'YYYY-MM-DD'));
INSERT INTO DemoData VALUES (3, 3.14159265, TO_DATE('2025-12-31', 'YYYY-MM-DD'));

INSERT INTO DemoCollection VALUES (1, StringList('Apple', 'Banana', 'Cherry'));
INSERT INTO DemoCollection VALUES (2, StringList('X', 'Y'));

COMMIT;

-- COS: Cosine of angle
SELECT ID, Angle, COS(Angle) AS "Cosine"
FROM DemoData;

-- ADD_MONTHS: Add 1 month to each base date
SELECT ID, TO_CHAR(BaseDate, 'YYYY-MM-DD') AS "Base Date",
             TO_CHAR(ADD_MONTHS(BaseDate, 1), 'YYYY-MM-DD') AS "Plus One Month"
FROM DemoData;

-- CARDINALITY: Count items in each nested collection
SELECT ID, CARDINALITY(Items) AS "Item Count"
FROM DemoCollection;
