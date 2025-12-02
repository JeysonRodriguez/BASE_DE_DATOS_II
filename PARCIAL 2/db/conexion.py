import mariadb
import os
from dotenv import load_dotenv
from datetime import datetime
import uuid

load_dotenv()

DB_HOST = os.getenv("DB_HOST", "localhost")
DB_PORT = int(os.getenv("DB_PORT", 3306))
DB_USER = os.getenv("DB_USER", "root")
DB_PASSWORD = os.getenv("DB_PASSWORD", "")
DB_NAME = os.getenv("DB_NAME", "SIS-EXP")

def getConnexion():
    """
    Devuelve una nueva conexión a la base de datos.
    """
    connector = mariadb.connect(
        user=DB_USER,
        password=DB_PASSWORD,
        host=DB_HOST,
        port=DB_PORT,
        database=DB_NAME,
        autocommit=False
    )
    return connector

def get_cursor():
    """
    Devuelve (conn, cursor). Siempre cerrar conn en el caller.
    """
    conn = getConnexion()
    cursor = conn.cursor()
    return conn, cursor

def getEntidad(nombre):
    """
    SELECT * FROM <nombre_tabla>
    Devuelve lista de diccionarios.
    """
    conn, cursor = get_cursor()
    try:
        query = f"SELECT * FROM `{nombre}`"
        cursor.execute(query)
        rows = cursor.fetchall()
        columns = [desc[0] for desc in cursor.description] if cursor.description else []
        result = [dict(zip(columns, row)) for row in rows]
        return result
    finally:
        cursor.close()
        conn.close()

def getExpedientes(abogado_id):
    """
    Devuelve expedientes filtrados por abogado_id.
    """
    conn, cursor = get_cursor()
    try:
        query = "SELECT * FROM vista_expedientes WHERE abogado_id = %s;"
        cursor.execute(query, (abogado_id,))
        rows = cursor.fetchall()
        columns = [desc[0] for desc in cursor.description] if cursor.description else []
        return [dict(zip(columns, row)) for row in rows]
    finally:
        cursor.close()
        conn.close()

def normalize_date_input(fecha):
    """
    Acepta 'DD-MM-YYYY' o 'YYYY-MM-DD' y retorna 'YYYY-MM-DD' o lanza ValueError.
    """
    for fmt in ("%Y-%m-%d", "%d-%m-%Y"):
        try:
            d = datetime.strptime(fecha, fmt)
            return d.strftime("%Y-%m-%d")
        except ValueError:
            continue
    raise ValueError("Formato de fecha inválido. Use YYYY-MM-DD o DD-MM-YYYY")

def getExpedientesPorFecha(fecha, abogado_id):
    """
    Busca expedientes donde fecha está entre fecha_inicio y fecha_finalizacion.
    """
    try:
        fecha_sql = normalize_date_input(fecha)
    except ValueError as e:
        return {"error": str(e)}

    conn, cursor = get_cursor()
    try:
        # Usamos condición explícita en ambas columnas
        query = """
            SELECT * FROM vista_expedientes
            WHERE fecha_inicio <= %s AND fecha_finalizacion >= %s
              AND abogado_id = %s;
        """
        cursor.execute(query, (fecha_sql, fecha_sql, abogado_id))
        rows = cursor.fetchall()
        columns = [desc[0] for desc in cursor.description] if cursor.description else []
        return [dict(zip(columns, row)) for row in rows]
    finally:
        cursor.close()
        conn.close()

def getExpedientesConteo(abogado_id):
    """
    Retorna conteo por estado para un abogado (abogado_id).
    """
    conn, cursor = get_cursor()
    try:
        query = "SELECT conteo, estado FROM vista_conteo_expedientes WHERE abogado_id = %s;"
        cursor.execute(query, (abogado_id,))
        rows = cursor.fetchall()
        columns = [desc[0] for desc in cursor.description] if cursor.description else []
        return [dict(zip(columns, row)) for row in rows]
    finally:
        cursor.close()
        conn.close()

def getExpedientesTotales(aseguradora=None, tipo_de_proceso=None, abogado=None):
    """
    Filtros opcionales; parámetros añadidos dinámicamente.
    """
    conn, cursor = get_cursor()
    try:
        query = "SELECT * FROM vista_expedientes_totales WHERE 1=1"
        params = []

        if aseguradora:
            query += " AND aseguradora = %s"
            params.append(aseguradora)
        if tipo_de_proceso:
            query += " AND tipo_de_proceso = %s"
            params.append(tipo_de_proceso)
        if abogado:
            query += " AND abogado = %s"
            params.append(abogado)

        query += " ORDER BY fecha_inicio DESC LIMIT 1000;"

        cursor.execute(query, tuple(params))
        rows = cursor.fetchall()
        columns = [desc[0] for desc in cursor.description] if cursor.description else []
        return [dict(zip(columns, row)) for row in rows]
    finally:
        cursor.close()
        conn.close()

