<?php
                $conexion = mysqli_connect("127.0.0.1", "root","", "sistemasanidad");
                date_default_timezone_set('America/Lima');
                $fecha_public=date("Y-m-d");
                $query = "UPDATE asistencia SET fecha_des='$fecha_public' WHERE 1";
                $resultado = $conexion->query($query);
                $query = "UPDATE usuarios SET ingreso=0 WHERE 1";
                $resultado = $conexion->query($query);
                header("Location:../main.php?view=ingresosistema");
?>