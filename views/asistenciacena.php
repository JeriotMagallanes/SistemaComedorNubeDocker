<?php
    require_once 'acceso_seguro.php';
    require_once 'datatable.php';
    if($_SESSION['nivelacceso'] != 'Administrador' && $_SESSION['nivelacceso'] != 'DBU'){
        echo "<strong>No tiene el nivel de acceso requerido</strong>";
        exit();
    }

    // Obtener la fecha actual
    $fechaActual = new DateTime();
    $anioActual = $fechaActual->format('Y'); // Año actual en formato numérico (YYYY)
    // Definir el año inicial
    $anioInicio = 2024;
    // Generar opciones de años
    $opcionesAnios = '';
    for ($anio = $anioInicio; $anio <= $anioActual; $anio++) {
        $selected = $anio == $anioActual ? 'selected' : '';
        $opcionesAnios .= "<option value=\"$anio\" $selected>$anio</option>";
    }
    // Lista de meses
    $meses = [
        1 => 'Enero', 2 => 'Febrero', 3 => 'Marzo', 4 => 'Abril', 5 => 'Mayo', 6 => 'Junio',
        7 => 'Julio', 8 => 'Agosto', 9 => 'Septiembre', 10 => 'Octubre', 11 => 'Noviembre', 12 => 'Diciembre'
    ];
    // Obtener el mes actual
    $mesActual = $fechaActual->format('m'); // Mes actual en formato numérico (01-12)
    // Generar opciones de meses
    $opcionesMeses = '';
    foreach ($meses as $numMes => $nombreMes) {
        $selected = $numMes == $mesActual ? 'selected' : '';
        $opcionesMeses .= "<option value=\"$numMes\" $selected>$nombreMes</option>";
    }
?>

<style>
    .asignar{
        display: none !important;
    }
</style>

<div class="row">
    <div class="col-md-12">
        <div  class=" card card-outline card-info">
            <div class="card-header">
                <div class="row col-md-12">
                    <div class="col-md-6">
                        <p class="card-title" style="font-size: 22px">Asistencia de Cena de Estudiantes</p>
                    </div>
                    <div class="col-md-6 display">
                        <div class="row">
                            <div class="col-md-5 text-center">
                                <p class="card-title " style="font-size: 16px">Mes:</p>
                                <select id="mes" class="form-control">
                                    <?php echo $opcionesMeses; ?>
                                </select>
                            </div>
                            <div class="col-md-5">
                                <p class="card-title " style="font-size: 16px">Año:</p>
                                <select id="anio" class="form-control">
                                    <?php echo $opcionesAnios; ?>
                                </select>
                            </div>
                            <div class="col-md-1">
                                <br>
                                <button type="button" id="bfecha" class="btn btn-secondary">
                                    <i class="fas fa-search"></i>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="card-body table-responsive">
                <table class="table text-center" id="tablaAsistenciacena">
                    <thead>
                        <tr>
                            <th class="text-center">DNI</th>
                            <th class="text-center">Nombres</th>
                            <th class="text-center">Apellidos</th>
                            <th class="text-center">Carrera</th>
                            <th class="text-center">D. Atendidos</th>
                            <th class="text-center">D. Asistidos</th>
                            <th class="text-center">D. Inasistidos</th>
                        </tr>
                    </thead>
                    <tbody class="table" id="tablaAsistenciaCenaListar">
                        <!-- Se carga de manera dinamica -->
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<script src="js/asistenciaCena.js"></script>
