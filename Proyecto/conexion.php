<?php
// conexion.php - conexión a la base de datos Farmacia Web

// Datos de conexión
$servername = "localhost";    // Servidor de la base de datos
$username = "root";           // Usuario de MySQL
$password = "";               // Contraseña de MySQL (si tienes, colócala aquí)
$database = "farmacia_db";    // Nombre de tu base de datos

// Crear conexión
$conn = new mysqli($servername, $username, $password, $database);

// Verificar conexión
//hola
if ($conn->connect_error) {
    die("Conexión fallida: " . $conn->connect_error);
}

// Configurar codificación UTF-8
$conn->set_charset("utf8");
?>
