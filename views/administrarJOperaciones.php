<?php
    require_once 'datatable.php';
    require_once 'acceso-seguro.php';
    if($_SESSION['nivelacceso']!= "Administrador"){
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
                <p class="card-title mt-1" style="font-size: 22px" id="Aviso">Jefe de Operaciones</p>
            </div>
            <!-- /.card-header -->
            <div class="card-body">
                <form action="" id="formularioJOperaciones" enctype="multipart/form-data">
                    <div class="form-group">
                        <div class="row">
                            <div class="col-md-12 mt-3">
                                <label for="joperaciones">Jefe de Operaciones:</label>
                                <select id="joperaciones" class="form-control form-control-border" >
                                </select>
                            </div>
                            <div class="col-md-12">
                                <label for="nombres">Nombres:</label>
                                <input id="nombres" class="form-control form-control-border">
                                <input type="text" id="idusuariomod" class="form-control form-control-border asignar" disabled>
                            </div>
                            <div class="col-md-12 mt-3">
                                <label for="apellidos">Apellidos:</label>
                                <input id="apellidos" class="form-control form-control-border">
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <div class="col-md-9">
        <div  class=" card card-outline card-info">
            <div class="card-header">
                <p class="card-title" style="font-size: 22px">Asignar Jefe de Fundo</p>
            </div>
            <div class="card-body table-responsive">
                <table class="table" id="tablaJOperaciones">
                    <thead>
                        <tr>
                            <th class="text-center">Nombres</th>
                            <th class="text-center">Apellidos</th>
                            <th class="text-center">Asignar</th>
                        </tr>
                    </thead>
                    <tbody class="table" id="tablaJOperacionesListar">
                        <!-- Se carga de manera dinamica -->
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<script src="js/jOperaciones.js"></script>


