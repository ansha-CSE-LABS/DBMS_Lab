DROP DATABASE student;
CREATE DATABASE student;
USE student;

CREATE TABLE STUDENT (
	snum int,
    sname varchar(20),
    major varchar(20),
    level varchar (5),
    age int,
    PRIMARY KEY (snum)
    );

CREATE TABLE FACULTY(
	fid int,
	fname varchar(20),
	dept_id int,
    PRIMARY KEY (fid)
    );
    
CREATE TABLE CLASS(
	cname varchar(20) PRIMARY KEY,
    meets_at timestamp,
    room varchar(20),
    fid int references FACULTY(fid)
    );
    
CREATE TABLE ENROLLED(
	snum int references STUDENT(snum),
    cname varchar(10) references CLASS (cname),
    PRIMARY KEY (snum, cname)
    );
    
INSERT INTO STUDENT
VALUES (1,'John', 'CS', 'sr',19),
(2,'Smith','CS','jr',20),
(3,'Jacob','CV','sr',20),
(4,'Tom','CS','jr',20),
(5,'Rahul','CS','jr',20),
(6,'Rita','CS','jr',21);

INSERT INTO FACULTY
VALUES (11,'Harish',1000),
(12,'MV',1000),
(13,'Mira',1001),
(14,'Shiva',1002),
(15,'Nupur',1000);

INSERT INTO ENROLLED
VALUES (1,'class1'),
(2,'class1'),
(3,'class3'),
(4,'class3'),
(5,'class4'),
(1,'class5'),
(2,'class5'),
(3,'class5'),
(4,'class5'),
(5,'class5');

INSERT INTO CLASS
VALUES ('class1', '22/1/1 10:15:16' ,'R1', 14),
('class10', '22/1/1 10:15:16' ,'R128', 14),
('class2', '22/1/1 10:15:20' ,'R2', 12),
('class3', '22/1/1 10:15:25' ,'R3', 11),
('class4', '22/1/1 20:15:25' ,'R4', 14),
('class5', '22/1/1 20:15:25' ,'R3', 15),
('class6', '22/1/1 13:20:20' ,'R2', 14),
('class7', '22/1/1 10:10:10' ,'R3', 14);



/*  names of all Juniors (level = JR) who are enrolled in a class taught by fid 11*/
SELECT S.sname
FROM STUDENT S, CLASS C, ENROLLED E, FACULTY F
WHERE F.fid = C.fid AND S.snum = E.snum AND C.cname=E.cname
	AND S.level = 'jr' AND F.fid=11;
 
 /* names of all classes that either meet in room R128 or have five or more Students enrolled*/
SELECT C.cname
FROM CLASS C
WHERE C.room = 'R128' OR C.cname IN (
	SELECT E.cname
    FROM ENROLLED E
	GROUP BY(E.cname)
	HAVING COUNT(E.snum) >=5
    );

/* names of all students who are enrolled in two classes that meet at the same time.*/
SELECT  DISTINCT S.sname
FROM STUDENT S, CLASS C1, CLASS C2, ENROLLED E1, ENROLLED E2
WHERE C1.meets_at = C2.meets_at AND 
	E1.snum = E2.snum AND E1.snum = S.snum AND 
    E1.cname = C1.cname AND E2.cname = C2.cname AND E1.cname <> E2.cname
GROUP BY(C1.meets_at)
HAVING COUNT(*)>1;

/*Find the names of faculty members who teach in every room in which some class is taught*/
SELECT DISTINCT F.fname
FROM FACULTY F
WHERE NOT EXISTS(
	SELECT C.room
    FROM CLASS C 
    where C.room NOT IN (
		SELECT c.room
        FROM CLASS c
        WHERE c.fid= F.fid
        )
	);
    
/*Find the names of faculty members for whom the combined enrolment of the courses that they teach is less
than five*/
SELECT DISTINCT F.fname
FROM FACULTY F
WHERE 5> (
	SELECT COUNT(E.snum)
    FROM CLASS C, ENROLLED E
    WHERE C.cname=E.cname AND C.fid=F.fid
    );
    
/*Find the names of students who are not enrolled in any class*/
SELECT DISTINCT S.sname
FROM STUDENT S
WHERE S.snum NOT IN(
	SELECT E.snum
    FROM ENROLLED E
    );
    
/*For each age value that appears in Students, find the level value that appears most often. For example, if
there are more FR level students aged 18 than SR, JR, or SO students aged 18, you should print the pair (18,
FR)*/
SELECT S.age, S.level
FROM STUDENT S
GROUP BY S.age, S.level
HAVING S.level IN (
	SELECT S1.level
    FROM STUDENT S1
    WHERE S1.AGE = S.AGE
    GROUP BY S1.level, S1.age
    HAVING COUNT(*) >= ALL (
		SELECT COUNT(*)
        FROM STUDENT S2
        WHERE S1.age = S2.age
        GROUP BY S2.level, S2.age
        )
	);
