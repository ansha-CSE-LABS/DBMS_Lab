/*CREATE DATABASE banking;*/
use banking;

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

CREATE TABLE DEPOSITOR (
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

CREATE TABLE BORROWER (
	customer_name varchar(30),
    accno int,
    PRIMARY KEY (customer_name,accno),
    FOREIGN KEY (accno) references ACCOUNTS(accno),
    FOREIGN KEY (customer_name) references DEPOSITOR(customer_name)
);

INSERT INTO BRANCH
values('SBI_A', 'Bangalore', 10000),
('SBI_B', 'Delhi', 30000),
('SBI_C', 'Mumbai', 50000);

INSERT INTO ACCOUNTS
values(001, 'SBI_A',2000),
(002, 'SBI_B', 4000),
(003, 'SBI_C',6000);

INSERT INTO DEPOSITOR
values('Neha', 'Churchstreet','Bangalore'),
('Rahul','Sarojini_road','Delhi'),
('Sia','Bandra', 'Mumbai');

INSERT INTO LOAN
values(11, 'SBI_A',1000),
(12, 'SBI_B', 2000),
(13, 'SBI_C',3000);

INSERT INTO BORROWER
values('Neha', 001),
('Rahul', 002),
('Sia', 003);

commit;

SELECT * FROM BRANCH;
SELECT * FROM ACCOUNTS;
SELECT * FROM DEPOSITOR;
SELECT * FROM LOAN;
SELECT * FROM BORROWER;

