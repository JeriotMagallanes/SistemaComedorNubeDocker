<?php
    require_once 'datatable.php';
    require_once 'acceso-seguro.php';
    require_once '../models/Reporte.php';
    require_once '../models/Serverside.php';
    if(($_SESSION['nivelacceso'] != 'Administrador')&&($_SESSION['nivelacceso'] != 'Operario')){
        echo "<strong>No tiene el nivel de acceso requerido</strong>";
        exit();
    }
    if (isset($_GET['id'])) {
        // Obtener el valor de id
        $id_reporte = $_GET['id'];
    }
// Verificar si el parámetro id está presente en la URL
    
?>

<style>
    .asignar{
        display: none !important;
    }
</style>

<div class="row">
    <div class="col-md-12">
        <div class=" card card-outline card-info">
            <div class="card-header">
                <form action="" id="formularioreservainstructivo">
                    <div class="form-group">
                    <div class="row justify-content-between">
                        <div class="col-md-3">
                            <input class="form-control" type="text" id="nreserva" placeholder="N° Reserva">
                            <input type="hidden" id="id_reporte" value="<?php
                        if (isset($_GET['id'])) {
                            // Obtener el valor de id
                            $id_reporte = $_GET['id'];
                            echo $id_reporte;
                        }
                    ?>" >
                        </div>
                        <div class="col-md-3">
                            <input class="form-control" type="text" id="ninstructivo" placeholder="N° Instructivo">
                        </div>
                        <div class="col-md-6 text-right">
                            <button type="button" class="btn bg-gradient-info" id="asignarReservaInstructivo">Asignar</button>
                            <button type="button" class="btn btn-secondary" onclick="window.location.href='main.php?view=vistaReservaInstructivo.php'">
                                <i class="fas fa-undo"></i>
                            </button>
                        </div>
                    </div>
                </div>

                </form>
            </div>
        </div>
        <div  class=" card card-outline card-info">
            <div class="card-header">
                <div class="row ">
                    <div class="col-md-10">
                        <p class="card-title" style="font-size: 22px">Lista de detalle del Reporte con codigo N°
                        <?php
                            echo $id_reporte;
                        ?>  
                        <input type="hidden" id="id_reporte" class="form-control form-control-border" value="<?php
                        if (isset($_GET['id'])) {
                            // Obtener el valor de id
                            $id_reporte = $_GET['id'];
                            echo $id_reporte;
                        }
                    ?>" >
                    </p>
                    </div>
            </div>
            
            <div class="table-responsive">
                <table class="table text-" id="tablaDatosReporte">
                    <thead>
                        <tr>
                            <th class="text- mb-2"></th>
                        </tr>
                    </thead>
                    <tbody class="table" id="tablaDatosReporteListar">
                        <!-- Se carga de manera dinámica -->
                    </tbody>
                </table>
            </div>
            </div>
            
            <div class="card-body table-responsive">
                <table class="table text-center" id="tablaDetalle">
                    <thead>
                        <tr>
                            <th class="text-center">Motivo</th>
                            <th class="text-center">Producto</th>
                            <th class="text-center">Carencia (dias)</th>
                            <th class="text-center">Dosis CIL</th>
                            <th class="text-center">N° CIL</th>
                            <th class="text-center">Dosis Tanque</th>
                            <th class="text-center">Total Producto</th>
                            <th class="text-center">Dosis/HA</th>
                            <th class="text-center">HA Aplicad</th>
                            <th class="text-center">H20/HA</th>
                            <th class="text-center">Eliminar</th>
                        </tr>
                    </thead>
                    <tbody class="table" id="tablaDetallelistar">
                        <!-- Se carga de manera dinamica -->
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<script src="js/detalle.js"></script>


