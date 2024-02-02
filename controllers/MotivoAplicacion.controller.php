<?php
session_start();

require_once '../models/MotivoAplicacion.php';
require_once '../models/Serverside.php';

if (isset($_GET['op'])){

  $motivo = new Motivo();

    if($_GET['op'] == 'registrarMotivo'){
        $motivo->registrarMotivo([
            'nombremotivo' => $_GET['nombremotivo']
        ]);
    }

    if ($_GET['op'] == 'nombreMotivoYaRegistrado'){
        $datosObtenidos = $motivo->nombreMotivoYaRegistrado(["nombremotivo" => $_GET['nombremotivo']]);
    
        if(count($datosObtenidos) == 0){
          echo 2;
          return true;
        }
        else{
          echo 1;
          return false;
        }
    }

    if($_GET['op']  == 'ListarMotivos'){              
      $clave = $motivo->listarMotivo();
  
      if(count($clave) != 0){
        $i = 1;
        foreach($clave as $valor){
          $estado="";
          if($valor->estado=="A"){
            $estado="<label class='switch'><input id='on'data-motivoEstado='$valor->id_motivo' type='checkbox' checked><div class='slider round'></label>";
          }else{
            $estado="<label class='switch'><input id='on'data-motivoEstado='$valor->id_motivo' type='checkbox'><div class='slider round'></label>";
          }
          echo "
            <tr>
              <td class='text-center'>$i</td>
                <td class='text-center'>$valor->nombre_motivo</td>
              <td class='text-center'>
                <a  href='#' data-idproducto='{$valor->id_motivo}' class='btn btn-sm btn-outline-secondary modificar'>
                  <i class='fas fa-edit'></i>
                </a>
                <!--<a  href='#' data-idproducto='{$valor->id_motivo}' class='btn btn-sm btn-outline-secondary eliminar'>
                  <i class='fas fa-trash-alt'></i>
                </a>-->
              </td>
              <td class='text-center'>{$estado}</td>
            </tr>
          ";
          $i++;
        }
      }
    }
    if($_GET['op']== 'eliminarMotivo'){
      $motivo->eliminarMotivo(["motivo_estado" => $_GET["motivo_estado"]]);
    }
    
    if($_GET['op'] == 'reactivarMotivo'){
      $motivo->reactivarMotivo(["motivo_estado" => $_GET['motivo_estado']]);
    }
    if($_GET['op'] == 'modificarProducto'){
      $motivo->modificarMotivo([
        "id_motivo" => $_GET['id_motivo'],
        "nombre_motivo" => $_GET['nombre_motivo'],
      ]);
    }

    if($_GET['op'] == 'getMotivo'){
      $data = $motivo->getMotivo(["id_motivo" => $_GET['idmotivo']]);
      echo json_encode($data);
    }


}
?>