--Funciones para los triggers---------------------------------------------------------

--Funcion para registrar los cambios realizados
CREATE OR REPLACE FUNCTION peliculas.fn_auditoria() RETURNS TRIGGER AS $fn_auditoria$
BEGIN
 	 INSERT INTO peliculas.auditoria (tabla, tipo, usuario, fecha)
  	VALUES (TG_TABLE_NAME, TG_OP, USER, NOW());
  	RETURN NULL;
END;
$fn_auditoria$ LANGUAGE plpgsql;

--Funcion para comprobar si esta la pagina web de la critica y si no esta que la añada
CREATE OR REPLACE FUNCTION peliculas.fn_comprobar_web() RETURNS TRIGGER AS $fn_comprobar_web$
BEGIN
IF NOT EXISTS (SELECT 1 FROM peliculas.pag_web WHERE nombre = NEW.nombre_pag_web) THEN
INSERT INTO peliculas.pag_web (nombre) VALUES (NEW.nombre_pag_web);
    	END IF;
    	RETURN NEW;
END;
$fn_comprobar_web$ LANGUAGE plpgsql;

--Funcion para actualizar la puntuacion media de las peliculas en una tabla nueva
CREATE OR REPLACE FUNCTION peliculas.fn_actualizar_media() RETURNS TRIGGER AS $fn_actualizar_media$
BEGIN
IF NOT EXISTS (SELECT 1 FROM peliculas.puntuacion_media WHERE titulo = NEW.titulo_peliculas) THEN
INSERT INTO peliculas.puntuacion_media (titulo, calificacion) VALUES (NEW.titulo_peliculas, NEW.calificacion);
   	 ELSE
        	UPDATE peliculas.puntuacion_media
SET calificacion = (SELECT AVG(calificacion) FROM peliculas.criticas WHERE titulo = NEW.titulo_peliculas)
        	WHERE titulo = NEW.titulo;
   	 END IF;
    	RETURN NULL;
END;
$fn_actualizar_media$ LANGUAGE plpgsql;

--Triggers-----------------------------------------------------------------------

--Triggers de cada tabla
CREATE TRIGGER tr_auditoria_actor
AFTER INSERT OR UPDATE OR DELETE ON peliculas.actor
FOR EACH ROW
EXECUTE FUNCTION peliculas.fn_auditoria();

CREATE TRIGGER tr_auditoria_actua
AFTER INSERT OR UPDATE OR DELETE ON peliculas.actua
FOR EACH ROW
EXECUTE FUNCTION peliculas.fn_auditoria();

CREATE TRIGGER tr_auditoria_caratulas
AFTER INSERT OR UPDATE OR DELETE ON peliculas.caratulas
FOR EACH ROW
EXECUTE FUNCTION peliculas.fn_auditoria();

CREATE TRIGGER tr_auditoria_criticas
AFTER INSERT OR UPDATE OR DELETE ON peliculas.criticas
FOR EACH ROW
EXECUTE FUNCTION peliculas.fn_auditoria();

CREATE TRIGGER tr_auditoria_director
AFTER INSERT OR UPDATE OR DELETE ON peliculas.director
FOR EACH ROW
EXECUTE FUNCTION peliculas.fn_auditoria();

CREATE TRIGGER tr_auditoria_generos
AFTER INSERT OR UPDATE OR DELETE ON peliculas.generos
FOR EACH ROW
EXECUTE FUNCTION peliculas.fn_auditoria();

CREATE TRIGGER tr_auditoria_pag_web
AFTER INSERT OR UPDATE OR DELETE ON peliculas.pag_web
FOR EACH ROW
EXECUTE FUNCTION peliculas.fn_auditoria();

CREATE TRIGGER tr_auditoria_peliculas
AFTER INSERT OR UPDATE OR DELETE ON peliculas.peliculas
FOR EACH ROW
EXECUTE FUNCTION peliculas.fn_auditoria();

CREATE TRIGGER tr_auditoria_personal
AFTER INSERT OR UPDATE OR DELETE ON peliculas.personal
FOR EACH ROW
EXECUTE FUNCTION peliculas.fn_auditoria();

--Trigger de pag_web
CREATE OR REPLACE TRIGGER comprobar_web
BEFORE INSERT ON peliculas.criticas
FOR EACH ROW
EXECUTE FUNCTION peliculas.fn_comprobar_web();

--Trigger de puntuacion media
CREATE TRIGGER actualizar_media
AFTER INSERT ON peliculas.criticas
FOR EACH ROW
EXECUTE FUNCTION actualizar_media();