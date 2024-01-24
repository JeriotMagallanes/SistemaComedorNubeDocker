<?php

require_once '../core/model.master.php';

class Detalle extends ModelMaster{

  public function registrardetalles(array $data){
      try{
        parent::execProcedure($data, "spu_detalle_registro", false);
      }catch(Exception $error){
        die($error->getMessage());
      }
    }
    
  public function eliminarDetalle(array $data){
    try{
        parent::deleteRows($data, "spu_eliminar_detalle");
    }catch(Exception $error){
        die($error->getMessage());
    }
  }

  public function listardetalle(array $data){
    try{
        return parent::execProcedure($data, "spu_listar_detalle", true);
    }catch(Exception $error){
        die($error->getMessage());
    }
  }

}
?>