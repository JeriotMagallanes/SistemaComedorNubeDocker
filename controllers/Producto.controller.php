<?php
session_start();

require_once '../models/Producto.php';
require_once '../models/Serverside.php';

if (isset($_GET['op'])){

  $producto = new Producto();

    if($_GET['op'] == 'registrarProducto'){
        $producto->registrarProducto([
            'idcategoria' => $_GET['idcategoria'],
            'nombreproducto' => $_GET['nombreproducto'],
            'principiosactivos' => $_GET['principiosactivos'],
            'formafarmaceutica' => $_GET['formafarmaceutica'],
            'descripcion' => $_GET['descripcion'],
            'fechavencimiento' => $_GET['fechavencimiento']
        ]);
    }

    if ($_GET['op'] == 'nombreproductoYaRegistrado'){
        $datosObtenidos = $producto->nombreproductoYaRegistrado(["nombreproducto" => $_GET['nombreproducto']]);
    
        if(count($datosObtenidos) == 0){
          echo 2;
          return true;
        }
        else{
          echo 1;
          return false;
        }
    }

    //if ($_GET['op'] == 'ListarProductoMedico'){
      //$serverSide->get('vista_listar_productos_farmacia', 'idproducto', array('idproducto', 'nombreproducto', 'principiosactivos', 'formafarmaceutica', 'descripcion', 'fechavencimiento'));
    //}

      
    //if ($_GET['op'] == 'ListarProductoFarmacia'){
      //$serverSide->get('vista_listar_productos_farmacia', 'idproducto', array('idproducto','categoria', 'nombreproducto', 'principiosactivos', 'fechavencimiento'));
    //}

    if($_GET['op']  == 'ListarProductoFarmaciaPrueba'){              
      $clave = $producto->listarProducto();
  
      if(count($clave) != 0){
        $i = 1;
        foreach($clave as $valor){
          $color="";
          $estado="";
          $prueba = strtotime($valor->fechavencimiento);
          $mes1 = date("m", $prueba);
          $anio1 = date("Y", $prueba);
          date_default_timezone_set('America/Lima');
          $fecha_actual=date("Y-m-d");
          $mes2=date('m',strtotime($fecha_actual));
          $anio2 = date("Y", strtotime($fecha_actual));
          if($mes1-$mes2<=3 && $anio1<=$anio2){
            $color="red";$color2="white";
          }elseif($mes1-$mes2<=6 && $anio1<=$anio2){
            $color="yellow";$color2="black";
          }else{
            $color="green";$color2="white";
          }
          echo "
            <tr>
              <td class='text-center'>$i</td>
              <td class='text-center'>$valor->idcategoria</td>
              <td class='text-center'><span style='background-color:$color'>$valor->nombreproducto</span></td>
              <td class='text-center'>$valor->principiosactivos</td>
              <td class='text-center'><p style='background-color:$color;color:$color2'><span >$valor->fechavencimiento</span></p></td>
              <td class='text-center'>
                <a  href='#' data-idproducto='{$valor->idproducto}' class='btn btn-sm btn-outline-secondary modificar'>
                  <i class='fas fa-edit'></i>
                </a>
                <a  href='#' data-idproducto='{$valor->idproducto}' class='btn btn-sm btn-outline-secondary eliminar'>
                  <i class='fas fa-trash-alt'></i>
                </a>
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
        "idproducto" => $_GET['idproducto'],
        "nombreproducto" => $_GET['nombreproducto'],
        "principiosactivos" => $_GET['principiosactivos'],
        "formafarmaceutica" => $_GET['formafarmaceutica'],
        "descripcion" => $_GET['descripcion'],
        "fechavencimiento" => $_GET['fechavencimiento']
      ]);
    }

    if($_GET['op'] == 'getProducto'){
      $data = $producto->getProducto(["idproducto" => $_GET['idproducto']]);
      echo json_encode($data);
    }

    if($_GET['op'] == 'filtrarCategorias'){
      $clave = $producto->filtrarCategoria(['idcategoria' => $_GET['idcategoria']]);
      $i = 1;
      foreach($clave as $valor){
        $color="";
        $color2="";
        $estado="";
        $prueba = strtotime($valor->fechavencimiento);
        $mes1 = date("m", $prueba);
        $anio1 = date("Y", $prueba);
        date_default_timezone_set('America/Lima');
        $fecha_actual=date("Y-m-d");
        $mes2=date('m',strtotime($fecha_actual));
        $anio2 = date("Y", strtotime($fecha_actual));
        if($mes1-$mes2<=3 && $anio1<=$anio2){
          $color="red";$color2="white";
        }elseif($mes1-$mes2<=6 && $anio1<=$anio2){
          $color="yellow";$color2="black";
        }else{
          $color="green";$color2="white";
        }
        echo "
          <tr>
            <td class='text-center'>$i</td>
            <td class='text-center'>$valor->idcategoria</td>
            <td class='text-center'><span style='background-color:$color'>$valor->nombreproducto</span></td>
            <td class='text-center'>$valor->principiosactivos</td>
            <td class='text-center'><p style='background-color:$color;color:$color2'><span >$valor->fechavencimiento</span></p></td>
            <td class='text-center'>
              <a  href='#' data-idproducto='{$valor->idproducto}' class='btn btn-sm btn-outline-secondary modificar'>
                <i class='fas fa-edit'></i>
              </a>
              <a  href='#' data-idproducto='{$valor->idproducto}' class='btn btn-sm btn-outline-secondary eliminar'>
                <i class='fas fa-trash-alt'></i>
              </a>
            </td>
          </tr>
        ";
        $i++;
      }
    }

    if($_GET['op'] == 'filtrarCategoriasMedicos'){
      $clave = $producto->filtrarCategoria(['idcategoria' => $_GET['idcategoria']]);
      $i = 1;
      foreach($clave as $valor){
        $color="";
        $color2="";
        $estado="";
        $prueba = strtotime($valor->fechavencimiento);
        $mes1 = date("m", $prueba);
        $anio1 = date("Y", $prueba);
        date_default_timezone_set('America/Lima');
        $fecha_actual=date("Y-m-d");
        $mes2=date('m',strtotime($fecha_actual));
        $anio2 = date("Y", strtotime($fecha_actual));
        if($mes1-$mes2<=3 && $anio1<=$anio2){
          $color="red";$color2="white";
        }elseif($mes1-$mes2<=12 && $anio1<=$anio2){
          $color="yellow";$color2="black";
        }else{
          $color="green";$color2="white";
        }
        echo "
          <tr>
            <td class='text-center'>$i</td>
            <td class='text-center'>$valor->nombreproducto</td>
            <td class='text-center'>$valor->principiosactivos</td>
            <td class='text-center'>$valor->formafarmaceutica</td>
            <td class='text-center'>$valor->descripcion</td>
            <td class='text-center'><p style='background-color:$color;color:$color2'><span >$valor->fechavencimiento</span></p></td>
          </tr>
        ";
        $i++;
      }
    }

    if($_GET['op']  == 'ListarProductoMedicoPrueba'){              
      $clave = $producto->listarProducto();
  
      if(count($clave) != 0){
        $i = 1;
        foreach($clave as $valor){
          $color="";
          $estado="";
          $prueba = strtotime($valor->fechavencimiento);
          $mes1 = date("m", $prueba);
          $anio1 = date("Y", $prueba);
          date_default_timezone_set('America/Lima');
          $fecha_actual=date("Y-m-d");
          $mes2=date('m',strtotime($fecha_actual));
          $anio2 = date("Y", strtotime($fecha_actual));
          if($mes1-$mes2<=3 && $anio1<=$anio2){
            $color="red";$color2="white";
          }elseif($mes1-$mes2<=6 && $anio1<=$anio2){
            $color="yellow";$color2="black";
          }else{
            $color="green";$color2="white";
          }
          echo "
            <tr>
              <td class='text-center'>$i</td>
              <td class='text-center'><span style='background-color:$color;color:$color2'>$valor->nombreproducto</span></td>
              <td class='text-center'>$valor->principiosactivos</td>
              <td class='text-center'>$valor->formafarmaceutica</td>
              <td class='text-center'>$valor->descripcion</td>
              <td class='text-center'><p style='background-color:$color;color:$color2'><span >$valor->fechavencimiento</span></p></td>
            </tr>
          ";
          $i++;
        }
      }
    }

}
?>