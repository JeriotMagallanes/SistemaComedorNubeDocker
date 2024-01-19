<?php
session_start();

require_once '../models/Fundo.php';
require_once '../models/Serverside.php';

if (isset($_GET['op'])){

  $Fundo = new Fundo();

    if($_GET['op'] == 'registrarFundo'){
        $Fundo->registrarFundo([
            'idcategoria' => $_GET['idcategoria'],
            'nombreproducto' => $_GET['nombreproducto'],
            'lote' => $_GET['lote'],
            's_lote' => $_GET['s_lote'],
            'hectareas' => $_GET['hectareas'],
            'cultivo' => $_GET['cultivo'],
            'variedad' => $_GET['variedad']
        ]);
    }

    if ($_GET['op'] == 'nombrefundoYaRegistrado'){
        $datosObtenidos = $Fundo->nombrefundoYaRegistrado(["nombreproducto" => $_GET['nombreproducto']]);
    
        if(count($datosObtenidos) == 0){
          echo 2;
          return true;
        }
        else{
          echo 1;
          return false;
        }
    }

    if($_GET['op']  == 'listarfundo'){              
      $clave = $Fundo->listarfundo();
      if(count($clave) != 0){
        $i = 1;
        foreach($clave as $valor){
          echo "
            <tr>
              <td class='text-center'>$i</td>
              <td class='text-center'>$valor->nombre</td>
              <td class='text-center'>{$valor->nombres} {$valor->apellidos}</td>
              <td class='text-center'>$valor->nombre_lote</td>
              <td class='text-center'>$valor->_slote_nombre</td>
              <td class='text-center'>$valor->hectareas</td>
              <td class='text-center'>$valor->nombre_cultivo</td>
              <td class='text-center'>$valor->nombre_variedad</td>
              <td class='text-center'>
                <a  href='#' data-idproducto='{$valor->id_fundo}' class='btn btn-sm btn-outline-secondary modificar'>
                  <i class='fas fa-edit'></i>
                </a>
                <!--<a  href='#' data-idproducto='{$valor->id_fundo}' class='btn btn-sm btn-outline-secondary eliminar'>
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
      $Fundo->eliminarProducto(["idproducto" => $_GET["idproducto"]]);
    }
    
    if($_GET['op'] == 'modificarProducto'){
      $Fundo->modificarProducto([
        "idproducto" => $_GET['idproducto'],
        "idcategoria" => $_GET['idcategoria'],
        "nombreproducto" => $_GET['nombreproducto'],
        "lote" => $_GET['lote'],
        "s_lote" => $_GET['s_lote'],
        "hectareas" => $_GET['hectareas'], 
        "cultivo" => $_GET['cultivo'],
        "variedad" => $_GET['variedad'],
      ]);
    }

    if($_GET['op'] == 'getProducto'){
      $data = $Fundo->getProducto(["id_fundo" => $_GET['idproducto']]);
      echo json_encode($data);
    }

    if($_GET['op'] == 'filtrarCategorias'){
      $clave = $Fundo->filtrarCategoria(['jefe_fundo' => $_GET['jefe_fundo']]);
      $i = 1;
      foreach($clave as $valor){
        echo "
          <tr>
            <td class='text-center'>$i</td>
            <td class='text-center'>$valor->nombre</td>
            <td class='text-center'>{$valor->nombres} {$valor->apellidos}</td>
            <td class='text-center'>$valor->nombre_lote</td>
            <td class='text-center'>$valor->_slote_nombre</td>
            <td class='text-center'>$valor->hectareas</td>
            <td class='text-center'>$valor->nombre_cultivo</td>
            <td class='text-center'>$valor->nombre_variedad</td>
            <td class='text-center'>
              <a  href='#' data-idproducto='{$valor->id_fundo}' class='btn btn-sm btn-outline-secondary modificar'>
                <i class='fas fa-edit'></i>
              </a>
              <!--<a  href='#' data-idproducto='{$valor->id_fundo}' class='btn btn-sm btn-outline-secondary eliminar'>
                <i class='fas fa-trash-alt'></i>
              </a>-->
            </td>
          </tr>
        ";
        $i++;
      }
    }

}
?>
