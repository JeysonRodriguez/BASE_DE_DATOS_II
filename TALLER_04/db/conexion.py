import mariadb
import os
from dotenv import load_dotenv

load_dotenv()

def getConnexion():
    connector = mariadb.connect(
        user=os.getenv("DB_USER"),
        password=os.getenv("DB_PASSWORD"),
        host=os.getenv("DB_HOST"),
        port=int(os.getenv("DB_PORT")),
        database=os.getenv("DB_NAME")
    )
    return connector

def getCursor():
    return getConnexion().cursor()

def getEntidad(nombre):
    
    conn = getConnexion()
    cursor = conn.cursor()
    query = "SELECT * FROM {}".format(nombre)

    print("Query: ", query)

    cursor.execute(query)
    rows = cursor.fetchall()
    columns = [desc[0] for desc in cursor.description] if cursor.description else []
    result = [dict(zip(columns, row)) for row in rows]

    cursor.close()
    conn.close()
    return result

def getExpedientes():
    cursor = getCursor()
    query = """SELECT e.id, a.nombre AS aseguradora, p.nombre_completo AS asegurado, e.juzgado, e.estado, DATE(e.fecha) as FECHA FROM expedientes e JOIN aseguradoras a ON a.id = e.aseguradora_id JOIN personas p ON
a.id_persona = p.id"""
    cursor.execute(query)
    rows = cursor.fetchall()
    columns = [desc[0] for desc in cursor.description] if cursor.description else []
    result = [dict(zip(columns, row)) for row in rows]
    return result

def getExpedientesConteo():
    cursor = getCursor()
    query = """SELECT estado, COUNT(*) AS conteo FROM expedientes GROUP BY estado;"""
    cursor.execute(query)
    rows = cursor.fetchall()
    columns = [desc[0] for desc in cursor.description] if cursor.description else []
    result = [dict(zip(columns, row)) for row in rows]
    return result

def encontrarUsuario(usuario):
    cursor = getCursor()
    query = "SELECT id, nombre_completo, usuario, contrasena, created_at FROM usuarios WHERE usuario = ? "
    cursor.execute(query, (usuario,))
    row = cursor.fetchone()
    if row:
        columns = [desc[0] for desc in cursor.description]
        return dict(zip(columns, row))
    return None

if __name__ == "__main__":
    print("Conexión exitosa a la base de datos")
   