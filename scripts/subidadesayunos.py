import mysql.connector
import requests
import logging
from mysql.connector import Error

# Configuración del logging
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

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
        logging.info("No hay conexión a Internet. Terminando el script.")
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

        # Consulta para seleccionar registros con server = 0
        query = "SELECT idAsistencia, fecha_hora, dni FROM asistenciacomedordesayuno WHERE server = 0"
        mycursor.execute(query)
        result = mycursor.fetchall()

        if not result:
            logging.info("No hay más registros para procesar.")
            return  # Salir del script si no hay más registros

        # Recorrer los registros
        for row in result:
            idAsistencia, fecha_hora, dni = row

            # Enviar los datos al servidor
            url = f"http://182.160.24.51:8080/controllers/asistenciaDesayuno.controller.php?op=registrarAsistenciaDesayuno&fecha_hora={fecha_hora}&dni={dni}"
            try:
                response = requests.get(url)
                if response.status_code == 200:
                    # Actualizar el atributo 'server' a 1
                    update_query = "UPDATE asistenciacomedordesayuno SET server = 1 WHERE idAsistencia = %s"
                    mycursor.execute(update_query, (idAsistencia,))
                    mydb.commit()
                    logging.info(f"Datos de estudiante con ID {idAsistencia} sincronizados correctamente.")
                else:
                    logging.warning(f"Error al enviar datos del estudiante con ID {idAsistencia}. Código de estado: {response.status_code}")
            except requests.RequestException as e:
                logging.error(f"Error en la solicitud HTTP para el estudiante con ID {idAsistencia}: {e}")

    except Error as e:
        logging.error(f"Error al conectar a MySQL: {e}")
    finally:
        if mycursor:
            mycursor.close()
        if mydb:
            mydb.close()

if __name__ == "__main__":
    process_students()
