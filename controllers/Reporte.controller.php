<?php
session_start();

require_once '../models/Reporte.php';
require_once '../models/Serverside.php';

if (isset($_GET['op'])){

    $Reporte = new Reporte();
    //Op para registrar reportes 
    if($_GET['op'] == 'registrarReporte'){
        $Reporte->registrarReporte([
            'fechahoraReporte' => $_GET['fechahoraReporte'],
            'turno' => $_GET['turno'],
            'encSanidad' => $_GET['encSanidad'],
            'encQA' => $_GET['encQA'],
            'encAlmacen' => $_GET['encAlmacen'],
            'idcategoria' => $_GET['idcategoria'],
            'fundo' => $_GET['fundo'],
            'lote' => $_GET['lote'],
            's_lote' => $_GET['s_lote'],
            'cultivo' => $_GET['cultivo'],
            'variedad' => $_GET['variedad'],
            'pep' => $_GET['pep'],
            'etcultivo' => $_GET['etcultivo'],
            'fechallegada' => $_GET['fechallegada']
        ]);
    }
    //op para eliminar un reporte, opcion solo para sanidad
    if ($_GET['op'] == 'eliminarReporte') {
      $nombres = $_SESSION['nombres'];
      $apellidos = $_SESSION['apellidos'];
      $nombreapellido = $nombres . ' ' . $apellidos; // Concatenación de nombres y apellidos
      $Reporte->eliminarReportes([
          'idproducto' => $_GET['idproducto'],
      ]);
      $Reporte->registrarEliminacionReporte([
          'idproducto' => $_GET['idproducto'],
          'observacion' => $_GET['observacion'],
          'nombreapellido' => $nombreapellido,
          'datosEliminados' => $_GET['datosEliminados'],
      ]);
    }
    //op para que el jefe de fundo pueda aprobar un reporte 
    if($_GET['op']== 'aprobarreporteJfundo'){
      $Reporte->aprobarReporteJFundo(["idproducto" => $_GET["idproducto"]]);
    }
    //op para que el jefe de sanidad pueda aprobar un reporte 
    if($_GET['op']== 'aprobarreporteSanidad'){
      $Reporte->aprobarreporteSanidad([
        "idproducto" => $_GET["idproducto"],
        "id_jefe_sanidad" => $_GET["id_jefe_sanidad"]
      ]);
    }
    //op para que el jefe de calidad pueda aprobar un reporte 
    if($_GET['op']== 'aprobarreporteCalidad'){
      $Reporte->aprobarreporteCalidad([
        "idproducto" => $_GET["idproducto"]
      ]);
    }
    //op para modificar un reporte, opcion solo para sanidad
    if($_GET['op'] == 'modificarReporte'){
      $Reporte->modificarReporte([
        "idreporte" => $_GET['idreporte'],
        "encSanidad" => $_GET['encSanidad'],
        "encQA" => $_GET['encQA'],
        "encAlmacen" => $_GET['encAlmacen'],
        "idcategoria" => $_GET['idcategoria'], 
        "fundo" => $_GET['fundo'],
        "lote" => $_GET['lote'],
        "s_lote" => $_GET['s_lote'], 
        "cultivo" => $_GET['cultivo'],
        "variedad" => $_GET['variedad'],
        "nreserva" => $_GET['nreserva'],
        "ninstructivo" => $_GET['ninstructivo'], 
        "pep" => $_GET['pep'],
        "etcultivo" => $_GET['etcultivo'],
        "fechallegada" => $_GET['fechallegada']
      ]); 
    }
    if($_GET['op'] == 'modificarReporte'){
      $nombres = $_SESSION['nombres'];
      $apellidos = $_SESSION['apellidos'];
      $nombreapellido = $nombres . ' ' . $apellidos; // Concatenación de nombres y apellidos
      $Reporte->registrarModificacionReporte([
          'idreporte' => $_GET['idreporte'],
          'observacion' => $_GET['observacion'],
          'nombreapellido' => $nombreapellido,
          'antes' => $_GET['antes'],
          'despues' => $_GET['despues']
      ]);
    }
    //op para traer los datos de un reporte, opcion solo para sanidad
    if($_GET['op'] == 'getReporte'){
      $data = $Reporte->getReporte(["id_reporte" => $_GET['id_reporte']]);
      echo json_encode($data);
    }

    if($_GET['op']  == 'listarReporteAmodificar'){
      $id_reporte = $_GET['id_reporte'];              
      $clave = $Reporte->listarReporte();
      if(count($clave) != 0){
        $i = 1;
        foreach($clave as $valor){
              if ($valor->id_reporte == $id_reporte){
                echo "
                <tr class='table-primary'>
                  <td class='text-center'>$valor->id_reporte</td>
                  <td class='text-center'>$valor->fecha_hora</td>
                  <td class='text-center'>$valor->jefe_fundo</td>
                  <td class='text-center'>$valor->nombre_fundo</td>
                  <td class='text-center'>$valor->nombre_lote</td>
                  <td class='text-center'>$valor->_slote_nombre</td>
                  <td class='text-center'>$valor->nrReserva</td>
                  <td class='text-center'>$valor->nrInstructivo</td>";
                  if(($_SESSION['nivelacceso'] != 'Administrador')&&(($valor->aprob_jefefundo=='No Aprobado')&&($valor->aprob_jefesanidad=='No Aprobado'))){
                  echo "
                  <td class='text-center'>
                  <a  href='#' data-idproducto='{$valor->id_reporte}' class='btn btn-sm btn-outline-secondary detalle'>
                    <i class='fas fa-bars'></i>
                  </a>
                  </td>";}
                  if(($_SESSION['nivelacceso'] != 'Administrador')&&(($valor->aprob_jefefundo=='Aprobado')||($valor->aprob_jefesanidad=='Aprobado'))){
                    echo "
                    <td class='text-center'>
                    <a  href='#' data-idproducto='{$valor->id_reporte}' class='btn btn-sm btn-outline-secondary alerta_aprobado'>
                      <i class='fas fa-check'></i>
                    </a>
                    </td>";}
                  if(($_SESSION['nivelacceso'] == 'Administrador')){
                    echo
                    "
                  <td class='text-center'>
                    <a  href='#' data-idproducto='{$valor->id_reporte}' class='btn btn-sm btn-outline-secondary detalle'>
                      <i class='fas fa-bars'></i>
                    </a>
                  </td>
                  <td class='text-center'>
                    <a  href='#' data-idproducto='{$valor->id_reporte}' class='btn btn-sm btn-outline-secondary modificar'>
                      <i class='fas fa-edit'></i>
                    </a>
                  </td>
                  <td class='text-center'>
                    <a  href='#' data-idproducto='{$valor->id_reporte}' class='btn btn-sm btn-outline-secondary eliminar'>
                      <i class='fas fa-trash-alt'></i>
                    </a>
                  </td> 
                  ";}
              echo "</tr>";
              }else{
                echo "
                <tr >
                  <td class='text-center'>$valor->id_reporte</td>
                  <td class='text-center'>$valor->fecha_hora</td>
                  <td class='text-center'>$valor->jefe_fundo</td>
                  <td class='text-center'>$valor->nombre_fundo</td>
                  <td class='text-center'>$valor->nombre_lote</td>
                  <td class='text-center'>$valor->_slote_nombre</td>
                  <td class='text-center'>$valor->nrReserva</td>
                  <td class='text-center'>$valor->nrInstructivo</td>";
                  if(($_SESSION['nivelacceso'] != 'Administrador')&&(($valor->aprob_jefefundo=='No Aprobado')&&($valor->aprob_jefesanidad=='No Aprobado'))){
                  echo "
                  <td class='text-center'>
                  <a  href='#' data-idproducto='{$valor->id_reporte}' class='btn btn-sm btn-outline-secondary detalle'>
                    <i class='fas fa-bars'></i>
                  </a>
                  </td>";}
                  if(($_SESSION['nivelacceso'] != 'Administrador')&&(($valor->aprob_jefefundo=='Aprobado')||($valor->aprob_jefesanidad=='Aprobado'))){
                    echo "
                    <td class='text-center'>
                    <a  href='#' data-idproducto='{$valor->id_reporte}' class='btn btn-sm btn-outline-secondary alerta_aprobado'>
                      <i class='fas fa-check'></i>
                    </a>
                    </td>";}
                  if(($_SESSION['nivelacceso'] == 'Administrador')){
                    echo
                    "
                  <td class='text-center'>
                    <a  href='#' data-idproducto='{$valor->id_reporte}' class='btn btn-sm btn-outline-secondary detalle'>
                      <i class='fas fa-bars'></i>
                    </a>
                  </td>
                  <td class='text-center'>
                    <a  href='#' data-idproducto='{$valor->id_reporte}' class='btn btn-sm btn-outline-secondary modificar'>
                      <i class='fas fa-edit'></i>
                    </a>
                  </td>
                  <td class='text-center'>
                    <a  href='#' data-idproducto='{$valor->id_reporte}' class='btn btn-sm btn-outline-secondary eliminar'>
                      <i class='fas fa-trash-alt'></i>
                    </a>
                  </td> 
                  ";}
              echo "</tr>";
              }
          $i++;
        }
      }
    }
    /////////////////////7
    if($_GET['op'] == 'listarReporteAmodificarFecha'){
      $id_reporte = $_GET['id_reporte'];      
      $clave = $Reporte->filtrarFecha([
      'fechainicial' => $_GET['fechainicial'],
      'fechafinal' => $_GET['fechafinal']
      ]);
      $i = 1;
      foreach($clave as $valor){
        if ($valor->id_reporte == $id_reporte){
          echo "
          <tr class='table-primary'>
            <td class='text-center'>$valor->id_reporte</td>
            <td class='text-center'>$valor->fecha_hora</td>
            <td class='text-center'>$valor->jefe_fundo</td>
            <td class='text-center'>$valor->nombre_fundo</td>
            <td class='text-center'>$valor->nombre_lote</td>
            <td class='text-center'>$valor->_slote_nombre</td>
            <td class='text-center'>$valor->nrReserva</td>
            <td class='text-center'>$valor->nrInstructivo</td>";
            if(($_SESSION['nivelacceso'] != 'Administrador')&&(($valor->aprob_jefefundo=='No Aprobado')&&($valor->aprob_jefesanidad=='No Aprobado'))){
            echo "
            <td class='text-center'>
            <a  href='#' data-idproducto='{$valor->id_reporte}' class='btn btn-sm btn-outline-secondary detalle'>
              <i class='fas fa-bars'></i>
            </a>
            </td>";}
            if(($_SESSION['nivelacceso'] != 'Administrador')&&(($valor->aprob_jefefundo=='Aprobado')||($valor->aprob_jefesanidad=='Aprobado'))){
              echo "
              <td class='text-center'>
              <a  href='#' data-idproducto='{$valor->id_reporte}' class='btn btn-sm btn-outline-secondary alerta_aprobado'>
                <i class='fas fa-check'></i>
              </a>
              </td>";}
            if(($_SESSION['nivelacceso'] == 'Administrador')){
              echo
              "
            <td class='text-center'>
              <a  href='#' data-idproducto='{$valor->id_reporte}' class='btn btn-sm btn-outline-secondary detalle'>
                <i class='fas fa-bars'></i>
              </a>
            </td>
            <td class='text-center'>
              <a  href='#' data-idproducto='{$valor->id_reporte}' class='btn btn-sm btn-outline-secondary modificar'>
                <i class='fas fa-edit'></i>
              </a>
            </td>
            <td class='text-center'>
              <a  href='#' data-idproducto='{$valor->id_reporte}' class='btn btn-sm btn-outline-secondary eliminar'>
                <i class='fas fa-trash-alt'></i>
              </a>
            </td> 
            ";}
        echo "</tr>";
        }else{
          echo "
          <tr >
            <td class='text-center'>$valor->id_reporte</td>
            <td class='text-center'>$valor->fecha_hora</td>
            <td class='text-center'>$valor->jefe_fundo</td>
            <td class='text-center'>$valor->nombre_fundo</td>
            <td class='text-center'>$valor->nombre_lote</td>
            <td class='text-center'>$valor->_slote_nombre</td>
            <td class='text-center'>$valor->nrReserva</td>
            <td class='text-center'>$valor->nrInstructivo</td>";
            if(($_SESSION['nivelacceso'] != 'Administrador')&&(($valor->aprob_jefefundo=='No Aprobado')&&($valor->aprob_jefesanidad=='No Aprobado'))){
            echo "
            <td class='text-center'>
            <a  href='#' data-idproducto='{$valor->id_reporte}' class='btn btn-sm btn-outline-secondary detalle'>
              <i class='fas fa-bars'></i>
            </a>
            </td>";}
            if(($_SESSION['nivelacceso'] != 'Administrador')&&(($valor->aprob_jefefundo=='Aprobado')||($valor->aprob_jefesanidad=='Aprobado'))){
              echo "
              <td class='text-center'>
              <a  href='#' data-idproducto='{$valor->id_reporte}' class='btn btn-sm btn-outline-secondary alerta_aprobado'>
                <i class='fas fa-check'></i>
              </a>
              </td>";}
            if(($_SESSION['nivelacceso'] == 'Administrador')){
              echo
              "
            <td class='text-center'>
              <a  href='#' data-idproducto='{$valor->id_reporte}' class='btn btn-sm btn-outline-secondary detalle'>
                <i class='fas fa-bars'></i>
              </a>
            </td>
            <td class='text-center'>
              <a  href='#' data-idproducto='{$valor->id_reporte}' class='btn btn-sm btn-outline-secondary modificar'>
                <i class='fas fa-edit'></i>
              </a>
            </td>
            <td class='text-center'>
              <a  href='#' data-idproducto='{$valor->id_reporte}' class='btn btn-sm btn-outline-secondary eliminar'>
                <i class='fas fa-trash-alt'></i>
              </a>
            </td> 
            ";}
        echo "</tr>";
        }

        $i++;
      }
    }
    //op para listar las acciones de los reportes a la hora de crearlos en administrarreportes.php
    //se comtemplo la vista para los usuarios operador como sanidad
    if($_GET['op']  == 'ListarReportes'){              
      $clave = $Reporte->listarReporte();
      if(count($clave) != 0){
        $i = 1;
        foreach($clave as $valor){
              echo "
              <tr>
                <td class='text-center'>$valor->id_reporte</td>
                <td class='text-center'>$valor->fecha_hora</td>
                <td class='text-center'>$valor->jefe_fundo</td>
                <td class='text-center'>$valor->nombre_fundo</td>
                <td class='text-center'>$valor->nombre_lote</td>
                <td class='text-center'>$valor->_slote_nombre</td>
                <td class='text-center'>$valor->nrReserva</td>
                <td class='text-center'>$valor->nrInstructivo</td>";
                if(($_SESSION['nivelacceso'] != 'Administrador')&&(($valor->aprob_jefefundo=='No Aprobado')&&($valor->aprob_jefesanidad=='No Aprobado'))){
                echo "
                <td class='text-center'>
                <a  href='#' data-idproducto='{$valor->id_reporte}' class='btn btn-sm btn-outline-secondary detalle'>
                  <i class='fas fa-bars'></i>
                </a>
                </td>";}
                if(($_SESSION['nivelacceso'] != 'Administrador')&&(($valor->aprob_jefefundo=='Aprobado')||($valor->aprob_jefesanidad=='Aprobado'))){
                  echo "
                  <td class='text-center'>
                  <a  href='#' data-idproducto='{$valor->id_reporte}' class='btn btn-sm btn-outline-secondary alerta_aprobado'>
                    <i class='fas fa-check'></i>
                  </a>
                  </td>";}
                if(($_SESSION['nivelacceso'] == 'Administrador')){
                  echo
                  "
                <td class='text-center'>
                  <a  href='#' data-idproducto='{$valor->id_reporte}' class='btn btn-sm btn-outline-secondary detalle'>
                    <i class='fas fa-bars'></i>
                  </a>
                </td>
                <td class='text-center'>
                  <a  href='#' data-idproducto='{$valor->id_reporte}' class='btn btn-sm btn-outline-secondary modificar'>
                    <i class='fas fa-edit'></i>
                  </a>
                </td>
                <td class='text-center'>
                  <a  href='#' data-idproducto='{$valor->id_reporte}' class='btn btn-sm btn-outline-secondary eliminar'>
                    <i class='fas fa-trash-alt'></i>
                  </a>
                </td> 
                ";}
            echo "</tr>";
          $i++;
        }
      }
    }
    //Op para filtrar fechas de la vista de arriba
    if($_GET['op'] == 'filtrarFechas'){
      $clave = $Reporte->filtrarFecha([
      'fechainicial' => $_GET['fechainicial'],
      'fechafinal' => $_GET['fechafinal']
      ]);
      $i = 1;
      foreach($clave as $valor){
        echo "
        <tr>
          <td class='text-center'>$valor->id_reporte</td>
          <td class='text-center'>$valor->fecha_hora</td>
          <td class='text-center'>$valor->jefe_fundo</td>
          <td class='text-center'>$valor->nombre_fundo</td>
          <td class='text-center'>$valor->nombre_lote</td>
          <td class='text-center'>$valor->_slote_nombre</td>
          <td class='text-center'>$valor->nrReserva</td>
          <td class='text-center'>$valor->nrInstructivo</td>";
          if(($_SESSION['nivelacceso'] != 'Administrador')&&(($valor->aprob_jefefundo=='No Aprobado')&&($valor->aprob_jefesanidad=='No Aprobado'))){
          echo "
          <td class='text-center'>
          <a  href='#' data-idproducto='{$valor->id_reporte}' class='btn btn-sm btn-outline-secondary detalle'>
            <i class='fas fa-bars'></i>
          </a>
          </td>";}
          if(($_SESSION['nivelacceso'] != 'Administrador')&&(($valor->aprob_jefefundo=='Aprobado')||($valor->aprob_jefesanidad=='Aprobado'))){
            echo "
            <td class='text-center'>
            <a  href='#' data-idproducto='{$valor->id_reporte}' class='btn btn-sm btn-outline-secondary alerta_aprobado'>
              <i class='fas fa-check'></i>
            </a>
            </td>";}
          if(($_SESSION['nivelacceso'] == 'Administrador')){
            echo
            "
          <td class='text-center'>
            <a  href='#' data-idproducto='{$valor->id_reporte}' class='btn btn-sm btn-outline-secondary detalle'>
              <i class='fas fa-bars'></i>
            </a>
          </td>
          <td class='text-center'>
            <a  href='#' data-idproducto='{$valor->id_reporte}' class='btn btn-sm btn-outline-secondary modificar'>
              <i class='fas fa-edit'></i>
            </a>
          </td>
          <td class='text-center'>
            <a  href='#' data-idproducto='{$valor->id_reporte}' class='btn btn-sm btn-outline-secondary eliminar'>
              <i class='fas fa-trash-alt'></i>
            </a>
          </td> 
          ";}
      echo "</tr>";
        $i++;
      }
    }
    //op para listar los productos generales en vistageneralreportes.php
    if($_GET['op']  == 'ListarReportesGeneralAdministrador'){              
      $clave = $Reporte->listarReporteAdministrador();
  
      if(count($clave) != 0){
        $i = 1;
        foreach($clave as $valor){
          echo "
            <tr>
              <td class='text-center'>$valor->id_reporte</td>
              <td class='text-center'>$valor->fecha_hora</td>
              <td class='text-center'>$valor->turno</td>
              <td class='text-center'>$valor->jefe_fundo</td>
              <td class='text-center'>$valor->nombre_fundo</td>
              <td class='text-center'>{$valor->nombre_lote} ({$valor->_slote_nombre})</td>
              <td class='text-center'>{$valor->nombre_cultivo} ({$valor->nombre_variedad})</td>
              <td class='text-center'>$valor->nrReserva</td>
              <td class='text-center'>$valor->nrInstructivo</td>
              <td class='text-center'>$valor->nombre_motivo</td>
              <td class='text-center'>$valor->nombre_producto</td>
              <td class='text-center'>$valor->dosiscil</td>
              <td class='text-center'>$valor->ncil</td>
              <td class='text-center'>$valor->dosistanque</td>
              <td class='text-center'>$valor->totalproducto</td>
              <td class='text-center'>$valor->dosisHA</td>
              <td class='text-center'>$valor->HAaplicada</td>
              </tr>"
          ;
          $i++;
        }
      }
    }
    //op para filtrar las fechas de la vista de arriba
    if($_GET['op'] == 'filtrarFechasAdministrador'){
      $clave = $Reporte->filtrarFechaAdministrador([
      'fechainicial' => $_GET['fechainicial'],
      'fechafinal' => $_GET['fechafinal']
      ]);
      $i = 1;
      foreach($clave as $valor){
       
        echo "
        <tr>
          <td class='text-center'>$valor->id_reporte</td>
          <td class='text-center'>$valor->fecha_hora</td>
          <td class='text-center'>$valor->turno</td>
          <td class='text-center'>$valor->jefe_fundo</td>
          <td class='text-center'>$valor->nombre_fundo</td>
          <td class='text-center'>{$valor->nombre_lote} ({$valor->_slote_nombre})</td>
          <td class='text-center'>{$valor->nombre_cultivo} ({$valor->nombre_variedad})</td>
          <td class='text-center'>$valor->nrReserva</td>
          <td class='text-center'>$valor->nrInstructivo</td>
          <td class='text-center'>$valor->nombre_motivo</td>
          <td class='text-center'>$valor->nombre_producto</td>
          <td class='text-center'>$valor->dosiscil</td>
          <td class='text-center'>$valor->ncil</td>
          <td class='text-center'>$valor->dosistanque</td>
          <td class='text-center'>$valor->totalproducto</td>
          <td class='text-center'>$valor->dosisHA</td>
          <td class='text-center'>$valor->HAaplicada</td>
          </tr>"
      ;
        $i++;
      }
    }
    //op para listar los reportes para el usuario de calidad en la vista vistacalidadreporte.php
    if($_GET['op']  == 'ListarReportesCalidad'){              
      $clave = $Reporte->listarReporteCalidad();
      if(count($clave) != 0){
        $i = 1;
        foreach($clave as $valor){
          if($valor->aprob_jefeCalidad=='Aprobado'){
            $estadojefeCalidad='aprobado.png';
          }else{
            $estadojefeCalidad='no_aprobado.png';
          }
          echo "
            <tr>
              <td class='text-center'>$valor->id_reporte</td>
              <td class='text-center'>$valor->fecha_hora</td>
              <td class='text-center'>$valor->jefe_fundo</td>
              <td class='text-center'>$valor->nombre_fundo</td>
              <td class='text-center'>$valor->nombre_lote</td>
              <td class='text-center'>$valor->_slote_nombre</td>
              <td class='text-center'>$valor->nrReserva</td>
              <td class='text-center'>$valor->nrInstructivo</td>
              <td class='text-center align-middle'>
              <img src='images/$estadojefeCalidad' alt='Aprobado' width='50'>
              </td>
              <td class='text-center'>
                <a style='margin-top: 20px;  href='#' data-idproducto='{$valor->id_reporte}' class='btn btn-sm btn-outline-secondary detalle'>
                  <i class='fas fa-bars'></i>
                </a>
              </td>
              <td class='text-center'>
                <a  style='margin-top: 20px;  href='#' data-idproducto='{$valor->id_reporte}' class='btn btn-sm btn-outline-secondary aprobar'>
                  <i class='fas fa-check'></i>
                </a>
              </td>
              <td class='text-center'>";
                if($valor->aprob_jefeCalidad=='Aprobado'){
                  echo "
                  <form style='margin-top: 20px; id='{$valor->id_reporte}' action='views/generarPdfCalidad.php' method='post' target='_blank'>
                    <input type='hidden' name='reporte_id'  value='{$valor->id_reporte}'>
                    <button class='btn btn-sm btn-outline-secondary' type='submit'><i class='fas fa-file-pdf'></i></button>
                  </form>";
                }
                echo "
              </td>
              </tr>";
          $i++;
        }
      }
    }
    //op para filtrar las fechas de la vista de arriba
    if($_GET['op'] == 'filtrarFechasCalidad'){
      $clave = $Reporte->filtrarFechaCalidad([
      'fechainicial' => $_GET['fechainicial'],
      'fechafinal' => $_GET['fechafinal']
      ]);
      $i = 1;
      foreach($clave as $valor){
        if($valor->aprob_jefeCalidad=='Aprobado'){
          $estadojefeCalidad='aprobado.png';
        }else{
          $estadojefeCalidad='no_aprobado.png';
        }
        echo "
          <tr>
            <td class='text-center'>$valor->id_reporte</td>
            <td class='text-center'>$valor->fecha_hora</td>
            <td class='text-center'>$valor->jefe_fundo</td>
            <td class='text-center'>$valor->nombre_fundo</td>
            <td class='text-center'>$valor->nombre_lote</td>
            <td class='text-center'>$valor->_slote_nombre</td>
            <td class='text-center'>$valor->nrReserva</td>
            <td class='text-center'>$valor->nrInstructivo</td>
            <td class='text-center align-middle'>
            <img src='images/$estadojefeCalidad' alt='Aprobado' width='50'>
            </td>
            <td class='text-center'>
              <a style='margin-top: 20px;  href='#' data-idproducto='{$valor->id_reporte}' class='btn btn-sm btn-outline-secondary detalle'>
                <i class='fas fa-bars'></i>
              </a>
            </td>
            <td class='text-center'>
              <a  style='margin-top: 20px;  href='#' data-idproducto='{$valor->id_reporte}' class='btn btn-sm btn-outline-secondary aprobar'>
                <i class='fas fa-check'></i>
              </a>
            </td>
            <td class='text-center'>";
              if($valor->aprob_jefeCalidad=='Aprobado'){
                echo "
                <form style='margin-top: 20px; id='{$valor->id_reporte}' action='views/generarPdfCalidad.php' method='post' target='_blank'>
                  <input type='hidden' name='reporte_id'  value='{$valor->id_reporte}'>
                  <button class='btn btn-sm btn-outline-secondary' type='submit'><i class='fas fa-file-pdf'></i></button>
                </form>";
              }
              echo "
            </td>
            </tr>";
        $i++;
      }
    }
    //op para listar los reportes para el usuario operador en la vista vistareporte.php
    if($_GET['op']  == 'ListarReportesOperario'){              
      $clave = $Reporte->listarReporte();
  
      if(count($clave) != 0){
        $i = 1;
        foreach($clave as $valor){
          if($valor->aprob_jefefundo=='Aprobado'){
            $estadojefefundo='aprobado.png';
          }else{
            $estadojefefundo='no_aprobado.png';
          }
          if($valor->aprob_jefesanidad=='Aprobado'){
            $estadojefesanidad='aprobado.png';
          }else{
            $estadojefesanidad='no_aprobado.png';
          }
          echo "
            <tr>
              <td class='text-center'>$valor->id_reporte</td>
              <td class='text-center'>$valor->fecha_hora</td>
              <td class='text-center'>$valor->jefe_fundo</td>
              <td class='text-center'>$valor->nombre_fundo</td>
              <td class='text-center'>$valor->nombre_lote</td>
              <td class='text-center'>$valor->_slote_nombre</td>
              <td class='text-center'>$valor->nrReserva</td>
              <td class='text-center'>$valor->nrInstructivo</td>
              <td class='text-center align-middle'>
              <img src='images/$estadojefefundo' alt='Aprobado' width='50'>
              </td>
              <td class='text-center align-middle'>
              <img src='images/$estadojefesanidad' alt='Aprobado' width='50'>
              </td>
              <td class='text-center'>
                <a  style='margin-top: 20px;' href='#' data-idproducto='{$valor->id_reporte}' class='btn btn-sm btn-outline-secondary detalle'>
                  <i class='fas fa-bars'></i>
                </a>
              </td>
              <td class='text-center'>";
                if($valor->aprob_jefefundo=='Aprobado'&& $valor->aprob_jefesanidad=='Aprobado'){
                  echo "
                  <form style='margin-top: 20px; id='{$valor->id_reporte}' action='views/generarPdf.php' method='post' target='_blank'>
                    <input type='hidden' name='reporte_id'  value='{$valor->id_reporte}'>
                    <button class='btn btn-sm btn-outline-secondary' type='submit'><i class='fas fa-file-pdf'></i></button>
                  </form>";
                }
                echo "
              </td>
              </tr>"
          ;
          $i++;
        }
      }
    }
    //op para filtrar las fechas de la vista de arriba
    if($_GET['op'] == 'filtrarFechasOperario'){
      $clave = $Reporte->filtrarFecha([
      'fechainicial' => $_GET['fechainicial'],
      'fechafinal' => $_GET['fechafinal']
      ]);
      if(count($clave) != 0){
        $i = 1;
        foreach($clave as $valor){
          if($valor->aprob_jefefundo=='Aprobado'){
            $estadojefefundo='aprobado.png';
          }else{
            $estadojefefundo='no_aprobado.png';
          }
          if($valor->aprob_jefesanidad=='Aprobado'){
            $estadojefesanidad='aprobado.png';
          }else{
            $estadojefesanidad='no_aprobado.png';
          }
          echo "
            <tr>
              <td class='text-center'>$valor->id_reporte</td>
              <td class='text-center'>$valor->fecha_hora</td>
              <td class='text-center'>$valor->jefe_fundo</td>
              <td class='text-center'>$valor->nombre_fundo</td>
              <td class='text-center'>$valor->nombre_lote</td>
              <td class='text-center'>$valor->_slote_nombre</td>
              <td class='text-center'>$valor->nrReserva</td>
              <td class='text-center'>$valor->nrInstructivo</td>
              <td class='text-center align-middle'>
              <img src='images/$estadojefefundo' alt='Aprobado' width='50'>
              </td>
              <td class='text-center align-middle'>
              <img src='images/$estadojefesanidad' alt='Aprobado' width='50'>
              </td>
              <td class='text-center'>
                <a  style='margin-top: 20px;' href='#' data-idproducto='{$valor->id_reporte}' class='btn btn-sm btn-outline-secondary detalle'>
                  <i class='fas fa-bars'></i>
                </a>
              </td>
              <td class='text-center'>";
                if($valor->aprob_jefefundo=='Aprobado'&& $valor->aprob_jefesanidad=='Aprobado'){
                  echo "
                  <form style='margin-top: 20px; id='{$valor->id_reporte}' action='views/generarPdf.php' method='post' target='_blank'>
                    <input type='hidden' name='reporte_id'  value='{$valor->id_reporte}'>
                    <button class='btn btn-sm btn-outline-secondary' type='submit'><i class='fas fa-file-pdf'></i></button>
                  </form>";
                }
                echo "
              </td>
              </tr>"
          ;
          $i++;
        }
      }
    }
    //op que muestra los reportes de cada jefe de fundo en este caso
    //para los administradores    
    if($_GET['op']  == 'ListarReportesJFundo'){              
      $clave = $Reporte->listarReporte();
      if(count($clave) != 0){
        $i = 1;
        foreach($clave as $valor){
          if($valor->aprob_jefefundo=='Aprobado'){
            $estadojefefundo='aprobado.png';
          }else{
            $estadojefefundo='no_aprobado.png';
          }
          echo "
            <tr>
              <td class='text-center'>$valor->id_reporte</td>
              <td class='text-center'>$valor->fecha_hora</td>
              <td class='text-center'>$valor->jefe_fundo</td>
              <td class='text-center'>$valor->nombre_fundo</td>
              <td class='text-center'>$valor->nombre_lote</td>
              <td class='text-center'>$valor->_slote_nombre</td>
              <td class='text-center'>$valor->nrReserva</td>
              <td class='text-center'>$valor->nrInstructivo</td>
              <td class='text-center align-middle'>
              <img src='images/$estadojefefundo' alt='Aprobado' width='50'>
              </td>
              <td class='text-center'>
                <a  style='margin-top: 20px;  href='#' data-idproducto='{$valor->id_reporte}' class='btn btn-sm btn-outline-secondary detalle'>
                  <i class='fas fa-bars'></i>
                </a>
              </td>
              <td class='text-center'>
                <a  style='margin-top: 20px;  href='#' data-idproducto='{$valor->id_reporte}' class='btn btn-sm btn-outline-secondary aprobar'>
                  <i class='fas fa-check'></i>
                </a>
              </td>
              <td class='text-center'>";
                if($valor->aprob_jefefundo=='Aprobado'&& $valor->aprob_jefesanidad=='Aprobado'){
                  echo "
                  <form style='margin-top: 20px; id='{$valor->id_reporte}' action='views/generarPdf.php' method='post' target='_blank'>
                    <input type='hidden' name='reporte_id'  value='{$valor->id_reporte}'>
                    <button class='btn btn-sm btn-outline-secondary' type='submit'><i class='fas fa-file-pdf'></i></button>
                  </form>";
                }
                echo "
              </td>
              </tr>"
          ;
          $i++;
        }
      }
    }
    /*op que muestra el listtado de los reportes pero solo para cada jefe de fundo en especial*/ 
    if($_GET['op']  == 'ListarPorJefeReportesJFundo'){  
      $clave = $Reporte->ListarReportesPorJefeFundo([
        'id_jefe_fundo' => $_GET['id_jefe_fundo'],
      ]);
        $i = 1;
        foreach($clave as $valor){
          if($valor->aprob_jefefundo=='Aprobado'){
            $estadojefefundo='aprobado.png';
          }else{
            $estadojefefundo='no_aprobado.png';
          }
          echo "
            <tr>
              <td class='text-center'>$valor->id_reporte</td>
              <td class='text-center'>$valor->fecha_hora</td>
              <td class='text-center'>$valor->jefe_fundo</td>
              <td class='text-center'>$valor->nombre_fundo</td>
              <td class='text-center'>$valor->nombre_lote</td>
              <td class='text-center'>$valor->_slote_nombre</td>
              <td class='text-center'>$valor->nrReserva</td>
              <td class='text-center'>$valor->nrInstructivo</td>
              <td class='text-center align-middle'>
              <img src='images/$estadojefefundo' alt='Aprobado' width='50'>
              </td>
              <td class='text-center'>
                <a  style='margin-top: 20px;  href='#' data-idproducto='{$valor->id_reporte}' class='btn btn-sm btn-outline-secondary detalle'>
                  <i class='fas fa-bars'></i>
                </a>
              </td>
              <td class='text-center'>
                <a  style='margin-top: 20px;  href='#' data-idproducto='{$valor->id_reporte}' class='btn btn-sm btn-outline-secondary aprobar'>
                  <i class='fas fa-check'></i>
                </a>
              </td>
              <td class='text-center'>";
                if($valor->aprob_jefefundo=='Aprobado'&& $valor->aprob_jefesanidad=='Aprobado'){
                  echo "
                  <form style='margin-top: 20px; id='{$valor->id_reporte}' action='views/generarPdf.php' method='post' target='_blank'>
                    <input type='hidden' name='reporte_id'  value='{$valor->id_reporte}'>
                    <button class='btn btn-sm btn-outline-secondary' type='submit'><i class='fas fa-file-pdf'></i></button>
                  </form>";
                }
                echo "
              </td>
              ";
            echo "</tr>
          ";
          $i++;
        }
    }

    if($_GET['op']  == 'ListarPorJefeReportesJOperaciones'){  
      $clave = $Reporte->ListarPorJefeReportesJOperaciones([
        'id_jefe_operaciones' => $_GET['id_jefe_operaciones'],
      ]);
        $i = 1;
        foreach($clave as $valor){
          if($valor->aprob_jefefundo=='Aprobado'){
            $estadojefefundo='aprobado.png';
          }else{
            $estadojefefundo='no_aprobado.png';
          }
          echo "
            <tr>
              <td class='text-center'>$valor->id_reporte</td>
              <td class='text-center'>$valor->fecha_hora</td>
              <td class='text-center'>$valor->jefe_fundo</td>
              <td class='text-center'>$valor->nombre_fundo</td>
              <td class='text-center'>$valor->nombre_lote</td>
              <td class='text-center'>$valor->_slote_nombre</td>
              <td class='text-center'>$valor->nrReserva</td>
              <td class='text-center'>$valor->nrInstructivo</td>
              <td class='text-center align-middle'>
              <img src='images/$estadojefefundo' alt='Aprobado' width='50'>
              </td>
              <td class='text-center'>
                <a  style='margin-top: 20px;  href='#' data-idproducto='{$valor->id_reporte}' class='btn btn-sm btn-outline-secondary detalle'>
                  <i class='fas fa-bars'></i>
                </a>
              </td>
              <td class='text-center'>
                <a  style='margin-top: 20px;  href='#' data-idproducto='{$valor->id_reporte}' class='btn btn-sm btn-outline-secondary aprobar'>
                  <i class='fas fa-check'></i>
                </a>
              </td>
              <td class='text-center'>";
                if($valor->aprob_jefefundo=='Aprobado'&& $valor->aprob_jefesanidad=='Aprobado'){
                  echo "
                  <form style='margin-top: 20px; id='{$valor->id_reporte}' action='views/generarPdf.php' method='post' target='_blank'>
                    <input type='hidden' name='reporte_id'  value='{$valor->id_reporte}'>
                    <button class='btn btn-sm btn-outline-secondary' type='submit'><i class='fas fa-file-pdf'></i></button>
                  </form>";
                }
                echo "
              </td>
              ";
            echo "</tr>
          ";
          $i++;
        }
    }

    //op que filtra las fechas para jefe de funso y administrador segund su nivel de acceso
    if($_GET['op'] == 'filtrarFechasJFundo'){
      $id_jefefundo=$_SESSION['idusuario'] ;
      $nivelacceso=$_SESSION['nivelacceso'];
      $clave = $Reporte->filtrarFechaJFundoAdmiinistrar([
        'fechainicial' => $_GET['fechainicial'],
        'fechafinal' => $_GET['fechafinal']
        ]);
      if($nivelacceso=='Jefe de Fundo'){
      $clave = $Reporte->filtrarFechaJFundo([
        'fechainicial' => $_GET['fechainicial'],
        'fechafinal' => $_GET['fechafinal'],
        'id_jefefundo' => $id_jefefundo
        ]);
      }
      if($nivelacceso=='Jefe de Operaciones'){
        $clave = $Reporte->filtrarFechaJOperaciones([
          'fechainicial' => $_GET['fechainicial'],
          'fechafinal' => $_GET['fechafinal'],
          'id_jefeOperaciones' => $id_jefefundo
          ]);
        }
      $i = 1;
      foreach($clave as $valor){
        if($valor->aprob_jefefundo=='Aprobado'){
          $estadojefefundo='aprobado.png';
        }else{
          $estadojefefundo='no_aprobado.png';
        }
        if($valor->aprob_jefesanidad=='Aprobado'){
          $estadojefesanidad='aprobado.png';
        }else{
          $estadojefesanidad='no_aprobado.png';
        }
        echo "
          <tr>
            <td class='text-center'>$valor->id_reporte</td>
            <td class='text-center'>$valor->fecha_hora</td>
            <td class='text-center'>$valor->jefe_fundo</td>
            <td class='text-center'>$valor->nombre_fundo</td>
            <td class='text-center'>$valor->nombre_lote</td>
            <td class='text-center'>$valor->_slote_nombre</td>
            <td class='text-center'>$valor->nrReserva</td>
            <td class='text-center'>$valor->nrInstructivo</td>
            <td class='text-center align-middle'>
            <img src='images/$estadojefefundo' alt='Aprobado' width='50'>
            </td>
            <td class='text-center'>
              <a style='margin-top: 20px;  href='#' data-idproducto='{$valor->id_reporte}' class='btn btn-sm btn-outline-secondary detalle'>
                <i class='fas fa-bars'></i>
              </a>
            </td>
            <td class='text-center'>
              <a style='margin-top: 20px;  href='#' data-idproducto='{$valor->id_reporte}' class='btn btn-sm btn-outline-secondary aprobar'>
                <i class='fas fa-check'></i>
              </a>
            </td>
            <td class='text-center'>";
              if($valor->aprob_jefefundo=='Aprobado'&& $valor->aprob_jefesanidad=='Aprobado'){
                echo "
                <form style='margin-top: 20px; id='{$valor->id_reporte}' action='views/generarPdf.php' method='post' target='_blank'>
                  <input type='hidden' name='reporte_id'  value='{$valor->id_reporte}'>
                  <button class='btn btn-sm btn-outline-secondary' type='submit'><i class='fas fa-file-pdf'></i></button>
                </form>";
              }
              echo "
            </td>
            </tr>
        ";
        $i++;
      }
    }

    //op que lista los reportes para ser aprobado por los de sanidad o administradores
    if($_GET['op']  == 'ListarReportesSanidadAdministrador'){              
      $clave = $Reporte->listarReporte();
      if(count($clave) != 0){
        $i = 1;
        foreach($clave as $valor){
          if($valor->aprob_jefefundo=='Aprobado'){
            $estadojefefundo='aprobado.png';
          }else{
            $estadojefefundo='no_aprobado.png';
          }
          if($valor->aprob_jefesanidad=='Aprobado'){
            $estadojefesanidad='aprobado.png';
          }else{
            $estadojefesanidad='no_aprobado.png';
          }
          echo "
            <tr>
              <td class='text-center'>$valor->id_reporte</td>
              <td class='text-center'>$valor->fecha_hora</td>
              <td class='text-center'>$valor->jefe_fundo</td>
              <td class='text-center'>$valor->nombre_fundo</td>
              <td class='text-center'>$valor->nombre_lote</td>
              <td class='text-center'>$valor->_slote_nombre</td>
              <td class='text-center'>$valor->nrReserva</td>
              <td class='text-center'>$valor->nrInstructivo</td>
              <td class='text-center align-middle'>
              <img src='images/$estadojefefundo' alt='Aprobado' width='50'>
              </td>
              <td class='text-center align-middle'>
              <img src='images/$estadojefesanidad' alt='Aprobado' width='50'>
              </td>
              <td class='text-center'>
                <a style='margin-top: 20px;  href='#' data-idproducto='{$valor->id_reporte}' class='btn btn-sm btn-outline-secondary detalle'>
                  <i class='fas fa-bars'></i>
                </a>
              </td>
              <td class='text-center'>
                <a style='margin-top: 20px;  href='#' data-idproducto='{$valor->id_reporte}' class='btn btn-sm btn-outline-secondary aprobar'>
                  <i class='fas fa-check'></i>
                </a>
              </td>
              <td class='text-center'>";
                if($valor->aprob_jefefundo=='Aprobado'&& $valor->aprob_jefesanidad=='Aprobado'&&$valor->aprob_jefeCalidad=='No Aprobado'){
                  echo "
                  <form style='margin-top: 20px; id='{$valor->id_reporte}' action='views/generarPdf.php' method='post' target='_blank'>
                    <input type='hidden' name='reporte_id'  value='{$valor->id_reporte}'>
                    <button class='btn btn-sm btn-outline-secondary' type='submit'><i class='fas fa-file-pdf'></i></button>
                  </form>";
                }
                
                if($valor->aprob_jefefundo=='Aprobado'&& $valor->aprob_jefesanidad=='Aprobado'&&$valor->aprob_jefeCalidad=='Aprobado'){
                  echo "
                  <form style='margin-top: 20px; id='{$valor->id_reporte}' action='views/generarPdfCalidad.php' method='post' target='_blank'>
                    <input type='hidden' name='reporte_id'  value='{$valor->id_reporte}'>
                    <button class='btn btn-sm btn-outline-secondary' type='submit'><i class='fas fa-file-pdf'></i></button>
                  </form>";
                }
                echo "
              </td>
              ";
            echo "
              </tr>"
          ;
          $i++;
        }
      }
    }

    //op que  filtra los reportes por fechas de la vista anterior
    if($_GET['op'] == 'filtrarFechasSanidad'){
      $clave = $Reporte->filtrarFecha([
      'fechainicial' => $_GET['fechainicial'],
      'fechafinal' => $_GET['fechafinal']
     ]);
      $i = 1;
      foreach($clave as $valor){
        if($valor->aprob_jefefundo=='Aprobado'){
          $estadojefefundo='aprobado.png';
        }else{
          $estadojefefundo='no_aprobado.png';
        }
        if($valor->aprob_jefesanidad=='Aprobado'){
          $estadojefesanidad='aprobado.png';
        }else{
          $estadojefesanidad='no_aprobado.png';
        }
        echo "
          <tr>
            <td class='text-center'>$valor->id_reporte</td>
            <td class='text-center'>$valor->fecha_hora</td>
            <td class='text-center'>$valor->jefe_fundo</td>
            <td class='text-center'>$valor->nombre_fundo</td>
            <td class='text-center'>$valor->nombre_lote</td>
            <td class='text-center'>$valor->_slote_nombre</td>
            <td class='text-center'>$valor->nrReserva</td>
            <td class='text-center'>$valor->nrInstructivo</td>
            <td class='text-center align-middle'>
            <img src='images/$estadojefefundo' alt='Aprobado' width='50'>
            </td>
            <td class='text-center align-middle'>
            <img src='images/$estadojefesanidad' alt='Aprobado' width='50'>
            </td>
            <td class='text-center'>
              <a  style='margin-top: 20px; href='#' data-idproducto='{$valor->id_reporte}' class='btn btn-sm btn-outline-secondary detalle'>
                <i class='fas fa-bars'></i>
              </a>
            </td>
            <td class='text-center'>
              <a  style='margin-top: 20px;  href='#' data-idproducto='{$valor->id_reporte}' class='btn btn-sm btn-outline-secondary aprobar'>
                <i class='fas fa-check'></i>
              </a>
            </td>
            <td class='text-center'>";
              if($valor->aprob_jefefundo=='Aprobado'&& $valor->aprob_jefesanidad=='Aprobado'){
                echo "
                <form style='margin-top: 20px; id='{$valor->id_reporte}' action='views/generarPdf.php' method='post' target='_blank'>
                  <input type='hidden' name='reporte_id'  value='{$valor->id_reporte}'>
                  <button class='btn btn-sm btn-outline-secondary' type='submit'><i class='fas fa-file-pdf'></i></button>
                </form>";
              }
              echo "
            </td>
            </tr>
        ";
        $i++;
      }
    }

    if($_GET['op']  == 'ListarLlegadaProductos'){              
      $clave = $Reporte->listarReporteLlegadaProductos();
      if(count($clave) != 0){
        foreach($clave as $valor){
          echo "
            <tr>
              <td class='text-center'>$valor->id_reporte</td>
              <td class='text-center'>$valor->fecha_hora</td>
              <td class='text-center'>$valor->jefe_fundo</td>
              <td class='text-center'>$valor->nombre_fundo</td>
              <td class='text-center'>$valor->nombre_lote</td>
              <td class='text-center'>$valor->_slote_nombre</td>
              <td class='text-center'>$valor->nrReserva</td>
              <td class='text-center'>$valor->nrInstructivo</td>";
              if($valor->fecha_llegada==null){
                echo "
                <td class='text-center'>
                  <a style='margin-top: 10px;  href='#' data-idproducto='{$valor->id_reporte}' class='btn btn-sm btn-outline-secondary fechallegada'>
                    <i class='fas fa-calendar'></i>
                  </a>
                </td> ";
              } 
              else{
              echo"
              <td class='text-center'>
                <a style='margin-top: 10px;  href='#' data-idproducto='{$valor->id_reporte}' class='btn btn-sm btn-outline-secondary volverasignarfechallegada'>
                  <i class='fas fa-check'></i>
                </a>
              </td>
              ";}
              echo "</tr>";
        }
      }
    }

    if($_GET['op'] == 'filtrarFechasLlegadaProducto'){
      $clave = $Reporte->filtrarFechaLlegadaProducto([
      'fechainicial' => $_GET['fechainicial'],
      'fechafinal' => $_GET['fechafinal']
     ]);
     foreach($clave as $valor){
       echo "
         <tr>
           <td class='text-center'>$valor->id_reporte</td>
           <td class='text-center'>$valor->fecha_hora</td>
           <td class='text-center'>$valor->jefe_fundo</td>
           <td class='text-center'>$valor->nombre_fundo</td>
           <td class='text-center'>$valor->nombre_lote</td>
           <td class='text-center'>$valor->_slote_nombre</td>
           <td class='text-center'>$valor->nrReserva</td>
           <td class='text-center'>$valor->nrInstructivo</td>";
           if($valor->fecha_llegada==null){
             echo "
             <td class='text-center'>
               <a style='margin-top: 10px;  href='#' data-idproducto='{$valor->id_reporte}' class='btn btn-sm btn-outline-secondary fechallegada'>
                 <i class='fas fa-calendar'></i>
               </a>
             </td> ";
           } 
           else{
           echo"
           <td class='text-center'>
             <a style='margin-top: 10px;  href='#' data-idproducto='{$valor->id_reporte}' class='btn btn-sm btn-outline-secondary volverasignarfechallegada'>
               <i class='fas fa-check'></i>
             </a>
           </td>
           ";}
           echo "</tr>";
     }
    }
    
    if($_GET['op']  == 'ListarRegistroTotalProductos'){              
      $clave = $Reporte->listarReporteLlegadaProductos();
      if(count($clave) != 0){
        foreach($clave as $valor){
          echo "
            <tr>
              <td class='text-center'>$valor->id_reporte</td>
              <td class='text-center'>$valor->fecha_hora</td>
              <td class='text-center'>$valor->jefe_fundo</td>
              <td class='text-center'>$valor->nombre_fundo</td>
              <td class='text-center'>$valor->nombre_lote</td>
              <td class='text-center'>$valor->_slote_nombre</td>
              <td class='text-center'>$valor->nombre_pep</td>
              <td class='text-center'>$valor->nombreEcultivo</td>
              <td class='text-center'>$valor->nrReserva</td>
              <td class='text-center'>$valor->nrInstructivo</td>
              <td class='text-center'>$valor->fecha_llegada</td>
              </tr>";
        }
      }
    }

    if($_GET['op'] == 'filtrarFechasReportesTotales'){
      $clave = $Reporte->filtrarFechaLlegadaProducto([
      'fechainicial' => $_GET['fechainicial'],
      'fechafinal' => $_GET['fechafinal']
     ]);
     foreach($clave as $valor){
       echo "
         <tr>
           <td class='text-center'>$valor->id_reporte</td>
           <td class='text-center'>$valor->fecha_hora</td>
           <td class='text-center'>$valor->jefe_fundo</td>
           <td class='text-center'>$valor->nombre_fundo</td>
           <td class='text-center'>$valor->nombre_lote</td>
           <td class='text-center'>$valor->nombre_pep</td>
           <td class='text-center'>$valor->nombreEcultivo</td>
           <td class='text-center'>$valor->_slote_nombre</td>
           <td class='text-center'>$valor->nrReserva</td>
           <td class='text-center'>$valor->nrInstructivo</td>
           <td class='text-center'>$valor->fecha_llegada</td>
           </tr>";
     }
    }

    if($_GET['op'] == 'asignarFechaLlegada'){
      $Reporte->AsignarFechallegada([
          'idreporte' => $_GET['idreporte'],
          'fechaLlegada' => $_GET['fechaLlegada']
      ]);
    }

    if($_GET['op']  == 'ListarReportesreservainstructivo'){              
      $clave = $Reporte->listarReporte();
      if(count($clave) != 0){
        $i = 1;
        foreach($clave as $valor){
              echo "
              <tr>
                <td class='text-center'>$valor->id_reporte</td>
                <td class='text-center'>$valor->fecha_hora</td>
                <td class='text-center'>$valor->jefe_fundo</td>
                <td class='text-center'>$valor->nombre_fundo</td>
                <td class='text-center'>$valor->nombre_lote</td>
                <td class='text-center'>$valor->_slote_nombre</td>
                <td class='text-center'>$valor->nrReserva</td>
                <td class='text-center'>$valor->nrInstructivo</td>
                <td class='text-center'>
                <a  href='#' data-idproducto='{$valor->id_reporte}' class='btn btn-sm btn-outline-secondary reservainstructivo'>
                  <i class='fas fa-bars'></i>
                </a>
                </td>
                </tr>";
          $i++;
        }
      }
    }
    
    if($_GET['op'] == 'filtrarFechasReportesreservaintructivo'){
      $clave = $Reporte->filtrarFecha([
      'fechainicial' => $_GET['fechainicial'],
      'fechafinal' => $_GET['fechafinal']
     ]);
      $i = 1;
      foreach($clave as $valor){
        echo "
        <tr>
          <td class='text-center'>$valor->id_reporte</td>
          <td class='text-center'>$valor->fecha_hora</td>
          <td class='text-center'>$valor->jefe_fundo</td>
          <td class='text-center'>$valor->nombre_fundo</td>
          <td class='text-center'>$valor->nombre_lote</td>
          <td class='text-center'>$valor->_slote_nombre</td>
          <td class='text-center'>$valor->nrReserva</td>
          <td class='text-center'>$valor->nrInstructivo</td>
          <td class='text-center'>
          <a  href='#' data-idproducto='{$valor->id_reporte}' class='btn btn-sm btn-outline-secondary reservainstructivo'>
            <i class='fas fa-bars'></i>
          </a>
          </td>
          </tr>";
        $i++;
      }
    }

    if($_GET['op']  == 'ListarReporteAcciones'){              
      $clave = $Reporte->listarReporteAcciones();
      if(count($clave) != 0){
        $i = 1;
        foreach($clave as $valor){
          echo "
            <tr>
              <td class='text-center col-2'>$valor->ARfecha</td>
              <td class='text-center col-4'>$valor->ARnombres</td>
              <td class='text-center col-1'>$valor->ARcodigo_reporte</td>
              <td class='text-center col-2'>$valor->ARaccion</td>
              <td class='text-center col-3'>$valor->ARobservacion</td>";
              if($valor->ARaccion=='Modificar'){
                echo "
                <td class='text-center'>
                  <a style='margin-top: 10px;  href='#' data-antes='{$valor->antes}' data-despues='{$valor->despues}' class='btn btn-sm btn-outline-secondary bitacoraModificar'>
                    <i class='fas fa-eye'></i>
                  </a>
                </td>";
              }
              if($valor->ARaccion=='Eliminar'){
                echo "
                <td class='text-center'>
                  <a style='margin-top: 10px;  href='#' data-eliminar='{$valor->eliminar}' class='btn btn-sm btn-outline-secondary bitacoraEliminar'>
                    <i class='fas fa-trash'></i>
                  </a>
                </td>";
              }
              echo "
              </tr>
              ";
          $i++;
        }
      }
    }
    
    if($_GET['op'] == 'filtrarFechasReportesAcciones'){
      $clave = $Reporte->filtrarFechaReporteAccion([
      'fechainicial' => $_GET['fechainicial'],
      'fechafinal' => $_GET['fechafinal']
     ]);
      $i = 1;
      foreach($clave as $valor){echo "
        <tr>
          <td class='text-center col-2'>$valor->ARfecha</td>
          <td class='text-center col-4'>$valor->ARnombres</td>
          <td class='text-center col-1'>$valor->ARcodigo_reporte</td>
          <td class='text-center col-2'>$valor->ARaccion</td>
          <td class='text-center col-3'>$valor->ARobservacion</td>";
          if($valor->ARaccion=='Modificar'){
            echo "
            <td class='text-center'>
              <a style='margin-top: 10px;  href='#' data-antes='{$valor->antes}' data-despues='{$valor->despues}' class='btn btn-sm btn-outline-secondary bitacoraModificar'>
                <i class='fas fa-eye'></i>
              </a>
            </td>";
          }
          if($valor->ARaccion=='Eliminar'){
            echo "
            <td class='text-center'>
              <a style='margin-top: 10px;  href='#' data-eliminar='{$valor->eliminar}' class='btn btn-sm btn-outline-secondary bitacoraEliminar'>
                <i class='fas fa-trash'></i>
              </a>
            </td>";
          }
          echo "
          </tr>
          ";
        $i++;
      }
    }

    if($_GET['op']  == 'ListarProductosAcciones'){              
      $clave = $Reporte->listarProductosAcciones();
      if(count($clave) != 0){
        $i = 1;
        foreach($clave as $valor){
          echo "
            <tr>
              <td class='text-center col-2'>$valor->RDFecha</td>
              <td class='text-center col-4'>$valor->RDnombres</td>
              <td class='text-center col-1'>$valor->RDcodigo_reporte</td>
              <td class='text-center col-2'>$valor->RDaccion</td>
              <td class='text-center col-3'>$valor->RDobservacion</td>
              <td class='text-center'>
                <a style='margin-top: 10px;  href='#' data-bitacoraProducto='{$valor->RDcodigo_reporte}' class='btn btn-sm btn-outline-secondary bitacora'>
                  <i class='fas fa-eye'></i>
                </a>
              </td>
              </tr>
              ";
          $i++;
        }
      }
    }
    
    if($_GET['op'] == 'filtrarFechasProductosAcciones'){
      $clave = $Reporte->filtrarFechaProductosAccion([
      'fechainicial' => $_GET['fechainicial'],
      'fechafinal' => $_GET['fechafinal']
     ]);
      $i = 1;
      foreach($clave as $valor){
        echo "
        <tr>
          <td class='text-center col-2'>$valor->RDFecha</td>
          <td class='text-center col-4'>$valor->RDnombres</td>
          <td class='text-center col-1'>$valor->RDcodigo_reporte</td>
          <td class='text-center col-2'>$valor->RDaccion</td>
          <td class='text-center col-3'>$valor->RDobservacion</td>
          <td class='text-center'>
            <a style='margin-top: 10px;  href='#' data-bitacoraProducto='{$valor->RDcodigo_reporte}' class='btn btn-sm btn-outline-secondary bitacora'>
              <i class='fas fa-eye'></i>
            </a>
          </td>
        </tr>
        ";
        $i++;
      }
    }
}
?>
