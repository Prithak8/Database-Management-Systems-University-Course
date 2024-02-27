CREATE DATABASE UniDB;
use unidb;
create table students 
(roll_no int primary key,
student_name varchar(150) not null,
course varchar(150));

#INSERT
insert into students 
values(1,'ashish','java');
select * from students; #select all

Insert into students 
values(2,'rahul','C++');

insert into students 
(roll_no, student_name, course)
values(3,'raju','C');

insert into students 
(roll_no, course)
values(4,'AI');

insert into students 
(roll_no, student_name)
values(4,'rohit');

Insert into students 
values(5,'sagar','C');

Insert into students 
values(6,'sagar','C++');

create table students2 
(roll_no int primary key,
student_name varchar(150) not null,
course varchar(150));

Insert into students2  #pop one element from one table to another
select roll_no, student_name, course 
from students where roll_no = 2;
select * from students2;

Insert into students2  #inserting the partial data
(Roll_no, student_name)
select roll_no, student_name 
from students where roll_no = 3;

Insert into students2  #error here// primary key here so coping not possible
(Roll_no, student_name)
select roll_no, student_name 
from students;

alter table students2
ADD address varchar(50);

Insert into students2 #error as column count doesnt match
select *  #in order to copy entire table where column structure is not same
from students where roll_no = 1;

Insert into students2 #error table structure is not same 
select roll_no, student_name, course 
from students where roll_no = 1;
#note: if the table structure is not same then we should explicitly mention the column of the tables
 

#SELECT
select * from students;

select roll_no, course from students;

SELECT * FROM students WHERE course IS NULL;
SELECT * FROM students WHERE course IS not NULL;

#select where
select * from students where course = 'C';
select student_name from students where roll_no > 3; #>=
select student_name from students where roll_no < 3; #<=
select student_name from students where roll_no <> 3; #not equal
select student_name from students where roll_no between 2 and 4;
select * from students where student_name in ('rohit', 'sagar'); #multiple possible values for a column
SELECT * FROM students WHERE student_name LIKE 'r%'; #where student name is starting with the character r, %r : ending with r
select * from unidb.students;

#select distinct: we can see unique record (distinct record)
SELECT DISTINCT student_name FROM students;
SELECT DISTINCT roll_no, student_name FROM students;
SELECT DISTINCT student_name, course FROM students;
SELECT COUNT(DISTINCT student_name) FROM students; #counting how many distinct student names here

#SQL and, or, not
SELECT * FROM students WHERE student_name='raju' AND course='C'; 
SELECT * FROM students WHERE student_name='raju' or course='C'; 
SELECT * FROM students WHERE student_name LIKE 's%'or course='C'; 
SELECT * FROM students WHERE NOT student_name='raju';
SELECT * FROM students WHERE student_name LIKE 'r%' AND (course='C' OR roll_no between 2 and 4);
SELECT * FROM students WHERE student_name LIKE 'r%' AND NOT course='c';

#order by
SELECT * FROM students ORDER BY student_name;
SELECT * FROM students ORDER BY student_name desc;
SELECT * FROM students ORDER BY student_name, course; #This means that it orders by student_name, but if some rows have the same student_name, it orders them by course
SELECT * FROM students ORDER BY student_name ASC, course DESC;

 

#aggregate functions
SELECT MIN(roll_no) AS FirstRollNo FROM students;
SELECT MAX(roll_no) AS LastRollNo FROM students;
SELECT MIN(course) as FirstCourse, MAX(course) AS LastCourse FROM students;
SELECT COUNT(roll_no) FROM students;
SELECT AVG(roll_no) FROM students;
SELECT SUM(roll_no) FROM students; #NULL values are ignored.

 

#Group by
SELECT COUNT(roll_no), course  #in which course how many student are there
FROM students
GROUP BY course; #lists the number of students in each course
SELECT COUNT(roll_no), course
FROM students
GROUP BY course
ORDER BY COUNT(roll_no) DESC; #number of students in each course, sorted high to low

 

#having
SELECT COUNT(roll_no), course
FROM students
GROUP BY course
HAVING COUNT(roll_no) > 1; #lists the number of students in each course with more than 1 student

 

#UPDATE
UPDATE students
SET student_name = 'Alfred', course= 'ML'
WHERE roll_no = 2;
select * from students;
UPDATE students
SET student_name='Puja'
WHERE course='C++'; #update all records where course is C
#If you omit the WHERE clause, ALL records will be updated!#

 

#DELETE
DELETE FROM students WHERE student_Name='Alfred';
DELETE FROM students2; #delete all records

 

#truncate
TRUNCATE TABLE  students; 


 