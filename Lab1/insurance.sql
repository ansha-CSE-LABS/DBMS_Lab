DROP DATABASE insurance;
CREATE DATABASE insurance;
USE insurance;

CREATE TABLE PERSON(
driver_id varchar(20),
p_name varchar(20),
address varchar(20),
PRIMARY KEY(driver_id)
);

CREATE TABLE CAR(
Regno varchar(20),
model varchar(20),
year int,
PRIMARY KEY(Regno)
);

CREATE TABLE ACCIDENT(
report_number int,
date date,
location varchar(20),
PRIMARY KEY(report_number)
);

CREATE TABLE OWNS(
driver_id varchar(20),
Regno varchar(20),
PRIMARY KEY(driver_id,Regno),
FOREIGN KEY(Regno)References CAR(Regno),
FOREIGN KEY(driver_id) References PERSON (driver_id)
);

CREATE TABLE PARTICIPATED(
driver_id varchar(20),
Regno varchar(20),
report_number int,
damage_amount int,
PRIMARY KEY(report_number,Regno,driver_id),
FOREIGN KEY(Regno)References CAR(Regno),
FOREIGN KEY(driver_id) References PERSON (driver_id),
FOREIGN KEY(report_number) References ACCIDENT (report_number)
);

INSERT INTO PERSON
Values('1','Abc','Delhi'),
('2','Xyz','Lucknow'),
('5','Pqr','Kolkatha'),
('3','Lmn','Kerala'),
('7','Uvw','Bihar');

INSERT INTO CAR
Values('1111','Alto',2000),
('1234','i10',2003),
('1122','Omni',2005),
('2233','Suzuki',2007),
('3344','Alto',2009);

INSERT INTO ACCIDENT
Values(11,'2002-2-1','Delhi'),
(12,'2004-3-2','Lucknow'),
(13,'2006-2-4','Kolkatha'),
(14,'2008-8-5','Kerala'),
(15,'2010-11-4','Bihar'),
(16,'2008-4-1','Chennai');

INSERT INTO OWNS
Values('1','1111'),
('2','1234'),
('5','1122'),
('3','2233'),
('7','3344');
COMMIT;

INSERT INTO PARTICIPATED
Values('1','1111',11,1000),
('2','1234',12,2000),
('5','1122',13,5000),
('3','2233',14,8000),
('7','3344',15,7000);


/*Update the damage amount for the car with a specific Regno in the accident with report number 12 to
25000*/
UPDATE PARTICIPATED SET damage_amount=25000 WHERE report_number=12 and Regno='1234';

SELECT * FROM PARTICIPATED;

/*Add a new accident to the database*/
INSERT INTO ACCIDENT Values(23,'2010-5-9','Mysore');

SELECT * FROM ACCIDENT;


/* Find the total number of people who owned cars that involved in accidents in 2008 */
SELECT COUNT(*)
FROM ACCIDENT A, PARTICIPATED P, OWNS O
WHERE  A.report_number=P.report_number AND 
	  P.Regno = O.Regno AND 
    A.date BETWEEN '2008-01-01' AND '2008-12-31';

/*Find the number of accidents in which cars belonging to a specific model were involved*/
SELECT COUNT(*)
FROM ACCIDENT A, CAR C, PARTICIPATED P
WHERE A.report_number = P.report_number AND P.Regno = C.Regno AND C.model='Alto';
