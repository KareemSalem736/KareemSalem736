BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE demo_employees';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/

CREATE TABLE demo_employees (
    employee_id NUMBER PRIMARY KEY,
    first_name VARCHAR2(50),
    last_name VARCHAR2(50),
    hire_date DATE
);

INSERT INTO demo_employees VALUES (101, 'alice', 'frank', TO_DATE('2022-03-15', 'YYYY-MM-DD'));
INSERT INTO demo_employees VALUES (102, 'bob', 'mob', TO_DATE('2023-08-01', 'YYYY-MM-DD'));
INSERT INTO demo_employees VALUES (103, 'charlie', 'day', TO_DATE('2024-01-20', 'YYYY-MM-DD'));

SELECT first_name,
       INITCAP(first_name || ' ' || last_name) AS formatted_name
FROM demo_employees;


SELECT employee_id, first_name,
       CASE MOD(employee_id, 2)
            WHEN 0 THEN 'Even'
            ELSE 'Odd'
       END AS id_type
FROM demo_employees;

SELECT employee_id, first_name, hire_date,
       SYSDATE AS current_date,
       ROUND(MONTHS_BETWEEN(SYSDATE, hire_date), 2) AS months_worked
FROM demo_employees;