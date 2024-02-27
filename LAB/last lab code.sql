/*What is Exception
An error occurs during the program execution is called Exception in PL/SQL.
PL/SQL facilitates programmers to catch such conditions using exception block 
in the program and an appropriate action is taken against the error condition.*/

 

/*Types:
There are three type of exceptions:
1. Internally defined exceptions are errors which arise from the Oracle Database environment. 
The runtime system raises the internally defined exceptions automatically. 
ORA-27102 (out of memory) is one example of Internally defined exceptions. Note that 
Internally defined exceptions do not have names, but an error code.
2. Predefined exceptions are errors which occur during the execution of the program. The predefined 
exceptions are internally defined exceptions that PL/SQL has given names e.g., NO_DATA_FOUND, TOO_MANY_ROWS.

 

Exception                      Raised when....
DUP_VAL_ON_INDEX         When you try to insert a duplicate value into a unique column.
INVALID_CURSOR             It occurs when we try accessing an invalid cursor.
INVALID_NUMBER              On usage of something other than number in place of number value.
LOGIN_DENIED              At the time when user login is denied.
TOO_MANY_ROWS              When a select query returns more than one row and the destination variable can take only single value.
VALUE_ERROR                  When an arithmetic, value conversion, truncation, or constraint error occurs.
CURSOR_ALREADY_OPEN           Raised when we try to open an already open cursor.

 

3. User-defined exceptions are custom exception defined by users like you. User-defined exceptions 
must be raised explicitly.

 

The following table illustrates the differences between exception categories.

 

Category - Definer -  Has Error Code - Has Name - Raised Implicitly - Raised Explicitly
Internally defined - Runtime system - Always - Only if you assign one -    Yes - Optionally
Predefined - Runtime system - Always - Always - Yes - Optionally
User-defined - User - Only if you assign one - Always -    No - Always*/

 

/* Declare a handler:
To declare a handler, you use the  DECLARE HANDLER statement as follows:

 

DECLARE action HANDLER FOR condition_value statement;

 

If a condition whose value matches the  condition_value , MySQL will execute the statement 
and continue or exit the current code block based on the action .

 

The action accepts one of the following values:
1. CONTINUE :  the execution of the enclosing code block ( BEGIN … END ) continues.
2. EXIT : the execution of the enclosing code block, where the handler is declared, terminates.

 

The  condition_value specifies a particular condition or a class of conditions that activate the handler. 
The  condition_value accepts one of the following values:
1. A MySQL error code.
2. A standard SQLSTATE value. Or it can be an SQLWARNING , NOTFOUND or SQLEXCEPTION condition, 
which is shorthand for the class of SQLSTATE values. The NOTFOUND condition is used for a cursor 
or  SELECT INTO variable_list statement.
3. A named condition associated with either a MySQL error code or SQLSTATE value.

 

The statement could be a simple statement or a compound statement enclosing by the BEGIN and END keywords.*/

 

/*MySQL error handling examples:
1. The following handler set the value of the  hasError variable to 1 and continue the execution 
if an SQLEXCEPTION occurs:

 

DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET hasError = 1;

 

2. The following handler rolls back the previous operations, issues an error message, and exit 
the current code block in case an error occurs. If you declare it inside the BEGIN END block of a 
stored procedure, it will terminate the stored procedure immediately.

 

DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
    ROLLBACK;
    SELECT 'An error has occurred, operation rollbacked and the stored procedure was terminated';
END;

 

3. The following handler sets the value of the  RowNotFound variable to 1 and continues execution 
if there is no more row to fetch in case of a cursor or SELECT INTO statement:

 

DECLARE CONTINUE HANDLER FOR NOT FOUND 
SET RowNotFound = 1;

 

4. If a duplicate key error occurs, the following handler issues an error message and continues execution.
DECLARE CONTINUE HANDLER FOR 1062
SELECT 'Error, duplicate key occurred';*/

use unidb;
desc students;
delimiter $$
drop procedure if exists nullchk;
CREATE PROCEDURE nullchk()
BEGIN
    -- exit if the null occurs
    DECLARE EXIT HANDLER FOR 1364
    BEGIN
     SELECT ('roll number, student name cant be null') AS message;
    END;
    
    -- insert a new row into students
    #INSERT INTO students(roll_no, course) VALUES(1, 'JAVA');
    #INSERT INTO students(course) VALUES('JAVA');
    INSERT INTO students(student_name, course) VALUES('priya', 'JAVA');
    
END$$

 

CALL nullchk;
delimiter $$
drop procedure if exists notable$$
CREATE PROCEDURE notable()
BEGIN
    -- exit if the no table present
    DECLARE EXIT HANDLER FOR 1146
    BEGIN
     SELECT ('used table not exists') AS message;
    END;
    
    -- insert a new row into student
    INSERT INTO student(student_name, course) VALUES('priya', 'JAVA');
    
