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




