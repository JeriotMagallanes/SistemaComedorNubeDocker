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
    
    if($_GET['op'] == 'cargarCategoriaNombreFundo'){
      $datosObtenidos = $categoria->cargarCategoriaNombreFundos(["jefe_fundo" => $_GET['jefe_fundo']]);
      echo "<option value=''>Seleccione</option>";
      foreach($datosObtenidos as $valor){
          echo"
          <option value='$valor->nombre'>$valor->nombre</option>
          ";
      }
    }
    if($_GET['op'] == 'cargarCategoriaLoteNombreFundo'){
      $datosObtenidos = $categoria->cargarCategoriaLoteNombreFundos([
        "nombre" => $_GET['nombre'],
        "jefe_fundo"=>$_GET['jefe_fundo']
      ]);
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
    
    if($_GET['op'] == 'cargarCategoriaCultivoLote'){
      $datosObtenidos = $categoria->cargarCategoriaCultivosLotes(["id_sub_lote" => $_GET['id_sub_lote']]);
      echo "<option value=''>Seleccione</option>";
      foreach($datosObtenidos as $valor){
          echo"
          <option value='$valor->id_cultivo '>$valor->nombre_cultivo</option>
          ";
      }
    }
    if($_GET['op'] == 'cargarCategoriaVariedadLote'){
      $datosObtenidos = $categoria->cargarCategoriaVariedadLotes(["s_lote" => $_GET['s_lote']]);
      echo "<option value=''>Seleccione</option>";
      foreach($datosObtenidos as $valor){
          echo"
          <option value='$valor->id_variedad '>$valor->nombre_variedad</option>
          ";
      }
    }

}
?>