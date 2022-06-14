CREATE DATABASE insurance;
use insurance;

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
COMMIT;

INSERT INTO CAR
Values('1111','Alto',2000),
('1234','i10',2003),
('1122','Omni',2005),
('2233','Suzuki',2008),
('3344','brezza',2004);
COMMIT;

INSERT INTO ACCIDENT
Values(11,'2000-2-1','Delhi'),
(22,'2003-3-2','Lucknow'),
(33,'2005-2-4','Kolkatha'),
(44,'2008-8-5','Kerala'),
(55,'2004-11-4','Bihar');
COMMIT;

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
COMMIT;

SELECT * FROM PERSON;
SELECT * FROM CAR;
SELECT * FROM OWNS;
SELECT * FROM ACCIDENT;
SELECT * FROM PARTICIPATED;

UPDATE PARTICIPATED SET damage_amount=25000 WHERE report_number=12 and Regno='1234';

INSERT INTO ACCIDENT Values(23,'2010-5-9','Mysore');
INSERT INTO PARTICIPATED Values('4','1111',23,10000);

SELECT COUNT(*) AS Totalcars FROM CAR C,PARTICIPATED P WHERE C.Regno = P.Regno AND C.model='Alto';

