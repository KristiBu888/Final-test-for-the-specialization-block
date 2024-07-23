-- В ранее подключенном MySQL создать базу данных с названием "Human Friends".

DROP DATABASE IF EXISTS HumanFriendsDB;
CREATE DATABASE HumanFriendsDB;
USE HumanFriendsDB;

-- Создать таблицы, соответствующие иерархии из диаграммы классов. 
-- Заполнить таблицы данными о животных (имена, даты рождения, выполняемые команды).

DROP TABLE IF EXISTS human_friends;
CREATE TABLE human_friends
(
	id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT NOT NULL,
    kind_id VARCHAR(20) NOT NULL
);

INSERT INTO human_friends(id, kind_id)
VALUES
(1, 'pets'),
(2, 'pack_animals');


DROP TABLE IF EXISTS pets;
CREATE TABLE pets
(
	id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT NOT NULL,
    type_id VARCHAR(20) NOT NULL,
    kind_id INT UNSIGNED NOT NULL,
    FOREIGN KEY (kind_id) REFERENCES human_friends (id) ON DELETE CASCADE
);

INSERT INTO pets(id, type_id, kind_id)
VALUES 
(1, 'cat', 1),
(2, 'dog', 1),
(3, 'hamster', 1);

DROP TABLE IF EXISTS pack_animals;
CREATE TABLE pack_animals
(
	id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT NOT NULL,
    type_id VARCHAR(20),
    kind_id INT UNSIGNED NOT NULL,
    FOREIGN KEY (kind_id) REFERENCES human_friends (id) ON DELETE CASCADE
);

INSERT INTO pack_animals(id, type_id, kind_id)
VALUES 
(1, 'horse', 2),
(2, 'camel', 2),
(3, 'donkey', 2);

-- create and insert into table cats

DROP TABLE IF EXISTS cats;
CREATE TABLE cats
(
	id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT NOT NULL,
    name VARCHAR(50) NOT NULL,
    type_id INT UNSIGNED NOT NULL,
    birth_date DATE NOT NULL,
    commands VARCHAR(50) NOT NULL,
	FOREIGN KEY (type_id) REFERENCES pets (id) ON DELETE CASCADE
);

INSERT INTO cats(name, type_id, birth_date, commands)
VALUES
('Lucy', 1,	'2023-05-15', 'Sit, Pounce'),
('Happy', 1, '2020-02-20', 'Sit, Pounce, Scratch'),
('Faris', 1, '2020-06-30', 'Meow, Scratch, Jump');

-- create and insert into table dogs

DROP TABLE IF EXISTS dogs;
CREATE TABLE dogs
(
	id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT NOT NULL,
    type_id INT UNSIGNED NOT NULL,
    name VARCHAR(50) NOT NULL,
    birth_date DATE NOT NULL,
    commands VARCHAR(50) NOT NULL,
    FOREIGN KEY (type_id) REFERENCES pets (id) ON DELETE CASCADE
);

INSERT INTO dogs(name, type_id, birth_date, commands)
VALUES
('Natsu', 2, '2023-01-01', 'Sit, Stay, Fetch'),
('Gray', 2,	'2018-12-10', 'Sit, Paw, Bark'),
('Wendy', 2, '2019-11-11', 'Sit, Stay, Roll');

-- create and insert into table hamster

DROP TABLE IF EXISTS hamsters;
CREATE TABLE hamsters
(
	id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT NOT NULL,
    type_id INT UNSIGNED NOT NULL,
    name VARCHAR(50) NOT NULL,
    birth_date DATE NOT NULL,
    commands VARCHAR(50) NOT NULL,
    FOREIGN KEY (type_id) REFERENCES pets (id) ON DELETE CASCADE
);

INSERT INTO hamsters(name, type_id, birth_date, commands)
VALUES
('Erza', 3, '2021-03-10', 'Roll, Hide'),
('Elfman', 3, '2021-08-01', 'Roll, Spin');

-- create and insert into table horse

DROP TABLE IF EXISTS horses;
CREATE TABLE horses
(
	id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT NOT NULL,
    type_id INT UNSIGNED NOT NULL,
    name VARCHAR(50) NOT NULL,
    birth_date DATE NOT NULL,
    commands VARCHAR(50) NOT NULL,
    FOREIGN KEY (type_id) REFERENCES pack_animals (id) ON DELETE CASCADE
);

INSERT INTO horses(name, type_id, birth_date, commands)
VALUES
('Luffy', 1, '2015-07-21', 'Trot, Canter, Gallop'),
('Nami', 1,	'2022-05-05', 'Trot, Canter'),
('Chopper', 1, '2016-02-29', 'Trot, Jump, Gallop');

-- create and insert into table camel

DROP TABLE IF EXISTS camels;
CREATE TABLE camels
(
	id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT NOT NULL,
    type_id INT UNSIGNED NOT NULL,
    name VARCHAR(50) NOT NULL,
    birth_date DATE NOT NULL,
    commands VARCHAR(50) NOT NULL,
    FOREIGN KEY (type_id) REFERENCES pack_animals (id) ON DELETE CASCADE
);

