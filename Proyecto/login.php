<?php
// ------------------- CONEXIÓN A SQLITE -------------------
$db = new SQLite3('farmacia.db');

if (!$db) {
    die("Error al conectar con la base de datos SQLite");
}

// ------------------- RECIBIR DATOS -------------------
$correo = $_POST['correo'];
$password = $_POST['password'];

// ------------------- CONSULTAR USUARIO -------------------
$stmt = $db->prepare("SELECT * FROM usuarios 
                     WHERE correo = :correo AND password = :password");

$stmt->bindValue(':correo', $correo, SQLITE3_TEXT);
$stmt->bindValue(':password', $password, SQLITE3_TEXT);

$resultado = $stmt->execute();

$usuario = $resultado->fetchArray(SQLITE3_ASSOC);

if ($usuario) {
    // LOGIN CORRECTO
    session_start();
    $_SESSION['correo'] = $correo;

    header("Location: inicio.html");
    exit();
} else {
    // LOGIN INCORRECTO
    echo "
        <script>
            alert('Correo o contraseña incorrectos');
            window.location.href = 'login.html';
        </script>
    ";
}

$db->close();
?>
