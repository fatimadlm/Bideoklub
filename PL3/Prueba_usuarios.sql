--Pruebas de usuarios y permisos------------------------------------------------------------------------
--Iniciamos sesion siendo administrador para comprobar que podemos hacer todo
--Desde el terminal: psql -U administrador -p 5432 -d peliculas -W
--Ya hemos probado la insercion y consultas en prueba_triggers
--Probamos el borrado
DELETE FROM peliculas.personal WHERE nombre = 'Alvaro';
SELECT * FROM peliculas.personal WHERE nombre = 'Alvaro';
--Devuelve tabla vacia
--El gestor tiene los mismos permisos asi que funcionara igual. Hacemos lo mismo pero iniciando sesion con gestor
--Probamos a insertar siendo cliente. Iniciamos sesion.
INSERT INTO peliculas.personal(nombre, nacionalidad, f_nacimiento) VALUES ('Alvaro', 'Español', '2003-09-18');
--Resultado: ERROR:  permission denied for table personal (captura en memoria)
--Lo mismo al intentar borrar. 
--Probamos a insertar en personal siendo critico (solo puede insertar en la tabla criticas)
INSERT INTO peliculas.personal(nombre, nacionalidad, f_nacimiento) VALUES ('Alvaro', 'Español', '2003-09-18');
--Resultado: ERROR:  permission denied for table personal (captura en memoria)
--Probamos a insertar en la tabla de criticas
INSERT INTO peliculas.criticas(critico, puntuacion, texto, año_peliculas, titulo_peliculas, nombre_pag_web, fecha)
VALUES('alvaro', 6.5, 'mala', 2018, 'The Public', 'cosa', '2021-09-23');
--Resultado: se inserta