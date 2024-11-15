<?php
session_start();

require_once '../models/Inasistencia.php';

if (isset($_GET['op'])){

  $inasistencia = new Inasistencia();

    if($_GET['op']  == 'ListarInasistenciaDesayuno'){              
      $clave = $inasistencia->ListarInasistenciaDesayuno();
  
      if(count($clave) != 0){
        $i = 1;
        foreach($clave as $valor){ 
            $inasistencia=$valor->rdesayuno-$valor->asistencias;
          echo "
            <tr>
              <td class='text-center'>$valor->fecha</td>
              <td class='text-center'>$valor->asistencias</td>
              <td class='text-center'>$inasistencia</td>
            </tr>
          ";
          $i++;
        }
      }
    }

    if($_GET['op']  == 'ListarInasistenciaAlmuerzo'){              
      $clave = $inasistencia->ListarInasistenciaAlmuerzo();
  
      if(count($clave) != 0){
        $i = 1;
        foreach($clave as $valor){ 
            $inasistencia=$valor->ralmuerzo-$valor->asistencias;
          echo "
            <tr>
              <td class='text-center'>$valor->fecha</td>
              <td class='text-center'>$valor->asistencias</td>
              <td class='text-center'>$inasistencia</td>
            </tr>
          ";
          $i++;
        }
      }
    }
    
    if($_GET['op']  == 'ListarInasistenciaCena'){              
      $clave = $inasistencia->ListarInasistenciaCena();
  
      if(count($clave) != 0){
        $i = 1;
        foreach($clave as $valor){ 
            $inasistencia=$valor->rcena-$valor->asistencias;
          echo "
            <tr>
              <td class='text-center'>$valor->fecha</td>
              <td class='text-center'>$valor->asistencias</td>
              <td class='text-center'>$inasistencia</td>
            </tr>
          ";
          $i++;
        }
      }
    }


}
?>