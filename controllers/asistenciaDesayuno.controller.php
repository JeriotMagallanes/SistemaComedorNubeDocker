<?php
session_start();

require_once '../models/AsistenciaDesayuno.php';

if (isset($_GET['op'])){

  $asistencia = new AsistenciaDesayuno();

    if($_GET['op'] == 'registrarAsistenciaDesayuno'){
      $asistencia->RegistrarAsistenciaDesayuno([
        "fecha_hora" => $_GET['fecha_hora'],
        "dni" => $_GET['dni']
      ]);
    }

    if($_GET['op']  == 'ListarInasistenciaDesayuno'){              
      $clave = $asistencia->ListarInasistenciaDesayuno();            
        $clave1 = $asistencia->Asistencia_dias_atendidos();
        if(count($clave1) != 0){
          $i = 1;
          foreach($clave1 as $valor1){ 
            $dias_atendidos=$valor1->total;
            $i++;
          }
        }
      if(count($clave) != 0){
        $i = 1;
        foreach($clave as $valor){ 
            //$asistencia=$valor->racion-$valor->asistencias;
          // Calcula el número de días inasistidos
        $dias_inasistidos = $dias_atendidos - $valor->asistencias;

        // Determina el color de fondo y el borde basado en el valor de $dias_inasistidos
        if ($dias_inasistidos >= 5) {
            $color_fondo = '#f8d7da'; // Rojo claro
            $borde = '5px solid #ffffff'; // Borde rojo claro
        } elseif ($dias_inasistidos >= 3) {
            $color_fondo = '#fff3cd'; // Amarillo claro
            $borde = '5px solid #ffffff'; // Borde amarillo claro
        } else {
            $color_fondo = '#d4edda'; // Verde claro
            $borde = '5px solid #ffffff'; // Borde verde claro
        }

        // Imprime la fila de la tabla con el color de fondo y el borde aplicados
        echo "
        <tr style='background-color: $color_fondo; border-bottom: black;'>
            <td class='text-center'>$valor->dni</td>
            <td class='text-center'>$valor->nombres</td>
            <td class='text-center'>$valor->aPaterno $valor->aMaterno</td>
            <td class='text-center'>$valor->descripcion</td>
            <td class='text-center'>$dias_atendidos</td>
            <td class='text-center'>$valor->asistencias</td>
            <td class='text-center'>$dias_inasistidos</td>
        </tr>
        ";
          $i++;
        }
      }
    }

    //op que  filtra los reportes por fechas de la vista anterior
    if($_GET['op'] == 'ListarAsistenciaDesayunoFecha'){    
      $clave1 = $asistencia->Asistencia_dias_atendidos([
        'anio' => $_GET['anio'],
        'mes' => $_GET['mes']
        ]);
      if(count($clave1) != 0){
        $i = 1;
        foreach($clave1 as $valor1){ 
          $dias_atendidos=$valor1->total;
          $i++;
        }
      }
      $clave = $asistencia->ListarAsistenciaDesayunoFecha([
     'anio' => $_GET['anio'],
     'mes' => $_GET['mes']
     ]);       
      $i = 1;
      foreach($clave as $valor){
          //$asistencia=$valor->racion-$valor->asistencias;
          // Calcula el número de días inasistidos
      $dias_inasistidos = $dias_atendidos - $valor->asistencias;
      // Determina el color de fondo y el borde basado en el valor de $dias_inasistidos
      if ($dias_inasistidos >= 5) {
          $color_fondo = '#f8d7da'; // Rojo claro
      } elseif ($dias_inasistidos >= 3) {
          $color_fondo = '#fff3cd'; // Amarillo claro
      } else {
          $color_fondo = '#d4edda'; // Verde claro
      }
      // Imprime la fila de la tabla con el color de fondo y el borde aplicados
      echo "
      <tr style='background-color: $color_fondo; border-bottom: black;'>
          <td class='text-center'>$valor->dni</td>
          <td class='text-center'>$valor->nombres</td>
          <td class='text-center'>$valor->aPaterno $valor->aMaterno</td>
          <td class='text-center'>$valor->descripcion</td>
          <td class='text-center'>$dias_atendidos</td>
          <td class='text-center'>$valor->asistencias</td>
          <td class='text-center'>$dias_inasistidos</td>
      </tr>
      ";
         $i++;
     }
 }
}
?>