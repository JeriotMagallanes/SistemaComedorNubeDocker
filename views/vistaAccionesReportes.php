<?php
    require_once 'datatable.php';
    require_once 'acceso-seguro.php';
    if(($_SESSION['nivelacceso'] != 'Administrador')){
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
                        <p class="card-title" style="font-size: 22px">Registro de acciones a los Reportes</p>
                    </div>
                    <div class="col-md-6 display">
                        <div class="row">
                            <div class="col-md-5 text-center">
                                <p class="card-title " style="font-size: 16px">Desde:</p>
                                <input type="date" id="fechainicial" class="form-control">
                            </div>
                            <div class="col-md-5">
                                <p class="card-title " style="font-size: 16px">Hasta:</p>
                                <input type="date" id="fechafinal" class="form-control">
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
                <table class="table text-center" id="tablaAccionesReporte">
                    <thead>
                        <tr>
                            <th class="text-center">Fecha y Hora</th>
                            <th class="text-center">Nombres</th>
                            <th class="text-center">Codigo Reporte</th>
                            <th class="text-center">Accion</th>
                            <th class="text-center">Observacion</th>
                        </tr>
                    </thead>
                    <tbody class="table" id="tablaAccionesReporteListar">
                        <!-- Se carga de manera dinamica -->
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<script src="js/reportes.js"></script>

