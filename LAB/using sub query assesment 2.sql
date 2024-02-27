create database Db;
use Db;
create table employee 
(
eid varchar(4) primary key,
name varchar(150),
gender varchar(150),
city varchar (50),
age int,
doj date,
salary float,
cid varchar(4)
);
show tables;
desc employee;
create table customer 
(
cid varchar(4) primary key,
cname varchar(150),
gender varchar(150),
city varchar (50),
age int,
occupation varchar(50),
salary int,
pid varchar(4)
);
desc customer;
create table product
(
pid varchar(4) primary key,
pname varchar(150),
warehouse_location varchar(150),
weight float,
price int
);
desc product;
alter table customer rename column ename to cname;

insert into employee
values('e01','archi','female','delhi',45,'2021-02-15',60000.8,'c10');
insert into employee
values('e02','sumon','male','chennai',35,'2021-02-10',50000.1,'c11');
insert into employee
values('e03','ruchi','female','mumbai',40,'2021-02-18',55000.8,'c12');
insert into employee
values('e04','sameer','male','delhi',42,'2021-02-17',51000,'c10');
insert into employee
values('e05','prasun','male','chennai',39,'2021-02-25',65000,'c11');
insert into employee
values('e06','pritam','male','mumbai',38,'2021-02-26',62000,'c12');
select * from employee;

select * from customer;
insert into customer
values('c10','priya','female','delhi',30,'scholar',25000,'p005');
insert into customer
values('c11','ranjit','male','chennai',50,'doctor',50000,'p006');
insert into customer
values('c12','shyamol','male','mumbai',35,'professor',70000,'p007');


select * from product;
insert into product
values('p005','tv','delhi',15.2,38000);
insert into product
values('p006','ac','chennai',10.9,40000);
insert into product
values('p007','induction','delhi',2.7,28000);


#1
select e.eid,e.ename,e.doj from employee e
order by e.doj;


#2
select E.ename,E.salary,E.city from employee E
where(E.city,E.salary) in (
select E1.city,MAX(E1.salary)
from employee E1
group by salary)
order by E.salary desc;

 #3
 select e.eid,e.ename from employee e where e.cid in(
 select c.cid from customer c, product p
 where c.city<>p.warehouse_location and c.pid=p.pid);
 
 #4
 update employee
 set salary=salary+1000
 where cid IN(
 select cid from customer c, product p 
 where
 p.price>30000 and c.salary>30000 and p.pid=c.cid);
 select *from employee;
 
 
 #5
 delete from employee e where exists(
 select cid from customer c
where age>40 and e.cid=c.cid);
select *from employee; 
 
 #6
 Select customer.cid ,customer.cname,customer.age,product.warehouse_location 
from customer 
right join product on 
customer.pid=product.pid;

 