INSERT INTO camels(name, type_id, birth_date, commands)
VALUES
('Zoro', 2,	'2016-11-03', 'Walk, Carry Load'),
('Sanji', 2, '2018-12-12', 'Walk, Sit'),
('Shanks', 2, '2015-08-14', 'Walk, Run');

-- create and insert into table donkey

DROP TABLE IF EXISTS donkeys;
CREATE TABLE donkeys
(
	id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT NOT NULL,
    type_id INT UNSIGNED NOT NULL,
    name VARCHAR(50) NOT NULL,
    birth_date DATE NOT NULL,
    commands VARCHAR(50) NOT NULL,
    FOREIGN KEY (type_id) REFERENCES pack_animals (id) ON DELETE CASCADE
);

INSERT INTO donkeys(name, type_id, birth_date, commands)
VALUES
('Usopp', 3, '2017-09-18', 'Walk, Carry Load, Bray'),
('Robin', 3, '2019-01-23', 'Walk, Bray, Kick');

-- delete * where type 'camel' and UNION tabler horse with donkey

DELETE FROM camels WHERE id>0 AND type_id=2;

DROP TABLE IF EXISTS horse_and_donkey;
CREATE TABLE horse_and_donkey
	(SELECT id, name, type_id, birth_date, commands
	FROM horses
	UNION SELECT id, name, type_id, birth_date, commands FROM donkeys
);

-- create new table "young_animals" WHEN birth_date between 1 and 3 years old and show age in month

DROP TEMPORARY TABLE IF EXISTS union_animals;
CREATE TEMPORARY TABLE union_animals(
	SELECT name, type_id, birth_date FROM cats c WHERE birth_date <= DATE_SUB(CURDATE(), INTERVAL 1 YEAR) AND birth_date >= DATE_SUB(CURDATE(), INTERVAL 3 YEAR)
		UNION SELECT name, type_id, birth_date FROM dogs d WHERE birth_date <= DATE_SUB(CURDATE(), INTERVAL 1 YEAR) AND birth_date >= DATE_SUB(CURDATE(), INTERVAL 3 YEAR)
		UNION SELECT name, type_id, birth_date FROM hamsters h WHERE birth_date <= DATE_SUB(CURDATE(), INTERVAL 1 YEAR) AND birth_date >= DATE_SUB(CURDATE(), INTERVAL 3 YEAR)
        UNION SELECT name, type_id, birth_date FROM donkeys don WHERE birth_date <= DATE_SUB(CURDATE(), INTERVAL 1 YEAR) AND birth_date >= DATE_SUB(CURDATE(), INTERVAL 3 YEAR)
		UNION SELECT name, type_id, birth_date FROM horses ho WHERE birth_date <= DATE_SUB(CURDATE(), INTERVAL 1 YEAR) AND birth_date >= DATE_SUB(CURDATE(), INTERVAL 3 YEAR)
		UNION SELECT name, type_id, birth_date FROM camels ca WHERE birth_date <= DATE_SUB(CURDATE(), INTERVAL 1 YEAR) AND birth_date >= DATE_SUB(CURDATE(), INTERVAL 3 YEAR));
-- SELECT * FROM union_animals;

DROP TABLE IF EXISTS young_animals;
CREATE TABLE young_animals (
  id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT NOT NULL,
  name VARCHAR(50) NOT NULL,
  type_id INT UNSIGNED NOT NULL,
  age_months INT NOT NULL
);
INSERT INTO young_animals(name, type_id, age_months)
SELECT name AS name, type_id AS type_id, TIMESTAMPDIFF(MONTH, birth_date, CURDATE()) AS age_months
FROM union_animals;
-- SELECT * FROM young_animals;

-- CREATE and INSERT TABLE "all_animals"

CREATE TABLE all_animals (
   id INT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE,
  name VARCHAR(50) NOT NULL,
  commands VARCHAR(100) NOT NULL,
  birth_date DATE NOT NULL,
  type_id INT UNSIGNED NOT NULL,
  source_table VARCHAR(20) NOT NULL,
  PRIMARY KEY (id)
);


INSERT INTO all_animals (name, commands, birth_date, type_id, source_table)
SELECT name, commands, birth_date, type_id, 'cats' AS source_table
FROM cats;

INSERT INTO all_animals (name, commands, birth_date, type_id, source_table)
SELECT name, commands, birth_date, type_id, 'dogs' AS source_table
FROM dogs;

INSERT INTO all_animals (name, commands, birth_date, type_id, source_table)
SELECT name, commands, birth_date, type_id, 'donkeys' AS source_table
FROM donkeys;

INSERT INTO all_animals (name, commands, birth_date, type_id, source_table)
SELECT name, commands, birth_date, type_id, 'hamsters' AS source_table
FROM hamsters;

INSERT INTO all_animals (name, commands, birth_date, type_id, source_table)
SELECT name, commands, birth_date, type_id, 'horses' AS source_table
FROM horses;
