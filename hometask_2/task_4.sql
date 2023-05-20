

-- -----------------------------------------------------
-- Home Task 2.4
-- Спроектируйте базу данных для системы отдела кадров 
-- -----------------------------------------------------
DROP DATABASE IF EXISTS company_employees;
CREATE DATABASE IF NOT EXISTS company_employees;
USE company_employees;

CREATE TABLE IF NOT EXISTS positions (
  position_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  position_name VARCHAR(45) NOT NULL,
  position_salary DECIMAL(10,2) NOT NULL
);


CREATE TABLE IF NOT EXISTS employees (
  employee_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  first_name VARCHAR(45) NOT NULL,
  last_name VARCHAR(45) NOT NULL,
  birthday_date DATE NOT NULL,
  date_of_employment DATE NOT NULL,
  salary_bonus DECIMAL(10,2) NOT NULL
);

CREATE TABLE IF NOT EXISTS employees_has_positions (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  employee_id INT NOT NULL,
  position_id INT NOT NULL,
  date_of_take_position DATE NOT NULL,
  FOREIGN KEY (employee_id) REFERENCES company_employees.employees (employee_id),
  FOREIGN KEY (position_id) REFERENCES company_employees.positions (position_id)
);


INSERT INTO positions (position_name, position_salary) VALUES
  ('Менеджер', 5000.00),
  ('Розробник', 6000.00),
  ('Бухгалтер', 4500.00),
  ('Адміністратор', 4000.00),
  ('Тестувальник', 5500.00);

INSERT INTO employees (first_name, last_name, birthday_date, date_of_employment, salary_bonus) VALUES
  ('Іван', 'Петров', '1990-05-10', '2020-01-15', 1000.00),
  ('Марія', 'Сидоренко', '1985-12-18', '2018-06-20', 800.00),
  ('Олександр', 'Василенко', '1992-08-25', '2019-03-05', 1200.00),
  ('Оксана', 'Коваленко', '1988-07-02', '2017-09-10', 900.00),
  ('Андрій', 'Семенов', '1993-03-15', '2021-11-05', 1100.00);

INSERT INTO employees_has_positions (employee_id, position_id, date_of_take_position) VALUES
  (1, 1, '2020-01-15'),
  (2, 2, '2018-06-20'),
  (3, 3, '2019-03-05'),
  (4, 4, '2017-09-10'),
  (5, 5, '2021-11-05');
  
  SELECT employees.first_name, employees.last_name, employees.date_of_employment, 
  positions.position_name, employees_has_positions.date_of_take_position, 
  (positions.position_salary + employees.salary_bonus) AS salary
  FROM employees
  JOIN employees_has_positions ON employees_has_positions.employee_id = employees.employee_id
  JOIN positions ON positions.position_id = employees_has_positions.position_id;


INSERT INTO employees_has_positions (employee_id, position_id, date_of_take_position) VALUES
  (1, 2, '2022-07-05');

SELECT employees.first_name, employees.last_name, employees.date_of_employment, 
  positions.position_name, employees_has_positions.date_of_take_position, 
  (positions.position_salary + employees.salary_bonus) AS salary
  FROM employees
  JOIN employees_has_positions ON employees_has_positions.employee_id = employees.employee_id
  JOIN positions ON positions.position_id = employees_has_positions.position_id;
