import mysql.connector
import requests
from mysql.connector import Error

def check_internet_connection():
    try:
        # Intenta acceder a un sitio conocido
        response = requests.get('http://www.google.com', timeout=5)
        return response.status_code == 200
    except requests.ConnectionError:
        return False

def process_students():
    if not check_internet_connection():
        # Si no hay conexión a Internet, termina el script
        return
    
    mydb = None
    mycursor = None
    
    try:
        # Configuración de la conexión a la base de datos
        mydb = mysql.connector.connect(
            host="localhost",
            user="root",
            passwd="",
            database="sistemareconocimiento"
        )
        mycursor = mydb.cursor()

        # Eliminar registros con server = 1 en ambas tablas
        delete_query = "DELETE FROM asistenciacomedoralmuerzo WHERE server = 1"
        mycursor.execute(delete_query)
        
        delete_query = "DELETE FROM asistenciacomedordesayuno WHERE server = 1"
        mycursor.execute(delete_query)
        
        mydb.commit()

        # Consulta para seleccionar registros con server = 0
        query = "SELECT id, cUniversitario, dni, nombres, aPaterno, aMaterno, carrera, modalidad FROM estudiante WHERE server = 0"
        mycursor.execute(query)
        result = mycursor.fetchall()

        if not result:
            return  # Salir del script si no hay más registros

        # Recorrer los registros
        for row in result:
            id, cUniversitario, dni, nombres, aPaterno, aMaterno, carrera,modalidad = row

            # Enviar los datos al servidor
            url = f"http://182.160.24.51:8080/controllers/Estudiante.controller.php?op=registrarEstudiantes&coduniversitario={cUniversitario}&dni={dni}&nombres={nombres}&apaterno={aPaterno}&amaterno={aMaterno}&carrera={carrera}&modalidad={modalidad}"
            
            try:
                response = requests.get(url)
                if response.status_code == 200:
                    # Actualizar el atributo 'server' a 1
                    update_query = "UPDATE estudiante SET server = 1 WHERE id = %s"
                    mycursor.execute(update_query, (id,))
                    mydb.commit()
                # No se imprimen mensajes
            except requests.RequestException:
                # No se imprimen mensajes
                pass

    except Error:
        # No se imprimen mensajes
        pass
    finally:
        if mycursor:
            mycursor.close()
        if mydb:
            mydb.close()

if __name__ == "__main__":
    process_students()
