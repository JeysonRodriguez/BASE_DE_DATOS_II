from flask import Flask, request, jsonify
from db.conexion import (
    encontrarUsuario,
    crearExpediente,
    getExpedientes,
    getExpedientesPorFecha,
    getExpedientesConteo,
    getExpedientesTotales
)
import bcrypt

app = Flask(__name__)

@app.route("/login", methods=["POST"])
def login():
    data = request.get_json()
    if not data:
        return jsonify({"error": "Falta usuario y contraseña"}), 400

    usuario = data.get("usuario")
    contrasena = data.get("contrasena")

    if not usuario or not contrasena:
        return jsonify({"error": "Falta usuario y contraseña"}), 400

    user = encontrarUsuario(usuario)
    if not user:
        return jsonify({"error": "Usuario no encontrado"}), 404

    try:
        stored_hash = user.get("contrasena")
        if isinstance(stored_hash, str):
            stored_hash = stored_hash.encode("utf-8")
        is_valid = bcrypt.checkpw(contrasena.encode("utf-8"), stored_hash)
    except Exception as e:
        return jsonify({"error": "Error verificando contraseña", "detail": str(e)}), 500

    if not is_valid:
        return jsonify({"error": "Usuario o contrasena incorrecta"}), 401

    return jsonify({
        "message": "Login exitoso",
        "user": {
            "id": user.get("id"),
            "nombre_completo": user.get("nombre_completo"),
            "usuario": user.get("usuario"),
            "role": user.get("role", None)
        }
    }), 200

@app.route("/expedientes", methods=["POST"])
def create_expediente():
    """Create a new expediente"""
    data = request.get_json()
    if not data:
        return jsonify({"error": "Cuerpo JSON requerido"}), 400

    required_fields = [
        "conductor", "aseguradora", "numero_de_caso", "tipo_de_proceso",
        "abogado", "fecha_inicio", "fecha_finalizacion", "juzgado", "formato"
    ]

    for field in required_fields:
        if field not in data or data.get(field) in (None, ""):
            return jsonify({"error": f"Falta el campo {field}"}), 400

    result = crearExpediente(data)
    if isinstance(result, dict) and result.get("error"):
        return jsonify(result), 400

    return jsonify(result), 201

@app.route("/expedientes", methods=["GET"])
def list_expedientes():
    """List expedientes filtrados por abogado (abogado_id)"""
    abogado_id = request.args.get("abogado_id")
    if not abogado_id:
        return jsonify({"error": "Falta el parametro abogado_id"}), 400

    info = getExpedientes(abogado_id)
    return jsonify(info), 200

@app.route("/expedientes/fecha/<fecha>", methods=["GET"])
def list_expedientes_por_fecha(fecha):
    """List expedientes by date (fecha en formato YYYY-MM-DD o DD-MM-YYYY), restringido por abogado"""
    abogado_id = request.args.get("abogado_id")
    if not abogado_id:
        return jsonify({"error": "Falta el parametro abogado_id"}), 400

    info = getExpedientesPorFecha(fecha, abogado_id)
    return jsonify(info), 200

@app.route("/expedientes/conteo", methods=["GET"])
def conteo_expedientes():
    """Dar conteo de expedientes por estado (para un abogado)"""
    abogado_id = request.args.get("abogado_id")
    if not abogado_id:
        return jsonify({"error": "Falta el parametro abogado_id"}), 400

    query_result = getExpedientesConteo(abogado_id)
    return jsonify(query_result), 200

@app.route("/expedientes/totales", methods=["GET"])
def list_expedientes_totales():
    """List all expedientes totales (filtros opcionales)"""
    aseguradora = request.args.get("aseguradora")
    tipo_de_proceso = request.args.get("tipo_de_proceso")
    abogado = request.args.get("abogado")  

    info = getExpedientesTotales(aseguradora, tipo_de_proceso, abogado)
    return jsonify(info), 200

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=True)

