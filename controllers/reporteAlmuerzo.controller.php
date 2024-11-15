<?php
session_start();

require_once '../models/ReporteAlmuerzo.php';

if (isset($_GET['op'])){

  $reporte = new ReporteAlmuerzo();

    if($_GET['op']  == 'ListarReporteAlmuerzo'){              
      $clave = $reporte->ListarReporteAlmuerzo();   
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
    if($_GET['op'] == 'ListarReporteAlmuerzoFecha'){
         $clave = $reporte->ListarReporteAlmuerzoFecha([
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