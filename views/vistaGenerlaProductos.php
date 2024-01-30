<?php
    require_once 'datatable.php';
    require_once 'acceso-seguro.php';
    if(($_SESSION['nivelacceso'] != 'Administrador')&&($_SESSION['nivelacceso'] != 'Calidad')){
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
                <table class="table text-center" id="tablareporteGeneralAdministrador">
                    <thead>
                        <tr>
                            <th class="text-center">Fecha Hora</th>
                            <th class="text-center">Turno</th>
                            <th class="text-center">Jefe Fundo</th>
                            <th class="text-center">Fundo</th>
                            <th class="text-center">Lote - SubLote</th>
                            <th class="text-center">Cultivo - Variedad</th>
                            <th class="text-center">Mot. Aplicacion</th>
                            <th class="text-center">Producto</th>
                            <th class="text-center">Carencia (Dias)</th>
                            <th class="text-center">Dosis CIL</th>
                            <th class="text-center">N° CIL</th>
                            <th class="text-center">Dosis Tanque</th>
                            <th class="text-center">Total Producto</th>
                            <th class="text-center">Dosis/HA</th>
                            <th class="text-center">HA Aplicada</th>
                            <th class="text-center">Gasto H2O/HA</th>
                        </tr>
                    </thead>
                    <tbody class="table" id="tablareporteGeneralAdministradorListar">
                        <!-- Se carga de manera dinamica -->
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<script src="js/reportes.js"></script>

