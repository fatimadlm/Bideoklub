-- Database generated with pgModeler (PostgreSQL Database Modeler).
-- pgModeler version: 0.9.4
-- PostgreSQL version: 13.0
-- Project Site: pgmodeler.io
-- Model Author: ---

-- Database creation must be performed outside a multi lined SQL file. 
-- These commands were put in this file only as a convenience.
-- 
-- object: new_database | type: DATABASE --
-- DROP DATABASE IF EXISTS new_database;
CREATE DATABASE new_database;
-- ddl-end --


-- object: peliculas | type: SCHEMA --
-- DROP SCHEMA IF EXISTS peliculas CASCADE;
CREATE SCHEMA peliculas;
-- ddl-end --
ALTER SCHEMA peliculas OWNER TO postgres;
-- ddl-end --

SET search_path TO pg_catalog,public,peliculas;
-- ddl-end --

-- object: peliculas.personal | type: TABLE --
-- DROP TABLE IF EXISTS peliculas.personal CASCADE;
CREATE TABLE peliculas.personal (
	nombre varchar NOT NULL,
	nacionalidad varchar,
	año_nacimiento date,
	CONSTRAINT personal_pk PRIMARY KEY (nombre)
);
-- ddl-end --
ALTER TABLE peliculas.personal OWNER TO postgres;
-- ddl-end --

-- object: peliculas.actor | type: TABLE --
-- DROP TABLE IF EXISTS peliculas.actor CASCADE;
CREATE TABLE peliculas.actor (
	nombre_personal varchar NOT NULL,
	CONSTRAINT actor_pk PRIMARY KEY (nombre_personal)
);
-- ddl-end --
ALTER TABLE peliculas.actor OWNER TO postgres;
-- ddl-end --

-- object: personal_fk | type: CONSTRAINT --
-- ALTER TABLE peliculas.actor DROP CONSTRAINT IF EXISTS personal_fk CASCADE;
ALTER TABLE peliculas.actor ADD CONSTRAINT personal_fk FOREIGN KEY (nombre_personal)
REFERENCES peliculas.personal (nombre) MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: peliculas.director | type: TABLE --
-- DROP TABLE IF EXISTS peliculas.director CASCADE;
CREATE TABLE peliculas.director (
	nombre_personal varchar NOT NULL,
	CONSTRAINT director_pk PRIMARY KEY (nombre_personal)
);
-- ddl-end --
ALTER TABLE peliculas.director OWNER TO postgres;
-- ddl-end --

-- object: personal_fk | type: CONSTRAINT --
-- ALTER TABLE peliculas.director DROP CONSTRAINT IF EXISTS personal_fk CASCADE;
ALTER TABLE peliculas.director ADD CONSTRAINT personal_fk FOREIGN KEY (nombre_personal)
REFERENCES peliculas.personal (nombre) MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: peliculas.peliculas | type: TABLE --
-- DROP TABLE IF EXISTS peliculas.peliculas CASCADE;
CREATE TABLE peliculas.peliculas (
	año smallint NOT NULL,
	titulo varchar NOT NULL,
	duracion smallint,
	idioma char(2),
	calificacion varchar,
	nombre_personal_director varchar NOT NULL,
	CONSTRAINT peliculas_pk PRIMARY KEY (año,titulo)
);
-- ddl-end --
ALTER TABLE peliculas.peliculas OWNER TO postgres;
-- ddl-end --

-- object: director_fk | type: CONSTRAINT --
-- ALTER TABLE peliculas.peliculas DROP CONSTRAINT IF EXISTS director_fk CASCADE;
ALTER TABLE peliculas.peliculas ADD CONSTRAINT director_fk FOREIGN KEY (nombre_personal_director)
REFERENCES peliculas.director (nombre_personal) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: peliculas.actua | type: TABLE --
-- DROP TABLE IF EXISTS peliculas.actua CASCADE;
CREATE TABLE peliculas.actua (
	nombre_personal_actor varchar NOT NULL,
	año_peliculas smallint NOT NULL,
	titulo_peliculas varchar NOT NULL,
	CONSTRAINT actua_pk PRIMARY KEY (nombre_personal_actor,año_peliculas,titulo_peliculas)
);
-- ddl-end --

