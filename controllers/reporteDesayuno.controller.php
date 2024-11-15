<?php
session_start();

require_once '../models/ReporteDesayuno.php';

if (isset($_GET['op'])){

  $reporte = new ReporteDesayuno();

    if($_GET['op']  == 'ListarReporteDesayuno'){              
      $clave = $reporte->ListarReporteDesayuno();   
      if(count($clave) != 0){
        $i = 1;
        foreach($clave as $valor){ 
        echo "
        <tr>
            <td class='text-center'>$i</td>
            <td class='text-center'>$valor->fechaHora</td>
            <td class='text-center'>$valor->dni</td>
            <td class='text-center'>$valor->nombres</td>
            <td class='text-center'>$valor->aPaterno $valor->aMaterno</td>
        </tr>
        ";
          $i++;
        }
      }
    }

    //op que  filtra los reportes por fechas de la vista anterior
    if($_GET['op'] == 'ListarReporteDesayunoFecha'){
         $clave = $reporte->ListarReporteDesayunoFecha([
        'fecha' => $_GET['fecha']
        ]);
        $i = 1;   
        if(count($clave) != 0){
          $i = 1;
          foreach($clave as $valor){ 
          echo "
          <tr>
              <td class='text-center'>$i</td>
              <td class='text-center'>$valor->fechaHora</td>
              <td class='text-center'>$valor->dni</td>
              <td class='text-center'>$valor->nombres</td>
              <td class='text-center'>$valor->aPaterno $valor->aMaterno</td>
          </tr>
          ";
            $i++;
          }
        }
    }

}
?>