SELECT * FROM `bank`.`client` LIMIT 1000;
SELECT * FROM `bank`.`application` LIMIT 1000;
SELECT * FROM `bank`.`department` LIMIT 1000;

-- 1. +Вибрати усіх клієнтів, чиє ім'я має менше ніж 6 символів.

SELECT * FROM bank.client where length (firstname) <6 ;

-- 2. +Вибрати львівські відділення банку.+

SELECT * FROM bank.department where DepartmentCity = 'Lviv' ;

-- 3. +Вибрати клієнтів з вищою освітою та посортувати по прізвищу.

SELECT FirstName,LastName,Education FROM bank.client where Education	='high';

-- 4. +Виконати сортування у зворотньому порядку над таблицею Заявка і вивести 5 останніх елементів.

SELECT * FROM bank.application order by idApplication desc LIMIT 5;

-- 5. +Вивести усіх клієнтів, чиє прізвище закінчується на OV чи OVA.

SELECT * FROM bank.client where (LastName like '%iv' or LastName like '%iva') ;

-- 6. +Вивести клієнтів банку, які обслуговуються київськими відділеннями.

SELECT client.FirstName, client.LastName,department.DepartmentCity	 FROM bank.client
left join bank.department ON 
bank.client.Department_idDepartment = bank.department.idDepartment where DepartmentCity = 'Kyiv';	

-- 7. +Вивести імена клієнтів та їхні номера паспорту, погрупувавши їх за іменами.

SELECT idClient,FirstName	,Passport FROM client group by firstname order by idClient ;

-- 8. +Вивести дані про клієнтів, які мають кредит більше ніж на 5 тисяч гривень.

SELECT * from bank.client c
join bank.application a ON
c.idClient = a.Client_idClient
where CreditState='Not returned' and Sum>5000 ;

-- 9. +Порахувати кількість клієнтів усіх відділень та лише львівських відділень.

select count(idClient) as ClientTotalQty from bank.client;

select count(idClient) as LvivClientQty, DepartmentCity from bank.client c
join bank.department d 
ON c.Department_idDepartment = d.idDepartment 
where DepartmentCity='Lviv';

-- 10. Знайти кредити, які мають найбільшу суму для кожного клієнта окремо.

select idClient,FirstName,LastName, max(sum) as MaxCreditSum 
from bank.client c
join bank.application a
on c.idClient = a.Client_idClient group by idClient;

-- 11. Визначити кількість заявок на крдеит для кожного клієнта.

select idClient,FirstName,LastName, count(sum) as CreditOrderQty
from bank.client c
join bank.application a 
on c.idClient = a.Client_idClient group by idClient;

-- 12. Визначити найбільший та найменший кредити.

(select  Client_idClient,sum
from bank.application where sum = (select max(sum) from bank.application))
union 
(select  Client_idClient,sum
from bank.application where sum = (select min(sum) from bank.application))

select Client_idClient,sum 
from bank.application 
where sum in (select max(sum) from bank.application)
or sum in(select min(sum) from bank.application)  


-- 13. Порахувати кількість кредитів для клієнтів,які мають вищу освіту.

select idClient,FirstName,LastName, count(idClient) as CreditQty
from bank.client c
join bank.application a
on idClient = Client_idClient 
where Education = 'high' group by idClient;

-- 14. Вивести дані про клієнта, в якого середня сума кредитів найвища.

select idClient,FirstName,LastName,avg(sum) 
from bank.client c
join bank.application a
on idClient = Client_idClient 
group by idClient 
order by avg(sum) desc
limit 1;

-- 15. Вивести відділення, яке видало в кредити найбільше грошей

select idDepartment, DepartmentCity , sum(sum) as MaxTotalCredit
from bank.department d
join bank.client c
on idDepartment = Department_idDepartment
join bank.application a
on idClient = Client_idClient 
group by idDepartment
order by MaxTotalCredit desc
limit 1;

-- 16. Вивести відділення, яке видало найбільший кредит.

select idDepartment, DepartmentCity , max(sum) as MaxCredit
from bank.department d
join bank.client c
on idDepartment = Department_idDepartment
join bank.application a
on idClient = Client_idClient 
group by idDepartment
order by MaxCredit desc
limit 1;

-- 17. Усім клієнтам, які мають вищу освіту, встановити усі їхні кредити у розмірі 6000 грн.

update bank.client
join bank.application
on idClient = Client_idClient
set sum = 6000
where Education = 'high' and CreditState = 'Not returned';


-- 18. Усіх клієнтів київських відділень пересилити до Києва.

update bank.client
join bank.department
on Department_idDepartment = idDepartment
set City = 'Kyiv'
where  DepartmentCity = 'Kyiv';

-- 19. Видалити усі кредити, які є повернені.

update bank.client
join bank.application
on idClient = Client_idClient
set Sum = '0'
where CreditState = 'Not returned';

-- 20. Видалити кредити клієнтів, в яких друга літера прізвища є голосною.

update bank.client
join bank.application
on idClient = Client_idClient
set Sum = '0'
where LastName rlike '^.[aeiouAEIOU]';


Знайти львівські відділення, які видали кредитів на загальну суму більше ніж 5000
