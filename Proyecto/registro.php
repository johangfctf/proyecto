<?php
// ------------------- CONEXIÓN A SQLITE -------------------
$db = new SQLite3('farmacia.db');

if (!$db) {
    die("Error al conectar con la base de datos SQLite");
}

// ------------------- OBTENER DATOS DEL FORMULARIO -------------------
$nombre = $_POST['nombre'];
$correo = $_POST['correo'];
$telefono = $_POST['telefono'];
$password = $_POST['password'];
$confirmar = $_POST['confirmar'];

// ------------------- VALIDAR CONTRASEÑAS -------------------
if ($password !== $confirmar) {
    echo "
        <script>
            alert('Las contraseñas no coinciden');
            window.location.href = 'registro.html';
        </script>
    ";
    exit();
}

// ------------------- VERIFICAR CORREO REPETIDO -------------------
$sqlCorreo = $db->prepare("SELECT * FROM usuarios WHERE correo = :correo");
$sqlCorreo->bindValue(':correo', $correo, SQLITE3_TEXT);
$resultadoCorreo = $sqlCorreo->execute();

if ($resultadoCorreo->fetchArray(SQLITE3_ASSOC)) {
    echo "
        <script>
            alert('Este correo ya está registrado');
            window.location.href = 'registro.html';
        </script>
    ";
    exit();
}

// ------------------- INSERTAR USUARIO NUEVO -------------------
$sqlInsert = $db->prepare("
    INSERT INTO usuarios (nombre, correo, telefono, password)
    VALUES (:nombre, :correo, :telefono, :password)
");

$sqlInsert->bindValue(':nombre', $nombre, SQLITE3_TEXT);
$sqlInsert->bindValue(':correo', $correo, SQLITE3_TEXT);
$sqlInsert->bindValue(':telefono', $telefono, SQLITE3_TEXT);
$sqlInsert->bindValue(':password', $password, SQLITE3_TEXT);

if ($sqlInsert->execute()) {
    echo "
        <script>
            alert('Registro exitoso. Ahora puedes iniciar sesión');
            window.location.href = 'login.html';
        </script>
    ";
} else {
    echo "
        <script>
            alert('Error al registrar el usuario');
            window.location.href = 'registro.html';
        </script>
    ";
}

$db->close();
?>
