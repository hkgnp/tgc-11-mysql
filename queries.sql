/* logging in */
/* the root account has been created by default */
mysql -u root

/* see all databases */
show databases;

/* create a database */
create database swimming;

/* switch database */
use swimming;

/* show all tables */
show tables;

/* create table */
create table Parents (
    parent_id int unsigned auto_increment primary key,
    surname varchar(50) not null,
    given_name varchar(50) not null,
    email varchar(350) not null
) engine=innodb;

/* insert one row into the table */
insert into Parents (surname, given_name, email)
    values ('Phua', 'Chua Kang', 'chukang@phua.com.sg');

insert into Parents (surname, given_name, email)
    values ('Lim', 'Megan', 'meganlim@fake.com.sg');

insert into Parents (surname, given_name, email)
    values ('Tan', 'Arthur', 'arthurtan@fake.com.sg');

insert into Parents (surname, given_name, email)
    values ('Lee', 'Johnson', 'johnson@lee.com.sg');
/* see all the rows in a table */
select * from Parents;

-- Create certificates
create table Certificates (
    certificate_id int unsigned auto_increment primary key,
    title varchar(100) not null
) engine=innodb;

insert into Certificates (title) 
    values ('Basic Swimming'),
           ('Basic Lifesaving'),
           ('Advanced Lifesaving');

select * from Certificates;

create table Venues (
    venue_id tinyint unsigned auto_increment primary key,
    `name` varchar(100)  not null,
    `address` varchar(500) not null
) engine=innodb;

insert into Venues (`name`, address) values
    ('Yishun Swimming Complex', 'Yishun Ave 4'),
    ('Ang Mio Ko Swimming Complex', 'Ang Mio Kio Ave 1');

describe venues; 

--Foreign keys

create table Students (
    student_id int unsigned auto_increment primary key,
    surname varchar(100) not null,
    given_name varchar(100) not null,
    date_of_birth date not null,
    parent_id int unsigned not null,
    foreign key (parent_id) references Parents(parent_id)
) engine=innodb;

insert into Students (surname, given_name, date_of_birth, parent_id)
    values ('Phua', 'Anthony', '1990-06-21', 1);

insert into Students (surname, given_name, date_of_birth, parent_id)
    values ('Lim', 'Mary', '1990-10-12', 2);

-- To delete
delete from Parents where parent_id = 1;

create table Sessions (
    session_id int unsigned auto_increment primary key,
    session_date datetime not null,
    venue_id tinyint unsigned not null,
    foreign key (venue_id) references Venues(venue_id)
) engine = innodb;

-- delete rules
-- to ber inserted at the foreign key
-- eg foreign key (venue_id) references Venues(venue_id) on delete restrict
-- most useful is on delete cascade BUT must be very careful, default is on delete restrict, 
on delete restrict
on delete cascade
on delete set null

insert into Sessions(session_date, venue_id, coach_id)
    values ('2020-12-31 13:00:00', 1,2);

insert into Sessions(session_date, venue_id, coach_id)
    values ('2020-12-31 13:00:00', 2,1);

-- Creating table with ONLY foreign keys
create table CertificateStudent (
    certificate_student_id int unsigned auto_increment primary key,
    student_id int unsigned,
    certificate_id int unsigned,
    award_date date not null,
    foreign key (student_id) references Students(student_id),
    foreign key (certificate_id) references Certificates(certificate_id)
) engine = innodb;

insert into CertificateStudent(student_id, certificate_id, award_date)
    values (1,2,'2021-02-01');

-- Adding column to a table (alter table)
alter table Students add gender varchar(1) not null;

-- Renaming a column
alter table Students rename column surname to last_name;
alter table Students rename column given_name to first_name;

-- Modify definition of column
alter table Students modify gender varchar(1) null;

-- Deleting a table (called fake) (assuming it has no relations, e.g. foreign keys)
drop table Fake;

-- Deleting row
delete from Parents where parent_id = 2;

-- Modifying a row
update Students set first_name = "Peter" where student_id = 1;

-- Adding in a foreign key after the table exists (not recommended)
-- 1. Create new table
create table Coaches (
    coach_id tinyint unsigned auto_increment primary key,
    coach_name varchar(100) not null
) engine=innodb;

-- 2. Add in the new column
alter table Sessions add coach_id tinyint unsigned not null;

-- 3. Add in foreign key definition
alter table Sessions add foreign key(coach_id) references Coaches(coach_id);

