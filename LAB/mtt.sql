CREATE DATABASE mttanswers;
USE mttanswers;
create table SAILOR(
	SID int primary key,
    NAME varchar(100),
    DOB date,
    GENDER varchar(50));
    
create table BOAT(
	BID int primary key,
    BTYPE varchar(100),
    BNAME varchar(100),
    COLOR varchar(50),
    Constraint CHK_BTYPE check(BTYPE ='D' OR BTYPE='S'));
    
create table SAILS(
	SID int,
    BID int,
    DOT date,
    SHIFT varchar(10),
    primary key (SID,BID,DOT),
    CONSTRAINT CHK_SHIFT check ( SHIFT ='AN' or SHIFT = 'FN'),
    foreign key (SID) references SAILOR(SID),
	foreign key (BID) references BOAT(BID));
    
DESC SAILOR;
DESC BOAT;
DESC SAILS;
INSERT INTO SAILOR VALUES (1,'RAM','2000-10-13','MALE');
INSERT INTO SAILOR VALUES (2,'SITA','1998-1-13','FEMALE');
INSERT INTO SAILOR VALUES (3,'HARI','1997-11-13','MALE');
INSERT INTO SAILOR VALUES (4,'SAM','1999-9-13','MALE');
INSERT INTO SAILOR VALUES (5,'GITA','2001-5-13','FEMALE');

INSERT INTO BOAT VALUES (1,'D','NIRVANA','BLUE');
INSERT INTO BOAT VALUES (2,'S','PACIFIC SAILORS','RED');
INSERT INTO BOAT VALUES (3,'D','JAAHAJ','GREEN');
INSERT INTO BOAT VALUES (4,'D','DUNGA','YELLOW');
INSERT INTO BOAT VALUES (5,'S','PIRATES','BROWN');

INSERT INTO SAILS VALUES (1,2,'2020-10-13','FN');
INSERT INTO SAILS VALUES (3,4,'2021-04-01','FN');
INSERT INTO SAILS VALUES (4,3,'2021-07-01','AN');
INSERT INTO SAILS VALUES (5,5,'2021-09-11','FN');

SELECT * FROM SAILOR;
SELECT * FROM BOAT;
SELECT * FROM SAILS;

SELECT * FROM BOAT 
WHERE (BTYPE='S') AND (COLOR='RED');



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

delimiter $$
drop procedure if exists nullchk;
CREATE PROCEDURE nullchk()
BEGIN
    -- exit if the null occurs
    DECLARE EXIT HANDLER FOR 1364
    BEGIN
     SELECT ('SID, NO SUCH SAILOR EXISTS') AS message;
    END;
    
    INSERT INTO SAILOR(SID) VALUES(2);
    
END$$
CALL nullchk();




create procedure sailorInformation (
    in SID int,
    out NAME varchar(50))
begin
      select SID
      into NAME
      limit 1;
end$$


create procedure userInformation (
    in SID int,
    out SAILOR_NAME varchar(50),

   )
begin
      select concat(u.firstname, ' ', u.lastname)
      into out_fullname
      from users u
      where u.userid = in_uID;

      select o.occupation
      into out_job
      from occupation o join
           users u 
           on u.occupationID = o.occupationid
      where u.userid = in_uID;

      select ue.useremail
      into out_email
      from useremail ue JOIN
           users u
           on ue.userid = u.userid
      where ue.userid = in_uID
      limit 1;
end$$



create procedure userInformation (
    in SID int,
    out SAILOR_NAME varchar(50)
   
   )
begin
      select SID
      into SAILOR_NAME
      limit 1;
end$$


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
create procedure sailor_name(in sail_id int, out result varchar(250) )
begin
declare sname_out varchar(250);
Select sname into sname_out from sailor where sid = sail_id;
set result= concat(sname);
 end $$
 
 
call  sailor_name(11,@result);
select @result;




delimiter $$
create procedure get_name(in isid int
    , out sname varchar(20))
begin
    set @sanme = 'a';

    select sname into @sname 
    where sid = isid;

    sname = @sname;
end;

$$