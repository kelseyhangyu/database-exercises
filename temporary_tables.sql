# ------------------------------ temp tables -------------------------------#
 -- once created, last through the whole session
 -- DML: data manipulation language; DDL: data definition language
 # example 1 #
 create temporary table runners (
 id int primary key,
 table_name_ varchar(50),
 age int,
 gender char(1),
 event_name varchar(50),
 best_time float 
 );

 insert into runners
 (id,table_name_,age,gender,event_name,best_time) values
 (1,'michael',31,'F','400 meters',3.18),
 (1,'john',31,'F','400 meters',3.18)
 ;
 # example 2#
create temporary table music 
(
select * from albums
where artist = 'Beatles'
) ;

#---------------------------- example practices -------------------------------#
use ursula_2336;
select database();
create temporary table runners (
 id int primary key,
 table_name_ varchar(50),
 age int,
 gender char(1),
 event_name varchar(50),
 best_time float 
 );
  insert into runners
 (id,table_name_,age,gender,event_name,best_time) values
 (1,'michael',31,'F','400 meters',3.18),
 (2,'john',31,'F','400 meters',3.18)
 ;
 select * from runners;
 drop table runners;














