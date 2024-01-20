<?php
session_start();

require_once '../models/Reporte.php';
require_once '../models/Serverside.php';

if (isset($_GET['op'])){

  $Reporte = new Reporte();

    if($_GET['op'] == 'registrarReporte'){
        $Reporte->registrarReporte([
            'fechahoraReporte' => $_GET['fechahoraReporte'],
            'turno' => $_GET['turno'],
            'encSanidad' => $_GET['encSanidad'],
            'encQA' => $_GET['encQA'],
            'encAlmacen' => $_GET['encAlmacen'],
            'idcategoria' => $_GET['idcategoria'],
            'fundo' => $_GET['fundo'],
            'lote' => $_GET['lote'],
            's_lote' => $_GET['s_lote'],
            'cultivo' => $_GET['cultivo'],
            'variedad' => $_GET['variedad']
        ]);
    }

    if($_GET['op']  == 'ListarReportes'){              
      $clave = $Reporte->listarReporte();
  
      if(count($clave) != 0){
        $i = 1;
        foreach($clave as $valor){
          echo "
            <tr>
              <td class='text-center'>$valor->id_reporte</td>
              <td class='text-center'>$valor->fecha_hora</td>
              <td class='text-center'>$valor->jefe_fundo</td>
              <td class='text-center'>$valor->nom_fundo</td>
              <td class='text-center'>$valor->nombre_lote</td>
              <td class='text-center'>$valor->_slote_nombre</td>
              <td class='text-center'>
                <a  href='#' data-idproducto='{$valor->id_reporte}' class='btn btn-sm btn-outline-secondary modificar'>
                  <i class='fas fa-edit'></i>
                </a>
                <!--<a  href='#' data-idproducto='{$valor->id_reporte}' class='btn btn-sm btn-outline-secondary eliminar'>
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
      $Reporte->eliminarProducto(["idproducto" => $_GET["idproducto"]]);
    }
    
    if($_GET['op'] == 'modificarProducto'){
      $Reporte->modificarProducto([
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
      $data = $Reporte->getProducto(["id_fundo" => $_GET['idproducto']]);
      echo json_encode($data);
    }

    if($_GET['op'] == 'filtrarFechas'){
      $clave = $Reporte->filtrarFecha([
      'fechainicial' => $_GET['fechainicial'],
      'fechafinal' => $_GET['fechafinal']
    ]);
      $i = 1;
      foreach($clave as $valor){
        echo "
            <tr>
            <td class='text-center'>$valor->id_reporte</td>
            <td class='text-center'>$valor->fecha_hora</td>
            <td class='text-center'>$valor->jefe_fundo</td>
            <td class='text-center'>$valor->nom_fundo</td>
            <td class='text-center'>$valor->nombre_lote</td>
            <td class='text-center'>$valor->_slote_nombre</td>
            <td class='text-center'>
              <a  href='#' data-idproducto='{$valor->id_reporte}' class='btn btn-sm btn-outline-secondary modificar'>
                <i class='fas fa-edit'></i>
              </a>
              <!--<a  href='#' data-idproducto='{$valor->id_reporte}' class='btn btn-sm btn-outline-secondary eliminar'>
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
