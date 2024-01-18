<?php
    require_once 'datatable.php';
    require_once 'acceso-seguro.php';
    if(($_SESSION['nivelacceso'] != 'Administrador')&&($_SESSION['nivelacceso'] != 'Operario')){
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
    <div class="col-md-3">
        <div class=" card card-outline card-info">
            <div class="card-header">
                <p class="card-title mt-1" style="font-size: 22px" id="Aviso">Registro de Reportes</p>

            </div>
            <!-- /.card-header -->
            <?php
            // Obtener la fecha y hora actual
            date_default_timezone_set('America/Lima');
            $fechaActual = date('Y-m-d');
            $horaActual = date('H:i');
            // Determinar el turno
            if ($horaActual >= '05:00' && $horaActual < '12:00') {
                $turno = 'Mañana';
            } elseif ($horaActual >= '12:00' && $horaActual < '18:00') {
                $turno = 'Tarde';
            } else {
                $turno = 'Noche';
            }
            ?>
            <div class="card-body">
                <form action="" id="formularioFundo">
                    <div class="form-group">
                        <div class="row">
                            <div class="col-md-12 mt-3">
                                <label for="fechaReporte">Fecha:</label>
                                <input type="text" id="fechaReporte" class="form-control form-control-border" value="<?php echo $fechaActual; ?>" readonly disabled>
                            </div>
                            <div class="col-md-12 mt-3">
                                <label for="turno">Turno:</label>
                                <input type="text" id="turno" class="form-control form-control-border" value="<?php echo $turno; ?>" disabled>
                            </div>
                            <div class="col-md-12 mt-3">
                                <label for="encSanidad">Encargado de Sanidad:</label>
                                <input type="text" id="encSanidad" class="form-control form-control-border">
                            </div>
                            <div class="col-md-12 mt-3">
                                <label for="encQA">Encargado de QA:</label>
                                <input type="text" id="encQA" class="form-control form-control-border">
                            </div>
                            <div class="col-md-12 mt-3">
                                <label for="encAlmacen">Encargado de Almacen:</label>
                                <input type="text" id="encSanidad" class="form-control form-control-border">
                            </div>
                            <div class="col-md-12 mt-3">
                                <label for="idcategoria">Jefe de Fundo</label>
                                <select class="form-control form-control-border" name="idcategoria" id="idcategoria" >
                                </select>
                            </div>
                            <div class="col-md-12 mt-3">
                                <label for="fundo">Fundo</label>
                                <select class="form-control form-control-border" name="fundo" id="fundo" >
                                </select>
                            </div>
                            <div class="col-md-12 mt-3">
                                <label for="lote">Lote:</label>
                                <select class="form-control form-control-border" name="lote" id="lote" >
                                </select>
                            </div>
                            <div class="col-md-12 mt-3">
                                <label for="s_lote">Sub Lote:</label>
                                <select class="form-control form-control-border" name="s_lote" id="s_lote" >
                                </select>
                            </div>
                            <div class="col-md-12 mt-3">
                                <label for="cultivo">Cultivo</label>
                                <select class="form-control form-control-border" name="cultivo" id="cultivo">
                                </select>
                            </div>
                            <div class="col-md-12 mt-3">
                                <label for="variedad">Variedad</label>
                                <select class="form-control form-control-border" name="variedad" id="variedad">
                                </select>
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
                    <div class="col-md-9">
                        <p class="card-title" style="font-size: 22px">Lista de Reportes</p>
                    </div>
                    <div class="col-md-3">
                        <select name="categoriaselect" id="categoriaselect" class="form-control float-right">
                        </select>
                    </div>
                </div>
            </div>
            <div class="card-body table-responsive">
                <table class="table text-center" id="tablaProducto">
                    <thead>
                        <tr>
                            <th class="text-center">N°</th>
                            <th class="text-center">Nombre</th>
                            <th class="text-center">Jefe de Fundo</th>
                            <th class="text-center">Lote</th>
                            <th class="text-center">Sub Lote</th>
                            <th class="text-center">Hectareas</th>
                            <th class="text-center">Cultivo</th>
                            <th class="text-center">Variedad</th>
                            <th class="text-center">Modificar</th>
                        </tr>
                    </thead>
                    <tbody class="table" id="tablaProductolistar">
                        <!-- Se carga de manera dinamica -->
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<script src="js/reportes.js"></script>


