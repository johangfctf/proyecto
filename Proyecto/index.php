<?php include 'conexion.php'; ?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Farmacia Web</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            padding: 0;
        }
        .categories {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            padding: 20px;
        }
        .category {
            background-color: #3498db;
            color: white;
            padding: 10px 15px;
            border-radius: 8px;
            cursor: pointer;
            transition: 0.3s;
        }
        .category:hover {
            background-color: #2980b9;
        }
        .productos {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            padding: 20px;
        }
        .producto {
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.2);
            padding: 15px;
            width: 200px;
            text-align: center;
        }
        .producto img {
            width: 100%;
            border-radius: 5px;
        }
        .producto h3 {
            margin: 10px 0 5px 0;
        }
        .producto p {
            margin: 5px 0;
        }
    </style>
</head>
<body>

<h1 style="text-align:center; padding: 20px;">Farmacia Web</h1>

<div class="categories">
    <?php
    // Mostrar todas las categorías usando SQLite
    $result = $db->query("SELECT * FROM categorias");

    while ($row = $result->fetchArray(SQLITE3_ASSOC)) {
        echo '<div class="category" onclick="mostrarProductos('.$row['id'].')">'
            . htmlspecialchars($row['nombre']) .
            '</div>';
    }
    ?>
</div>

<div class="productos" id="productos">
    <!-- Aquí se mostrarán los productos -->
</div>

<script>
function mostrarProductos(cat_id) {
    var xhttp = new XMLHttpRequest();
    xhttp.onreadystatechange = function() {
        if (this.readyState == 4 && this.status == 200) {
            document.getElementById("productos").innerHTML = this.responseText;
        }
    };
    xhttp.open("GET", "productos.php?cat_id=" + cat_id, true);
    xhttp.send();
}
</script>

</body>
</html>
