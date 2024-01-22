<?php
    require_once 'datatable.php';
    require_once 'acceso-seguro.php';
    require_once '../models/Reporte.php';
    require_once '../models/Serverside.php';
    if(($_SESSION['nivelacceso'] != 'Administrador')&&($_SESSION['nivelacceso'] != 'Operario')){
        echo "<strong>No tiene el nivel de acceso requerido</strong>";
        exit();
    }
    var_dump($_POST);
    if (isset($_POST['op'])) {
        $Reporte = new Reporte();
    
        if ($_POST['op'] == 'envio_id_reporte') {
            // Verifica si se proporcionó el ID del reporte
            if (isset($_POST['idreporte'])) {
                $idReporte = $_POST['idreporte'];
                
                // Ahora puedes utilizar $idReporte en tu lógica, por ejemplo:
                // $Reporte->registrarReporte($idReporte);
    
                // Envía una respuesta (puedes personalizar según tus necesidades)
                echo 'ID del reporte recibido correctamente: ' . $idReporte;
            } else {
                // Si no se proporciona el ID del reporte, devuelve un mensaje de error
                echo 'Error: No se proporcionó el ID del reporte.';
            }
        }
    }
    
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
                <form action="" id="formularioReporte">
                    <div class="form-group">
                        <div class="row">
                            <div class="col-md-12 mt-3">
                                <label for="motaplicacion">Motivo de Aplicacion</label>
                                <select class="form-control form-control-border" name="motaplicacion" id="motaplicacion" >
                                </select>
                            </div>
                            <div class="col-md-12 mt-3">
                                <label for="producto">Producto</label>
                                <select class="form-control form-control-border" name="producto" id="producto" >
                                </select>
                            </div>
                            <div class="col-md-12 mt-3">
                                <label for="unidad">Unidad:</label>
                                <input type="text" id="unidad" class="form-control form-control-border" disabled>
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
                <div class="row col-md-12">
                    <div class="col-md-6">
                        <p class="card-title" style="font-size: 22px">Lista de detalle del Reporte
                    </p>
                    </div>
                </div>
            </div>
            <div class="card-body table-responsive">
                <table class="table text-center" id="tablareporte">
                    <thead>
                        <tr>
                            <th class="text-center">Codigo</th>
                            <th class="text-center">Fecha y Hora</th>
                            <th class="text-center">Jefe de Fundo</th>
                            <th class="text-center">Fundo</th>
                            <th class="text-center">Lote</th>
                            <th class="text-center">Sub Lote</th>
                            <th class="text-center">Ver Productos</th>
                            <?php 
                            if(($_SESSION['nivelacceso'] == 'Administrador')){
                            echo
                            "<th class='text-center'>Editar</th>
                            <th class='ext-center'>Eliminar</th>";
                            }?>
                        </tr>
                    </thead>
                    <tbody class="table" id="tablareportelistar">
                        <!-- Se carga de manera dinamica -->
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<script src="js/reportes.js"></script>


