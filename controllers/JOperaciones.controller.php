<?php
session_start();
require_once '../models/JOperaciones.php';
require_once '../models/Serverside.php';
if (isset($_GET['op'])){
  $JOperaciones = new JOperaciones();

    if($_GET['op'] == 'cargarJOperaciones'){
        $datosObtenidos = $JOperaciones->cargarJoperaciones();
        echo "<option value=''>Seleccione</option>";
        foreach($datosObtenidos as $valor){
            echo"
            <option value='$valor->idusuario'>{$valor->nombres} {$valor->apellidos}</option>
            ";
        }
    }
    
    if($_GET['op'] == 'getJOperaciones'){
        $data = $JOperaciones->getJOperaciones(["joperaciones" => $_GET['joperaciones']]);
        echo json_encode($data);
    }
    
    if($_GET['op'] == 'filtrar_JFundo_JOperaciones'){
        $id_JOperaciones=$_GET['jefeOperaciones'];
        $clave = $JOperaciones->filtrar_JFundo_JOperaciones(['jefeOperaciones' => $_GET['jefeOperaciones']]);
        $i = 1;
        foreach($clave as $valor){
            $estado="";
            if($valor->fk_jOperaciones==$id_JOperaciones){
              $estado="<label class='switch'><input id='on'data-estado_JOperaciones='$valor->idusuario' type='checkbox' checked><div class='slider round'></label>
              <input type='hidden' id='id_JOperaciones' value='$id_JOperaciones'>";
            }else{
              $estado="<label class='switch'><input id='on'data-estado_JOperaciones='$valor->idusuario' type='checkbox'><div class='slider round'></label
              ><input type='hidden' id='id_JOperaciones' value='$id_JOperaciones'>";
            }
            echo "
              <tr>
                <td class='text-center'>$valor->apellidos</td>
                <td class='text-center'>$valor->nombres</td>
                <td class='text-center'>
                  {$estado}
                </td>
              </tr>
            ";
          $i++;
        }
    }
    if($_GET['op']  == 'listarJefeFundo'){
        $clave = $JOperaciones->listarJefeFundo();
        if(count($clave) != 0){
        $i = 1;
            foreach($clave as $valor){
                $estado="";
                if($valor->fk_jOperaciones!=null){
                $estado="<label class='switch'><input id='on' type='checkbox' checked><div class='slider round'></label>";
                }else{
                $estado="<label class='switch'><input id='on' type='checkbox'><div class='slider round'></label>";
                }
                echo "
                <tr>
                    <td class='text-center'>$valor->apellidos</td>
                    <td class='text-center'>$valor->nombres</td>
                    <td class='text-center'>
                    {$estado}
                    </td>
                </tr>
                ";
                $i++;
            }
        }
    }

    if($_GET['op']== 'desasignarJOperaciones'){
        $JOperaciones->desasignarJOperaciones([
            "JOperaccionesasignar" => $_GET["JOperaccionesasignar"]
        ]);
      }
      
    if($_GET['op'] == 'asignarJOperaciones'){
        $JOperaciones->asignarJOperaciones([
            "JOperaccionesasignar" => $_GET["JOperaccionesasignar"],
            "id_JOperaciones" => $_GET["id_JOperaciones"]
        ]);
      }
   
}
?>