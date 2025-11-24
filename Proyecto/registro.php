<?php
// CONEXIÓN A LA BASE DE DATOS
$conexion = new mysqli("localhost", "root", "", "farmacia_db");

if ($conexion->connect_error) {
    die("Error de conexión: " . $conexion->connect_error);
}

// OBTENER DATOS DEL FORMULARIO
$nombre = $_POST['nombre'];
$correo = $_POST['correo'];
$telefono = $_POST['telefono'];
$password = $_POST['password'];
$confirmar = $_POST['confirmar'];

// VALIDAR QUE LAS CONTRASEÑAS COINCIDAN
if ($password !== $confirmar) {
    echo "
        <script>
            alert('Las contraseñas no coinciden');
            window.location.href = 'registro.html';
        </script>
    ";
    exit();
}

// VERIFICAR QUE EL CORREO NO ESTÉ REGISTRADO
$sqlCorreo = "SELECT * FROM usuarios WHERE correo = '$correo'";
$resultadoCorreo = $conexion->query($sqlCorreo);

if ($resultadoCorreo->num_rows > 0) {
    echo "
        <script>
            alert('Este correo ya está registrado');
            window.location.href = 'registro.html';
        </script>
    ";
    exit();
}

// INSERTAR EL USUARIO NUEVO
$sqlInsert = "INSERT INTO usuarios (nombre, correo, telefono, password) 
              VALUES ('$nombre', '$correo', '$telefono', '$password')";

if ($conexion->query($sqlInsert) === TRUE) {
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

$conexion->close();
?>
