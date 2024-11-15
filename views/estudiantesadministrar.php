<?php
    require_once 'acceso_seguro.php';
    require_once 'datatable.php';
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
                <p class="card-title mt-1" style="font-size: 22px" id="Aviso">Estudiantes</p>
            </div>
            <!-- /.card-header -->
            <div class="card-body">
                <form action="" id="formularioEstudiante" enctype="multipart/form-data">
                    <div class="form-group">
                        <div class="row">
                            <div class="col-md-12">
                                <label for="coduniversitario">Codigo Universitario:</label>
                                <input id="coduniversitario" class="form-control form-control-border">
                               <input type="text" id="idestudiante" class="form-control form-control-border asignar" disabled>
                            </div>
                            <div class="col-md-12 mt-3">
                                <label for="dni">DNI:</label>
                                <input id="dni" class="form-control form-control-border">
                            </div>
                            <div class="col-md-12 mt-3">
                                <label for="nombres">Nombres:</label>
                                <input id="nombres" class="form-control form-control-border">
                            </div>
                            <div class="col-md-12 mt-3">
                                <label for="apaterno">Apellido Paterno:</label>
                                <input id="apaterno" class="form-control form-control-border">
                            </div>
                            <div class="col-md-12 mt-3">
                                <label for="amaterno">Apellido Materno:</label>
                                <input id="amaterno" class="form-control form-control-border">
                            </div>
                            <div class="col-md-12 mt-3">
                                <label for="carrera">Carrera:</label>
                                <select id="carrera" class="form-control form-control-border">
                                    <option value="">Seleccione</option>
                                    <option value="1">Ing. Sistemas</option>
                                    <option value="2">Administracion </option>
                                    <option value="3">Turismo</option>
                                    <option value="4">Agronomía</option>
                                    <option value="5">Contabilidad</option>
                                </select>
                            </div>
                            <div class="col-md-12 mt-3">
                                <label for="desayuno">Desayuno:</label>
                                <select id="desayuno" class="form-control form-control-border">
                                    <option value="1">Si</option>
                                    <option value="0">No </option>
                                </select>
                            </div>
                            <div class="col-md-12 mt-3">
                                <label for="almuerzo">Almuerzo:</label>
                                <select id="almuerzo" class="form-control form-control-border">
                                    <option value="1">Si</option>
                                    <option value="0">No </option>
                                </select>
                            </div>
                            <div class="col-md-12 mt-3">
                                <label for="cena">Cena:</label>
                                <select id="cena" class="form-control form-control-border">
                                    <option value="1">Si</option>
                                    <option value="0">No </option>
                                </select>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
            <!-- /.card-body -->
            <div class="card-footer text-right bg-white">
                <button type="reset" class="btn bg-gradient-secondary" id="cancelar">Cancelar</button>
                <button type="button" class="btn bg-gradient-info" id="registrar">Guardar</button>
                <button type="button" class="btn bg-gradient-info asignar" id="actualizar">Actualizar</button>
            </div>
            <!-- /.card-footer -->
        </div>
    </div>
    <div class="col-md-9">
        <div  class=" card card-outline card-info">
            <div class="card-header">
                <p class="card-title" style="font-size: 22px">Lista de Usuarios</p>
            </div>
            <div class="card-body table-responsive">
                <table class="table" id="tablaEstudiante">
                    <thead>
                        <tr>
                            <th class="text-center">N°</th>
                            <th class="text-center">Cod. Estudiante</th>
                            <th class="text-center">DNI</th>
                            <th class="text-center">Nombres</th>
                            <th class="text-center">Apellidos</th>
                            <th class="text-center">Carrera</th>
                            <th class="text-center">Desayuno</th>
                            <th class="text-center">Almuerzo</th>
                            <th class="text-center">Cena</th>
                            <th class="text-center">Operaciones</th>
                        </tr>
                    </thead>
                    <tbody class="table" id="datosEstudiante">
                        <!-- Se carga de manera dinamica -->
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<script src="js/estudiantes.js"></script>


