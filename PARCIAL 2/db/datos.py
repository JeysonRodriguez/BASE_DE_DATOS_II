import mariadb
from dotenv import load_dotenv
import os
import bcrypt
import uuid
from random import randint
from datetime import datetime, timedelta
import sys
import traceback

load_dotenv()

DB_HOST = os.getenv("DB_HOST", "localhost")
DB_PORT = int(os.getenv("DB_PORT", 3306))
DB_USER = os.getenv("DB_USER", "root")
DB_PASSWORD = os.getenv("DB_PASSWORD", "")
DB_NAME = os.getenv("DB_NAME", "SIS-EXP")

def get_server_connection():
    """Conexión al servidor (sin seleccionar base necesariamente)."""
    return mariadb.connect(
        user=DB_USER,
        password=DB_PASSWORD,
        host=DB_HOST,
        port=DB_PORT,
        autocommit=False
    )

def get_db_connection():
    """Conexión ya apuntando a la base de datos (usada después de crearla)."""
    return mariadb.connect(
        user=DB_USER,
        password=DB_PASSWORD,
        host=DB_HOST,
        port=DB_PORT,
        database=DB_NAME,
        autocommit=False
    )

def run():
    try:
        # Conexión al servidor (sin DB) para crear/eliminar la base si es necesario
        server_conn = get_server_connection()
        server_cur = server_conn.cursor()
        print("Conexión al servidor MySQL/MariaDB establecida")

        # Eliminar base de datos 
        server_cur.execute(f"DROP DATABASE IF EXISTS `{DB_NAME}`;")
        print(f"Base de datos '{DB_NAME}' eliminada (si existía)")

        # Crear base de datos
        server_cur.execute(f"CREATE DATABASE IF NOT EXISTS `{DB_NAME}` CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;")
        print(f"Base de datos '{DB_NAME}' creada/existente")

        # Commit y cerrar conexión al servidor
        server_conn.commit()
        server_cur.close()
        server_conn.close()

        # Conexión ya a la base de datos creada
        conn = get_db_connection()
        cursor = conn.cursor()
        print(f"Conexión a la base de datos '{DB_NAME}' establecida")

        # Crear tablas
        cursor.execute("""
        CREATE TABLE IF NOT EXISTS usuarios(
            id VARCHAR(36) NOT NULL PRIMARY KEY,
            nombre_completo VARCHAR(100) NOT NULL,
            usuario VARCHAR(50) NOT NULL UNIQUE,
            contrasena VARCHAR(255) NOT NULL,
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
            updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
        );
        """)
        print("Tabla 'usuarios' creada exitosamente")

        cursor.execute("""
        CREATE TABLE IF NOT EXISTS personas(
            id VARCHAR(36) NOT NULL PRIMARY KEY,
            nombre_completo VARCHAR(100) NOT NULL,
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
            updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
        );
        """)
        print("Tabla 'personas' creada exitosamente")

        cursor.execute("""
        CREATE TABLE IF NOT EXISTS aseguradoras(
            id VARCHAR(36) NOT NULL PRIMARY KEY,
            nombre VARCHAR(100) NOT NULL,
            id_persona VARCHAR(36) NOT NULL,
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
            updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
            FOREIGN KEY (id_persona) REFERENCES personas(id)
        );
        """)
        print("Tabla 'aseguradoras' creada exitosamente")

        cursor.execute("""
        CREATE TABLE IF NOT EXISTS expedientes(
            id VARCHAR(36) NOT NULL PRIMARY KEY,
            aseguradora_id VARCHAR(36) NOT NULL, 
            estado ENUM('Pendiente','En curso','Cerrado') NOT NULL DEFAULT 'Pendiente',
            juzgado VARCHAR(255) NOT NULL,
            fecha_inicio DATE,
            fecha_finalizacion DATE,
            formato VARCHAR(50),
            conductor VARCHAR(255),
            numero_de_caso VARCHAR(50),
            tipo_de_proceso ENUM('TRANSITO', 'PENAL') NOT NULL,
            abogado_id VARCHAR(36) NOT NULL,
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
            updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
            CONSTRAINT `fk_expediente_aseguradora` FOREIGN KEY (aseguradora_id) REFERENCES aseguradoras(id),
            CONSTRAINT `fk_expediente_abogado` FOREIGN KEY (abogado_id) REFERENCES usuarios(id)
        );
        """)
        print("Tabla 'expedientes' creada exitosamente")

        conn.commit()

        insert_usuario_sql = "INSERT INTO usuarios (id, usuario, nombre_completo, contrasena) VALUES (%s, %s, %s, %s)"
        nombres_usuarios = [
            (str(uuid.uuid4()), "sofia.rodriguez", "Sofía Rodríguez", "secret"),
            (str(uuid.uuid4()), "luis.castillo", "Luis Castillo", "secret"),
            (str(uuid.uuid4()), "andres.mejia", "Andrés Mejía", "secret"),
        ]

        for usuario in nombres_usuarios:
            uid = usuario[0]
            username = usuario[1]
            full = usuario[2]
            raw_pass = usuario[3]
            hashed = bcrypt.hashpw(raw_pass.encode("utf-8"), bcrypt.gensalt(12)).decode("utf-8")
            cursor.execute(insert_usuario_sql, (uid, username, full, hashed))
            print(f"Usuario '{username}' insertado")
        conn.commit()

        # Aseguradoras -  nombres
        nombres_aseguradoras = [
            (str(uuid.uuid4()), "Seguros Nacionales"),
            (str(uuid.uuid4()), "Protección Total"),
            (str(uuid.uuid4()), "VidaFuerte"),
            (str(uuid.uuid4()), "Seguros Istmo"),
            (str(uuid.uuid4()), "Panaseguro"),
            (str(uuid.uuid4()), "Seguros Pacífico"),
            (str(uuid.uuid4()), "Coberturas Plus"),
        ]

        # Personas (asegurados) -  nombres
        nombre_personas = [
            (str(uuid.uuid4()), "Ricardo Mendoza"),
            (str(uuid.uuid4()), "Verónica Salazar"),
            (str(uuid.uuid4()), "Héctor Aguilar"),
            (str(uuid.uuid4()), "María Valverde"),
            (str(uuid.uuid4()), "José Domínguez"),
            (str(uuid.uuid4()), "Adriana Cortés"),
            (str(uuid.uuid4()), "Fernando Lara"),
        ]

        insert_persona_sql = "INSERT INTO personas (id, nombre_completo) VALUES (%s, %s)"
        insert_aseguradora_sql = "INSERT INTO aseguradoras (id, nombre, id_persona) VALUES (%s, %s, %s)"

        for i in range(len(nombres_aseguradoras)):
            id_persona = nombre_personas[i][0]
            nombre_persona = nombre_personas[i][1]
            id_aseguradora = nombres_aseguradoras[i][0]
            nombre_aseg = nombres_aseguradoras[i][1]

            cursor.execute(insert_persona_sql, (id_persona, nombre_persona))
            cursor.execute(insert_aseguradora_sql, (id_aseguradora, nombre_aseg, id_persona))
            print(f"Aseguradora '{nombre_aseg}' y persona '{nombre_persona}' insertadas")
        conn.commit()

        # Insertar expedientes de ejemplo
        insert_expediente_sql = """
        INSERT INTO expedientes 
        (id, aseguradora_id, estado, juzgado, fecha_inicio, fecha_finalizacion, formato, conductor, numero_de_caso, tipo_de_proceso, abogado_id)
        VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
        """
        # coger IDs de usuarios para asignar abogados
        cursor.execute("SELECT id FROM usuarios")
        usuarios_ids = [row[0] for row in cursor.fetchall()]

        for i in range(len(nombre_personas)):
            id_expediente = str(uuid.uuid4())
            aseguradora_id = nombres_aseguradoras[i][0]
            estado = ["Pendiente", "En curso", "Cerrado"][randint(0,2)]
            fecha_inicio = datetime.now().date()
            fecha_finalizacion = (datetime.now() + timedelta(days=randint(5,30))).date()
            formato = ["Digital", "Fisico"][randint(0,1)]
            conductor = f"Conductor {i+1}"
            numero_de_caso = f"CASO-{randint(1000,9999)}"
            tipo_de_proceso = ["TRANSITO","PENAL"][randint(0,1)]
            abogado_id = usuarios_ids[randint(0, len(usuarios_ids)-1)]

            cursor.execute(insert_expediente_sql, (
                id_expediente,
                aseguradora_id,
                estado,
                f"Juzgado {i+1}",
                fecha_inicio,
                fecha_finalizacion,
                formato,
                conductor,
                numero_de_caso,
                tipo_de_proceso,
                abogado_id
            ))
            print(f"Expediente {numero_de_caso} insertado para aseguradora {aseguradora_id}")
        conn.commit()

        # Crear vistas
        cursor.execute("""
        CREATE OR REPLACE VIEW vista_expedientes AS
        SELECT e.id, e.abogado_id AS usuario_id, a.nombre AS aseguradora, p.nombre_completo AS asegurado, e.juzgado, e.fecha_inicio, e.fecha_finalizacion
        FROM expedientes e 
        JOIN aseguradoras a ON a.id = e.aseguradora_id 
        JOIN personas p ON a.id_persona = p.id
        JOIN usuarios u ON e.abogado_id = u.id;
        """)
        print("Vista 'vista_expedientes' creada")

        cursor.execute("""
        CREATE OR REPLACE VIEW vista_conteo_expedientes AS
        SELECT estado, abogado_id AS usuario_id, COUNT(*) AS conteo FROM expedientes GROUP BY abogado_id, estado;
        """)
        print("Vista 'vista_conteo_expedientes' creada")

        cursor.execute("""
        CREATE OR REPLACE VIEW vista_expedientes_totales AS
        SELECT a.nombre AS aseguradora, e.tipo_de_proceso as tipo_de_proceso, u.nombre_completo as abogado, e.fecha_inicio as fecha_inicio, p.nombre_completo as asegurado 
        FROM expedientes e 
        JOIN aseguradoras a ON a.id = e.aseguradora_id
        JOIN personas p ON a.id_persona = p.id
        JOIN usuarios u ON e.abogado_id = u.id;
        """)
        print("Vista 'vista_expedientes_totales' creada")
        conn.commit()

        # Cerrar
        cursor.close()
        conn.close()
        print("Script completado correctamente")

    except Exception as ex:
        print("Error durante la ejecución del script:")
        traceback.print_exc()
        try:
            conn.rollback()
        except Exception:
            pass
        try:
            cursor.close()
            conn.close()
        except Exception:
            pass
        sys.exit(1)

if __name__ == "__main__":
    run()
