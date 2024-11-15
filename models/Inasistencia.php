<?php

require_once '../core/model.master.php';

class Inasistencia extends ModelMaster{

  public function ListarInasistenciaDesayuno(){
    try{
        return parent::getRows("spu_inasistenciadesayuno_listar");
    }catch(Exception $error){
        die($error->getMessage());
    }
  }

  public function ListarInasistenciaAlmuerzo(){
    try{
        return parent::getRows("spu_inasistenciaalmuerzo_listar");
    }catch(Exception $error){
        die($error->getMessage());
    }
  }
  public function ListarInasistenciaCena(){
    try{
        return parent::getRows("spu_inasistenciacena_listar");
    }catch(Exception $error){
        die($error->getMessage());
    }
  }

}
?>