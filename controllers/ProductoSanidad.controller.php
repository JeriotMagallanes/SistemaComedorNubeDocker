<?php
session_start();

require_once '../models/ProductoSanidad.php';
require_once '../models/Serverside.php';

if (isset($_GET['op'])){

  $producto = new Producto();

    if($_GET['op'] == 'registrarProducto'){
        $producto->registrarProducto([
            'codigoproducto' => $_GET['codigoproducto'],
            'nombreproducto' => $_GET['nombreproducto'],
            'unidadproducto' => $_GET['unidadproducto']
        ]);
    }

    if ($_GET['op'] == 'nombreproductoYaRegistrado'){
        $datosObtenidos = $producto->nombreproductoaRegistrado(["nombreproducto" => $_GET['nombreproducto']]);
    
        if(count($datosObtenidos) == 0){
          echo 2;
          return true;
        }
        else{
          echo 1;
          return false;
        }
    }

    if($_GET['op']  == 'ListarProductos'){              
      $clave = $producto->listarProducto();
  
      if(count($clave) != 0){
        $i = 1;
        foreach($clave as $valor){ 
          $estado="";
          if($valor->estado=="A"){
            $estado="<label class='switch'><input id='on'data-productoEstado='$valor->id_producto' type='checkbox' checked><div class='slider round'></label>";
          }else{
            $estado="<label class='switch'><input id='on'data-productoEstado='$valor->id_producto' type='checkbox'><div class='slider round'></label>";
          }
          echo "
            <tr>
              <td class='text-center'>$i</td>
              <td class='text-center'>$valor->codigo_producto</td>
              <td class='text-center'>$valor->nombre_producto</td>
              <td class='text-center'>$valor->unidad</td>
              <td class='text-center'>
                <a  href='#' data-idproducto='{$valor->id_producto}' class='btn btn-sm btn-outline-secondary modificar'>
                  <i class='fas fa-edit'></i>
                </a>
                <!--<a  href='#' data-idproducto='{$valor->id_producto}' class='btn btn-sm btn-outline-secondary eliminar'>
                  <i class='fas fa-trash-alt'></i>
                </a>-->
              </td>
              <td class='text-center'>{$estado}</td>
            </tr>
          ";
          $i++;
        }
      }
    }

    if($_GET['op']== 'eliminarProducto'){
      $producto->eliminarProducto(["producto_estado" => $_GET["producto_estado"]]);
    }
    
    if($_GET['op'] == 'reactivarProducto'){
      $producto->reactivarProducto(["producto_estado" => $_GET['producto_estado']]);
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