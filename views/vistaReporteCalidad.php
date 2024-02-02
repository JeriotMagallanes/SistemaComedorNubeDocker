<?php
    require_once 'datatable.php';
    require_once 'acceso-seguro.php';
    if(($_SESSION['nivelacceso'] != 'Administrador')&&($_SESSION['nivelacceso'] != 'Operario')&&($_SESSION['nivelacceso'] != 'Calidad')){
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
                        <p class="card-title" style="font-size: 22px">Lista de Reportes</p>
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
                <table class="table text-center" id="tablareporteCalidad">
                    <thead>
                        <tr>
                            <th class="text-center">Codigo</th>
                            <th class="text-center">Fecha y Hora</th>
                            <th class="text-center">Jefe de Fundo</th>
                            <th class="text-center">Fundo</th>
                            <th class="text-center">Lote</th>
                            <th class="text-center">Sub Lote</th>
                            <th class="text-center ">Aprob. Fundo</th>
                            <th class="text-center ">Aprob. Sanidad</th>
                            <th class="text-center">Ver Productos</th>
                            <th class="text-center">Reporte Autorizacion</th>
                        </tr>
                    </thead>
                    <tbody class="table" id="tablareporteCalidadListar">
                        <!-- Se carga de manera dinamica -->
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<script src="js/reportes.js"></script>


