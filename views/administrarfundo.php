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
    <div class="col-md-3">
        <div class=" card card-outline card-info">
            <div class="card-header">
                <p class="card-title mt-1" style="font-size: 22px" id="Aviso">Registro de Fundos</p>

            </div>
            <!-- /.card-header -->
            <div class="card-body">
                <form action="" id="formularioFundo">
                    <div class="form-group">
                        <div class="row">
                            <div class="col-md-12 mt-3">
                                <label for="idcategoria">Jefe de Fundo</label>
                                <select class="form-control form-control-border" name="idcategoria" id="idcategoria" >
                                </select>
                            </div>
                            <div class="col-md-12 mt-3">
                                <label for="nombreproducto">Nombre:</label>
                                <input type="text" id="nombreproducto" class="form-control form-control-border">
                                <input type="text" id="idproductomod" class="form-control form-control-border asignar" disabled>
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
                                <label for="hectareas">Hectareas:</label>
                                <input class="money form-control form-control-border" type="text"id="hectareas" >
                                
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
                        <p class="card-title" style="font-size: 22px">Lista de Fundos</p>
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
<script src="js/fundos.js"></script>


