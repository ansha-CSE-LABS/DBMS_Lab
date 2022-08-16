drop database malldatabase;
create database malldatabase;
use malldatabase;
create table mall(
                m_name varchar(20),
                addr varchar(100),
                mall_id int,
                primary key(mall_id));


create table owners(
                owner_id int,
                o_name varchar(20),
                addr varchar(100),
                phone_no int,
                primary key(owner_id));

create table store(
                snum int,
                sname varchar(20),
                room_no int,
                mall_id int,
                owner_id int,
                foreign key(mall_id) references mall(mall_id),
                foreign key(owner_id) references owners(owner_id),
                primary key(snum));
                
create table department(
                dnum int,
                dname varchar(20),
                primary key(dnum));
                
create table dept_manager(
                dm_name varchar(20),
                dssn int,
                dnum int,
                snum int,
                foreign key (dnum) references department(dnum),
                foreign key (snum) references store(snum),
                primary key(dssn));
                
create table store_manager(
                ssn int,
                sm_name varchar(20),
                salary int,
                snum int,
                foreign key (snum) references store(snum),
                primary key(ssn));
                
create table employee(
                ssn int,
                e_name varchar(20),
                mssn int,
                dnum int,
                super_ssn int,
                foreign key (dnum) references department(dnum),
                foreign key (mssn) references dept_manager(dssn),
                foreign key (super_ssn) references dept_manager(dssn),
                primary key(ssn));
                
create table has(
                s_no int,
                d_no int,
                foreign key (s_no) references store(snum),
                foreign key (d_no) references department(dnum),
                primary key(s_no,d_no));
		
insert into mall
values("abc","mumbai",001),
("pqr","bangalore",002),
("lmn","delhi",003),
("xyz","kolkatha",004),
("zzz","chennai",005);

insert into owners
values(101,"karan","aaa",11111),
(102,"neha","bbb",22222),
(103,"akansha","ccc",33333),
(104,"aatreyee","ddd",44444),
(105,"ansha","eee",55555);

insert into store
values(4001,"store1",501,001,102),
(4002,"store2",502,001,103),
(4003,"store3",503,001,101),
(4004,"store4",504,001,101),
(4005,"store5",503,001,102);

insert into department
values(301,"Accounts"),
(302,"dept2"),
(303,"dept3"),
(304,"dept4"),
(305,"dept5");

insert into dept_manager
values("dm1",0001,301,4001),
("dm2",0002,302,4002),
("dm3",0003,303,4003),
("dm4",0004,304,4005),
("dm5",0005,305,4004);

insert into store_manager
values(1101,"sm1",50000,4001),
(1102,"sm2",40000,4002),
(1103,"sm3",70000,4004),
(1104,"sm4",80000,4003),
(1105,"sm5",60000,4005);

insert into employee
values(1,"e1",0001,301,0001),
(2,"e2",0002,302,0002),
(3,"e3",0003,301,0003),
(4,"e4",0004,304,0004),
(5,"e5",0005,305,0005);

insert into has
values(4001,301),
(4001,302),
(4001,303),
(4002,304),
(4002,305);

/*
select * from mall;
select * from store;
select * from department;
select * from dept_manager;
select * from store_manager;
select * from owners;
select * from has;
select * from employee;
*/
/* question a*/
select s.sname,s.owner_id,st.sm_name
from store s, store_manager st
where s.snum=st.snum and s.owner_id in (
										select owner_id
                                        from store
                                        group by (owner_id)
                                        having count(*) >1
                                        );
									
/* quetion b */
create view store_details (store_num, store_name, store_location, store_owner,store_manager) as
select s.snum,s.sname,s.room_no,o.o_name,st.sm_name
from store s, store_manager st, owners o
where s.owner_id= o.owner_id and s.snum=st.snum;
select * from store_details;

/* question d */
update store_manager
set salary= (salary + salary*0.1)
where snum in (
			select s.snum
            from store s, owners o
            where s.owner_id = o.owner_id and o.o_name="karan"
            );
select * from store_manager;
								
/* question e */
delete
from employee e
where e.dnum = (
				select dnum
                from department
				where dname = "Accounts"
                );
select * from employee;

/* question f */
select s_no, count(*) as n_of_dept
from has
group by (s_no);

/* question c */
alter table store
modify sname varchar(20) not null;


