
-- Task 2 - 4

DROP DATABASE IF EXISTS MyJoinsDB;

CREATE DATABASE IF NOT EXISTS MyJoinsDB DEFAULT CHARACTER SET utf8 ;
USE MyJoinsDB ;

CREATE TABLE IF NOT EXISTS positions (
  position_id INT NOT NULL,
  position_name VARCHAR(45) NULL,
  PRIMARY KEY (position_id))
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS salary (
  salary_id INT NOT NULL AUTO_INCREMENT,
  salary INT NOT NULL,
  position_id INT NOT NULL,
  PRIMARY KEY (salary_id),
  CONSTRAINT fk_salary_positions
    FOREIGN KEY (position_id)
    REFERENCES positions (position_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS merital_status (
  merital_status_id INT NOT NULL AUTO_INCREMENT,
  merital_status VARCHAR(45) NOT NULL,
  PRIMARY KEY (merital_status_id))
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS personal_data (
  personal_data_id INT NOT NULL AUTO_INCREMENT,
  merital_status_id INT NOT NULL,
  date_of_birthd DATE NOT NULL,
  home_address VARCHAR(100) NULL,
  PRIMARY KEY (personal_data_id),
  CONSTRAINT fk_personal_data_merital_status1
    FOREIGN KEY (merital_status_id)
    REFERENCES merital_status (merital_status_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS employees (
  employee_id INT NOT NULL AUTO_INCREMENT,
  first_name VARCHAR(45) NOT NULL,
  last_name VARCHAR(45) NOT NULL,
  phone_number VARCHAR(15) NULL,
  salary_id INT NOT NULL,
  personal_data_id INT NOT NULL,
  PRIMARY KEY (employee_id),
  CONSTRAINT fk_employees_salary1
    FOREIGN KEY (salary_id)
    REFERENCES salary (salary_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_employees_personal_data1
    FOREIGN KEY (personal_data_id)
    REFERENCES personal_data (personal_data_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- ---------------------------------------------
-- Add data
-- ----------------------------------------------

INSERT INTO positions (position_id, position_name) VALUES
(1, 'Manager'),
(2, 'Developer'),
(3, 'Designer'),
(4, 'Salesperson'),
(5, 'Accountant');

INSERT INTO salary (salary, position_id) VALUES
(5000, 1),
(4000, 2),
(3500, 3),
(3000, 4),
(4500, 5);

INSERT INTO merital_status (merital_status) VALUES
('Single'),
('Married'),
('Divorced'),
('Widowed'),
('In a relationship');

INSERT INTO personal_data (merital_status_id, date_of_birthd, home_address) VALUES
(1, '1990-05-10', '123 Main St'),
(2, '1985-12-15', '456 Elm St'),
(3, '1978-08-25', '789 Oak St'),
(2, '1995-03-05', '321 Pine St'),
(1, '1982-07-20', '987 Maple St'),
(4, '1972-11-30', '654 Birch St'),
(5, '1998-09-12', '234 Cedar St'),
(1, '1993-01-18', '876 Spruce St'),
(3, '1987-06-08', '543 Fir St'),
(2, '1991-04-02', '210 Walnut St');

INSERT INTO employees (first_name, last_name, phone_number, salary_id, personal_data_id) VALUES
('John', 'Doe', '555-1234', 1, 1),
('Jane', 'Smith', '555-5678', 2, 2),
('Mike', 'Johnson', '555-4321', 3, 3),
('Sarah', 'Williams', '555-8765', 4, 4),
('David', 'Brown', '555-9876', 5, 5),
('Emily', 'Taylor', '555-2345', 1, 6),
('Michael', 'Anderson', '555-6789', 2, 7),
('Jessica', 'Thomas', '555-3456', 3, 8),
('Daniel', 'Wilson', '555-7890', 4, 9),
('Laura', 'Martinez', '555-2109', 5, 10);


-- ---------------------------------
-- Requests
-- ---------------------------------

SELECT employees.first_name, employees.last_name, employees.phone_number, personal_data.home_address
FROM employees
JOIN personal_data ON personal_data.personal_data_id = employees.personal_data_id;

SELECT employees.first_name, employees.last_name, employees.phone_number, personal_data.date_of_birthd
FROM employees
JOIN personal_data ON personal_data.personal_data_id = employees.personal_data_id
JOIN merital_status ON merital_status.merital_status_id = personal_data.merital_status_id
WHERE merital_status.merital_status != 'Married' AND  merital_status.merital_status != 'In a relationship' ;

SELECT employees.first_name, employees.last_name, employees.phone_number, personal_data.date_of_birthd
FROM employees
JOIN personal_data ON personal_data.personal_data_id = employees.personal_data_id
JOIN salary ON salary.salary_id = employees.salary_id
JOIN positions ON positions.position_id = salary.salary_id
WHERE positions.position_name = 'Manager';
