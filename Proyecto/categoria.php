<?php
include "conexion.php";

$query = "SELECT id, nombre FROM productos";
$result = mysqli_query($con, $query);
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Productos</title>

    <style>
        body {
            font-family: Arial;
            background: #f2f2f2;
        }
        .producto {
            background: white;
            padding: 15px;
            margin: 10px auto;
            width: 300px;
            border-radius: 10px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.2);
        }
        h3 {
            color: #0072ff;
        }
    </style>
</head>

<body>

<h2 style="text-align:center;">Lista de Productos</h2>

<?php while ($row = mysqli_fetch_assoc($result)) { ?>
    <div class="producto">
        <h3><?php echo $row['nombre']; ?></h3>
        <p>ID: <?php echo $row['id']; ?></p>
    </div>
<?php } ?>

</body>
</html>
