-- Database generated with pgModeler (PostgreSQL Database Modeler).
-- pgModeler  version: 0.9.3-beta1
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


-- object: public."Peliculas" | type: TABLE --
-- DROP TABLE IF EXISTS public."Peliculas" CASCADE;
CREATE TABLE public."Peliculas" (
	"Anno" smallint NOT NULL,
	"Titulo" varchar NOT NULL,
	"Idioma" varchar,
	"Genero" varchar,
	"Calificacion" smallint,
	"Duracion" varchar,
	"DNI_Personal_Director" varchar,
	CONSTRAINT "Peliculas_pk" PRIMARY KEY ("Anno","Titulo")

);
-- ddl-end --
ALTER TABLE public."Peliculas" OWNER TO postgres;
-- ddl-end --

-- object: public."Personal" | type: TABLE --
-- DROP TABLE IF EXISTS public."Personal" CASCADE;
CREATE TABLE public."Personal" (
	"Nombre" varchar,
	"annoNacimiento" smallint,
	"Nacionalidad" varchar,
	"DNI" varchar NOT NULL,
	CONSTRAINT "Personal_pk" PRIMARY KEY ("DNI")

);
-- ddl-end --
ALTER TABLE public."Personal" OWNER TO postgres;
-- ddl-end --

-- object: public."Actor" | type: TABLE --
-- DROP TABLE IF EXISTS public."Actor" CASCADE;
CREATE TABLE public."Actor" (
	"DNI_Personal" varchar NOT NULL,
	CONSTRAINT "Actor_pk" PRIMARY KEY ("DNI_Personal")

);
-- ddl-end --
ALTER TABLE public."Actor" OWNER TO postgres;
-- ddl-end --

-- object: public."Director" | type: TABLE --
-- DROP TABLE IF EXISTS public."Director" CASCADE;
CREATE TABLE public."Director" (
	"DNI_Personal" varchar NOT NULL,
	CONSTRAINT "Director_pk" PRIMARY KEY ("DNI_Personal")

);
-- ddl-end --
ALTER TABLE public."Director" OWNER TO postgres;
-- ddl-end --

-- object: "Personal_fk" | type: CONSTRAINT --
-- ALTER TABLE public."Actor" DROP CONSTRAINT IF EXISTS "Personal_fk" CASCADE;
ALTER TABLE public."Actor" ADD CONSTRAINT "Personal_fk" FOREIGN KEY ("DNI_Personal")
REFERENCES public."Personal" ("DNI") MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: "Personal_fk" | type: CONSTRAINT --
-- ALTER TABLE public."Director" DROP CONSTRAINT IF EXISTS "Personal_fk" CASCADE;
ALTER TABLE public."Director" ADD CONSTRAINT "Personal_fk" FOREIGN KEY ("DNI_Personal")
REFERENCES public."Personal" ("DNI") MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: "Director_fk" | type: CONSTRAINT --
-- ALTER TABLE public."Peliculas" DROP CONSTRAINT IF EXISTS "Director_fk" CASCADE;
ALTER TABLE public."Peliculas" ADD CONSTRAINT "Director_fk" FOREIGN KEY ("DNI_Personal_Director")
REFERENCES public."Director" ("DNI_Personal") MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: public."many_Actor_has_many_Peliculas" | type: TABLE --
-- DROP TABLE IF EXISTS public."many_Actor_has_many_Peliculas" CASCADE;
CREATE TABLE public."many_Actor_has_many_Peliculas" (
	"DNI_Personal_Actor" varchar NOT NULL,
	"Anno_Peliculas" smallint NOT NULL,
	"Titulo_Peliculas" varchar NOT NULL,
	"Papel" varchar,
	CONSTRAINT "many_Actor_has_many_Peliculas_pk" PRIMARY KEY ("DNI_Personal_Actor","Anno_Peliculas","Titulo_Peliculas")

);
-- ddl-end --

