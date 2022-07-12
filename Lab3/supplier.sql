DROP DATABASE supplier;
CREATE DATABASE supplier;
USE supplier;

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
(1002, 'ABC', 'Delhi'),
(1003, 'XYZ', 'Mumbai'),
(1004, 'PQR', 'Kolkatha');
COMMIT;

INSERT INTO PARTS
VALUES(2001, 'RAM' , 'Black'),
(2002, 'Monitor' , 'Blue'),
(2003, 'Keyboard' , 'White'),
(2004, 'Mouse', 'Green'),
(2005, 'CPU','Red'),
(2006,'Hard disk','Red');

INSERT INTO CATALOG
VALUES( 1001, 2001, 20000),
(1001,2002,8000),
(1001,2003,1000),
(1001,2004,500),
(1001,2006,6000),
(1001,2005,10000),
(1002,2006,2000),
(1003,2005,2000),
(1004,2004,1000);

SELECT * FROM SUPPLIERS;
SELECT * FROM PARTS;
SELECT * FROM CATALOG;

/*Find the pnames of parts for which there is some supplier*/
SELECT DISTINCT P.pname
FROM PARTS P, CATALOG C
WHERE P.pid = C.pid;

/*Find the snames of suppliers who supply every part*/
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
    
/*Find the snames of suppliers who supply every red part*/
SELECT DISTINCT S.sname
FROM PARTS P, SUPPLIERS S, CATALOG C
WHERE C.sid=S.sid AND C.pid=P.pid
AND P.color='Red';

/*Find the pnames of parts supplied by Acme Widget Suppliers and by no one else*/
SELECT P.pname
FROM PARTS P, CATALOG C, SUPPLIERS S
WHERE P.pid = C.pid AND C.sid=S.sid AND S.sname = 'Acme Widget' AND 
	NOT EXISTS (
		SELECT * FROM CATALOG c, SUPPLIERS s
        WHERE c.pid=P.pid AND s.sid=c.sid AND s.sname <> 'Acme Widget'
        );
        
/*Find the sids of suppliers who charge more for some part than the average cost of that part (averaged over
all the suppliers who supply that part)*/

SELECT DISTINCT sid
FROM CATALOG C
WHERE cost > (
	SELECT AVG(cost)
	FROM CATALOG C1
	WHERE C1.pid=C.pid
	);

/*For each part, find the sname of the supplier who charges the most for that part*/
SELECT S.sname, P.pid
FROM SUPPLIERS S, PARTS P, CATALOG C
WHERE C.pid = P.pid AND C.sid = S.sid AND C.cost = (
	SELECT MAX(cost)
    FROM CATALOG
    WHERE pid=P.pid
    );

/*Find the sids of suppliers who supply only red parts*/
SELECT C.sid
FROM CATALOG C, PARTS P
WHERE P.pid= C.pid AND P.color='Red' AND C.sid NOT IN (
		SELECT c.sid
        FROM CATALOG c, PARTS p
        WHERE c.pid = p.pid AND p.color <>'Red'
        );
