create database database1;
use database1;
#creating table
create table employee
(
ID int primary key,
name varchar(200) not null,
age int, 
department varchar(200) null,
address varchar(200) null,
salary int null
);
show tables;
describe employee;
insert into employee
values(1,'Prabhat',25,'sales','Dehli',25000);
insert into employee
values(2,'Rimpa',27,'Manufacturing','Mumbai',20000);
insert into employee
values(3,'Saikat',31,'Manufacturing','Kolkota',30000);
insert into employee
values(4,'Sagar',29,'Finance','Noida',34000);
insert into employee
values(5,'Naina',30,'Finance','Kerela',29000);
insert into employee
values(6,'Rahul',28,'Finance','Chennai',27000);
select * from employee;

insert into employee
values(7,'Raktim',25,'Design','Noida',31000);

select * from employee where age<=30 and address='Mumbai';

select name,age
from employee
where age in (25,27);
select name,age
from employee where age between 24 and 28;

select name,salary from employee where salary=(select min(salary) from employee);

select COUNT(ID), department
from employee
group by department;

update employee
set 
	age=32
where 
	address='Kerela';
SELECT 
	age,address
from 
	employee
where 
	address='Kerela';

select * from employee order by salaray desc;

select COUNT(ID),department
from employee
group by department 
having count (ID)>2;

select avg(salary) from employee;



