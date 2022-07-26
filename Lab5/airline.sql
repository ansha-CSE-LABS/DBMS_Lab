drop database airline_18;
create database airline_18;
use airline_18;

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
    
insert into flights values(101,'Bangalore','Delhi',2500,TIMESTAMP '2005-05-13 07:15:31',TIMESTAMP '2005-05-13 17:15:31',5000),
(102,'Bangalore','Lucknow',3000,TIMESTAMP '2005-05-13 07:15:31',TIMESTAMP '2005-05-13 11:15:31',6000),
(103,'Lucknow','Delhi',500,TIMESTAMP '2005-05-13 12:15:31',TIMESTAMP ' 2005-05-13 17:15:31',3000),
(107,'Bangalore','Frankfurt',8000,TIMESTAMP '2005-05-13  07:15:31',TIMESTAMP '2005-05-13 22:15:31',60000),
(104,'Bangalore','Frankfurt',8500,TIMESTAMP '2005-05-13 07:15:31',TIMESTAMP '2005-05-13 23:15:31',75000),
(105,'Kolkata','Delhi',3400,TIMESTAMP '2005-05-13 07:15:31',TIMESTAMP  '2005-05-13 09:15:31',70000);

insert into aircraft values(101,'747',3000),
(102,'Boeing',900),
(103,'647',800),
(104,'Dreamliner',10000),
(105,'Boeing',3500),
(106,'707',1500),
(107,'Dream', 120000);

insert into employee values(701,'A',50000),
(702,'B',100000),
(703,'C',150000),
(704,'D',90000),
(705,'E',40000),
(706,'F',60000),
(707,'G',90000);

insert into certified values(701,101),
(701,102),
(701,106),
(701,105),
(702,104),
(703,104),
(704,104),
(702,107),
(703,107),
(704,107),
(702,101),
(703,105),
(704,105),
(705,103);


select * from flights;
select * from aircraft;
select * from employee;
select * from certified;

/*Find the names of aircraft such that all pilots certified to operate them have salaries more than Rs.80,000.*/
select distinct a.aname
from employee e, aircraft a, certified c
where a.aid = c.aid and e.eid = c.eid and e.salary > 80000;

/*For each pilot who is certified for more than three aircrafts, find the eid and the maximum cruising range of
the aircraft for which she or he is certified*/
select c.eid, max(a.cruisingrange)
from aircraft a, certified c
where c.aid = a.aid
group by c.eid
having count(*) >3;

/* Find the names of pilots whose salary is less than the price of the cheapest route from Bengaluru to
Frankfurt*/
select e.ename
from employee e
where e.salary < (
	select min(f.price)
    from flights f
    where f.frm ="Bangalore" and f.landing = "Frankfurt"
    );

/* For all aircraft with cruising range over 1000 Kms, find the name of the aircraft and the average salary of
all pilots certified for this aircraft */
select a.aname, avg(e.salary)
from employee e, certified c, aircraft a
where c.aid = a.aid and e.eid = c.eid
group by a.aid
having a.aid in (
	select aid
    from aircraft
    where cruisingrange >1000
    );
    
/* Find the names of pilots certified for some Boeing aircraft */
select distinct e.ename
from employee e, aircraft a, certified c
where e.eid = c.eid and a.aid = c.aid and a.aname = "Boeing";

/* Find the aids of all aircraft that can be used on routes from Bengaluru to New Delhi. */
select aid
from aircraft
where cruisingrange > (
	select min(distance)
    from flights
    where frm = "Bangalore" and landing = "Frankfurt"
    );

/* Print the name and salary of every non-pilot whose salary is more than the average salary for pilots. */
select e.ename, e.salary
from employee e
where salary > (
	select avg(e1.salary)
    from employee e1
    where e1.eid in (
		select distinct eid
        from certified))
    and e.eid not in (
		select  distinct eid
        from certified
        );
	
/* A customer wants to travel from Bangalore to Delhi with no more than two changes of flight. List the
choice of departure times from Bangalore if the customer wants to arrive in Delhi by 6 p.m */
select f.departs
from flights f
where f.flno in (
	select flno
    from flights
    where frm="Bangalore" and landing = "Delhi"
    and extract (hour from arrives) <18)
    )
    union(
    select flno
    from flights f1, flights f2, flights f3
    where f1.frm = "Bangalore" and f1.landing = f2.frm and f2.landing = "Delhi"
    and f2.departs > f1.arrives
	and f3.departs > f2.arrives
	and extract(hour from f3.arrives) < 18)
    )
);
		
    
    




