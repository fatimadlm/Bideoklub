--Triggers pruebas----------------------------------------------------------

--Desde el usuario administrador (tiene todos los permisos) introducimos un nuevo elemento a la tabla personal
INSERT INTO peliculas.personal(nombre, nacionalidad, f_nacimiento) VALUES ('Alvaro', 'Español', '2003-09-18');
--Se inserta correctamente
--Comprobamos que se ha insertado y se ha añadido a la tabla de auditoria
SELECT * FROM peliculas.personal WHERE nombre='Alvaro';
--Esta
--Comprobamos que se han metido los datos de la insercion en la tabla de auditoria
SELECT * FROM peliculas.auditoria;
--Aparecen los datos (Captura en la memoria)
--Insertamos una critica para probar los otros dos triggers ('cosa' es el nombre de la web, podria ser una url pero seria mas dificil encontrarla)
INSERT INTO peliculas.criticas(critico, puntuacion, texto, año_peliculas, titulo_peliculas, nombre_pag_web, fecha)
VALUES('alvaro', 6.5, 'mala', 2018, 'The Public', 'cosa', '2021-09-23');
--Se inserta
--Comprobamos que al ser una pagina web nueva se ha añadido a la tabla de las paginas web
SELECT * FROM peliculas.pag_web WHERE nombre='cosa';
--Esta
--Comprobamos que en la tabla de puntuacion_media se ha añadido la pelicula y su puntuacion
SELECT * FROM peliculas.puntuacion_media;
--Esta
--Añadimos otra critica a la misma pelicula con la misma web para comprobar si se hace la media y si al estar la pag web no la añade otra vez
INSERT INTO peliculas.criticas(critico, puntuacion, texto, año_peliculas, titulo_peliculas, nombre_pag_web, fecha)
VALUES('alvaro', 9.0, 'mala', 2018, 'The Public', 'cosa', '2021-09-23');
--Se inserta
--Comprobamos la puntuacion media y las pag. web
SELECT * FROM peliculas.puntuacion_media;
SELECT * FROM peliculas.pag_web WHERE nombre='cosa';
--Se hace la media y no se repite la pag.