END$$

 

CALL notable;delimiter $$
drop procedure if exists table_exists$$
CREATE PROCEDURE table_exists()
BEGIN
    -- exit if table already exists
    DECLARE EXIT HANDLER FOR 1050
    BEGIN
     SELECT ('table already exists') AS message;
    END;
    
    create table students (sturoll int);
    
END$$

 

CALL table_exists;delimiter $$
drop procedure if exists table_exists$$
CREATE PROCEDURE table_exists()
BEGIN
    -- exit if table already exists
    DECLARE EXIT HANDLER FOR 1050
    BEGIN
     SELECT ('table already exists') AS message;
    END;
    
    create table students (sturoll int);
    
END$$

 

CALL table_exists;
delimiter $$
drop procedure if exists stu_add_chk;
CREATE PROCEDURE stu_add_chk(stu_id int, stu_address varchar (20))
 BEGIN
   DECLARE stu_count INT;
   DECLARE address_count INT; 

 

  -- check if student exists
   SELECT COUNT(*) INTO stu_count
   FROM students
   WHERE roll_no = stu_id;

 

  IF stu_count != 1 THEN 
     SIGNAL SQLSTATE '45000'
     SET MESSAGE_TEXT = 'stu_id not found in students table.';
   END IF;

 

  -- check if address exists
   SELECT COUNT(*) INTO address_count
   FROM students
   WHERE address = stu_address;

 

  IF address_count != 1 THEN 
     SIGNAL SQLSTATE '45000'
     SET MESSAGE_TEXT = 'stu_address not found in students table.';
   END IF; 

 

END$$

 

call stu_add_chk(1,'mumbai');
call stu_add_chk(2,'USA');
[1:03 PM] Jyotismita Chaki
    
#BEFORE UPDATE
#First, create a new table:
drop table if exists sales_info;
CREATE TABLE sales_info (  
    id INT AUTO_INCREMENT,  
    product VARCHAR(100) NOT NULL,  
    quantity INT NOT NULL DEFAULT 0,  
    fiscalYear SMALLINT NOT NULL,  
    CHECK(fiscalYear BETWEEN 2000 and 2050),  
    CHECK (quantity >=0),  
    UNIQUE(product, fiscalYear),  
    PRIMARY KEY(id)  
);  


#Next, we will insert some records into the sales_info table as follows:
INSERT INTO sales_info(product, quantity, fiscalYear)  
VALUES  
    ('2003 Maruti Suzuki',110, 2020),  
    ('2015 Avenger', 120,2020),  
    ('2018 Honda Shine', 150,2020),  
    ('2014 Apache', 150,2020);  
 select * from sales_info;


/*Next, create a BEFORE UPDATE trigger that is invoked before a change is made to the sales_info table.
The trigger produces an error message and stops the updation if we update the value in the quantity 
column to a new value two times greater than the current value.*/
DELIMITER $$   
drop trigger if exists before_update_salesInfo; 
CREATE TRIGGER before_update_salesInfo  
BEFORE UPDATE  
ON sales_info FOR EACH ROW  
BEGIN  
    DECLARE error_msg VARCHAR(255);  
    SET error_msg = ('The new quantity cannot be greater than 2 times the current quantity');  
    IF new.quantity > old.quantity * 2 THEN  
    SIGNAL SQLSTATE '45000'   #SQLSTATE is a code which identifies SQL error conditions. It composed by five characters, which can be numbers or uppercase. To signal a generic SQLSTATE value, use '45000', which means “unhandled user-defined exception.”
    SET MESSAGE_TEXT = error_msg;  
    END IF;  
END $$ 


#Then, show all triggers in the current database by using the SHOW TRIGGERS statement:
SHOW TRIGGERS;


#call the trigger
UPDATE sales_info SET quantity = 135 WHERE id = 2; select * from sales_info; #This statement works well because it does not violate the rule.
UPDATE sales_info SET quantity = 700 WHERE id = 2;  #It will give the error as follows because it violates the rule. 
 






<https://teams.microsoft.com/l/message/19:giyqDclSvkhaoIPx94Gh6LVXsX6Vaoj0DYXQerC4zyE1@thread.tacv2/1637911108741?tenantId=d4963ce2-af94-4122-95a9-644e8b01624d&amp;groupId=37e608ef-bc03-40a9-aeb9-1d68749af0de&amp;parentMessageId=1637911108741&amp;teamName=FALL 21-22_ELA_(L29+L30)_Database Management Systems&amp;channelName=General&amp;createdTime=1637911108741>
#First, create a new table named SupplierProducts for the demonstration:
drop table if exists SupplierProducts;
CREATE TABLE SupplierProducts (
    supplierId INT,
    productId INT,
    PRIMARY KEY (supplierId , productId)
);

 

