<?php
session_start();
require_once '../models/CategoriaFundo.php';
if (isset($_GET['op'])){
  $categoria = new Categoria();

    if($_GET['op'] == 'cargarCategoria'){
      $datosObtenidos = $categoria->cargarCategoria();
        echo "<option value=''>Seleccione</option>";
        foreach($datosObtenidos as $valor){
            echo"
            <option value='$valor->idusuario'>$valor->Nombre</option>
            ";
        }
    }

    if($_GET['op'] == 'cargarCategoriaFundo'){
      $datosObtenidos = $categoria->cargarCategoriaFundo();
        echo "<option value=''>Seleccione</option>";
        foreach($datosObtenidos as $valor){
            echo"
            <option value='$valor->id_fundo_nombre'>$valor->nombre_fundo</option>
            ";
        }
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
        <option value='$id_cultivo->id_cultivo'>$valor->nombre_cultivo</option>
        ";}
      }
        foreach($datosObtenidos as $valor){
            if($valor->id_cultivo!=$cultivoGET){
            echo"
            <option value='$valor->id_cultivo'>$valor->nombre_cultivo</option>
            ";}
        }
        
    }
    
    if($_GET['op'] == 'cargarCategoriaSubLote'){
      $datosObtenidos = $categoria->cargarCategoriaSubLotes(["id_lote" => $_GET['id_lote']]);
      echo "<option value=''>Seleccione</option>";
      foreach($datosObtenidos as $valor){
          echo"
          <option value='$valor->id_sub_lote '>$valor->_slote_nombre</option>
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

    if($_GET['op'] == 'cargarCategoriaVariedades'){
      $datosObtenidos = $categoria->cargarCategoriaVariedades(["id_cultivo" => $_GET['id_cultivo']]);
      echo "<option value=''>Seleccione</option>";
      foreach($datosObtenidos as $valor){
          echo"
          <option value='$valor->id_variedad'>$valor->nombre_variedad</option>
          ";
      }
    }
        
}
?>