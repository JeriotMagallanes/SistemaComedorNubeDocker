<?php
require_once 'acceso_seguro.php';
require_once 'datatable.php';
    if($_SESSION['nivelacceso'] != 'Administrador' && $_SESSION['nivelacceso'] != 'Concesionario'&& $_SESSION['nivelacceso'] != 'DBU'){
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
                <p class="card-title mt-1" style="font-size: 22px" id="Aviso">Registro de Comidas</p>

            </div>
            <!-- /.card-header -->
            <div class="card-body">
                <form action="" id="formularioAlmuerzo">
                    <div class="form-group">
                        <div class="row">
                            <div class="col-md-12 mt-3">
                                <label for="fecha">Fecha:</label>
                                <input type="date" id="fecha" class="form-control form-control-border">
                            </div>
                            <div class="col-md-12 mt-3">
                                <label for="desayuno">Desayuno:</label>
                                <input type="text" id="desayuno" class="form-control form-control-border">
                                <input type="text" id="idcomida" class="form-control form-control-border asignar" disabled>
                            </div>
                            <div class="col-md-12 mt-3">
                                <label for="almuerzo">Almuerzo:</label>
                                <input type="text" id="almuerzo" class="form-control form-control-border">
                            </div>
                            <div class="col-md-12 mt-3">
                                <label for="cena">Cena:</label>
                                <input type="text" id="cena" class="form-control form-control-border">
                            </div>
                            <div class="col-md-12 mt-3">
                                <label for="rdesayuno">Ración Desayuno:</label>
                                <input type="number" id="rdesayuno" class="form-control form-control-border" value="150">
                            </div>
                            <div class="col-md-12 mt-3">
                                <label for="ralmuerzo">Ración Almuerzo:</label>
                                <input type="number" id="ralmuerzo" class="form-control form-control-border" value="500">
                            </div>
                            <div class="col-md-12 mt-3">
                                <label for="rcena">Ración Cena:</label>
                                <input type="number" id="rcena" class="form-control form-control-border" value="250">
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
                        <p class="card-title" style="font-size: 22px">Lista de Almuerzos</p>
                    </div>
                </div>
            </div>
            <div class="card-body table-responsive">
                <table class="table text-center" id="tablaAlmuerzo">
                    <thead>
                        <tr>
                            <th class="text-center">Fecha</th>
                            <th class="text-center">Desayuno</th>
                            <th class="text-center">Almuerzo</th>
                            <th class="text-center">Cena</th>
                            <th class="text-center">Rac. Desayuno</th>
                            <th class="text-center">Rac. Almuerzo</th>
                            <th class="text-center">Rac. Cena</th>
                            <th class="text-center">Modificar</th>
                        </tr>
                    </thead>
                    <tbody class="table" id="tablaAlmuerzolistar">
                        <!-- Se carga de manera dinamica -->
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<script src="js/almuerzos.js"></script>