#Second, create a stored procedure that inserts product id and supplier id into the SupplierProducts table:
delimiter $$
drop procedure if exists InsertSupplierProduct;
CREATE PROCEDURE InsertSupplierProduct(
    IN inSupplierId INT, 
    IN inProductId INT
)
BEGIN
    -- exit if the duplicate key occurs
    DECLARE EXIT HANDLER FOR 1062
    BEGIN
     SELECT CONCAT('Duplicate key (',inSupplierId,',',inProductId,') occurred') AS message;
    END;
    
    -- insert a new row into the SupplierProducts
    INSERT INTO SupplierProducts(supplierId,productId)
    VALUES(inSupplierId,inProductId);
    
    -- return the products supplied by the supplier id
    SELECT COUNT(*) 
    FROM SupplierProducts
    WHERE supplierId = inSupplierId;
    
END$$

 

CALL InsertSupplierProduct(1,1);
CALL InsertSupplierProduct(1,2);
CALL InsertSupplierProduct(1,3);

 

CALL InsertSupplierProduct(1,3);
/*Because the handler is an EXIT handler, the last statement does not execute:
SELECT COUNT(*) 
FROM SupplierProducts
WHERE supplierId = inSupplierId;*/
#If  you change the EXIT in the handler declaration to CONTINUE , you will also get the number of products provided by the supplier:
DROP PROCEDURE IF EXISTS InsertSupplierProduct;

 

DELIMITER $$

 

CREATE PROCEDURE InsertSupplierProduct(
    IN inSupplierId INT, 
    IN inProductId INT
)
BEGIN
    -- exit if the duplicate key occurs
    DECLARE CONTINUE HANDLER FOR 1062
    BEGIN
    SELECT CONCAT('Duplicate key (',inSupplierId,',',inProductId,') occurred') AS message;
    END;
    
    -- insert a new row into the SupplierProducts
    INSERT INTO SupplierProducts(supplierId,productId)
    VALUES(inSupplierId,inProductId);
    
    -- return the products supplied by the supplier id
    SELECT COUNT(*) 
    FROM SupplierProducts
    WHERE supplierId = inSupplierId;
    
END$$
/*MySQL handler precedence
In case you have multiple handlers that handle the same error, MySQL will call the most specific 
handler to handle the error first based on the following rules:
1. An error always maps to a MySQL error code because in MySQL it is the most specific.
2. An SQLSTATE may map to many MySQL error codes, therefore, it is less specific.
3. An SQLEXCPETION or an SQLWARNING is the shorthand for a class of SQLSTATES values so it is the most generic.

 

Based on the handler precedence rules,  MySQL error code handler, SQLSTATE handler and SQLEXCEPTION takes 
the first, second and third precedence.*/

 

#Suppose that we have three handlers in the handlers in the stored procedure
DROP PROCEDURE IF EXISTS InsertSupplierProduct;

 

DELIMITER $$

 

CREATE PROCEDURE InsertSupplierProduct(
    IN inSupplierId INT, 
    IN inProductId INT
)
BEGIN
    -- exit if the duplicate key occurs
    DECLARE EXIT HANDLER FOR 1062 SELECT 'Duplicate keys error encountered' Message; 
    DECLARE EXIT HANDLER FOR SQLEXCEPTION SELECT 'SQLException encountered' Message; 
    DECLARE EXIT HANDLER FOR SQLSTATE '23000' SELECT 'SQLSTATE 23000' ErrorCode;
    
    -- insert a new row into the SupplierProducts
    INSERT INTO SupplierProducts(supplierId,productId)
    VALUES(inSupplierId,inProductId);
    
    -- return the products supplied by the supplier id
    SELECT COUNT(*) 
    FROM SupplierProducts
    WHERE supplierId = inSupplierId;
    
END$$

 

CALL InsertSupplierProduct(1,3);
#######################################################################################

 

/*Using a named error condition:
MySQL provides you with the DECLARE CONDITION statement that declares a named error condition, 
which associates with a condition.
Here is the syntax of the DECLARE CONDITION statement:

 

DECLARE condition_name CONDITION FOR condition_value;

 

The condition_value  can be a MySQL error code such as 1146 or a SQLSTATE value. 
The condition_value is represented by the condition_name .

 

After the declaration, you can refer to condition_name instead of condition_value .*/

 

DROP PROCEDURE IF EXISTS TestProc;
DELIMITER $$
CREATE PROCEDURE TestProc()
BEGIN
    DECLARE TableNotFound CONDITION for 1146 ; 

 

    DECLARE EXIT HANDLER FOR TableNotFound 
    SELECT 'Please create table abc first' Message; 
    SELECT * FROM abc;
END$$

 

call TestProc();

 

CALL InsertSupplierProduct(1,3);
