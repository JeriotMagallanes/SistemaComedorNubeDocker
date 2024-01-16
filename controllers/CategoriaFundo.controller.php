<?php
session_start();
require_once '../models/CategoriaFundo.php';
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
    //   echo json_encode($data);
    }
    
    if($_GET['op'] == 'cargarCategoriaCultivos'){
      $datosObtenidos = $categoria->cargarCategoriaCultivos();
        echo "<option value=''>Seleccione</option>";
        foreach($datosObtenidos as $valor){
            echo"
            <option value='$valor->id_cultivo'>$valor->nombre_cultivo</option>
            ";
        }
    //   echo json_encode($data);
    }
    if($_GET['op'] == 'cargarCategoriaVariedades'){
      $datosObtenidos = $categoria->cargarCategoriaVariedades(["id_cultivo" => $_GET['id_cultivo']]);
      // echo json_encode($datosObtenidos);
      echo "<option value=''>Seleccione</option>";
      foreach($datosObtenidos as $valor){
          echo"
          <option value='$valor->id_variedad'>$valor->nombre_variedad</option>
          ";
      }
    }
}
?>