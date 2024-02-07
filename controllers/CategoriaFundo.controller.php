<?php
session_start();
require_once '../models/CategoriaFundo.php';
if (isset($_GET['op'])){
  $categoria = new Categoria();

    if ($_GET['op'] == 'cargarCategoria') {
      $datosObtenidos = $categoria->cargarCategoria();
      echo "<option value=''>Seleccione</option>";
      foreach($datosObtenidos as $valor){
          echo"
          <option value='$valor->idusuario '>$valor->Nombre</option>
          ";
        }
    }

    if ($_GET['op'] == 'cargarCategoriabitacora') {
      $datosObtenidos = $categoria->cargarCategoria();
      $categoriaMap = []; 
      foreach ($datosObtenidos as $valor) {
          $categoriaMap[$valor->idusuario] = $valor->Nombre;
      }
      echo json_encode($categoriaMap);
    }

    if ($_GET['op'] == 'cargarCategoriaFundo') {
      $datosObtenidos = $categoria->cargarCategoriaFundoFundos();
      echo "<option value=''>Seleccione</option>";
      foreach($datosObtenidos as $valor){
          echo"
          <option value='$valor->id_fundo_nombre '>$valor->nombre_fundo</option>
          ";
      }
    }

    if ($_GET['op'] == 'cargarCategoriaFundoBitacora') {
      $datosObtenidos = $categoria->cargarCategoriaFundoFundos();
      $fundoMap = [];
      foreach ($datosObtenidos as $valor) {
          $fundoMap[$valor->id_fundo_nombre] = $valor->nombre_fundo;
      }
      echo json_encode($fundoMap);
    }
    
    if($_GET['op'] == 'cargarFundoGET'){
      $fundoGET= $_GET['fundoGET'];
      $datosObtenidos = $categoria->cargarCategoriaFundoGET(
        ["jefeGET" => $_GET['jefeGET']]
      );
      
      foreach($datosObtenidos as $valor){
        if($valor->id_fundo_nombre==$fundoGET){
        echo"
        <option value='$valor->id_fundo_nombre'>$valor->nombre_fundo</option>
        ";}
      }
        foreach($datosObtenidos as $valor){
            if($valor->id_fundo_nombre!=$fundoGET){
            echo"
            <option value='$valor->id_fundo_nombre'>$valor->nombre_fundo</option>
            ";}
        }
        
    }
    
    if($_GET['op'] == 'cargarCategoriaLoteBitacora'){
      $datosObtenidos = $categoria->cargarCategoriaLoteBitacora();
      $loteMap = []; 
        foreach($datosObtenidos as $valor){
            $loteMap[$valor->id_lote] = $valor->nombre_lote;
        }
        echo json_encode($loteMap);
    }

    if($_GET['op'] == 'cargarCategoriaLote'){
      $datosObtenidos = $categoria->cargarCategoriaLote(["id_fundo" => $_GET['id_fundo']]);
        echo "<option value=''>Seleccione</option>";
        foreach($datosObtenidos as $valor){
            echo"
            <option value='$valor->id_lote'>$valor->nombre_lote</option>
            ";
        }
    }

    if($_GET['op'] == 'cargarLoteGET'){
      $id_loteGET= $_GET['id_lote'];
      $datosObtenidos = $categoria->cargarCategoriaLote(
        ["id_fundo" => $_GET['id_fundo']]
      );
      
      foreach($datosObtenidos as $valor){
        if($valor->id_lote==$id_loteGET){
        echo"
        <option value='$valor->id_lote'>$valor->nombre_lote</option>
        ";}
      }
        foreach($datosObtenidos as $valor){
            if($valor->id_lote!=$id_loteGET){
            echo"
            <option value='$valor->id_lote'>$valor->nombre_lote</option>
            ";}
        }
        
    }

    if($_GET['op'] == 'cargarCategoriaSLoteBitacora'){
      $datosObtenidos = $categoria->cargarCategoriaSLoteBitacora();
      $s_loteMap = []; 
      foreach($datosObtenidos as $valor){
          $s_loteMap[$valor->id_sub_lote] = $valor->_slote_nombre;
      }
      echo json_encode($s_loteMap);
    }

    if($_GET['op'] == 'cargarCategoriaSubLote'){
      $datosObtenidos = $categoria->cargarCategoriaSubLotes(["id_lote" => $_GET['id_lote']]);
      echo "<option value=''>Seleccione</option>";
      foreach($datosObtenidos as $valor){
          echo"
          <option value='$valor->id_sub_lote'>$valor->_slote_nombre</option>
          ";
      }
    }

    if($_GET['op'] == 'cargarCategoriaSubLoteGET'){
      $id_subloteGET= $_GET['id_sublote'];
      $datosObtenidos = $categoria->cargarCategoriaSubLotes(
        ["id_lote" => $_GET['id_lote']]
      );
      foreach($datosObtenidos as $valor){
        if($valor->id_sub_lote==$id_subloteGET){
        echo"
        <option value='$valor->id_sub_lote'>$valor->_slote_nombre</option>
        ";}
      }
        foreach($datosObtenidos as $valor){
            if($valor->id_sub_lote!=$id_subloteGET){
            echo"
            <option value='$valor->id_sub_lote'>$valor->_slote_nombre</option>
            ";}
        }
    }

    if($_GET['op'] == 'cargarCategoriaCultivosBitacora'){
      $datosObtenidos = $categoria->cargarCategoriaCultivos();
      $cultivoMap = []; 
      foreach($datosObtenidos as $valor){
          $cultivoMap[$valor->id_cultivo] = $valor->nombre_cultivo;
      }
      echo json_encode($cultivoMap);
    }
    
    if($_GET['op'] == 'cargarCategoriaCultivos'){
      $datosObtenidos = $categoria->cargarCategoriaCultivos();
        echo "<option value=''>Seleccione</option>";
        foreach($datosObtenidos as $valor){
            echo"
            <option value='$valor->id_cultivo'>$valor->nombre_cultivo</option>
            ";
        }
    }
    
    if($_GET['op'] == 'cargarCategoriaCultivoGET'){
      $cultivoGET= $_GET['cultivo'];
      $datosObtenidos = $categoria->cargarCategoriaCultivoGET(
        ["fundo_slote1" => $_GET['fundo_slote1']]
      );
      foreach($datosObtenidos as $valor){
        if($valor->id_cultivo==$cultivoGET){
        echo"
        <option value='$valor->id_cultivo'>$valor->nombre_cultivo</option>
        ";}
      }
        foreach($datosObtenidos as $valor){
            if($valor->id_cultivo!=$cultivoGET){
            echo"
            <option value='$valor->id_cultivo'>$valor->nombre_cultivo</option>
            ";}
        }
        
    }
    if($_GET['op'] == 'cargarCategoriaVariedadesGET'){
      $id_variedadGET = $_GET['variedad_get'];
      $datosObtenidos = $categoria->cargarCategoriaVariedades(
        ["id_cultivo" => $_GET['id_cultivo']]
      );
      foreach($datosObtenidos as $valor){
        if($valor->id_variedad==$id_variedadGET){
          echo"
          <option value='$valor->id_variedad'>$valor->nombre_variedad</option>
          ";}
      }
      foreach($datosObtenidos as $valor){
        if($valor->id_variedad!=$id_variedadGET){
        echo"
        <option value='$valor->id_variedad'>$valor->nombre_variedad</option>
        ";}
      }
    }

    if($_GET['op'] == 'cargarCategoriaVariedadesBitacora'){
      $datosObtenidos = $categoria->cargarCategoriaVariedadesBitacora();
      $variedadMap = []; 
      foreach($datosObtenidos as $valor){
          $variedadMap[$valor->id_variedad] = $valor->nombre_variedad;
      }
      echo json_encode($variedadMap);
    }

    if($_GET['op'] == 'cargarCategoriaVariedades'){
      $datosObtenidos = $categoria->cargarCategoriaVariedades(["id_cultivo" => $_GET['id_cultivo']]);
      echo "<option value=''>Seleccione</option>";
      foreach($datosObtenidos as $valor){
          echo"
          <option value='$valor->id_variedad'>$valor->nombre_variedad</option>
          ";
      }
    }
    if($_GET['op'] == 'cargarCategoriaPEPBitacora'){
      $datosObtenidos = $categoria->cargarCategoriaPEPBitacora();
      $pepMap = []; 
      foreach($datosObtenidos as $valor){
          $pepMap[$valor->id_pep] = $valor->nombre_pep;
      }
      echo json_encode($pepMap);
    }
    if($_GET['op'] == 'cargarCategoriaEtaCultivoBitacora'){
      $datosObtenidos = $categoria->cargarCategoriaEtaCultivoBitacora();
      $etapaCultivoMap = []; 
      foreach($datosObtenidos as $valor){
          $etapaCultivoMap[$valor->idEcultivo] = $valor->nombreEcultivo;
      }
      echo json_encode($etapaCultivoMap);
    }
}
?>