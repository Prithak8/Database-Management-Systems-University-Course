
create table tourism(
	Id int primary key,
    Place varchar(50) );
desc tourism;

#1
DELIMITER $$
#DROP PROCEDURE IF EXISTS print_odd;
CREATE PROCEDURE print_odd()
BEGIN
    DECLARE x  INT;
    DECLARE ODD VARCHAR(100);
    SET x = 1;
    SET ODD='';
    loop_odd:  LOOP
		SET ODD = CONCAT(ODD,x,',');
		set x = x + 2;
        IF x>20 THEN
			LEAVE loop_odd;
		END IF;
    END LOOP;
    select ODD;
END$$
call print_odd();


#2
Delimiter $$
#Drop procedure if exists ins_tourism;
create procedure ins_tourism()
begin
declare a int;
declare xyz varchar(50);
set a = 2;
set xyz = '';
while a <=12 do
	set xyz = concat('Place',a+1);
    insert into tourism 
    values(a,xyz);
    set a = a + 2;
    end while;
end$$
call ins_tourism();

select * from tourism;
truncate table tourism;


#3
Delimiter $$
DROP PROCEDURE IF EXISTS page_tourism;
CREATE PROCEDURE page_tourism()
begin
DECLARE count INT;
SET count = 0;
WHILE count< (Select count(Id) from tourism) do
   SELECT * FROM tourism limit 2 offset count;
   SET count = count + 2;
END while;
end$$
call page_tourism();


#4
Delimiter $$
DROP PROCEDURE IF EXISTS loopdemo;
CREATE PROCEDURE loopdemo()
BEGIN
declare a int;
set a = 4;
while a<= (Select max(Id) from tourism) do
	select Id,Place from tourism
    where Id = a;
    set a = a + 4;
end while;
end$$
call loopdemo();

Delimiter $$
DROP PROCEDURE IF EXISTS disp_tup;
CREATE PROCEDURE disp_tup()
BEGIN
call loopdemo();
end$$
call disp_tup();


#5
create table place_name (Name varchar (100));
Delimiter $$
DROP PROCEDURE IF EXISTS np;
CREATE PROCEDURE np()
BEGIN
insert into place_name values(@contname);
end$$
Delimiter $$
DROP PROCEDURE IF EXISTS While_Loop;
CREATE PROCEDURE While_Loop()
BEGIN
DECLARE Counter, MaxId INT; 
DECLARE ContName VARCHAR(100);
set counter = (SElect min(Id) from tourism);
set maxID = (SElect max(Id) from tourism);
set @contname='';

while (Counter-1 <= MaxId) do
   SET @ContName = (select Place FROM tourism WHERE Id = counter );
   call np();
   SET Counter  = Counter  + 4;        
END while;
end$$
call While_Loop();
select * from place_name;
drop table place_name;