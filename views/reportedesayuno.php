<?php
    require_once 'acceso_seguro.php';
    require_once 'datatable.php';
    if($_SESSION['nivelacceso'] != 'Administrador' && $_SESSION['nivelacceso'] != 'DBU'){
        echo "<strong>No tiene el nivel de acceso requerido</strong>";
        exit();
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
                        <p class="card-title" style="font-size: 22px">Reporte de Desayunos de Estudiantes</p>
                    </div>
                    <div class="col-md-6 display">
                        <div class="row">
                            <div class="col-md-5 text-center">
                                <p class="card-title" style="font-size: 16px">Fecha:</p>
                                <input type="date" id="fecha" name="fecha" class="form-control" style="width: 100%; display: inline-block;">
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
                <table class="table text-center" id="tablaReporteDesayuno">
                    <thead>
                        <tr>
                            <th class="text-center">Cantidad</th>
                            <th class="text-center">Fecha y Hora</th>
                            <th class="text-center">DNI</th>
                            <th class="text-center">Nombres</th>
                            <th class="text-center">Apellidos</th>
                        </tr>
                    </thead>
                    <tbody class="table" id="tablaReporteDesayunoListar">
                        <!-- Se carga de manera dinamica -->
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<script src="js/reportedesayuno.js"></script>
