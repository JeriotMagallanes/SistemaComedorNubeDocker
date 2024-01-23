<?php

require_once '../core/model.master.php';

class Fundo extends ModelMaster{

  public function registrarfundo(array $data){
      try{
        parent::execProcedure($data, "spu_fundo_registro", false);
      }catch(Exception $error){
        die($error->getMessage());
      }
    }
    
  public function eliminarProducto(array $data){
    try{
        parent::deleteRows($data, "spu_eliminar_fundo");
    }catch(Exception $error){
        die($error->getMessage());
    }
  }

  public function filtrarCategoria(array $data){
    try{
        return parent::execProcedure($data, "spu_fundo_filtrar_categorias", true);
    }catch(Exception $error){
        die($error->getMessage());
    }
  }

  public function listarfundo(){
    try{
        return parent::getRows("spu_fundos_listar");
    }catch(Exception $error){
        die($error->getMessage());
    }
  }

}
?>