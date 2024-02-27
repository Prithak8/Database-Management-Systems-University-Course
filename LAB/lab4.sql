use uniDB;
#NOT NULL Constraint: Ensures that a column cannot have a NULL value
CREATE TABLE Employee (
    ID int NOT NULL,
    LastName varchar(255) NOT NULL,
    FirstName varchar(255) NOT NULL,
    Age int
);
desc employee;

 

insert into employee
values (1, 'Sharma', 'Raju', 25);
select * from employee;
insert into employee
(id, firstname, age)
values (2, 'Roy', 25);

 

ALTER TABLE employee
MODIFY Age int NOT NULL;
desc employee;

 

drop table employee;
show tables;

 

#UNIQUE Constraint: Ensures that all values in a column are different
#create
CREATE TABLE employee (                
    ID int NOT NULL,
    LastName varchar(255) NOT NULL,
    FirstName varchar(255),
    Age int,
    UNIQUE (ID)   #single attribute
);
desc employee;
insert into employee
values (1, 'Sharma', 'Raju', 25);
insert into employee
values (1, 'Roy', 'Puja', 28);
drop table employee;

 

CREATE TABLE employee (
    ID int NOT NULL,
    LastName varchar(255) NOT NULL,
    FirstName varchar(255),
    Age int,
    UNIQUE (ID,LastName)            #multiple attribute: ckecking for the combined uniqueness
);
desc employee;
drop table employee;

 

CREATE TABLE employee (
    ID int,
    LastName varchar(255),
    FirstName varchar(255),
    Age int,
    UNIQUE (ID,LastName)            #multiple attribute: ckecking for the combined uniqueness
);
desc employee;

 

insert into employee
values (1, 'Sharma', 'Raju', 25);
insert into employee
values (1, 'Sharma', 'Puja', 28);
truncate table employee;

 

insert into employee
values (1, 'Sharma', 'Raju', 25);
insert into employee
values (2, 'Sharma', 'Puja', 28);
select * from employee;
truncate table employee;

 

insert into employee
values (1, 'Sharma', 'Raju', 25);
insert into employee
(Lastname, id, firstname, age)
values ('Roy', 1, 'Puja', 28);
drop table employee;

 

#alter
CREATE TABLE employee (
    ID int,
    LastName varchar(255),
    FirstName varchar(255),
    Age int
);
desc employee;
ALTER TABLE employee
ADD UNIQUE (ID);                #single
desc employee;
drop table employee;

 

CREATE TABLE employee (
    ID int,
    LastName varchar(255),
    FirstName varchar(255),
    Age int
);
desc employee;
ALTER TABLE employee
ADD UNIQUE (ID,LastName);            #multiple
desc employee;

 

insert into employee
values (1, 'Sharma', 'Raju', 25);
insert into employee
values (1, 'Sharma', 'Puja', 28);
truncate table employee;

 

insert into employee
values (1, 'Sharma', 'Raju', 25);
insert into employee
values (2, 'Sharma', 'Puja', 28);
select * from employee;
truncate table employee;

 

insert into employee
values (1, 'Sharma', 'Raju', 25);
insert into employee
(firstname, age)
values ('Raju', 25);
select * from employee;
truncate table employee;

 

insert into employee
values (1, 'Sharma', 'Raju', 25);
insert into employee
(lastname, firstname, age)
values ('Sharma', 'Raju', 25);
select * from employee;
drop table employee;

 

#drop
CREATE TABLE employee (
    ID int,
    LastName varchar(255),
    FirstName varchar(255),
    Age int,
    CONSTRAINT UC_employee UNIQUE (ID,LastName)            #multiple attribute: ckecking for the combined uniqueness
);
desc employee;
ALTER TABLE employee
DROP INDEX UC_employee;
desc employee;
drop table employee;

 

CREATE TABLE employee (
    ID int not null,
    LastName varchar(255) not null,
    FirstName varchar(255),
    Age int,
    CONSTRAINT UC_employee UNIQUE (ID,LastName)            #multiple attribute: ckecking for the combined uniqueness
);
desc employee;
ALTER TABLE employee
DROP INDEX UC_employee;
desc employee;
drop table employee;

 

CREATE TABLE employee (
    ID int NOT NULL,
    LastName varchar(255) NOT NULL,
    FirstName varchar(255),
    Age int
);
desc employee;
ALTER TABLE employee
ADD CONSTRAINT UC_employee UNIQUE (ID,LastName);
desc employee;
ALTER TABLE employee
DROP INDEX UC_employee;
desc employee;
drop table employee;

 

#PRIMARY KEY Constraint
#create
CREATE TABLE employee (
    ID int,
    LastName varchar(255) NOT NULL,
    FirstName varchar(255),
    Age int,
    PRIMARY KEY (ID)                #single
);
desc employee;
drop table employee;

 

CREATE TABLE employee (
    ID int,
    LastName varchar(255),
    FirstName varchar(255),
    Age int,
    PRIMARY KEY (ID,LastName)            #multiple
);
desc employee;
drop table employee;

 

#alter and drop
CREATE TABLE employee (
    ID int,
    LastName varchar(255) NOT NULL,
    FirstName varchar(255),
    Age int
);
desc employee;
ALTER TABLE employee
ADD PRIMARY KEY (ID);
desc employee;
ALTER TABLE employee
DROP PRIMARY KEY;
desc employee;
drop table employee;

 

