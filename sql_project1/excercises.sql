/*

To start the psql;
>  sudo -i -u postgres
> psql

To exit;
>  \q

You need to set a password! 

> postgres=# ALTER USER postgres PASSWORD 'myPassword';

** Control+D quit you from the database and psql! 
** Control+L clear the screen


1. You first need to create the database by;

> CREATE  DATABASE my_database

2. You need to go into the data base by 

> \c my_database

3. Then, you can create the tables by getting from the other sql file;

> \i ../person.sql

4. Now, you can start writing the sql codes!

Let me show the columns in the person table! 

*/

SELECT * FROM person;
SELECT first_name FROM person;
SELECT first_name,last_name FROM person;

/*

You can sort your data, using ORDER BY command

*/

SELECT * FROM person ORDER BY country_of_birth;


/*

This is by default in ascending order!

*/

SELECT * FROM person ORDER BY country_of_birth DESC; 
SELECT * FROM person ORDER BY country_of_birth ASC; 
SELECT country_of_birth FROM person ORDER BY country_of_birth; 

/*

To drop the duplicates in this column and see the unique countries in the table

*/

SELECT DISTINCT country_of_birth FROM person ORDER BY country_of_birth ASC;
SELECT DISTINCT country_of_birth FROM person ORDER BY country_of_birth DESC;


/*

WHERE clause helps to filter the data based on conditions

*/

SELECT * FROM person WHERE gender='Female';

/*

This chooses all the columns, where the gender is female! 
Note that there must be white space between the equal sign!
To use multiple conditions, AND can be added

*/

SELECT * FROM person WHERE gender='Female' AND country_of_birth='Portugal';
SELECT * FROM person WHERE gender='Female' AND (country_of_birth='Portugal'
OR country_of_birth='China');


/*

There are arithmetic and logical operators!

*/

SELECT 'ANDROMEDA' = 'ANDROMEDA';


/*

To limit the number of the raws to 10

*/

SELECT * FROM person LIMIT 10;
SELECT * FROM person OFFSET 5 LIMIT 10 

/*

This makes the start of the raws from 5, since the limit is 10 raws, 
it shows from 5 to 15 raws

*/

SELECT * FROM person where country_of_birth='China' OR country_of_birth='France' 
OR country_of_birth='Brazil';

/*

This takes a lot of code to write, so we can use IN instead

*/


SELECT * FROM person where country_of_birth IN ('China', 'France', 'Brazil')

/*

To get the raws which are between 2 dates or numbers, use BETWEEN!

*/

SELECT * FROM person WHERE date_of_birth BETWEEN DATE '2000-01-05' AND '2015-01-05';

/*

You can get the emails ends with ‘.com’, using LIKE or ILIKE if it is not case sensitive

*/

SELECT * FROM person WHERE email LIKE ('%.com');
SELECT * FROM person WHERE email LIKE ('%@blomberg.com');
SELECT * FROM person WHERE email LIKE ('%@google%');

/*

Also, instead of saying all by %, you can give the all characters with the specified character numbers,
giving the underscores as each character number! 

*/

SELECT * FROM person WHERE email LIKE ('________@%');

/*

If your characters are all written with upper and lower cases, you need to use ILIKE!

*/

SELECT * FROM person WHERE country_of_birth ILIKE ('p%');

/*

To find how many duplicates we have for each group of people for a country, 
GROUP BY can be used

*/

SELECT country_of_birth, COUNT(*) FROM person GROUP BY country_of_birth;
SELECT country_of_birth, COUNT(*) FROM person GROUP BY country_of_birth 
ORDER BY country_of_birth;

/*

If we want to find all the countries that have at least 5 people let’s say, 
we can use GROUP BY HAVING!

*/

SELECT country_of_birth, COUNT(*) FROM person GROUP BY country_of_birth HAVING COUNT(*) >= 5  
ORDER BY country_of_birth;

/*

To select the maximum, minimum and average of the prices from the person table, 
you can use the person function

*/

SELECT MAX(price) FROM  person;
SELECT MIN(price) FROM  person;
SELECT AVG(price) FROM  person;

/*

You can also round  the price of the average  number, using AVG function

*/

