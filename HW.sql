SELECT * FROM students;

SELECT  * FROM students WHERE gender LIKE 'f%';

SELECT  * FROM students WHERE gender LIKE 'm%' AND age BETWEEN 20 AND 40 ;

SELECT  * FROM students WHERE gender like 'f%' AND age > 30 AND name LIKE '_a%a';

SELECT  AVG(age) FROM students WHERE gender like 'm%';

SELECT  name, MAX(AGE) FROM students WHERE gender like 'f%';

SELECT * FROM (SELECT * FROM students ORDER BY id DESC LIMIT 3) AS ast ORDER BY id ;

SELECT gender ,COUNT(age) FROM students GROUP BY gender;

UPDATE students SET gender = 'female' WHERE gender LIKE 'm%';

UPDATE students SET name = 'Antonina' WHERE name LIKE'Anton';

UPDATE students SET age = '10' WHERE gender LIKE 'f%'AND name NOT LIKE '%a' ;
 
SET FOREIGN_KEY_CHECKS=0;
DELETE FROM students WHERE age NOT BETWEEN 25 AND 40 ; 
SET FOREIGN_KEY_CHECKS=1;