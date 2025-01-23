-- public.film definition

-- Drop table

-- DROP TABLE film;

CREATE TABLE film (
	id serial4 NOT NULL,
	"name" varchar(255) NULL,
	description text NULL,
	CONSTRAINT film_pkey PRIMARY KEY (id)
);

-- Permissions

ALTER TABLE public.film OWNER TO postgres;
GRANT ALL ON TABLE public.film TO postgres;


-- public.hall definition

-- Drop table

-- DROP TABLE hall;

CREATE TABLE hall (
	id serial4 NOT NULL,
	"name" varchar(100) NULL,
	CONSTRAINT hall_pkey PRIMARY KEY (id)
);

-- Permissions

ALTER TABLE public.hall OWNER TO postgres;
GRANT ALL ON TABLE public.hall TO postgres;


-- public.hall_row definition

-- Drop table

-- DROP TABLE hall_row;

CREATE TABLE hall_row (
	id_hall int4 NOT NULL,
	"number" int2 NOT NULL,
	capacity int2 NULL,
	CONSTRAINT hall_row_pkey PRIMARY KEY (id_hall, number),
	CONSTRAINT hall_row_id_hall_fkey FOREIGN KEY (id_hall) REFERENCES hall(id)
);

-- Permissions

ALTER TABLE public.hall_row OWNER TO postgres;
GRANT ALL ON TABLE public.hall_row TO postgres;


-- public.screening definition

-- Drop table

-- DROP TABLE screening;

CREATE TABLE screening (
	id serial4 NOT NULL,
	hall_id int4 NULL,
	film_id int4 NULL,
	"time" timestamp NULL,
	CONSTRAINT screening_pkey PRIMARY KEY (id),
	CONSTRAINT screening_film_id_fkey FOREIGN KEY (film_id) REFERENCES film(id),
	CONSTRAINT screening_hall_id_fkey FOREIGN KEY (hall_id) REFERENCES hall(id)
);

-- Permissions

ALTER TABLE public.screening OWNER TO postgres;
GRANT ALL ON TABLE public.screening TO postgres;


-- public.tickets definition

-- Drop table

-- DROP TABLE tickets;

CREATE TABLE tickets (
	id_screening int4 NOT NULL,
	"row" int2 NOT NULL,
	seat int2 NOT NULL,
	"cost" int4 NULL,
	CONSTRAINT tickets_pkey PRIMARY KEY (id_screening, "row", seat),
	CONSTRAINT tickets_id_screening_fkey FOREIGN KEY (id_screening) REFERENCES screening(id)
);

-- Permissions

ALTER TABLE public.tickets OWNER TO postgres;
GRANT ALL ON TABLE public.tickets TO postgres;

INSERT INTO public.hall ("name") VALUES
	 ('Зал 1'),
	 ('Зал 2'),
	 ('Зал 3'),
	 ('Зал 4'),
	 ('Зал 5'),
	 ('Зал 6'),
	 ('Зал 7'),
	 ('Зал 8'),
	 ('Зал 9'),
	 ('Зал 10');

	INSERT INTO public.hall_row (id_hall,"number",capacity) VALUES
	 (1,1,20),
	 (1,2,20),
	 (1,3,20),
	 (2,1,30),
	 (2,2,30),
	 (3,1,25),
	 (3,2,25),
	 (4,1,15),
	 (4,2,15),
	 (5,1,10);

	INSERT INTO public.film ("name",description) VALUES
	 ('Форсаж 1','Боевик, триллер'),
	 ('Веном 3','Боевик, ужасы'),
	 ('Ужасающий 3','Ужасы'),
	 ('Переводчик','Боевик, триллер'),
	 ('Драйв','Драма'),
	 ('Побег из Шоушенка','Драма'),
	 ('Игры разума','Биография'),
	 ('Форрест Гамп','Комедия, Драма'),
	 ('Матрица','Научная фантастика'),
	 ('Начало','Научная фантастика');
	
	INSERT INTO public.screening (hall_id,film_id,"time") VALUES
	 (1,1,'2023-10-01 18:00:00'),
	 (1,2,'2024-10-01 11:00:00'),
	 (2,3,'2023-10-01 12:00:00'),
	 (2,4,'2023-10-01 09:00:00'),
	 (3,5,'2023-10-01 02:00:00'),
	 (3,6,'2023-10-01 16:00:00'),
	 (4,7,'2023-10-01 10:00:00'),
	 (4,8,'2023-10-01 18:00:00'),
	 (5,9,'2023-10-01 19:00:00'),
	 (5,10,'2023-10-01 20:00:00');
	
	INSERT INTO public.tickets (id_screening,"row",seat,"cost") VALUES
	 (1,1,1,500),
	 (1,1,2,500),
	 (1,1,3,500),
	 (2,2,1,600),
	 (2,2,2,600),
	 (3,1,1,450),
	 (3,1,2,450),
	 (4,2,1,550),
	 (5,1,1,400),
	 (6,2,1,650);
	
	-- public.row_hall source

CREATE OR REPLACE VIEW public.row_hall
AS SELECT hall.name AS "Зал",
    hall_row.number AS "Ряд",
    hall_row.capacity AS "Кол-во мест"
   FROM hall_row
     JOIN hall ON hall_row.id_hall = hall.id
  WHERE hall_row.id_hall = 3 AND hall_row.number = 2;
 
 -- public.film_eleven source

CREATE OR REPLACE VIEW public.film_eleven
AS SELECT hall.name AS "Зал",
    film.name AS "Название фильма",
    screening."time" AS "Начало время"
   FROM screening
     JOIN hall ON hall.id = screening.hall_id
     JOIN film ON film.id = screening.film_id
  WHERE screening."time" > '2021-01-01 11:00:00'::timestamp without time zone;
 
 -- public.film2 source

CREATE OR REPLACE VIEW public.film2
AS SELECT hall.name AS "Зал",
    film.name AS "Название фильма",
    screening."time" AS "Начало время"
   FROM screening
     JOIN hall ON hall.id = screening.hall_id
     JOIN film ON film.id = screening.film_id
  WHERE screening.film_id = 4;
 
 -- public.film1 source

CREATE OR REPLACE VIEW public.film1
AS SELECT hall.name AS "Зал",
    film.name AS "Название фильма",
    screening."time" AS "Начало время"
   FROM screening
     JOIN hall ON hall.id = screening.hall_id
     JOIN film ON film.id = screening.film_id
  WHERE screening.hall_id = 5;
 
 
