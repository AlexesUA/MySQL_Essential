
-- I am united the task2 and task3

DROP DATABASE IF EXISTS military_personnel_department;

CREATE DATABASE IF NOT EXISTS military_personnel_department DEFAULT CHARACTER SET utf8 ;
USE military_personnel_department ;

CREATE TABLE IF NOT EXISTS ranks (
  rank_id INT NOT NULL AUTO_INCREMENT,
  rank_name VARCHAR(45) NOT NULL,
  rank_skin_link VARCHAR(256) NOT NULL,
  PRIMARY KEY (rank_id))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS positions (
  position_id INT NOT NULL AUTO_INCREMENT,
  position_name VARCHAR(45) NOT NULL,
  max_rank_id INT NOT NULL,
  PRIMARY KEY (position_id),
  CONSTRAINT fk_positions_ranks
    FOREIGN KEY (max_rank_id)
    REFERENCES military_personnel_department.ranks (rank_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS employees (
  employee_id INT NOT NULL AUTO_INCREMENT,
  personal_number VARCHAR(45) NOT NULL,
  first_name VARCHAR(45) NOT NULL,
  last_name VARCHAR(45) NOT NULL,
  date_o_birth VARCHAR(45) NOT NULL,
  date_of_death VARCHAR(45) NULL,
  PRIMARY KEY (employee_id, personal_number))  
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS departments (
  department_id INT NOT NULL AUTO_INCREMENT,
  department_name VARCHAR(45) NOT NULL,
  department_max_size INT NULL,
  PRIMARY KEY (department_id))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS ranks_has_employees (
  id INT NOT NULL AUTO_INCREMENT,
  ranks_rank_id INT NOT NULL,
  employees_employee_id INT NOT NULL,
  employees_personal_number VARCHAR(45) NOT NULL,
  date_of_get_rank DATE NOT NULL,
  PRIMARY KEY (id, ranks_rank_id, employees_employee_id, employees_personal_number),
  CONSTRAINT fk_ranks_has_employees
    FOREIGN KEY (ranks_rank_id)
    REFERENCES military_personnel_department.ranks (rank_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_employees_has_ranks
    FOREIGN KEY (employees_employee_id , employees_personal_number)
    REFERENCES military_personnel_department.employees (employee_id , personal_number)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS weapons_type (
  weapon_type_id INT NOT NULL AUTO_INCREMENT,
  weapon_type VARCHAR(45) NOT NULL,
  PRIMARY KEY (weapon_type_id))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS personal_weapons (
  weapon_id INT NOT NULL,
  weapon_number VARCHAR(45) NOT NULL,
  weapon_type_id INT NOT NULL,
  PRIMARY KEY (weapon_id, weapon_number),
  CONSTRAINT fk_personal_weapons_weapons_type
    FOREIGN KEY (weapon_type_id)
    REFERENCES military_personnel_department.weapons_type (weapon_type_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS employees_has_personal_weapons (
  id INT NOT NULL AUTO_INCREMENT,
  employees_employee_id INT NOT NULL,
  employees_personal_number VARCHAR(45) NOT NULL,
  personal_weapons_weapon_id INT NOT NULL,
  personal_weapons_weapon_number VARCHAR(45) NOT NULL,
  PRIMARY KEY (id, employees_employee_id, employees_personal_number, personal_weapons_weapon_id, personal_weapons_weapon_number),
  CONSTRAINT fk_employees_has_personal_weapons
    FOREIGN KEY (employees_employee_id , employees_personal_number)
    REFERENCES military_personnel_department.employees (employee_id , personal_number)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_personal_weapons_has_employees
    FOREIGN KEY (personal_weapons_weapon_id , personal_weapons_weapon_number)
    REFERENCES military_personnel_department.personal_weapons (weapon_id , weapon_number)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS employees_has_departments (
  id INT NOT NULL AUTO_INCREMENT,
  employees_employee_id INT NOT NULL,
  employees_personal_number VARCHAR(45) NOT NULL,
  departments_department_id INT NOT NULL,
  positions_position_id INT NOT NULL,
  date_of_transfer_to_department DATE NOT NULL,
  PRIMARY KEY (id, employees_employee_id, employees_personal_number, departments_department_id, positions_position_id),
  CONSTRAINT fk_employees_has_departments
    FOREIGN KEY (employees_employee_id , employees_personal_number)
    REFERENCES military_personnel_department.employees (employee_id , personal_number)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_departments_has_employees
    FOREIGN KEY (departments_department_id)
    REFERENCES military_personnel_department.departments (department_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_employees_has__positions
    FOREIGN KEY (positions_position_id)
    REFERENCES military_personnel_department.positions (position_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS rewards_and_reprimands (
  id INT NOT NULL AUTO_INCREMENT,
  type VARCHAR(45) NOT NULL,
  name VARCHAR(45) NOT NULL,
  date DATE NOT NULL,
  description VARCHAR(255) NULL,
  PRIMARY KEY (id))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS employees_has_rewards_and_reprimands (
  id INT NOT NULL AUTO_INCREMENT,
  employees_employee_id INT NOT NULL,
  employees_personal_number VARCHAR(45) NOT NULL,
  rewards_and_reprimands_id INT NOT NULL,
  PRIMARY KEY (id, employees_employee_id, employees_personal_number, rewards_and_reprimands_id),
  CONSTRAINT fk_employees_has_rewards_and_reprimands
    FOREIGN KEY (employees_employee_id , employees_personal_number)
    REFERENCES military_personnel_department.employees (employee_id , personal_number)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_rewards_and_reprimands_has_employees
    FOREIGN KEY (rewards_and_reprimands_id)
    REFERENCES military_personnel_department.rewards_and_reprimands (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- ---------------------------------------------------
-- Add data
-- ---------------------------------------------------
INSERT INTO ranks (rank_name, rank_skin_link) VALUES
('Private', 'link1'),
('Corporal', 'link2'),
('Sergeant', 'link3'),
('Lieutenant', 'link4'),
('Captain', 'link5');

INSERT INTO positions (position_name, max_rank_id) VALUES
('Infantry', 3),
('Artillery', 4),
('Logistics', 2),
('Medical', 2),
('Intelligence', 5);

INSERT INTO employees (personal_number, first_name, last_name, date_o_birth, date_of_death) VALUES
('12345', 'John', 'Doe', '1990-05-15', NULL),
('54321', 'Jane', 'Smith', '1985-09-20', '2022-03-10'),
('67890', 'Michael', 'Johnson', '1992-02-28', NULL),
('98765', 'Emily', 'Brown', '1988-12-07', NULL),
('13579', 'Robert', 'Davis', '1995-07-25', NULL),
('24680', 'Emma', 'Wilson', '1993-11-18', NULL),
('11223', 'David', 'Taylor', '1987-04-05', NULL),
('44556', 'Olivia', 'Miller', '1991-08-30', NULL),
('78901', 'Daniel', 'Anderson', '1994-06-12', NULL),
('10203', 'Sophia', 'Clark', '1989-10-03', NULL);

INSERT INTO departments (department_name, department_max_size) VALUES
('Alpha Company', 50),
('Bravo Company', 40),
('Charlie Company', 35),
('Delta Company', 45),
('Echo Company', 30);

INSERT INTO ranks_has_employees (ranks_rank_id, employees_employee_id, employees_personal_number, date_of_get_rank) VALUES
(1, 1, '12345', '2020-01-15'),
(2, 2, '54321', '2018-05-10'),
(3, 3, '67890', '2019-09-20'),
(4, 4, '98765', '2021-03-05'),
(3, 5, '13579', '2018-07-15'),
(2, 6, '24680', '2020-11-10'),
(3, 7, '11223', '2017-02-25'),
(4, 8, '44556', '2019-06-30'),
(5, 9, '78901', '2020-04-12'),
(4, 10, '10203', '2017-08-25');

INSERT INTO weapons_type (weapon_type) VALUES
('Assault Rifle'),
('Sniper Rifle'),
('Pistol'),
('Machine Gun'),
('Grenade Launcher');

INSERT INTO personal_weapons (weapon_id, weapon_number, weapon_type_id) VALUES
(1, 'AR001', 1),
(2, 'SR001', 2),
(3, 'P001', 3),
(4, 'MG001', 4),
(5, 'GL001', 5);

INSERT INTO employees_has_personal_weapons (employees_employee_id, employees_personal_number, personal_weapons_weapon_id, personal_weapons_weapon_number) VALUES
(1, '12345', 1, 'AR001'),
(2, '54321', 2, 'SR001'),
(3, '67890', 3, 'P001'),
(4, '98765', 4, 'MG001'),
(5, '13579', 5, 'GL001'),
(6, '24680', 1, 'AR001'),
(7, '11223', 2, 'SR001'),
(8, '44556', 3, 'P001'),
(9, '78901', 4, 'MG001'),
(10, '10203', 5, 'GL001');

INSERT INTO employees_has_departments (employees_employee_id, employees_personal_number, departments_department_id, positions_position_id, date_of_transfer_to_department) VALUES
(1, '12345', 1, 1, '2020-01-15'),
(2, '54321', 2, 1, '2018-05-10'),
(3, '67890', 3, 2, '2019-09-20'),
(4, '98765', 4, 3, '2021-03-05'),
(5, '13579', 5, 3, '2018-07-15'),
(6, '24680', 1, 4, '2020-11-10'),
(7, '11223', 2, 4, '2017-02-25'),
(8, '44556', 3, 5, '2019-06-30'),
(9, '78901', 4, 5, '2020-04-12'),
(10, '10203', 5, 2, '2017-08-25');

INSERT INTO rewards_and_reprimands (type, name, date, description) VALUES
('Reward', 'Service Medal', '2022-05-10', 'For exceptional performance.'),
('Reprimand', 'Violation Warning', '2021-08-20', 'For breaking military regulations.'),
('Reward', 'Achievement Award', '2023-01-05', 'For outstanding achievements.'),
('Reward', 'Bravery Medal', '2022-11-15', 'For acts of bravery in combat.'),
('Reprimand', 'Absenteeism Warning', '2021-10-02', 'For repeated unauthorized absences.');

INSERT INTO employees_has_rewards_and_reprimands (employees_employee_id, employees_personal_number, rewards_and_reprimands_id) VALUES
(1, '12345', 1),
(2, '54321', 2),
(3, '67890', 3),
(4, '98765', 4),
(5, '13579', 5),
(6, '24680', 1),
(7, '11223', 2),
(8, '44556', 3),
(9, '78901', 4),
(10, '10203', 5);

-- ----------------------------------------------------
-- requests
-- ---------------------------------------------------

SELECT employees.*, ranks.rank_name, ranks_has_employees.date_of_get_rank, departments.department_name, positions.position_name, 
    employees_has_departments.date_of_transfer_to_department, weapons_type.weapon_type, personal_weapons.weapon_number
FROM employees
JOIN ranks_has_employees ON ranks_has_employees.employees_employee_id = employees.employee_id 
    AND ranks_has_employees.employees_personal_namber = employees.personal_namber
JOIN ranks ON ranks.rank_id = ranks_has_employees.ranks_rank_id
JOIN employees_has_departments ON employees_has_departments.employees_employee_id = employees.employee_id 
    AND employees_has_departments.employees_personal_namber = employees.personal_namber
JOIN departments ON departments.department_id = employees_has_departments.departments_department_id
JOIN positions ON positions.position_id = employees_has_departments.positions_position_id
JOIN employees_has_personal_weapons ON employees_has_personal_weapons.employees_employee_id = employees.employee_id 
    AND employees_has_personal_weapons.employees_personal_namber = employees.personal_namber
JOIN personal_weapons ON personal_weapons.weapon_id = employees_has_personal_weapons.personal_weapons_weapon_id
JOIN weapons_type ON weapons_type.weapon_type_id = personal_weapons.weapon_type_id;

    
    
