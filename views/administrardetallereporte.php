<?php
    require_once 'datatable.php';
    require_once 'acceso-seguro.php';
    require_once '../models/Reporte.php';
    require_once '../models/Serverside.php';
    if(($_SESSION['nivelacceso'] != 'Administrador')&&($_SESSION['nivelacceso'] != 'Operario')){
        echo "<strong>No tiene el nivel de acceso requerido</strong>";
        exit();
    }
    
// Verificar si el parámetro id está presente en la URL
    
?>

<style>
    .asignar{
        display: none !important;
    }
</style>

<div class="row">
    <div class="col-md-3">
        <div class=" card card-outline card-info">
            <div class="card-header">
                <p class="card-title mt-1" style="font-size: 22px" id="Aviso">Registro Productos</p>

            </div>
            <!-- /.card-header -->
            <div class="card-body">
                <form action="" id="formularioDetalle">
                    <div class="form-group">
                        <div class="row">
                            <div class="col-md-12 mt-3">
                                <label for="motaplicacion">Motivo de Aplicacion</label>
                                <select class="form-control form-control-border" name="motaplicacion" id="motaplicacion" >
                                </select>
                            </div>
                            <div class="col-md-12 mt-3">
                                <label for="producto">Producto</label>
                                <select class="form-control form-control-border" name="producto_san" id="producto_san" >
                                </select>
                            </div>
                            <div class="col-md-12 mt-3">
                                <label for="unidad">Unidad:</label>
                                <input type="text" id="unidad" class="form-control form-control-border" disabled>
                                <input type="hidden" id="id_reporte" class="form-control form-control-border" value="<?php
                            if (isset($_GET['id'])) {
                                // Obtener el valor de id
                                $id_reporte = $_GET['id'];
                                echo $id_reporte;
                            }
                        ?>" >
                            </div>
                            <div class="col-md-12 mt-3">
                                <label for="diascarencia">Dias de carencia</label>
                                <input type="number" id="diascarencia" class="form-control form-control-border" >
                            </div>
                            <div class="col-md-12 mt-3">
                                <label for="dosiscil">Dosis CIL</label>
                                <input type="text" id="dosiscil" class="form-control form-control-border" >
                            </div>
                            <div class="col-md-12 mt-3">
                                <label for="ncil">N° CIL</label>
                                <input type="text" id="ncil" class="form-control form-control-border" >
                            </div>
                            <div class="col-md-12 mt-3">
                                <label for="dosistanque">Dosis Tanque</label>
                                <input type="text" id="dosistanque" class="form-control form-control-border" >
                            </div>
                            <div class="col-md-12 mt-3">
                                <label for="tproducto">Total Producto</label>
                                <input type="text" id="tproducto" class="form-control form-control-border" >
                            </div>
                            <div class="col-md-12 mt-3">
                                <label for="dosisha">Dosis/HA</label>
                                <input type="text" id="dosisha" class="form-control form-control-border" >
                            </div>
                            <div class="col-md-12 mt-3">
                                <label for="haaplicada">HA aplicada</label>
                                <input type="text" id="haaplicada" class="form-control form-control-border" >
                            </div>
                            <div class="col-md-12 mt-3">
                                <label for="gastoh20">Gasto H20/HA</label>
                                <input type="text" id="gastoh20" class="form-control form-control-border" >
                            </div>
                        </div>
                    </div>
                </form>
            </div>
            <!-- /.card-body -->
            <div class="card-footer text-right bg-white">
                <button type="button" class="btn bg-gradient-secondary" id="cancelar">Cancelar</button>
                <button type="button" class="btn bg-gradient-info" id="registrar">Guardar</button>
                <button type="button" class="btn bg-gradient-info asignar" id="actualizar">Actualizar</button>
            </div>
            <!-- /.card-footer -->
        </div>
    </div>
    <div class="col-md-9">
        <div  class=" card card-outline card-info">
            <div class="card-header">
                <div class="row ">
                    <div class="col-md-10">
                        <p class="card-title" style="font-size: 22px">Lista de detalle del Reporte con codigo N°
                        <?php
                            echo $id_reporte;
                        ?>
                    </p>
                    </div>
                    <div class="row justify-content-end">
                    <div class="col-md-2 items-center text-end">
                        <button type="button" class="btn btn-secondary" onclick="window.location.href='main.php?view=administrarreporte.php'">
                            <i class="fas fa-undo"></i>
                        </button>
                    </div>
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


