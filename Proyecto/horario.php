<?php
// ------- CONEXIÓN -------
$conn = new mysqli("localhost", "root", "", "farmacia_db");
if ($conn->connect_error) {
    die("Error de conexión: " . $conn->connect_error);
}
$conn->set_charset("utf8");

// Traer días
$sqlDias = "SELECT DISTINCT dia_semana FROM doctor_horario ORDER BY FIELD(
    dia_semana,'Lunes','Martes','Miércoles','Jueves','Viernes','Sábado','Domingo'
)";
$dias = $conn->query($sqlDias);

// Día seleccionado (por defecto Lunes)
$diaSeleccionado = isset($_GET['dia']) ? $_GET['dia'] : 'Lunes';

// Traer doctores del día
$sql = "
SELECT d.nombre, d.especialidad, h.hora_inicio, h.hora_fin 
FROM doctor d
INNER JOIN doctor_horario h ON d.id = h.doctor_id
WHERE h.dia_semana = '$diaSeleccionado'
ORDER BY h.hora_inicio
";
$res = $conn->query($sql);
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Horarios de Consultorio</title>

    <link rel="stylesheet" href="horario.css">
</head>

<body>

<h1>Horarios del Consultorio</h1>

<div class="selector-dia">
    <form method="GET">
        <select name="dia" onchange="this.form.submit()">
            <?php
            if ($dias->num_rows > 0) {
                while ($d = $dias->fetch_assoc()) {
                    $dia = $d['dia_semana'];
                    $selected = ($dia == $diaSeleccionado) ? "selected" : "";
                    echo "<option $selected value='$dia'>$dia</option>";
                }
            }
            ?>
        </select>
    </form>
</div>

<?php
if ($res->num_rows > 0) {
    while ($doc = $res->fetch_assoc()) {
        echo "
        <div class='doctor-card'>
            <h2>{$doc['nombre']}</h2>
            <p><b>Especialidad:</b> {$doc['especialidad']}</p>
            <p class='horario'>🕒 " . substr($doc['hora_inicio'],0,5) . " - " . substr($doc['hora_fin'],0,5) . "</p>
        </div>
        ";
    }
} else {
    echo "<p class='mensaje-vacio'>No hay doctores asignados a este día.</p>";
}
?>

</body>
</html>
