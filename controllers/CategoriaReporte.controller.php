<?php
session_start();
require_once '../models/CategoriaReporte.php';
if (isset($_GET['op'])){
  $categoria = new Categoria();

    if($_GET['op'] == 'cargarCategoria'){
      $datosObtenidos = $categoria->cargarCategoria();
        echo "<option value=''>Seleccione</option>";
        foreach($datosObtenidos as $valor){
            echo"
            <option value='$valor->idusuario'>$valor->Nombre</option>
            ";
        }
    }
    
    if($_GET['op'] == 'cargarCategoriaCultivos'){
      $datosObtenidos = $categoria->cargarCategoriaCultivos();
        echo "<option value=''>Seleccione</option>";
        foreach($datosObtenidos as $valor){
            echo"
            <option value='$valor->id_cultivo'>$valor->nombre_cultivo</option>
            ";
        }
    }
    if($_GET['op'] == 'cargarCategoriaVariedades'){
      $datosObtenidos = $categoria->cargarCategoriaVariedades(["id_cultivo" => $_GET['id_cultivo']]);
      echo "<option value=''>Seleccione</option>";
      foreach($datosObtenidos as $valor){
          echo"
          <option value='$valor->id_variedad'>$valor->nombre_variedad</option>
          ";
      }
    }
    if($_GET['op'] == 'cargarCategoriaLote'){
      $datosObtenidos = $categoria->cargarCategoriaLote();
        echo "<option value=''>Seleccione</option>";
        foreach($datosObtenidos as $valor){
            echo"
            <option value='$valor->id_lote'>$valor->nombre_lote</option>
            ";
        }
    }
    if($_GET['op'] == 'cargarCategoriaSubLote'){
      $datosObtenidos = $categoria->cargarCategoriaSubLotes(["id_lote" => $_GET['id_lote']]);
      echo "<option value=''>Seleccione</option>";
      foreach($datosObtenidos as $valor){
          echo"
          <option value='$valor->id_sub_lote '>$valor->_slote_nombre</option>
          ";
      }
    }
}
?>