<?php
session_start();

require_once '../models/MotivoAplicacion.php';
require_once '../models/Serverside.php';

if (isset($_GET['op'])){

  $producto = new Producto();

    if($_GET['op'] == 'registrarProducto'){
        $producto->registrarProducto([
            'nombremotivo' => $_GET['nombremotivo']
        ]);
    }

    if ($_GET['op'] == 'nombreproductoYaRegistrado'){
        $datosObtenidos = $producto->nombreproductoYaRegistrado(["nombremotivo" => $_GET['nombremotivo']]);
    
        if(count($datosObtenidos) == 0){
          echo 2;
          return true;
        }
        else{
          echo 1;
          return false;
        }
    }

    if($_GET['op']  == 'ListarProductoFarmaciaPrueba'){              
      $clave = $producto->listarProducto();
  
      if(count($clave) != 0){
        $i = 1;
        foreach($clave as $valor){
          echo "
            <tr>
              <td class='text-center'>$i</td>
                <td class='text-center'>$valor->nombre_motivo</td>
              <td class='text-center'>
                <a  href='#' data-idproducto='{$valor->id_motivo}' class='btn btn-sm btn-outline-secondary modificar'>
                  <i class='fas fa-edit'></i>
                </a>
                <!--<a  href='#' data-idproducto='{$valor->id_motivo}' class='btn btn-sm btn-outline-secondary eliminar'>
                  <i class='fas fa-trash-alt'></i>
                </a>-->
              </td>
            </tr>
          ";
          $i++;
        }
      }
    }

    if($_GET['op']== 'eliminarProducto'){
      $producto->eliminarProducto(["idproducto" => $_GET["idproducto"]]);
    }
    
    if($_GET['op'] == 'modificarProducto'){
      $producto->modificarProducto([
        "id_producto" => $_GET['id_producto'],
        "codigo_producto" => $_GET['codigo_producto'],
        "nombre_producto" => $_GET['nombre_producto'],
        "unidad" => $_GET['unidad'],
      ]);
    }

    if($_GET['op'] == 'getProducto'){
      $data = $producto->getProducto(["id_producto" => $_GET['idproducto']]);
      echo json_encode($data);
    }


}
?>