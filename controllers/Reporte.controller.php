<?php
session_start();

require_once '../models/Reporte.php';
require_once '../models/Serverside.php';

if (isset($_GET['op'])){

  $Reporte = new Reporte();

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
            'variedad' => $_GET['variedad']
        ]);
    }
    
    if($_GET['op']== 'eliminarReporte'){
      $Reporte->eliminarReportes(["idproducto" => $_GET["idproducto"]]);
    } 

    if($_GET['op']== 'aprobarreporteJfundo'){
      $Reporte->aprobarReporteJFundo(["idproducto" => $_GET["idproducto"]]);
    }

    if($_GET['op']== 'aprobarreporteSanidad'){
      $Reporte->aprobarreporteSanidad(["idproducto" => $_GET["idproducto"]]);
    }
    
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
      ]);
    }

    if($_GET['op'] == 'getReporte'){
      $data = $Reporte->getReporte(["id_reporte" => $_GET['id_reporte']]);
      echo json_encode($data);
    }
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
              <td class='text-center'>$valor->nom_fundo</td>
              <td class='text-center'>$valor->nombre_lote</td>
              <td class='text-center'>$valor->_slote_nombre</td>
              <td class='text-center'>
                <a  href='#' data-idproducto='{$valor->id_reporte}' class='btn btn-sm btn-outline-secondary detalle'>
                  <i class='fas fa-bars'></i>
                </a>
              </td>";
              if(($_SESSION['nivelacceso'] == 'Administrador')){
                echo
                "
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
            echo "</tr>
          ";
          $i++;
        }
      }
    }

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
            <td class='text-center'>$valor->nom_fundo</td>
            <td class='text-center'>$valor->nombre_lote</td>
            <td class='text-center'>$valor->_slote_nombre</td>
            <td class='text-center'>
              <a  href='#' data-idproducto='{$valor->id_reporte}' class='btn btn-sm btn-outline-secondary detalle'>
                <i class='fas fa-bars'></i>
              </a>
            </td>";
            if(($_SESSION['nivelacceso'] == 'Administrador')){
              echo
              "
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
          echo "</tr>
        ";
        $i++;
      }
    }

    if($_GET['op'] == 'filtrarFechasAdministrador'){
      $clave = $Reporte->filtrarFechaAdministrador([
      'fechainicial' => $_GET['fechainicial'],
      'fechafinal' => $_GET['fechafinal']
    ]);
      $i = 1;
      foreach($clave as $valor){
       
        echo "
        <tr>
          <td class='text-center'>$valor->fecha_hora</td>
          <td class='text-center'>$valor->turno</td>
          <td class='text-center'>$valor->jefe_fundo</td>
          <td class='text-center'>$valor->nom_fundo</td>
          <td class='text-center'>{$valor->nombre_lote} ({$valor->_slote_nombre})</td>
          <td class='text-center'>{$valor->nombre_cultivo} ({$valor->nombre_variedad})</td>
          <td class='text-center'>$valor->nombre_motivo</td>
          <td class='text-center'>$valor->nombre_producto</td>
          <td class='text-center'>$valor->diascarencia</td>
          <td class='text-center'>$valor->dosiscil</td>
          <td class='text-center'>$valor->ncil</td>
          <td class='text-center'>$valor->dosistanque</td>
          <td class='text-center'>$valor->totalproducto</td>
          <td class='text-center'>$valor->dosisHA</td>
          <td class='text-center'>$valor->HAaplicada</td>
          <td class='text-center'>$valor->gastoH2O</td>
          </tr>"
      ;
        $i++;
      }
    }
    if($_GET['op'] == 'filtrarFechasOperario'){
      $clave = $Reporte->filtrarFecha([
      'fechainicial' => $_GET['fechainicial'],
      'fechafinal' => $_GET['fechafinal']
    ]);
      $i = 1;
      foreach($clave as $valor){
        if($valor->aprob_jefefundo=='Aprobado'){
          $colorjefe='c3e6cb';
        }else{
          $colorjefe='dc3545';
        }
        if($valor->aprob_jefesanidad=='Aprobado'){
          $colorsanidad='c3e6cb';
        }else{
          $colorsanidad='dc3545';
        }
        echo "
          <tr>
            <td class='text-center'>$valor->id_reporte</td>
            <td class='text-center'>$valor->fecha_hora</td>
            <td class='text-center'>$valor->jefe_fundo</td>
            <td class='text-center'>$valor->nom_fundo</td>
            <td class='text-center'>$valor->nombre_lote</td>
            <td class='text-center'>$valor->_slote_nombre</td>
            <td class='text-center align-middle'>
            <div style='border: 4px solid #$colorjefe; border-radius: 5px; padding: 5px;'>
                $valor->aprob_jefefundo
            </div>
            </td>
            <td class='text-center align-middle'>
                <div style='border: 4px solid #$colorsanidad; border-radius: 5px; padding: 5px;'>
                    $valor->aprob_jefesanidad
                </div>
            </td>
            <td class='text-center'>
              <a  href='#' data-idproducto='{$valor->id_reporte}' class='btn btn-sm btn-outline-secondary detalle'>
                <i class='fas fa-bars'></i>
              </a>
            </td>";
          echo "</tr>
        ";
        $i++;
      }
    }
    
    if($_GET['op'] == 'filtrarFechasJFundo'){
      $clave = $Reporte->filtrarFecha([
      'fechainicial' => $_GET['fechainicial'],
      'fechafinal' => $_GET['fechafinal']
    ]);
      $i = 1;
      foreach($clave as $valor){
        if($valor->aprob_jefefundo=='Aprobado'){
          $colorjefe='c3e6cb';
        }else{
          $colorjefe='dc3545';
        }
        if($valor->aprob_jefesanidad=='Aprobado'){
          $colorsanidad='c3e6cb';
        }else{
          $colorsanidad='dc3545';
        }
        echo "
          <tr>
            <td class='text-center'>$valor->id_reporte</td>
            <td class='text-center'>$valor->fecha_hora</td>
            <td class='text-center'>$valor->jefe_fundo</td>
            <td class='text-center'>$valor->nom_fundo</td>
            <td class='text-center'>$valor->nombre_lote</td>
            <td class='text-center'>$valor->_slote_nombre</td>
            <td class='text-center align-middle'>
            <div style='border: 4px solid #$colorjefe; border-radius: 5px; padding: 5px;'>
                $valor->aprob_jefefundo
            </div>
            </td>
            <td class='text-center'>
              <a  href='#' data-idproducto='{$valor->id_reporte}' class='btn btn-sm btn-outline-secondary detalle'>
                <i class='fas fa-bars'></i>
              </a>
            </td>
            <td class='text-center'>
              <a  href='#' data-idproducto='{$valor->id_reporte}' class='btn btn-sm btn-outline-secondary aprobar'>
                <i class='fas fa-check'></i>
              </a>
            </td>
            ";
          echo "</tr>
        ";
        $i++;
      }
    }
    
    if($_GET['op'] == 'filtrarFechasSanidad'){
      $clave = $Reporte->filtrarFecha([
      'fechainicial' => $_GET['fechainicial'],
      'fechafinal' => $_GET['fechafinal']
    ]);
      $i = 1;
      foreach($clave as $valor){
        if($valor->aprob_jefefundo=='Aprobado'){
          $colorjefe='c3e6cb';
        }else{
          $colorjefe='dc3545';
        }
        if($valor->aprob_jefesanidad=='Aprobado'){
          $colorsanidad='c3e6cb';
        }else{
          $colorsanidad='dc3545';
        }
        echo "
          <tr>
            <td class='text-center'>$valor->id_reporte</td>
            <td class='text-center'>$valor->fecha_hora</td>
            <td class='text-center'>$valor->jefe_fundo</td>
            <td class='text-center'>$valor->nom_fundo</td>
            <td class='text-center'>$valor->nombre_lote</td>
            <td class='text-center'>$valor->_slote_nombre</td>
            <td class='text-center align-middle'>
            <div style='border: 4px solid #$colorjefe; border-radius: 5px; padding: 5px;'>
                $valor->aprob_jefefundo
            </div>
            </td>
            <td class='text-center align-middle'>
                <div style='border: 4px solid #$colorsanidad; border-radius: 5px; padding: 5px;'>
                    $valor->aprob_jefesanidad
                </div>
            </td>
            <td class='text-center'>
              <a  href='#' data-idproducto='{$valor->id_reporte}' class='btn btn-sm btn-outline-secondary detalle'>
                <i class='fas fa-bars'></i>
              </a>
            </td>
            <td class='text-center'>
              <a  href='#' data-idproducto='{$valor->id_reporte}' class='btn btn-sm btn-outline-secondary aprobar'>
                <i class='fas fa-check'></i>
              </a>
            </td>";
          echo "</tr>
        ";
        $i++;
      }
    }
    if($_GET['op']  == 'ListarReportesGeneralAdministrador'){              
      $clave = $Reporte->listarReporteAdministrador();
  
      if(count($clave) != 0){
        $i = 1;
        foreach($clave as $valor){
          echo "
            <tr>
              <td class='text-center'>$valor->fecha_hora</td>
              <td class='text-center'>$valor->turno</td>
              <td class='text-center'>$valor->jefe_fundo</td>
              <td class='text-center'>$valor->nom_fundo</td>
              <td class='text-center'>{$valor->nombre_lote} ({$valor->_slote_nombre})</td>
              <td class='text-center'>{$valor->nombre_cultivo} ({$valor->nombre_variedad})</td>
              <td class='text-center'>$valor->nombre_motivo</td>
              <td class='text-center'>$valor->nombre_producto</td>
              <td class='text-center'>$valor->diascarencia</td>
              <td class='text-center'>$valor->dosiscil</td>
              <td class='text-center'>$valor->ncil</td>
              <td class='text-center'>$valor->dosistanque</td>
              <td class='text-center'>$valor->totalproducto</td>
              <td class='text-center'>$valor->dosisHA</td>
              <td class='text-center'>$valor->HAaplicada</td>
              <td class='text-center'>$valor->gastoH2O</td>
              </tr>"
          ;
          $i++;
        }
      }
    }
    if($_GET['op']  == 'ListarReportesOperario'){              
      $clave = $Reporte->listarReporte();
  
      if(count($clave) != 0){
        $i = 1;
        foreach($clave as $valor){
          if($valor->aprob_jefefundo=='Aprobado'){
            $colorjefe='c3e6cb';
          }else{
            $colorjefe='dc3545';
          }
          if($valor->aprob_jefesanidad=='Aprobado'){
            $colorsanidad='c3e6cb';
          }else{
            $colorsanidad='dc3545';
          }
          echo "
            <tr>
              <td class='text-center'>$valor->id_reporte</td>
              <td class='text-center'>$valor->fecha_hora</td>
              <td class='text-center'>$valor->jefe_fundo</td>
              <td class='text-center'>$valor->nom_fundo</td>
              <td class='text-center'>$valor->nombre_lote</td>
              <td class='text-center'>$valor->_slote_nombre</td>
              <td class='text-center align-middle'>
                  <div style='border: 4px solid #$colorjefe; border-radius: 5px; padding: 5px;'>
                      $valor->aprob_jefefundo
                  </div>
              </td>
              <td class='text-center align-middle'>
                  <div style='border: 4px solid #$colorsanidad; border-radius: 5px; padding: 5px;'>
                      $valor->aprob_jefesanidad
                  </div>
              </td>
              <td class='text-center'>
                <a  href='#' data-idproducto='{$valor->id_reporte}' class='btn btn-sm btn-outline-secondary detalle'>
                  <i class='fas fa-bars'></i>
                </a>
              </td>
              <td class='text-center'>
              <form id='{$valor->id_reporte}' action='views/generarPdf.php' method='post' target='_blank'>
              <input type='hidden' name='reporte_id'  value='{$valor->id_reporte}'>
              <button class='btn btn-sm btn-outline-secondary' type='submit'><i class='fas fa-file-pdf'></i></button>
          </form>
              </td>
              </tr>"
          ;
          $i++;
        }
      }
    }
    if($_GET['op']  == 'ListarReportesJFundo'){              
      $clave = $Reporte->listarReporte();
      if(count($clave) != 0){
        $i = 1;
        foreach($clave as $valor){
          if($valor->aprob_jefefundo=='Aprobado'){
            $colorjefe='c3e6cb';
          }else{
            $colorjefe='dc3545';
          }
          echo "
            <tr>
              <td class='text-center'>$valor->id_reporte</td>
              <td class='text-center'>$valor->fecha_hora</td>
              <td class='text-center'>$valor->jefe_fundo</td>
              <td class='text-center'>$valor->nom_fundo</td>
              <td class='text-center'>$valor->nombre_lote</td>
              <td class='text-center'>$valor->_slote_nombre</td>
              <td class='text-center align-middle'>
                  <div style='border: 4px solid #$colorjefe; border-radius: 5px; padding: 5px;'>
                      $valor->aprob_jefefundo
                  </div>
              </td>
              <td class='text-center'>
                <a  href='#' data-idproducto='{$valor->id_reporte}' class='btn btn-sm btn-outline-secondary detalle'>
                  <i class='fas fa-bars'></i>
                </a>
              </td>
              <td class='text-center'>
                <a  href='#' data-idproducto='{$valor->id_reporte}' class='btn btn-sm btn-outline-secondary aprobar'>
                  <i class='fas fa-check'></i>
                </a>
              </td>
              </tr>"
          ;
          $i++;
        }
      }
    }
    if($_GET['op']  == 'ListarPorJefeReportesJFundo'){  
      $clave = $Reporte->ListarReportesPorJefeFundo([
        'id_jefe_fundo' => $_GET['id_jefe_fundo'],
      ]);
        $i = 1;
        foreach($clave as $valor){
          if($valor->aprob_jefefundo=='Aprobado'){
            $colorjefe='c3e6cb';
          }else{
            $colorjefe='dc3545';
          }
          if($valor->aprob_jefesanidad=='Aprobado'){
            $colorsanidad='c3e6cb';
          }else{
            $colorsanidad='dc3545';
          }
          echo "
            <tr>
              <td class='text-center'>$valor->id_reporte</td>
              <td class='text-center'>$valor->fecha_hora</td>
              <td class='text-center'>$valor->jefe_fundo</td>
              <td class='text-center'>$valor->nom_fundo</td>
              <td class='text-center'>$valor->nombre_lote</td>
              <td class='text-center'>$valor->_slote_nombre</td>
              <td class='text-center align-middle'>
              <div style='border: 4px solid #$colorjefe; border-radius: 5px; padding: 5px;'>
                  $valor->aprob_jefefundo
              </div>
              </td>
              <td class='text-center'>
                <a  href='#' data-idproducto='{$valor->id_reporte}' class='btn btn-sm btn-outline-secondary detalle'>
                  <i class='fas fa-bars'></i>
                </a>
              </td>
              <td class='text-center'>
                <a  href='#' data-idproducto='{$valor->id_reporte}' class='btn btn-sm btn-outline-secondary aprobar'>
                  <i class='fas fa-check'></i>
                </a>
              </td>
              ";
            echo "</tr>
          ";
          $i++;
        }
    }
    
    if($_GET['op']  == 'ListarReportesSanidad'){              
      $clave = $Reporte->listarReporte();
  
      if(count($clave) != 0){
        $i = 1;
        foreach($clave as $valor){
          if($valor->aprob_jefefundo=='Aprobado'){
            $colorjefe='c3e6cb';
          }else{
            $colorjefe='dc3545';
          }
          if($valor->aprob_jefesanidad=='Aprobado'){
            $colorsanidad='c3e6cb';
          }else{
            $colorsanidad='dc3545';
          }
          echo "
            <tr>
              <td class='text-center'>$valor->id_reporte</td>
              <td class='text-center'>$valor->fecha_hora</td>
              <td class='text-center'>$valor->jefe_fundo</td>
              <td class='text-center'>$valor->nom_fundo</td>
              <td class='text-center'>$valor->nombre_lote</td>
              <td class='text-center'>$valor->_slote_nombre</td>
              <td class='text-center align-middle'>
                  <div style='border: 4px solid #$colorjefe; border-radius: 5px; padding: 5px;'>
                      $valor->aprob_jefefundo
                  </div>
              </td>
              <td class='text-center align-middle'>
                  <div style='border: 4px solid #$colorsanidad; border-radius: 5px; padding: 5px;'>
                      $valor->aprob_jefesanidad
                  </div>
              </td>
              <td class='text-center'>
                <a  href='#' data-idproducto='{$valor->id_reporte}' class='btn btn-sm btn-outline-secondary detalle'>
                  <i class='fas fa-bars'></i>
                </a>
              </td>
              <td class='text-center'>
                <a  href='#' data-idproducto='{$valor->id_reporte}' class='btn btn-sm btn-outline-secondary aprobar'>
                  <i class='fas fa-check'></i>
                </a>
              </td>
              </tr>"
          ;
          $i++;
        }
      }
    }
}
?>