CREATE TABLE employee (
    ID int,
    LastName varchar(255),
    FirstName varchar(255),
    Age int
);
desc employee;
ALTER TABLE employee
ADD PRIMARY KEY (ID,LastName);
desc employee;
ALTER TABLE employee
DROP PRIMARY KEY;
desc employee;
drop table employee; 
#drop table core_group;

 

#foreign key constraint
#create
CREATE TABLE employee (
    employeeID int,
    LastName varchar(255) NOT NULL,
    FirstName varchar(255),
    Age int,
    PRIMARY KEY (employeeID)                #referenced table
);
desc employee;
CREATE TABLE core_group (
    cgID int NOT NULL,
    salary int NOT NULL,
    employeeID int not null,
    PRIMARY KEY (cgID),
    FOREIGN KEY (employeeID) REFERENCES employee(employeeID)        #referencing table
);
desc core_group;
drop table core_group;

 

insert into employee
values (1, 'Sharma', 'Puja', 28), (2, 'roy', 'rohit', 25);
insert into core_group
values (101, 50000, 1), (102, 60000, 2);
select * from employee;
select * from core_group;

 

truncate table core_group;
insert into core_group
values (101, 50000, 1), (102, 60000, 3);
select * from core_group;
drop table core_group;
drop table employee;

 

CREATE TABLE employee (
    employeeID int,
    LastName varchar(255) NOT NULL,
    FirstName varchar(255),
    Age int,
    PRIMARY KEY (employeeID, lastname)                #multiple
);
CREATE TABLE core_group (
    cgID int NOT NULL,
    salary int NOT NULL,
    employeeID int NOT NULL,
    lastname varchar(255),
    PRIMARY KEY (cgID),
    CONSTRAINT FK_emp_cg FOREIGN KEY (employeeID, lastname)
    REFERENCES employee(employeeID, lastname)
);
desc employee;
desc core_group;
drop table core_group;

 

#alter and drop
CREATE TABLE core_group (
    cgID int NOT NULL,
    salary int NOT NULL,
    employeeID int
);
desc core_group;
ALTER TABLE core_group
ADD CONSTRAINT FK_emp_cg
FOREIGN KEY (employeeID) REFERENCES employee(employeeID);   #single
desc core_group;
insert into core_group
values (101, 50000, 1), (102, 60000, 3);
ALTER TABLE core_group
DROP FOREIGN KEY FK_emp_cg; #If Key is MUL , the column is the first column of a nonunique index in which multiple occurrences of a given value are permitted within the column.
desc core_group;

 

insert into core_group
values (101, 50000, 1), (102, 60000, 3);
select * from core_group;
desc core_group;

 

drop table employee;
#CHECK Constraint: used to limit the value range that can be placed in a column.
#create
CREATE TABLE employee (
    ID int NOT NULL,
    LastName varchar(255) NOT NULL,
    FirstName varchar(255),
    Age int,
    CHECK (Age>=18)
);
desc employee;
insert into employee
values (1, 'Sharma', 'Puja', 18);
select * from employee;
drop table employee;

 

CREATE TABLE employee (
    ID int NOT NULL,
    LastName varchar(255) NOT NULL,
    FirstName varchar(255),
    Age int,
    City varchar(255),
    CONSTRAINT CHK_employee CHECK (Age>=18 OR City='Vellore')
);
insert into employee
values (1, 'Sharma', 'Puja', 18, 'Vellore');
insert into employee
values (1, 'Sharma', 'Puja', 25, 'chennai');
drop table employee;

 

CREATE TABLE employee (
    ID int NOT NULL,
    LastName varchar(255) NOT NULL,
    FirstName varchar(255),
    Age int,
    City varchar(255),
    CONSTRAINT CHK_employee CHECK (Age between 18 and 26 AND City='Vellore')
);
insert into employee
values (1, 'Sharma', 'Puja', 29, 'vellore');

 

#alter
CREATE TABLE employee (
    ID int NOT NULL,
    LastName varchar(255) NOT NULL,
    FirstName varchar(255),
    Age int,
    City varchar(255)
);
ALTER TABLE employee
ADD CHECK (Age>=18);

 

ALTER TABLE employee
ADD CONSTRAINT CHK_employee CHECK (Age>=18 AND City='vellore');

 

#drop
ALTER TABLE employee
DROP CHECK CHK_employee;
insert into employee
values (1, 'Sharma', 'Puja', 15, 'vellore');
select * from employee;

 

drop table employee;
#DEFAULT Constraint: used to set a default value for a column.
#create
CREATE TABLE employee (
    ID int NOT NULL,
    LastName varchar(255) NOT NULL,
    FirstName varchar(255),
    Age int,
    City varchar(255) DEFAULT 'vellore'
);
desc employee;
select * from employee;
insert into employee
values (1, 'Sharma', 'Puja', 29, 'chennai');
insert into employee
(ID, lastname, firstname, age)
values (2, 'Sharma', 'Puja', 29);
select * from employee;

 

#alter
ALTER TABLE employee
ALTER City SET DEFAULT 'vellore',
ALTER age SET DEFAULT 18;
desc employee;

 

#drop
ALTER TABLE employee
ALTER City DROP DEFAULT;
desc employee;

 

insert into employee
values (1, 'Sharma', 'Puja', 28, 'chennai'), (2, 'roy', 'rohit', 25, 'vellore');