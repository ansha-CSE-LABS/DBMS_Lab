/*create database airine;*/
use airline;

create table flights(
	flno int,
    frm varchar(20),
    landing varchar(20),
    distance int,
    departs varchar(20),
    arrives varchar(20),
    price int,
    primary key(flno)
    );
create table aircraft(
	aid int,
    aname varchar(20),
    cruisingrange int,
    primary key(aid)
    );
create table employee(
	eid int,
    ename varchar(20),
    salary int,
    primary key(eid)
    );
create table certified(
	eid int,
    aid int,
    primary key(eid,aid),
    foreign key(eid) references employee(eid),
    foreign key(aid) references aircraft(aid)
    );
    
insert into flights
values(1,'Bangalore','Mangalore',360,'10:45:00','12:00:00',3000),
(2,'Bangalore','Mumbai',800,'02:15:00','05:25:00',5000),
(3,'Delhi','Mumbai',700,'10:15:00','12:05:00',5000),
(4,'Bangalore','Frankfurt',7400,'10:00:00','07:45:00',12500);

insert into aircraft 
values(108,'Airbus',1000),
(302,'Boeing',5000),
(307,'747',5000),
(404,'Airbus380',8000),
(509,'Jet01',7000);

insert into employee 
values(11,'Karan',30000),
(12,'Arjun',85000),
(13,'Sonal',50000),
(14,'Mira',45000);

insert into certified 
values(11,108),
(12,108),
(11,302),
(14,404),
(11,509);

select * from flights;
select * from aircraft;
select * from employee;
select * from certified;

/*Find the names of aircraft such that all pilots certified to operate them have salaries more than Rs.80,000.*/
select a.aname
from employee e, aircraft a, certified c
where a.aid = c.aid and e.eid = c.eid and e.salary > 80000;

/*For each pilot who is certified for more than three aircrafts, find the eid and the maximum cruising range of
the aircraft for which she or he is certified*/
select c.eid, max(a.cruisingrange)
from aircraft a, certified c
group by c.eid


