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
    <div class="col-md-6">
        <div  class=" card card-outline card-info">
            <div class="card-header">
                <div class="row col-md-12">
                    <div class="col-md-9">
                        <p class="card-title" style="font-size: 22px">Inasistencias Desayunos</p>
                    </div>
                </div>
            </div>
            <div class="card-body table-responsive">
                <table class="table text-center" id="tablaInasistenciaDesayuno">
                    <thead>
                        <tr>
                            <th class="text-center">Fecha</th>
                            <th class="text-center">Asistencias</th>
                            <th class="text-center">Inasistencias</th>
                        </tr>
                    </thead>
                    <tbody class="table" id="tablaInasistenciaDesayunoListar">
                        <!-- Se carga de manera dinamica -->
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <div class="col-md-6">
        <div  class=" card card-outline card-info">
            <div class="card-header">
                <div class="row col-md-12">
                    <div class="col-md-9">
                        <p class="card-title" style="font-size: 22px">Inasistencias Almuerzos</p>
                    </div>
                </div>
            </div>
            <div class="card-body table-responsive">
                <table class="table text-center" id="tablaInasistenciaAlmuerzo">
                    <thead>
                        <tr>
                            <th class="text-center">Fecha</th>
                            <th class="text-center">Asistencias</th>
                            <th class="text-center">Inasistencias</th>
                        </tr>
                    </thead>
                    <tbody class="table" id="tablaInasistenciaAlmuerzoListar">
                        <!-- Se carga de manera dinamica -->
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <div class="col-md-6">
        <div  class=" card card-outline card-info">
            <div class="card-header">
                <div class="row col-md-12">
                    <div class="col-md-9">
                        <p class="card-title" style="font-size: 22px">Inasistencias Cena</p>
                    </div>
                </div>
            </div>
            <div class="card-body table-responsive">
                <table class="table text-center" id="tablaInasistenciaCena">
                    <thead>
                        <tr>
                            <th class="text-center">Fecha</th>
                            <th class="text-center">Asistencias</th>
                            <th class="text-center">Inasistencias</th>
                        </tr>
                    </thead>
                    <tbody class="table" id="tablaInasistenciaCenaListar">
                        <!-- Se carga de manera dinamica -->
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<script src="js/inasistencias.js"></script>
