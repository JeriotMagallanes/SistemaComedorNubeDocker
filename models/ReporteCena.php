<?php

require_once '../core/model.master.php';

class ReporteCena extends ModelMaster{

  public function ListarReporteCena(){
    try{
        return parent::getRows("spu_reporte_cena_listar");
    }catch(Exception $error){
        die($error->getMessage());
    }
  }
  
  public function ListarReporteCenaFecha(array $data){
    try{
        return parent::execProcedure($data, "spu_reporte_cena_listar_fecha", true);
    }catch(Exception $error){
        die($error->getMessage());
    }
  } 
}
?>