
-- ------------------------------------
-- HomeTask 1, tasks 2-5
-- ------------------------------------

DROP DATABASE mydb;

CREATE DATABASE MyDB;

USE MyDB;

CREATE TABLE positions
(
	position_id int auto_increment not null  primary key,
    position varchar(20) not null,
    salary int not null,
    premium int
);

CREATE TABLE personal_data
(
	pd_id int auto_increment not null  primary key,
    is_married boolean not null,
    count_children int,
    home_address varchar(50) not null
);

CREATE TABLE employees
(
	employee_id int auto_increment not null primary key,
    first_name varchar(50) not null,
    last_name varchar(50) not null,
    birthday date not null,
    phone_number int,
    position_id int not null,
    personal_data_id int not null,
    foreign key(position_id) references positions(position_id),
    foreign key(personal_data_id) references personal_data(pd_id)
);

INSERT INTO positions (position, salary, premium)
VALUES
    ('Manager', 10000, 2000),
    ('Developer', 12000, 1500),
    ('Accountant', 6000, 1000),
    ('Salesperson', 7000, 1200),
    ('Designer', 7500, 1300);
    
INSERT INTO personal_data (is_married, count_children, home_address)
VALUES
    (1, 2, '123 Main St'),
    (0, 0, '456 Elm St'),
    (1, 1, '789 Oak St'),
    (0, 3, '321 Pine St'),
    (1, 0, '654 Maple St');
    
INSERT INTO employees (first_name, last_name, birthday, phone_number, position_id, personal_data_id)
VALUES
    ('John', 'Doe', '1990-05-10', '123456789', 5, 1),
    ('Jane', 'Smith', '1985-12-15', '987654321', 5, 2),
    ('Michael', 'Johnson', '1992-08-22', null, 3, 3),
    ('Emily', 'Davis', '1994-02-28', '111444777', 1, 4),
    ('David', 'Wilson', '1988-07-03', '333222111', 2, 5);

SELECT * FROM employees
JOIN positions ON employees.position_id = positions.position_id
JOIN personal_data ON employees.personal_data_id = personal_data.pd_id;



SELECT employees.employee_id, employees.last_name, positions.position FROM employees
JOIN positions ON employees.position_id = positions.position_id
WHERE positions.salary > 10000;


-- ------------------------------------
-- HomeTask 1, task 7
-- ------------------------------------

CREATE DATABASE car_db;

USE car_db;

CREATE TABLE cars (
    id int auto_increment primary key,
    brand varchar(50),
    model varchar(50),
    engine_volume decimal(4,2),
    price decimal(10,2),
    max_speed int
);


INSERT INTO cars (brand, model, engine_volume, price, max_speed)
VALUES
    ('Toyota', 'Camry', 2.5, 25000.00, 200),
    ('Honda', 'Civic', 1.8, 18000.00, 190),
    ('Ford', 'Mustang', 5.0, 40000.00, 250),
    ('Chevrolet', 'Cruze', 1.4, 15000.00, 180),
    ('BMW', 'X5', 3.0, 60000.00, 240);
    
SELECT * FROM cars;
