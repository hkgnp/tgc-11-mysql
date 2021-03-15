-- EMPLOYEES DATABASE

create table Taskforces (
taskforce_id int unsigned auto_increment primary key,
name varchar(100) not null
) engine=innodb;

create table Departments (
    department_id int unsigned auto_increment primary key,
    name varchar(100) not null
) engine=innodb;

create table Employees (
    employee_id int unsigned auto_increment primary key,
    surname varchar(100) not null,
    given_name varchar(100) not null,
    date_of_employment datetime not null,
    department_id int unsigned not null,
    foreign key (department_id) references Departments(department_id)
) engine=innodb;

create table Employee_Taskforce (
    employee_taskforce_id int unsigned auto_increment primary key,
    employee_id int unsigned,
    taskforce_id int unsigned,
    foreign key (employee_id) references Employees(employee_id),
    foreign key (taskforce_id) references Taskforces(taskforce_id)
) engine=innodb;

alter table Employee_Taskforce add role varchar(100) not null;

create table Addresses (
    employee_id int unsigned,
    foreign key (employee_id) references Employees(employee_id),
    blk_number varchar(100) not null,
    street varchar(100) not null,
    unit_code varchar(100) not null,
    postal_code tinyint not null
) engine=innodb;

alter table Addresses add address_id int unsigned auto_increment primary key;

create table Employee_Supervisor (
    employee_supervisor_id int unsigned auto_increment primary key,
    employee_id int unsigned,
    foreign key (employee_id) references Employees(employee_id),
    supervisor_id int unsigned,
    foreign key (supervisor_id) references Employees(employee_id)
) engine=innodb;

-- INSERTING ROWS
insert into Departments(name)
    values ('IT Support');

insert into Employees(surname, given_name, department_id, date_of_employment)
    values("Tan", "Ryan", 1, "2020-01-01 00:00:00");

insert into Taskforces(name)
    values('Staff Welfare');

insert into Employee_Taskforce(role, employee_id, taskforce_id)
    values('President', 1, 1)

insert into Employees(surname, given_name, department_id, date_of_employment)
    values("Lee", "Peter", 1, "1980-01-01 00:00:00");

insert into Addresses(employee_id, blk_number, street,unit_code,postal_code)
    values(1, "123A", "Jalan Tua Tau", "#01-01", "123123");

insert into Addresses(employee_id, blk_number, street,unit_code,postal_code)
    values(2, "5", "Henderson Road", "", "00005");

insert into Employee_Supervisor(employee_id, supervisor_id)
    values(1, 2);


