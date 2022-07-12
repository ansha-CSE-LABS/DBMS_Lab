DROP DATABASE banking;
CREATE DATABASE banking;
USE banking;

CREATE TABLE BRANCH(
	branch_name varchar(30),
    branch_city varchar(30),
    assets real,
    PRIMARY KEY (branch_name)
);
    
CREATE TABLE ACCOUNTS (
	accno int,
    branch_name varchar(30),
    balance real,
    PRIMARY KEY (accno),
    FOREIGN KEY (branch_name) references BRANCH(branch_name)
);

CREATE TABLE BANKCUSTOMER (
	customer_name varchar(30),
	customer_street varchar(30),
    customer_city varchar(30),
    PRIMARY KEY (customer_name)
);

CREATE TABLE LOAN (
	loan_number int,
    branch_name varchar(30),
    amount real,
    PRIMARY KEY (loan_number),
    FOREIGN KEY (branch_name) references BRANCH(branch_name)
);

CREATE TABLE DEPOSITOR (
	customer_name varchar(30),
    accno int,
    PRIMARY KEY (customer_name,accno),
    FOREIGN KEY (accno) references ACCOUNTS(accno),
    FOREIGN KEY (customer_name) references BANKCUSTOMER(customer_name)
);

INSERT INTO BRANCH
values('SBI_A', 'Bangalore', 100000),
('SBI_B', 'Delhi', 30000),
('SBI_C', 'Mumbai', 50000),
('SBI_D','Mumbai',60000);

INSERT INTO ACCOUNTS
values(001, 'SBI_A',2000),
(002, 'SBI_B', 4000),
(003, 'SBI_C',6000),
(004,'SBI_A',5000),
(005,'SBI_A',8000),
(006, 'SBI_D',7000);

INSERT INTO BANKCUSTOMER
values('Neha', 'Churchstreet','Bangalore'),
('Rahul','Sarojini_road','Delhi'),
('Sia','Bandra', 'Mumbai');

INSERT INTO LOAN
values(11, 'SBI_A',1000),
(12, 'SBI_B', 2000),
(13, 'SBI_C',3000);

INSERT INTO DEPOSITOR
values('Neha', 001),
('Rahul', 002),
('Sia', 003),
('Neha', 004),
('Sia', 006);

SELECT * FROM BRANCH;
SELECT * FROM ACCOUNTS;
SELECT * FROM DEPOSITOR;
SELECT * FROM LOAN;
SELECT * FROM BANKCUSTOMER;

/*Find all the customers who have at least two accounts at the Main branch*/
SELECT DISTINCT D.customer_name
FROM DEPOSITOR D, ACCOUNTS A
WHERE A.branch_name= 'SBI_A' AND D.accno = A.accno;

/*Find all the customers who have an account at all the branches located in a specific city*/
SELECT DISTINCT D.customer_name
FROM DEPOSITOR D, ACCOUNTS A
WHERE A.accno= D.accno AND A.branch_name IN (
	SELECT branch_name
    FROM BRANCH
    WHERE branch_city='Mumbai'
    )
GROUP BY(D.customer_name)
HAVING COUNT(DISTINCT A.accno) >= (
	SELECT COUNT(*) FROM BRANCH
    WHERE branch_city = 'Mumbai'
    );