SELECT ROUND(AVG(price)) FROM  person;

/*

Let me check the minimum and maximum prices of the cars according to the models! 

*/

SELECT make, model, MIN(price) FROM person GROUP BY make, model;
SELECT make, model, MAX(price) FROM person GROUP BY make, model;
SELECT id, model, price, price * 0.1 FROM person;

/*

 Let me round the price with 2 decimal numbers, find 0.1 of the price and
 find the 0.1 off from the price!

*/

SELECT id, model, price, ROUND (price * 0.1, 2 ) FROM person;
SELECT id, model, price, ROUND (price * 0.1, 2 ), ROUND (price- (price * 0.1),2) 
FROM person;

/*

You need to specify the column name if you create one, using AS 

*/

SELECT id, model, price AS original_price, ROUND (price * 0.1, 2 ) AS ten_percent_price, ROUND 
(price- (price * 0.1),2) off_price FROM person;

/*

Let me fill the not provided emails with the string of ‘email not provided’

*/

SELECT email, COALESCE(email, 'email not provided') AS filled_mails FROM person;


/*

Division by zero, not to have error, you can use null if as;
This gives result as nan

*/

SELECT 10/ NULLIF(0,0)

/*

To  have the current time and date, using NOW

*/

SELECT NOW();

/*

Also, you can get the date and time from this by casting

*/

SELECT NOW()::DATE;
SELECT NOW()::TIME;
SELECT NOW() - INTERVAL '1 YEAR';
SELECT NOW() - INTERVAL '10 YEARS';
SELECT NOW() - INTERVAL '10 MONTHS';
SELECT NOW() - INTERVAL '10 WEEKS';
SELECT NOW() - INTERVAL '10 DAYS';

SELECT (NOW() + INTERVAL '10 MONTHS')::DATE;

/*

You can extract important values from given data!

*/

SELECT EXTRACT(YEAR FROM NOW())
SELECT EXTRACT(DAY FROM NOW())
SELECT EXTRACT(CENTURY FROM NOW())
SELECT EXTRACT(MONTH FROM NOW())

/*

To find age of someone, or the time between 2 date, you can use AGE

*/

SELECT first_name, last_name, gender, country_of_birth, data_of_birth, 
AGE(NOW, data_of_birth) AS AGE FROM person;

/*

A raw with the same id, which is a primary key, cannot be added. To deal with this, 
you can remove the primary key! 

*/

ALTER TABLE person DROP CONSTRAINT person_pkey;


/*

If you drop the keys and add the raw with the same id, you can also again add primary key! 
Note that if your raws are not unique for the column you want as primary key, you need to delete 
the duplicates before then do this as primary key!

*/

 DELETE FROM person WHERE id=1;
 ALTER TABLE person ADD PRIMARY KEY (id);

/*

To have unique values for the given column, 

*/

SELECT email, COUNT(*) FROM person GROUP BY email;
SELECT email, COUNT(*) FROM person GROUP BY email HAVING COUNT (*)>1;

DELETE FROM person WHERE id=1004;

/*

 Now, let’s add constraints! 

*/

ALTER TABLE person ADD CONSTRAINT unique_email_address UNIQUE (email);

/*

Adding  the same email to the table will not be permitted since we added the constraint! 
Let’s delete the constraint! 

*/

ALTER FROM person DROP CONSTRAINT  unique_email_address;

/*
To make the columns to have only 2 different strings like male and female for gender, 
you need to put check constraints!

*/

ALTER TABLE FROM person ADD CONSTRAINT gender_constraint CHECK 
(gender = 'Male' OR gender  = 'Female');

/*

You can delete record from the table, using DELETE
Be  careful to make the filtering carefully! 

*/

DELETE FROM person WHERE id = 1001
DELETE FROM person  WHERE gender = 'Female' AND country_of_birth = 'England';


/*

You need to use the WHERE clauses carefully, when updating! 
Let’s put an email to an empty column! 

*/

UPDATE person SET email = 'thoma@gmai.com' WHERE id=28;
UPDATE person SET first_name= 'Jack', last_name= 'Sparrow', 
email = 'jack@hotmail.com' WHERE id=28;

