use unidb;
CREATE TABLE students (
    roll_no int,
    student_name varchar(255) ,
    course varchar(255),
    address varchar(255),
    fees varchar(255),
    phone varchar(255)
);
CREATE TABLE parents (
    stu_roll_no int,
    parent_name varchar(255) ,
    address varchar(255),
    phone varchar(255),
    occupation varchar(255),
    occupationID int
);

insert into students
values (2, 'sanjay', 'C++', 'mumbai', 2500, '321-487'),
(3, 'partha', 'java', 'delhi', 5100, '123-456'),
(4, 'puja', 'C', 'mumbai', 5000, '365-741'),
(7, 'nikhil', 'C', 'chennai', 3000, '758-962'),
(8, 'rahul', 'java', 'noida', 3100, '259-741'),
(9, 'tina', 'java', 'delhi', 3100, '854-236');

insert into parents
values (1, 'keshav', 'chennai', '451-250', 'manager', 1),
(2, 'rajkumar', 'kolkata', '521-745', 'doctor', 2),
(3, 'tapas', 'delhi', '354-745', 'manager', 1),
(4, 'julia', 'kolkata', '475-856', 'doctor', 2),
(5, 'pinki', 'kolkata', '447-965', 'service', 3),
(6, 'ram', 'noida', '247-965', 'service', 3),
(10, 'jamuna', 'kolkata', '452-874', 'service', 3);

select * from students;
select * from parents;

 

#ANY: the condition will be true if the operation is true for any of the values in the range 
SELECT roll_no, student_name
FROM students
WHERE roll_no = ANY
  (SELECT stu_roll_no
  FROM parents
  WHERE occupation = 'doctor'); #this will return TRUE because the Occupation column has some values of 'Doctor'

 

select * from students;
select * from parents;
SELECT stu_roll_no FROM parents WHERE stu_roll_no > ANY (SELECT roll_no FROM students);  

 

SELECT stu_roll_no FROM parents WHERE stu_roll_no < ANY (SELECT roll_no FROM students);

 

#ALL: the condition will be true only if the operation is true for all values in the range 
SELECT roll_no, student_name
FROM students
WHERE roll_no = ALL
  (SELECT stu_roll_no
  FROM parents
  WHERE occupation = 'doctor'); #This will return FALSE because the occupation column has many different values (not only the value of 'Doctor')

 

SELECT stu_roll_no FROM parents WHERE stu_roll_no > ALL (SELECT roll_no FROM students);  
SELECT stu_roll_no FROM parents WHERE stu_roll_no < ALL (SELECT roll_no FROM students); 

 

#IN: allows you to specify multiple values in a WHERE clause. 
SELECT parent_name, occupation
FROM parents
WHERE occupation IN ('doctor', 'service'); 
/*same as: multiple OR
SELECT parent_name, occupation 
FROM parents 
WHERE occupation = 'doctor' OR occupation = 'service';*/

 

SELECT * FROM students
WHERE address IN (SELECT address FROM parents);
/* same as = ANY
SELECT * 
FROM students 
WHERE address = ANY (SELECT address FROM parents);*/  

 

#EXISTS: returns TRUE if the subquery returns one or more records.
SELECT roll_no, student_name
FROM students
WHERE EXISTS (SELECT * FROM parents WHERE students.roll_no = parents.stu_roll_no AND occupationID = 1);
select * from parents;
select * from students;

 

#NOT EXISTS
SELECT roll_no, student_name
FROM students
WHERE NOT EXISTS (SELECT parent_name FROM parents WHERE students.roll_no = parents.stu_roll_no AND occupationID = 1);
select * from parents;
select * from students;

 

#UNION
SELECT roll_no, student_name FROM students
UNION
SELECT parent_name, occupation FROM parents;

 

SELECT roll_no FROM students
UNION
SELECT stu_roll_no FROM parents
ORDER BY roll_no;

 

SELECT roll_no FROM students
UNION ALL                        #duplicate values
SELECT stu_roll_no FROM parents
ORDER BY roll_no;

 

select * from students;
select * from parents;
SELECT roll_no, student_name FROM students
WHERE address='chennai'
UNION
SELECT parent_name FROM parents
WHERE address='kolkata'
ORDER BY student_name;

 

SELECT roll_no, student_name FROM students
WHERE address='chennai'
UNION All
SELECT parent_name, stu_roll_no FROM parents
WHERE address='kolkata';

 

SELECT roll_no as num, student_name as name FROM students
WHERE address='chennai'
UNION
SELECT stu_roll_no, parent_name FROM parents
WHERE address='kolkata'
ORDER BY student_name;

 

SELECT roll_no as num, student_name as name FROM students
WHERE address='chennai'
UNION
SELECT stu_roll_no, parent_name FROM parents
WHERE address='kolkata'
ORDER BY name;

 

select * from students;
select * from parents;

 

#INTERSECT
SELECT DISTINCT roll_no FROM students          #MySQL does not provide support for the INTERSECT operator
INNER JOIN parents USING (stu_roll_no); 

 

SELECT DISTINCT address FROM students  
INNER JOIN parents USING (address); 

 

SELECT DISTINCT roll_no FROM students  
WHERE roll_no IN (SELECT stu_roll_no FROM parents);

 
#no data available just for understanding
SELECT contacts.contact_id, contacts.last_name, contacts.first_name
FROM contacts
WHERE contacts.contact_id < 100
AND EXISTS (SELECT *
            FROM customers
            WHERE customers.last_name <> 'Johnson'
            AND customers.customer_id = contacts.contact_id
            AND customers.last_name = contacts.last_name
            AND customers.first_name = contacts.first_name);