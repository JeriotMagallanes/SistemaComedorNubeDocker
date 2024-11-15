<?php

require_once '../core/model.master.php';

class ReporteDesayuno extends ModelMaster{

  public function ListarReporteDesayuno(){
    try{
        return parent::getRows("spu_reporte_desayuno_listar");
    }catch(Exception $error){
        die($error->getMessage());
    }
  }
  
  public function ListarReporteDesayunoFecha(array $data){
    try{
        return parent::execProcedure($data, "spu_reporte_desayuno_listar_fecha", true);
    }catch(Exception $error){
        die($error->getMessage());
    }
  } 
}
?>