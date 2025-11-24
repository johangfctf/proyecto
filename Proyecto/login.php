<?php
// CONEXIÓN A LA BASE DE DATOS
$conexion = new mysqli("localhost", "root", "", "farmacia_db");

if ($conexion->connect_error) {
    die("Error de conexión: " . $conexion->connect_error);
}

// RECIBIR DATOS DEL FORM
$correo = $_POST['correo'];
$password = $_POST['password'];

// CONSULTAR USUARIO
$sql = "SELECT * FROM usuarios WHERE correo = '$correo' AND password = '$password'";
$resultado = $conexion->query($sql);

if ($resultado->num_rows > 0) {
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

$conexion->close();
?>
