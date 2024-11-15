<?php
session_start();

require_once '../models/ReporteCena.php';

if (isset($_GET['op'])){

  $reporte = new ReporteCena();

    if($_GET['op']  == 'ListarReporteCena'){              
      $clave = $reporte->ListarReporteCena();   
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
    if($_GET['op'] == 'ListarReporteCenaFecha'){
         $clave = $reporte->ListarReporteCenaFecha([
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