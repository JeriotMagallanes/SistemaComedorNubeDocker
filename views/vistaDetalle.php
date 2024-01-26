<?php
    require_once 'datatable.php';
    require_once 'acceso-seguro.php';
    require_once '../models/Reporte.php';
    require_once '../models/Serverside.php';
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
                    <div class="col-md-10">
                        <input type="hidden" id="id_reporte" class="form-control form-control-border" value="<?php
                            if (isset($_GET['id'])) {
                                // Obtener el valor de id
                                $id_reporte = $_GET['id'];
                                echo $id_reporte;
                            }
                        ?>" >
                        
                        <p class="card-title" style="font-size: 22px">Lista de detalle del Reporte con codigo N°
                        <?php
                            echo $id_reporte;
                        ?>
                    </p>
                    </div>
                    <div class="col-md-2">
                        <button type="button" class="btn btn-secondary" onclick="window.location.href='main.php?view=vistaReporte.php'">
                            Regresar <i class="fas fa-undo ml-2"></i>
                        </button>
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
                <table class="table text-center" id="tablaDetalleOperario">
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
                        </tr>
                    </thead>
                    <tbody class="table" id="tablaDetallelistarOperario">
                        <!-- Se carga de manera dinamica -->
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<script src="js/detalle.js"></script>


