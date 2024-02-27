use uniDB;
create table students 
(roll_no int primary key,
student_name varchar(150) not null,
course varchar(150),
address varchar (50),
Fees int,
phone int);
insert into students
values (1, 'Raju', 'C', 'chennai', 2000, '451-250');
insert into students
values (2, 'sanjay', 'C++', 'mumbai', 2500, '321-487');
insert into students
values (3, 'partha', 'java', 'delhi', 2100, '123-456');
insert into students
values (4, 'puja', 'C', 'mumbai', 2000, '365-741');
insert into students
values (7, 'nikhil', 'C', 'chennai', 2000, '758-962');
insert into students
values (8, 'rahul', 'java', 'noida', 2100, '259-741');
insert into students
values (9, 'tina', 'java', 'delhi', 2100, '854-236');

 

create table parents 
(stu_roll_no int primary key,
parent_name varchar(150) not null,
address varchar (50),
phone varchar(50),
occupation varchar(50),
occupationid int);
insert into parents
values (1, 'keshav', 'chennai', '451-250', 'manager', 1);
insert into parents
values (2, 'rajkumar', 'mumbai', '521-745', 'doctor', 2);
insert into parents
values (3, 'tapas', 'delhi', '354-745', 'manager', 1);
insert into parents
values (4, 'julia', 'chennai', '475-856', 'doctor', 2);
insert into parents
values (5, 'pinki', 'kolkata', '447-965', 'service', 3);
insert into parents
values (6, 'ram', 'noida', '247-965', 'service', 3);

 

create table tution_fee 
(stu_roll_no int primary key,
tution_fee float not null);
insert into tution_fee 
values (1, 45800);
insert into tution_fee 
values (2, 55800);
insert into tution_fee 
values (3, 49800);
insert into tution_fee 
values (4, 51800);

 

select * from students;
select * from parents;
select * from tution_fee;

 

#The following correlated subqueries retrive name, course, fees and roll_no from the table students...
#... ( 's' and 'p' are the aliases of students and parents) with following conditions -
#the roll_no of students table must be the same stu_roll_no of parents table and address of prents table must be chennai
SELECT s.roll_no, s.student_name, s.course, s.fees
FROM students s
WHERE s.roll_no=(
SELECT p.stu_roll_no
FROM parents p WHERE p.address='chennai');

 

#Using EXISTS with a Correlated Subquery
#display the ward roll no, parent name, address of those parents whose ward roll no matches with their occupation ID.
SELECT stu_roll_no, parent_name, address
FROM parents p1
WHERE EXISTS
(SELECT p2.OccupationID
FROM parents p2,parents p1;
WHERE p1.stu_roll_no = p2.occupationID);
select * from parents

 

#Using NOT EXISTS with a Correlated Subquery
#display the ward roll no, parent name, address of those parents whose ward roll no not matches with their occupation ID.
SELECT stu_roll_no, parent_name, address
FROM parents p1
WHERE NOT EXISTS
(SELECT OccupationID
FROM parents p2
WHERE p1.stu_roll_no = p2.occupationID);

 

#To insert all records into 'students1' table from 'students' table, the following SQL statement can be used:
INSERT INTO students1
SELECT * FROM  students;
select * from students1;
truncate table students1;

 

#Inserting records using subqueries with where clause
#Insert records into 'students1' table from 'studentss' table with the following condition - 'address' of 'students' table must be 'mumbai'
INSERT INTO students1
SELECT * FROM  students
WHERE address="mumbai";
truncate table students1;

 

#inserting records using subqueries with any operator
#Insert records into 'students1' table from 'students' table with the following conditions -
#1. 'roll_no' of 'students' table must be any 'stu_roll_no' from 'customer' table which satisfies the condition bellow :
#2. 'address' of parents table must be 'chennai',
INSERT INTO students1
SELECT * FROM  students
WHERE roll_no=ANY(
SELECT stu_roll_no FROM parents
WHERE address="chennai");
select * from students1;
truncate table students1;

 

#insert records into 'students1' table from 'students' table with the following conditions -
#'roll_no' of students table must be any 'stu_roll_no' from 'parents' table which satisfies the condition bellow :
#'stu_roll_no' of parents table must be any 'stu_roll_no' from 'tution_fee' table which satisfies the condition bellow :
#'tution_fee' of 'tution_fee' table must be more than 50000
INSERT INTO students1
SELECT * FROM  students
WHERE roll_no=ANY(
SELECT stu_roll_no FROM parents
WHERE stu_roll_no =ANY(
SELECT stu_roll_no FROM tution_fee
WHERE  tution_fee>50000));
select * from students1;
truncate table students1;
select * from parents;

 

