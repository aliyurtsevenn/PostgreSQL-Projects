CREATE  TABLE car (
    id BIGSERIAL NOT NULL PRIMARY KEY,
    make VARCHAR(100) NOT NULL,
    model VARCHAR(100) NOT NULL,
    price NUMERIC (19,3) NOT NULL
);

CREATE TABLE person (
    id BIGSERIAL NOT NULL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    gender VARCHAR(7) NOT NULL,
    email VARCHAR(100),
    date_of_birth DATE NOT NULL,
    country_of_birth VARCHAR(50) NOT NULL,
    car_id BIGINT REFERENCES car (id),
    UNIQUE(car_id)
);

INSERT INTO person(first_name, last_name, gender, email, date_of_birth, country_of_birth) VALUES ('Fernanda','Beardon','Female','fernanda@is.gd','1953-10-28','China');
INSERT INTO person(first_name, last_name, gender, email, date_of_birth, country_of_birth) VALUES ('Omar','Colmaro','Male',NULL,'1921-04-23','Iran');
INSERT INTO person(first_name, last_name, gender, email, date_of_birth, country_of_birth) VALUES ('Adriana','Matuscheck','Female','amatuscheck@feedburner.com','1967-05-13','Italy');

INSERT INTO car(make, model, price) VALUES ('Land Rover', 'Sterling', '87665.5');
INSERT INTO car(make, model, price) VALUES ('GMC', 'Acadia', '177625.8');


/*

Let's show each table

*/

SELECT * FROM car;
SELECT * FROM car;

/*

Assign 2 cars to 2 people! Here, car ID for each person is empty! We can update this with
the 2 cars!

*/

UPDATE person SET car_id = 2 WHERE id = 1;
UPDATE person SET car_id = 1 WHERE id = 2;


/*

Joining  2 tables with the common overlapping ids! 

*/

SELECT * FROM person JOIN car ON person.car_id=car.id;
SELECT person.first_name, car.make, car.model, car.price FROM person JOIN car
ON person.car_id=car.id;

/*

If you want to include everyone that has a car and doesn't have any in person table

*/

SELECT * FROM person LEFT JOIN car ON car.id = person.car_id;
SELECT * FROM person WHERE car_id IS NULL;

/*

To convert your file to csv with the delimiter of ","

\copy  (SELECT * FROM person LEFT JOIN car ON car.id = person.car_id) TO '/home/ali/Documents/sql_project2/results.csv', DELIMITER ',' CSV HEADER;

*/



