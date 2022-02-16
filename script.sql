-- DESAFIO_BLOG

-- Creación de base de datos "blog" (1)

CREATE DATABASE blog
    WITH 
    OWNER = postgres
    ENCODING = 'UTF8'
    CONNECTION LIMIT = -1;

-- Crear las tablas indicadas de acuerdo al modelo de datos (2)

CREATE TABLE PUBLIC.users(
	id serial primary key,
	email varchar(100) not null
);

CREATE TABLE PUBLIC.posts(
	id serial primary key,
	id_user integer not null,
	post_title varchar(100) not null,
	post_date date not null,
	FOREIGN KEY (id_user) REFERENCES users(id)
);

CREATE TABLE PUBLIC.comments(
	id serial primary key,
	id_post integer not null,
	id_user integer not null,
	commentary_text text not null,
	commentary_date date not null,
	FOREIGN KEY (id_post) REFERENCES posts(id),
	FOREIGN KEY (id_user) REFERENCES users(id)
);

-- Insertar los siguientes registros (3)

COPY PUBLIC.users FROM 'C:\Users\franco\Desktop\users.csv' DELIMITER ',' CSV HEADER;

COPY PUBLIC.posts FROM 'C:\Users\franco\Desktop\posts.csv' DELIMITER ',' CSV HEADER;

COPY PUBLIC.comments FROM 'C:\Users\franco\Desktop\comments.csv' DELIMITER ',' CSV HEADER;

--  Seleccionar el correo, id y título de todos los post publicados por el usuario 5 (4)

select users.email, posts.id, posts.post_title from posts inner join users on posts.id_user = users.id where users.id = 5;

-- Listar el correo, id y el detalle de todos los comentarios que no hayan sido realizados
-- por el usuario con email usuario06@hotmail.com (5)

select users.email, comments.id, comments.commentary_text from comments inner join users on comments.id_user = users.id where not users.email = 'usuario06@hotmail.com';

-- Listar los usuarios que no han publicado ningún post (6)

select * from users where id not in (select id_user from posts);

-- Listar todos los post con sus comentarios (incluyendo aquellos que no poseen
-- comentarios) (7)

select posts.post_title, comments.commentary_text from posts left join comments on posts.id = comments.id_post;

-- Listar todos los usuarios que hayan publicado un post en Junio (8)

select users.id, users.email from users inner join posts on posts.id_user = users.id where post_date between '2020-06-01' and '2020-06-30';