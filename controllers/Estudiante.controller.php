<?php
session_start();

require_once '../models/Estudiante.php';

if (isset($_GET['op'])){

  $estudiante = new Estudiante();

  if ($_GET['op'] == 'nombreestudianteYaRegistrado'){
    $datosObtenidos = $estudiante->nombreestudianteYaRegistrado(["dniestudiante" => $_GET['dniestudiante']]);

    if(count($datosObtenidos) == 0){
      echo 2;
      return true;
    }
    else{
      echo 1;
      return false;
    }
  }

  if ($_GET['op'] == 'registrarEstudiantes') {
    try {
        $estudiante->RegistrarEstudiantes([
            "coduniversitario" => $_GET['coduniversitario'],
            "dni" => $_GET['dni'],
            "nombres" => $_GET['nombres'],
            "apaterno" => $_GET['apaterno'],
            "amaterno" => $_GET['amaterno'],
            "carrera" => $_GET['carrera'],
            "desayuno" => $_GET['desayuno'],
            "almuerzo" => $_GET['almuerzo'],
            "cena" => $_GET['cena'],
        ]);
        // Redirigir o mostrar un mensaje de éxito
        echo "Estudiante registrado exitosamente.";
    } catch (Exception $e) {
        // Mostrar el mensaje de error
        echo "Error al registrar estudiante: " . $e->getMessage();
    }
}

  if ($_GET['op'] == 'listarEstudiantes') {
    $clave = $estudiante->listarEstudiantes();

    if (count($clave) != 0) {
        $i = 1;
        foreach ($clave as $valor) {
            $estado = "";
            if($valor->desayuno==1){
              $desayuno='Si';
            }else{$desayuno='No';}
            if($valor->almuerzo==1){
              $almuerzo='Si';
            }else{$almuerzo='No';}
            if($valor->cena==1){
              $cena='Si';
            }else{$cena='No';}
            if ($valor->estado == "A") {
                $estado = "<label class='switch'><input id='on' data-idestudiante='$valor->id' type='checkbox' checked><div class='slider round'></div></label>";
            } else {
                $estado = "<label class='switch'><input id='on' data-idestudiante='$valor->id' type='checkbox'><div class='slider round'></div></label>";
            }
            echo "
            <tr>
                <td class='text-center'>$valor->id</td>
                <td class='text-center'>$valor->cUniversitario</td>
                <td class='text-center'>$valor->dni</td>
                <td class='text-center'>$valor->nombres</td>
                <td class='text-center'>$valor->aPaterno $valor->aMaterno</td>
                <td class='text-center'>$valor->descripcion</td>
                <td class='text-center'>$desayuno</td>
                <td class='text-center'>$almuerzo</td>
                <td class='text-center'>$cena</td>
                <td class='text-center'>
                    <a href='#' class='btn btn-sm btn-outline-secondary modificar mr-2' data-idestudiante='{$valor->id}' data-toggle='modal' data-target='#modelId'>
                    <i class='fas fa-edit'></i></a>";

                    echo "
                    {$estado}
                </td>
            </tr>
            ";
            $i++;
        }
    }
  }


  if($_GET['op'] == 'eliminarEstudiante'){
    $estudiante->eliminarEstudiante(["idestudiante" => $_GET['idestudiante']]);
  }

  if($_GET['op'] == 'reactivarEstudiante'){
    $estudiante->reactivarEstudiante(["idestudiante" => $_GET['idestudiante']]);
  }

  if($_GET['op'] == 'modificarEstudiante'){
    $estudiante->modificarEstudiante([
      "idestudiante" => $_GET['idestudiante'],
      "coduniversitario" => $_GET['coduniversitario'],
      "dni" => $_GET['dni'],
      "nombres" => $_GET['nombres'],
      "apaterno" => $_GET['apaterno'],
      "amaterno" => $_GET['amaterno'],
      "carrera" => $_GET['carrera'],
      "desayuno" => $_GET['desayuno'],
      "almuerzo" => $_GET['almuerzo'],
      "cena" => $_GET['cena'],
    ]);
  }

  if($_GET['op'] == 'getEstudiante'){
    $data = $estudiante->getEstudiante(["idestudiante" => $_GET['idestudiante']]);
    echo json_encode($data);
  }

}
?>