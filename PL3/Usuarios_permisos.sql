--Creacion de roles y usuarios---------------------------------------------

--Creamos rol de administrador con todos los privilegios
CREATE ROLE administrador WITH LOGIN PASSWORD 'administrador'
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA peliculas TO administrador;

--Creamos rol de gestor con privilegios de seleccion, insercion, actualizacion y borrado
CREATE ROLE gestor WITH LOGIN PASSWORD 'gestor'
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA peliculas TO gestor;

--Creamos rol de cliente con privilegios de seleccion
CREATE ROLE cliente WITH LOGIN PASSWORD 'cliente'
GRANT SELECT ON ALL TABLES IN SCHEMA peliculas TO cliente;

--Creamos rol de critico con privilegios de seleccion e insercion solo en la tabla de criticas
CREATE ROLE critico WITH LOGIN PASSWORD 'critico'
GRANT SELECT ON ALL TABLES IN SCHEMA peliculas to critico;
GRANT INSERT ON TABLE peliculas.criticas TO critico;
