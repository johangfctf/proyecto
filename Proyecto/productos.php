<?php
include 'conexion.php';

if(isset($_GET['cat_id'])){
    $cat_id = intval($_GET['cat_id']);
    $sql = "SELECT * FROM productos WHERE categoria_id = $cat_id";
    $result = $conn->query($sql);

    if ($result->num_rows > 0) {
        while($row = $result->fetch_assoc()) {
            echo '<div class="producto">';
            echo '<img src="imagenes/'.$row['imagen'].'" alt="'.$row['nombre'].'">';
            echo '<h3>'.$row['nombre'].'</h3>';
            echo '<p>'.$row['descripcion'].'</p>';
            echo '<p>Precio: $'.$row['precio'].'</p>';
            echo '</div>';
        }
    } else {
        echo '<p>No hay productos en esta categoría.</p>';
    }
}
?>
