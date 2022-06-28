DROP DATABASE supplier18;
CREATE DATABASE supplier18;
USE supplier18;

CREATE TABLE SUPPLIERS (
	sid INT,
	sname VARCHAR(20), 
	address VARCHAR(20),
    PRIMARY KEY(sid)
	);
    
CREATE TABLE PARTS (
	pid INT,
    pname VARCHAR(20),
    color VARCHAR(20),
    PRIMARY KEY(pid)
    );

CREATE TABLE CATALOG (
	sid INT,
    pid INT,
    cost REAL,
    PRIMARY KEY(sid, pid),
    FOREIGN KEY (sid) REFERENCES SUPPLIERS (sid),
    FOREIGN KEY (pid) REFERENCES PARTS (pid)
    );

INSERT INTO SUPPLIERS
VALUES (1001, 'Acme Widget', 'Bangalore'),
(1002, 'Relaince', 'Delhi'),
(1003, 'Lenovo', 'Mumbai'),
(1004, 'Sony', 'Kolkatha');
COMMIT;

INSERT INTO PARTS
VALUES(2001, 'TV' , 'Black'),
(2002, 'Mobile' , 'Blue'),
(2003, 'Keyboard' , 'White'),
(2004, 'Mouse', 'Green'),
(2005, 'CPU', 'Red');

INSERT INTO CATALOG
VALUES( 1001, 2001, 50000),
(1001,2002,200),
(1001,2003,100),
(1001,2004,500),
(1001,2005,1000),
(1002,2002,15000),
(1003,2003,2000),
(1004,2004,1000);

SELECT * FROM SUPPLIERS;
SELECT * FROM PARTS;
SELECT * FROM CATALOG;

SELECT DISTINCT P.pname
FROM PARTS P, CATALOG C
WHERE P.pid = C.pid;

SELECT S.sname
FROM SUPPLIERS S
WHERE S.sid IN (
	SELECT C.sid
	FROM CATALOG C
    GROUP BY C.sid
    HAVING count(*) = (
		SELECT count(*) FROM PARTS
		  )
    );