-- object: actor_fk | type: CONSTRAINT --
-- ALTER TABLE peliculas.actua DROP CONSTRAINT IF EXISTS actor_fk CASCADE;
ALTER TABLE peliculas.actua ADD CONSTRAINT actor_fk FOREIGN KEY (nombre_personal_actor)
REFERENCES peliculas.actor (nombre_personal) MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: peliculas_fk | type: CONSTRAINT --
-- ALTER TABLE peliculas.actua DROP CONSTRAINT IF EXISTS peliculas_fk CASCADE;
ALTER TABLE peliculas.actua ADD CONSTRAINT peliculas_fk FOREIGN KEY (año_peliculas,titulo_peliculas)
REFERENCES peliculas.peliculas (año,titulo) MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: peliculas.generos | type: TABLE --
-- DROP TABLE IF EXISTS peliculas.generos CASCADE;
CREATE TABLE peliculas.generos (
	genero varchar NOT NULL,
	año_peliculas smallint NOT NULL,
	titulo_peliculas varchar NOT NULL,
	CONSTRAINT generos_pk PRIMARY KEY (genero,año_peliculas,titulo_peliculas)
);
-- ddl-end --
ALTER TABLE peliculas.generos OWNER TO postgres;
-- ddl-end --

-- object: peliculas_fk | type: CONSTRAINT --
-- ALTER TABLE peliculas.generos DROP CONSTRAINT IF EXISTS peliculas_fk CASCADE;
ALTER TABLE peliculas.generos ADD CONSTRAINT peliculas_fk FOREIGN KEY (año_peliculas,titulo_peliculas)
REFERENCES peliculas.peliculas (año,titulo) MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: peliculas.criticas | type: TABLE --
-- DROP TABLE IF EXISTS peliculas.criticas CASCADE;
CREATE TABLE peliculas.criticas (
	critico varchar NOT NULL,
	puntuacion smallint,
	texto text,
	año_peliculas smallint NOT NULL,
	titulo_peliculas varchar NOT NULL,
	url_pag_web varchar NOT NULL,
	fecha date,
	CONSTRAINT criticas_pk PRIMARY KEY (critico,año_peliculas,titulo_peliculas)
);
-- ddl-end --
ALTER TABLE peliculas.criticas OWNER TO postgres;
-- ddl-end --

-- object: peliculas_fk | type: CONSTRAINT --
-- ALTER TABLE peliculas.criticas DROP CONSTRAINT IF EXISTS peliculas_fk CASCADE;
ALTER TABLE peliculas.criticas ADD CONSTRAINT peliculas_fk FOREIGN KEY (año_peliculas,titulo_peliculas)
REFERENCES peliculas.peliculas (año,titulo) MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: peliculas.caratulas | type: TABLE --
-- DROP TABLE IF EXISTS peliculas.caratulas CASCADE;
CREATE TABLE peliculas.caratulas (
	tipo varchar NOT NULL,
	tamaño smallint,
	año_peliculas smallint NOT NULL,
	titulo_peliculas varchar NOT NULL,
	url_pag_web varchar NOT NULL,
	CONSTRAINT caratulas_pk PRIMARY KEY (tipo,año_peliculas,titulo_peliculas)
);
-- ddl-end --
ALTER TABLE peliculas.caratulas OWNER TO postgres;
-- ddl-end --

-- object: peliculas_fk | type: CONSTRAINT --
-- ALTER TABLE peliculas.caratulas DROP CONSTRAINT IF EXISTS peliculas_fk CASCADE;
ALTER TABLE peliculas.caratulas ADD CONSTRAINT peliculas_fk FOREIGN KEY (año_peliculas,titulo_peliculas)
REFERENCES peliculas.peliculas (año,titulo) MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: peliculas.pag_web | type: TABLE --
-- DROP TABLE IF EXISTS peliculas.pag_web CASCADE;
CREATE TABLE peliculas.pag_web (
	url varchar NOT NULL,
	tipo varchar,
	CONSTRAINT pag_web_pk PRIMARY KEY (url)
);
-- ddl-end --
ALTER TABLE peliculas.pag_web OWNER TO postgres;
-- ddl-end --

-- object: pag_web_fk | type: CONSTRAINT --
-- ALTER TABLE peliculas.criticas DROP CONSTRAINT IF EXISTS pag_web_fk CASCADE;
ALTER TABLE peliculas.criticas ADD CONSTRAINT pag_web_fk FOREIGN KEY (url_pag_web)
REFERENCES peliculas.pag_web (url) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: pag_web_fk | type: CONSTRAINT --
-- ALTER TABLE peliculas.caratulas DROP CONSTRAINT IF EXISTS pag_web_fk CASCADE;
ALTER TABLE peliculas.caratulas ADD CONSTRAINT pag_web_fk FOREIGN KEY (url_pag_web)
REFERENCES peliculas.pag_web (url) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --