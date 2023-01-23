import psycopg2

def main():
    try:
        connstr = 'host=localhost port=5432 user=administrador password=administrador dbname=peliculas' 

        conn = psycopg2.connect(connstr)
#
# Se realiza la conexión a la base de datos de pelicula con el usuario postgres
#
        cur = conn.cursor()
        cur.execute('SELECT * FROM peliculas.peliculas;')#consulta que queremos realizar
#
# Se crea un cursor que se carga con los valores del resultado de la consulta
# 
        #resultados=cur.fetchall();
        for año,titulo,duracion,idioma,calificacion,nombre_personal_director in cur.fetchall():
            print(año,titulo,duracion,idioma,calificacion,nombre_personal_director)
#Para consultas del tipo like,where
   # for in :
   #     print(resultados)
#    
#
        conn.commit()#Para guardar los datos
# Se recorre el cursor y se imprimen por pantalla los valores del resultado de la consulta
#
        cur.close
        conn.close
#
# Se cierra el cursor y la conexión a la base de datos
#
    except psycopg2.Error as error:
        print ("ERROR",error)
    finally:
     conn.close()


main()