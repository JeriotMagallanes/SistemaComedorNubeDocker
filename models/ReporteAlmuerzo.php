<?php

require_once '../core/model.master.php';

class ReporteAlmuerzo extends ModelMaster{

  public function ListarReporteAlmuerzo(){
    try{
        return parent::getRows("spu_reporte_almuerzo_listar");
    }catch(Exception $error){
        die($error->getMessage());
    }
  }
  
  public function ListarReporteAlmuerzoFecha(array $data){
    try{
        return parent::execProcedure($data, "spu_reporte_almuerzo_listar_fecha", true);
    }catch(Exception $error){
        die($error->getMessage());
    }
  } 
}
?>