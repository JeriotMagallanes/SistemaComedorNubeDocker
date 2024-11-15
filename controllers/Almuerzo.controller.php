<?php
session_start();

require_once '../models/Almuerzo.php';

if (isset($_GET['op'])){

  $almuerzo = new Almuerzo();

    if($_GET['op'] == 'registrarAlmuerzo'){
        $almuerzo->registrarAlmuerzo([
            'fecha' => $_GET['fecha'],
            'desayuno' => $_GET['desayuno'],
            'almuerzo' => $_GET['almuerzo'],
            'cena' => $_GET['cena'],
            'rdesayuno' => $_GET['rdesayuno'],
            'ralmuerzo' => $_GET['ralmuerzo'],
            'rcena' => $_GET['rcena']
        ]);
    }

    if($_GET['op']  == 'ListarAlmuerzo'){              
      $clave = $almuerzo->ListarAlmuerzo();
  
      if(count($clave) != 0){
        $i = 1;
        foreach($clave as $valor){ 
          echo "
            <tr>
              <td class='text-center'>$valor->fecha</td>
              <td class='text-center'>$valor->desayuno</td>
              <td class='text-center'>$valor->almuerzo</td>
              <td class='text-center'>$valor->cena</td>
              <td class='text-center'>$valor->rdesayuno</td>
              <td class='text-center'>$valor->ralmuerzo</td>
              <td class='text-center'>$valor->rcena</td>
              <td class='text-center'>
                <a  href='#' data-idcomida='{$valor->idAlmuerzo}' class='btn btn-sm btn-outline-secondary modificar'>
                  <i class='fas fa-edit'></i>
                </a>
              </td>
            </tr>
          ";
          $i++;
        }
      }
    }

    if($_GET['op'] == 'modificarAlmuerzo'){
      $almuerzo->modificarAlmuerzo([
        "idcomida" => $_GET['idcomida'],
        "fecha" => $_GET['fecha'],
        "desayuno" => $_GET['desayuno'],
        "almuerzo" => $_GET['almuerzo'],
        "cena" => $_GET['cena'],
        "rdesayuno" => $_GET['rdesayuno'],
        "ralmuerzo" => $_GET['ralmuerzo'],
        "rcena" => $_GET['rcena']
      ]);
    }

    if($_GET['op'] == 'getAlmuerzo'){
      $data = $almuerzo->getAlmuerzo(["idcomida" => $_GET['idcomida']]);
      echo json_encode($data);
    }


}
?>