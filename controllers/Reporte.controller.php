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
                <a  href='main.php?view=administrardetallereporte' data-idproducto='{$valor->id_reporte}' class='btn btn-sm btn-outline-secondary detalle'>
                  <i class='fas fa-bars'></i>
                </a>
              </td>";
              if(($_SESSION['nivelacceso'] == 'Administrador')){
                echo
                "
              <td class='text-center'>
                <a  href='#' data-idproducto='{$valor->id_reporte}' class='btn btn-sm btn-outline-secondary modificar'>
                  <i class='fas fa-edit'></i>
                </a>
              </td>
              <td class='text-center'>
                <a  href='#' data-idproducto='{$valor->id_reporte}' class='btn btn-sm btn-outline-secondary eliminar'>
                  <i class='fas fa-trash-alt'></i>
                </a>
              </td> 
              ";}
            echo "</tr>
          ";
          $i++;
        }
      }
    }

    if($_GET['op']== 'eliminarReporte'){
      $Reporte->eliminarReportes(["idproducto" => $_GET["idproducto"]]);
    }
    
    if($_GET['op'] == 'modificarReporte'){
      $Reporte->modificarReporte([
        "idreporte" => $_GET['idreporte'],
        "encSanidad" => $_GET['encSanidad'],
        "encQA" => $_GET['encQA'],
        "encAlmacen" => $_GET['encAlmacen'],
        "idcategoria" => $_GET['idcategoria'], 
        "fundo" => $_GET['fundo'],
        "lote" => $_GET['lote'],
        "s_lote" => $_GET['s_lote'], 
        "cultivo" => $_GET['cultivo'],
        "variedad" => $_GET['variedad'],
      ]);
    }

    if($_GET['op'] == 'getReporte'){
      $data = $Reporte->getReporte(["id_reporte" => $_GET['id_reporte']]);
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
              <a  href='main.php?view=administrardetallereporte' data-idproducto='{$valor->id_reporte}' class='btn btn-sm btn-outline-secondary detalle'>
                <i class='fas fa-bars'></i>
              </a>
            </td>
            <td class='text-center'>
              <a  href='#' data-idproducto='{$valor->id_reporte}' class='btn btn-sm btn-outline-secondary modificar'>
                <i class='fas fa-edit'></i>
              </a>
            </td>
            <td class='text-center'>
              <a  href='#' data-idproducto='{$valor->id_reporte}' class='btn btn-sm btn-outline-secondary eliminar'>
                <i class='fas fa-trash-alt'></i>
              </a>
            </td>
          </tr>
        ";
        $i++;
      }
    }

}
?>