#UPDATE using subquery
#Update the 'students' table with following conditions -
#1. modified value for 'fees' is 'fees'+1000,
#2. the number 3 is greater than or equal to the number of 'name' from 'parents' table which satisfies the condition bellow :
UPDATE students
SET fees=fees+1000
WHERE 3>=(
SELECT COUNT(parent_name) FROM parents);
select * from students;

 

UPDATE students, parents
SET fees=fees+1000
where parents.stu_roll_no=students.roll_no;
select * from students;

 

#update using subqueries with 'IN'
#update the 'tution_fee' table with following conditions -
#1. modified value for 'fees' is 'fees'-500,
#2. 'stu_roll_no' is within the selected 'stu_roll_no' of 'parents' table named as alias 'p' which satisfies the condition bellow :
#3. 'address' of 'parents' table named as alias 'p' is same as the 'address' of 'student' table named as alias 's' which satisfies the condition bellow :
#4.'phone' of alias 'a'and'b'must be same,
UPDATE tution_fee
SET tution_fee=tution_fee-500
WHERE stu_roll_no IN(
SELECT stu_roll_no FROM parents a
WHERE address=(
SELECT address FROM students b
WHERE a.phone=b.phone));
select * from tution_fee;

 

#update using subqueries with 'IN' and min()
#update the 'tution_fee' table with following conditions -
#1. modified value for 'tution_fee' is 'tution_fee'-500,
#2. 'stu_roll_no' not within the selected 'stu_roll_no' of 'parents' table named as alias 'p' which satisfies the condition bellow :
#3. 'address' of 'parents' table named as alias 'p' is the minimum 'address' of 'student' table named as alias 's' which satisfies the condition bellow :
#4.'phone' of alias 'a'and'b'must be same,
UPDATE tution_fee
SET tution_fee=tution_fee-500
WHERE stu_roll_no NOT IN(
SELECT stu_roll_no FROM parents a
WHERE address=(
SELECT min(b.address) FROM students b
WHERE a.phone=b.phone));
select * from tution_fee;
select * from students;
select * from parents;

#Subqueries with DELETE statement
#remove rows from the table 'parents' with following conditions -
#1. 'stu_roll_no' should be any 'roll_no' from 'students' table which satisfies the condition bellow :
#2. 'adress' of 'students' table must be 'mumbai'
DELETE FROM parents
WHERE stu_roll_no=ANY(
SELECT roll_no FROM students
WHERE address='mumbai');
select * from parents;

 

#delete records using subqueries with alias
#remove rows from the table 'students' with following conditions -
#1. 't' and 's' are the aliases for the table 'tution_fee' and 'students'
#2. check the existence of the subquery is true or false. which satisfies the condition bellow :
#3. 'tution_fee' of 'tution_fee' table must be more than 50000,
#4. 'roll_no' of 'students' table and 'stu_roll_no' of 'tution_fee' table should be same,
DELETE FROM students s
WHERE EXISTS(
SELECT stu_roll_no FROM  tution_fee t
WHERE tution_fee>50000
AND s.roll_no=t.stu_roll_no);
select * from students;
select * from tution_fee;

 

#delete records using subqueries with alias and IN
#remove rows from the table 'students' with following conditions -
#1. 'p' and 's' are the aliases for the table 'parents' and 'students'
#2. check the address chennai is in the result of the subquery which satisfies the condition bellow :
#3. 'address' of 'parents' table and 'address' of 'students' table should be same,
DELETE FROM students s
WHERE 'chennai' IN(
SELECT p.stu_roll_no, p.address FROM parents p, students s
WHERE s.address=p.address);
select * from students;

 

#delete records using subqueries with alias and MIN
/*remove rows from the table 'students' with following conditions -
1. 'parents' table used as alias 'p1' and alias 'p2',
2. 'roll_no' of 'students' should be within the 'stu_roll_no' in alias 'p1' which satisfies the condition bellow :
i) 'stu_roll_no' of alias 'p1' must be equal to the minimum 'occupationID' of alias 'p2' which satisfies the condition bellow :
a) 'address' of alias 'p1' and alias 'p2' must be equal,*/
DELETE FROM students
WHERE roll_no IN
(SELECT stu_roll_no FROM parents p1
WHERE stu_roll_no=(
SELECT MIN(p1.occupationID) FROM parents p2, parents p1
WHERE p1.address=p2.address));
select * from students;