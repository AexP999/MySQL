SELECT * FROM `bank`.`client` LIMIT 1000;
SELECT * FROM `bank`.`application` LIMIT 1000;
SELECT * FROM `bank`.`department` LIMIT 1000;

SELECT * FROM bank.client where length (firstname) <6 ;

SELECT * FROM bank.department where DepartmentCity = 'Lviv' ;

SELECT FirstName,LastName,Education FROM bank.client where Education	='high';

SELECT * FROM bank.application order by idApplication desc LIMIT 5;

SELECT * FROM bank.client where (LastName like '%iv' or LastName like '%iva') ;

-- 6. +Вивести клієнтів банку, які обслуговуються київськими відділеннями.

SELECT client.FirstName, client.LastName,department.DepartmentCity	 FROM bank.client
left join bank.department ON 
bank.client.Department_idDepartment = bank.department.idDepartment where DepartmentCity = 'Kyiv';	

-- 7. +Вивести імена клієнтів та їхні номера паспорту, погрупувавши їх за іменами.

update

SELECT idClient,FirstName	,Passport FROM client group by firstname order by idClient ;

