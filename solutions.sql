/* Név: ÍRD IDE A NEVED */

NYúl Richárd István

-- FORDÍTÓIRODA FELADAT --

/* 1. Lekérdezés */

SELECT name FROM PEOPLE WHERE available = true ORDER BY name;

/* 2. Lekérdezés */

SELECT SUM(length) FROM docs WHERE field = 'marketing';

/* 3. Lekérdezés */

SELECT COUNT(docs.id) FROM docs
INNER JOIN languages ON docs.language_id = languages.id
WHERE languages.source_lang = 'Slovakian';



/* 4. Lekérdezés */

SELECT COUNT(docs.id), SUM(languages.unit_price) FROM docs
INNER JOIN languages ON docs.language_id = languages.id
WHERE docs.length > 5000;

/* 5. Lekérdezés */

SELECT length, field FROM docs
INNER JOIN languages ON docs.language_id = languages.id
WHERE source_lang = 'English' AND target_lang = 'Hungarian'
ORDER BY length DESC;

/* 6. Lekérdezés */

SELECT field, source_lang, target_lang FROM docs
INNER JOIN languages ON docs.language_id = languages.id
WHERE worktime BETWEEN 7 AND 9
ORDER BY source_lang;

/* 7. Lekérdezés */

SELECT people.name FROM people
INNER JOIN translators ON people.id = translators.person_id
INNER JOIN languages ON languages.id = translators.language_id
WHERE languages.source_lang = 'Hungarian'
GROUP BY people.name
ORDER BY COUNT(DISTINCT languages.target_lang) DESC
LIMIT 1;

/* 8. Lekérdezés */

SELECT people.name FROM people
INNER JOIN translators ON people.id = translators.person_id
INNER JOIN languages ON languages.id = translators.language_id
WHERE people.available = true AND source_lang = 'Hungarian' AND target_lang = 'English' OR source_lang = 'Hungarian' AND target_lang = 'Russian'
GROUP BY people.name
HAVING COUNT(target_lang) = 2;

/* 9. Lekérdezés */

SELECT DISTINCT field, source_lang, target_lang FROM docs
INNER JOIN languages ON docs.language_id = languages.id
ORDER BY field, source_lang;

-- BÚTOROS FELADAT --

/* 1. Feladat */

CREATE TABLE furnitures (id SERIAL PRIMARY KEY,
						type VARCHAR(255) NOT NULL,
						color VARCHAR(50) NOT NULL,
						price INTEGER CHECK (price > 0));
							
CREATE TABLE carts (id SERIAL PRIMARY KEY,
				   furniture_id INTEGER NOT NULL REFERENCES furnitures(id),
				   quantity INTEGER NOT NULL CHECK (quantity > 0),
				   created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP);	

/* 2. Feladat */

INSERT INTO furnitures 
	(type, color, price)
VALUES 
	('asztal', 'fekete', 19990),
	('kerek asztal', 'barna', 20000),
	('szék', 'fekete', 8900),
	('forgó szék', 'fekete', 114490),
	('éjeli szekrény', 'piros', 39900);
	
INSERT INTO carts
	(furniture_id, quantity)
VALUES
	(1, 1),
	(2, 1),
	(3, 6),
	(4, 2),
	(5, 2);

/* 3. Feladat */

UPDATE furnitures SET price = 10000 WHERE type LIKE '%asztal%';	

/* 4. Feladat */

ALTER TABLE carts
DROP CONSTRAINT carts_furniture_id_fkey;
DELETE FROM furnitures WHERE color = 'piros';
ALTER TABLE carts
ADD CONSTRAINT carts_furniture_id_fkey FOREIGN KEY (furniture_id) REFERENCES furnitures(id);

-- FELADATLAP VÉGE --
