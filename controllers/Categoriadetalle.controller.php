<?php
session_start();
require_once '../models/CategoriaDetalle.php';
if (isset($_GET['op'])){
  $categoria = new Categoria();
    
    if($_GET['op'] == 'cargarMotivoAplicacion'){
      $datosObtenidos = $categoria->cargarMotivosAplicacion();
        echo "<option value=''>Seleccione</option>";
        foreach($datosObtenidos as $valor){
            echo"
            <option value='$valor->id_motivo'>$valor->nombre_motivo</option>
            ";
        }
    }
    if($_GET['op'] == 'cargarProducto'){
      $datosObtenidos = $categoria->cargarProductos();
        echo "<option value=''>Seleccione</option>";
        foreach($datosObtenidos as $valor){
            echo"
            <option value='$valor->id_producto'>$valor->nombre_producto</option>
            ";
        }
    }
    
    if($_GET['op'] == 'cargarUnidad'){
      $data = $categoria->getProducto(["id_producto" => $_GET['id_producto']]);
      echo json_encode($data);
    }
}
?>