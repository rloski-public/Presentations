use Test_Logins;


create table PublicTable (id int identity(1,1) primary key, val int, tableName varchar(100));
create table PrivateTable (id int identity(1,1) primary key, val int, tableName varchar(100));
create table Drop1 (id int identity(1,1) primary key, val int);





insert PublicTable 
select number, 'PublicTable' from master.dbo.spt_values where type = 'P';

insert PrivateTable 
select number, 'PrivateTable' from master.dbo.spt_values where type = 'P'


