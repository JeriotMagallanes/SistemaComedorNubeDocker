<?php
    require_once 'datatable.php';
    require_once 'acceso-seguro.php';
    if($_SESSION['nivelacceso'] != 'Administrador'){
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
    <div class="col-md-4">
        <div class=" card card-outline card-info">
            <div class="card-header">
                <p class="card-title mt-1" style="font-size: 22px" id="Aviso">Registro de Motivos de Apli.</p>

            </div>
            <!-- /.card-header -->
            <div class="card-body">
                <form action="" id="formularioMotivoAplicacion">
                    <div class="form-group">
                        <div class="row">
                            <div class="col-md-12 mt-3">
                                <label for="nombremotivo">Nombre:</label>
                                <input type="text" id="nombremotivo" class="form-control form-control-border">
                                <input type="text" id="idproductomod" class="form-control form-control-border asignar" disabled>
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
    <div class="col-md-8">
        <div  class=" card card-outline card-info">
            <div class="card-header">
                <div class="row col-md-12">
                    <div class="col-md-9">
                        <p class="card-title" style="font-size: 22px">Lista de Motivos de Aplicacion</p>
                    </div>
                </div>
            </div>
            <div class="card-body table-responsive">
                <table class="table text-center" id="tablamotivoaplicacion">
                    <thead>
                        <tr>
                            <th class="text-center">N°</th>
                            <th class="text-center">Nombre</th>
                            <th class="text-center">Modificar</th>
                            <th class="text-center">Estado</th>
                        </tr>
                    </thead>
                    <tbody class="table" id="tablaMotivolistar">
                        <!-- Se carga de manera dinamica -->
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<script src="js/motivoaplicacion.js"></script>
