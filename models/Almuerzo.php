<?php

require_once '../core/model.master.php';

class Almuerzo extends ModelMaster{

  public function registrarAlmuerzo(array $data){
      try{
        parent::execProcedure($data, "spu_almuerzo_registro", false);
      }catch(Exception $error){
        die($error->getMessage());
      }
  }
  
  public function modificarAlmuerzo(array $data){
    try{
        parent::execProcedure($data, "spu_almuerzo_modificar", false);
    }catch(Exception $error){
        die($error->getMessage());
    }
  } 

  public function getAlmuerzo(array $data){
      try{
          return parent::execProcedure($data, "spu_almuerzo_getdata", true);
      }catch(Exception $error){
          die($error->getMessage());
      }
  }

  public function ListarAlmuerzo(){
    try{
        return parent::getRows("spu_almuerzo_listar");
    }catch(Exception $error){
        die($error->getMessage());
    }
  }

}
?>