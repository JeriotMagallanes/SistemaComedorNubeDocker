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
            date_default_timezone_set('America/Lima');
            $fechaHoraActual = date('Y-m-d H:i:s'); // Formato de fecha y hora para almacenar en base de datos
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
                <form action="" id="formularioReporte">
                    <div class="form-group">
                        <div class="row">
                            <div class="row">
                            <div class="col-md-6 ">
                                <label for="fechaReporte">Fecha:</label>
                                <input type="text" class="form-control form-control-border" value="<?php echo $fechaActual; ?>" readonly disabled>
                                <input type="hidden" id="fechahoraReporte" class="form-control form-control-border" value="<?php echo $fechaHoraActual; ?>" readonly disabled>
                                <input type="text" id="idproductomod" class="form-control form-control-border asignar" disabled>
                            </div>
                            <div class="col-md-6 ">
                                <label for="turno">Turno:</label>
                                <input type="text" id="turno" class="form-control form-control-border" value="<?php echo $turno; ?>" disabled>
                            </div>
                            </div>
                            <div class="col-md-12 mt-2">
                                <label for="encSanidad">Encargado de Sanidad:</label>
                                <input type="text" id="encSanidad" class="form-control form-control-border">
                            </div>
                            <div class="col-md-12 ">
                                <label for="encQA">Encargado de QA:</label>
                                <input type="text" id="encQA" class="form-control form-control-border">
                            </div>
                            <div class="col-md-12">
                                <label for="encAlmacen">Encargado de Almacen:</label>
                                <input type="text" id="encAlmacen" class="form-control form-control-border">
                            </div>
                            <div class="col-md-12">
                                <label for="idcategoria">Jefe de Fundo</label>
                                <select class="form-control form-control-border" name="idcategoria" id="idcategoria" >
                                </select>
                            </div>
                            <div class="col-md-12 ">
                                <label for="fundo">Fundo</label>
                                <select class="form-control form-control-border" name="fundo" id="fundo" >
                                </select>
                            </div>
                            <div class="col-md-12">
                                <label for="lote">Lote:</label>
                                <select class="form-control form-control-border" name="lote" id="lote" >
                                </select>
                            </div>
                            <div class="col-md-12">
                                <label for="s_lote">Sub Lote:</label>
                                <select class="form-control form-control-border" name="s_lote" id="s_lote" >
                                </select>
                            </div>
                            <div class="col-md-12 ">
                                <label for="cultivo">Cultivo</label>
                                <select class="form-control form-control-border" name="cultivo" id="cultivo">
                                </select>
                            </div>
                            <div class="col-md-12">
                                <label for="variedad">Variedad</label>
                                <select class="form-control form-control-border" name="variedad" id="variedad">
                                </select>
                            </div>
                            <div class="col-md-12 ">
                                <label for="nreserva">N° de Reserva:</label>
                                <input type="number" id="nreserva" class="form-control form-control-border">
                            </div>
                            <div class="col-md-12 ">
                                <label for="ninstructivo">N° de Instructivo:</label>
                                <input type="number" id="ninstructivo" class="form-control form-control-border">
                            </div>
                            <div class="col-md-12 ">
                                <label for="pep">PEP:</label>
                                <select id="pep" class="form-control form-control-border">
                                    <option value="">Seleccione</option>
                                    <option value="3">Foliar</option>
                                    <option value="4">Fumigacion</option>
                                    <option value="5">Control Etológico</option>
                                    <option value="6">Mosca de la Fruta</option>
                                </select>
                            </div>
                            <div class="col-md-12 ">
                                <label for="etcultivo">Etapa de Cultivo:</label>
                                <select id="etcultivo" class="form-control form-control-border">
                                    <option value="">Seleccione</option>
                                    <option value="1">Cosecha</option>
                                    <option value="2">Mantenimiento</option>
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
                <table class="table text-center" id="tablareporte">
                    <thead>
                        <tr>
                            <th class="text-center">Codigo</th>
                            <th class="text-center">Fecha y Hora</th>
                            <th class="text-center">Jefe de Fundo</th>
                            <th class="text-center">Fundo</th>
                            <th class="text-center">Lote</th>
                            <th class="text-center">Sub Lote</th>
                            <th class="text-center">Editar Productos</th>
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
<div class="modal" tabindex="-1" id="myModal">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title">Modal title</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body">
          <p>Modal body text goes here.</p>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
          <button type="button" class="btn btn-primary">Save changes</button>
        </div>
      </div>
    </div>
  </div>
<script src="js/reportes.js"></script>