-- object: "Actor_fk" | type: CONSTRAINT --
-- ALTER TABLE public."many_Actor_has_many_Peliculas" DROP CONSTRAINT IF EXISTS "Actor_fk" CASCADE;
ALTER TABLE public."many_Actor_has_many_Peliculas" ADD CONSTRAINT "Actor_fk" FOREIGN KEY ("DNI_Personal_Actor")
REFERENCES public."Actor" ("DNI_Personal") MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: "Peliculas_fk" | type: CONSTRAINT --
-- ALTER TABLE public."many_Actor_has_many_Peliculas" DROP CONSTRAINT IF EXISTS "Peliculas_fk" CASCADE;
ALTER TABLE public."many_Actor_has_many_Peliculas" ADD CONSTRAINT "Peliculas_fk" FOREIGN KEY ("Anno_Peliculas","Titulo_Peliculas")
REFERENCES public."Peliculas" ("Anno","Titulo") MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: public."Caratula" | type: TABLE --
-- DROP TABLE IF EXISTS public."Caratula" CASCADE;
CREATE TABLE public."Caratula" (
	"Tipo" varchar,
	"Tamanno" smallint,
	"Anno_Peliculas" smallint,
	"Titulo_Peliculas" varchar,
	url_web varchar,
	"Id" smallint NOT NULL,
	CONSTRAINT "Caratula_pk" PRIMARY KEY ("Id")

);
-- ddl-end --
ALTER TABLE public."Caratula" OWNER TO postgres;
-- ddl-end --

-- object: "Peliculas_fk" | type: CONSTRAINT --
-- ALTER TABLE public."Caratula" DROP CONSTRAINT IF EXISTS "Peliculas_fk" CASCADE;
ALTER TABLE public."Caratula" ADD CONSTRAINT "Peliculas_fk" FOREIGN KEY ("Anno_Peliculas","Titulo_Peliculas")
REFERENCES public."Peliculas" ("Anno","Titulo") MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: public.critica | type: TABLE --
-- DROP TABLE IF EXISTS public.critica CASCADE;
CREATE TABLE public.critica (
	critico varchar,
	puntuacion smallint,
	texto varchar,
	url_web varchar,
	fecha date,
	"Anno_Peliculas" smallint,
	"Titulo_Peliculas" varchar,
	"Id" smallint NOT NULL,
	CONSTRAINT critica_pk PRIMARY KEY ("Id")

);
-- ddl-end --
ALTER TABLE public.critica OWNER TO postgres;
-- ddl-end --

-- object: public.web | type: TABLE --
-- DROP TABLE IF EXISTS public.web CASCADE;
CREATE TABLE public.web (
	url varchar NOT NULL,
	tipo varchar,
	CONSTRAINT web_pk PRIMARY KEY (url)

);
-- ddl-end --
ALTER TABLE public.web OWNER TO postgres;
-- ddl-end --

-- object: web_fk | type: CONSTRAINT --
-- ALTER TABLE public.critica DROP CONSTRAINT IF EXISTS web_fk CASCADE;
ALTER TABLE public.critica ADD CONSTRAINT web_fk FOREIGN KEY (url_web)
REFERENCES public.web (url) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: "Peliculas_fk" | type: CONSTRAINT --
-- ALTER TABLE public.critica DROP CONSTRAINT IF EXISTS "Peliculas_fk" CASCADE;
ALTER TABLE public.critica ADD CONSTRAINT "Peliculas_fk" FOREIGN KEY ("Anno_Peliculas","Titulo_Peliculas")
REFERENCES public."Peliculas" ("Anno","Titulo") MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: web_fk | type: CONSTRAINT --
-- ALTER TABLE public."Caratula" DROP CONSTRAINT IF EXISTS web_fk CASCADE;
ALTER TABLE public."Caratula" ADD CONSTRAINT web_fk FOREIGN KEY (url_web)
REFERENCES public.web (url) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --


