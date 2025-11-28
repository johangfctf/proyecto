<?php
include 'conexion.php';  // aquí se abre conexión con SQLite en $db

if (isset($_GET['cat_id'])) {

    $cat_id = intval($_GET['cat_id']);

    // Consulta preparada para mayor seguridad
    $stmt = $db->prepare("SELECT * FROM productos WHERE categoria_id = :cat");
    $stmt->bindValue(':cat', $cat_id, SQLITE3_INTEGER);
    $result = $stmt->execute();

    $hayProductos = false;

    while ($row = $result->fetchArray(SQLITE3_ASSOC)) {

        $hayProductos = true;

        echo '<div class="producto">';
        echo '<img src="imagenes/' . htmlspecialchars($row['imagen']) . '" alt="' . htmlspecialchars($row['nombre']) . '">';
        echo '<h3>' . htmlspecialchars($row['nombre']) . '</h3>';
        echo '<p>' . htmlspecialchars($row['descripcion']) . '</p>';
        echo '<p>Precio: $' . number_format($row['precio'], 2) . '</p>';
        echo '</div>';
    }

    if (!$hayProductos) {
        echo '<p>No hay productos en esta categoría.</p>';
    }
}
?>
