<?php
session_start();

require_once '../models/Detalle.php';
require_once '../models/Serverside.php';

if (isset($_GET['op'])){

  $Detalle = new Detalle();

    if($_GET['op'] == 'registrarDetalle'){
        $Detalle->registrardetalles([
            'motaplicacion' => $_GET['motaplicacion'],
            'producto_san' => $_GET['producto_san'],
            'unidad' => $_GET['unidad'],
            'diascarencia' => $_GET['diascarencia'],
            'dosiscil' => $_GET['dosiscil'],
            'ncil' => $_GET['ncil'],
            'dosistanque' => $_GET['dosistanque'],
            'tproducto' => $_GET['tproducto'],
            'dosisha' => $_GET['dosisha'],
            'haaplicada' => $_GET['haaplicada'],
            'gastoh20' => $_GET['gastoh20'],
            'id_reporte' => $_GET['id_reporte']
        ]);
    }

    if($_GET['op'] == 'listardetalles'){
      $clave = $Detalle->listardetalle(['id_reporte' => $_GET['id_reporte']]);
      $i = 1;
      foreach($clave as $valor){
        echo "
          <tr>
            <td class='text-center'>$valor->nombre_motivo</td>
            <td class='text-center'>$valor->nombre_producto</td>
            <td class='text-center'>$valor->diascarencia</td>
            <td class='text-center'>$valor->dosiscil</td>
            <td class='text-center'>$valor->ncil</td>
            <td class='text-center'>$valor->dosistanque</td>
            <td class='text-center'>$valor->totalproducto</td>
            <td class='text-center'>$valor->dosisHA</td>
            <td class='text-center'>$valor->HAaplicada</td>
            <td class='text-center'>$valor->gastoH2O</td>
            <td class='text-center'>
              <a  href='#' data-idproducto='{$valor->id_detallereporte}' class='btn btn-sm btn-outline-secondary eliminar'>
                <i class='fas fa-trash-alt'></i>
              </a>
            </td>
          </tr>
        ";
        $i++;
      }
    }

    if ($_GET['op'] == 'listardatosReporte') {
      $reporte = $_GET['id_reporte'];
      $clave = $Detalle->listardatosreporte(['id_reporte' => $reporte]);
      $i = 1;
      foreach ($clave as $valor) {
          echo "
          <tr>
              <input type='text' id='idreportecambiarEstado' value='{$reporte}'>
              <td class='col-6 mb-0'>Jefe de Fundo: $valor->jefe_fundo</th>
              <td class='col-6 mb-0'>Fundo: $valor->nombre_fundo</th>
          </tr>
          <tr>
              <td class='col-6 mb-0'>Lote: $valor->nombre_lote</th>
              <td class='col-6 mb-0'>Sub-Lote: $valor->_slote_nombre</th>
          </tr>
          <tr>
              <td class='col-6 mb-0'>Cultivo: $valor->nombre_cultivo</th>
              <td class='col-6 mb-0'>Variedad: $valor->nombre_variedad</th>
          </tr>
          ";
          $i++;
      }
  }
    if($_GET['op'] == 'listardetallesOperario'){
      $clave = $Detalle->listardetalle(['id_reporte' => $_GET['id_reporte']]);
      $i = 1;
      foreach($clave as $valor){
        echo "
          <tr>
            <td class='text-center'>$valor->nombre_motivo</td>
            <td class='text-center'>$valor->nombre_producto</td>
            <td class='text-center'>$valor->diascarencia</td>
            <td class='text-center'>$valor->dosiscil</td>
            <td class='text-center'>$valor->ncil</td>
            <td class='text-center'>$valor->dosistanque</td>
            <td class='text-center'>$valor->totalproducto</td>
            <td class='text-center'>$valor->dosisHA</td>
            <td class='text-center'>$valor->HAaplicada</td>
            <td class='text-center'>$valor->gastoH2O</td>
          </tr>
        ";
        $i++;
      }
    }

    if($_GET['op']== 'eliminarDetalles'){
      $nombres = $_SESSION['nombres'];
      $apellidos = $_SESSION['apellidos'];
      $nombreapellido = $nombres . ' ' . $apellidos; // Concatenación de nombres y apellidos
      $Detalle->eliminarDetalle([
      'id_detallereporte' => $_GET['id_detallereporte']
      ]); 
      $Detalle->registrarEliminacionDetalle([
      'id_detallereporte' => $_GET['id_detallereporte'],
      'observacion' => $_GET['observacion'],
      'nombreapellido' => $nombreapellido
      ]);
      $Detalle->cambiarEstadoReporte([
      'id_reporte' => $_GET['id_reporte']
      ]);
    }
    

}
?>