def encontrarUsuario(usuario):
    """
    Buscar usuario por 'usuario' (username). Devuelve dict o None.
    """
    conn, cursor = get_cursor()
    try:
        query = "SELECT id, nombre_completo, usuario, contrasena, role FROM usuarios WHERE usuario = %s LIMIT 1;"
        cursor.execute(query, (usuario,))
        row = cursor.fetchone()
        if row:
            columns = [desc[0] for desc in cursor.description]
            user = dict(zip(columns, row))
            return user
        return None
    finally:
        cursor.close()
        conn.close()

def getAseguradoraIdPorNombre(nombre):
    """
    Retorna id de aseguradora por nombre, o None.
    """
    conn, cursor = get_cursor()
    try:
        query = "SELECT id FROM aseguradoras WHERE nombre = %s LIMIT 1;"
        cursor.execute(query, (nombre,))
        row = cursor.fetchone()
        if row:
            return row[0]
        return None
    finally:
        cursor.close()
        conn.close()

def crearExpediente(data):
    """
    Crea un expediente. 'abogado' puede venir como id (UUID string) o como nombre de usuario.
    'aseguradora' puede venir como id (UUID string) o como nombre (string).
    Devuelve dict con mensaje/id o error.
    """
    conn = getConnexion()
    cursor = conn.cursor()
    try:
        id_expediente = str(uuid.uuid4())

        aseguradora = data.get('aseguradora')
        if not aseguradora:
            return {"error": "Falta campo 'aseguradora'"}

        # obtener o crear aseguradora
        aseguradora_id = None
        if isinstance(aseguradora, str) and len(aseguradora) == 36:
            # es probable UUID
            cursor.execute("SELECT id FROM aseguradoras WHERE id = %s LIMIT 1;", (aseguradora,))
            if cursor.fetchone():
                aseguradora_id = aseguradora
            else:
                return {"error": "aseguradora id no encontrada"}
        else:
            # buscar por nombre
            cursor.execute("SELECT id FROM aseguradoras WHERE nombre = %s LIMIT 1;", (aseguradora,))
            row = cursor.fetchone()
            if row:
                aseguradora_id = row[0]
            else:
                # crear nueva aseguradora con UUID y id_persona NULL
                new_aseg_id = str(uuid.uuid4())
                cursor.execute("INSERT INTO aseguradoras (id, nombre, id_persona) VALUES (%s, %s, %s);",
                               (new_aseg_id, aseguradora, None))
                aseguradora_id = new_aseg_id

        abogado = data.get('abogado')
        if not abogado:
            return {"error": "Falta campo 'abogado'"}

        abogado_id = None
        if isinstance(abogado, str) and len(abogado) == 36:
            cursor.execute("SELECT id FROM usuarios WHERE id = %s LIMIT 1;", (abogado,))
            if cursor.fetchone():
                abogado_id = abogado
            else:
                return {"error": "abogado id no encontrado"}
        else:
            usuario_abogado = encontrarUsuario(abogado)
            if not usuario_abogado:
                return {"error": f"Abogado (usuario) '{abogado}' no encontrado"}
            abogado_id = usuario_abogado['id']

        insert_sql = """
            INSERT INTO expedientes
            (id, aseguradora_id, estado, juzgado, fecha_inicio, fecha_finalizacion, formato, conductor,
             numero_de_caso, tipo_de_proceso, abogado_id)
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s);
        """
        params = (
            id_expediente,
            aseguradora_id,
            data.get('estado', 'Pendiente'),
            data.get('juzgado'),
            data.get('fecha_inicio'),
            data.get('fecha_finalizacion'),
            data.get('formato'),
            data.get('conductor'),
            data.get('numero_de_caso'),
            data.get('tipo_de_proceso'),
            abogado_id
        )
        cursor.execute(insert_sql, params)
        conn.commit()
        return {"message": "Expediente creado exitosamente", "id": id_expediente}
    except Exception as e:
        conn.rollback()
        return {"error": str(e)}
    finally:
        try:
            cursor.close()
            conn.close()
        except Exception:
            pass



