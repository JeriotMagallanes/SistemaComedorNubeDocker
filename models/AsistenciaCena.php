<?php

require_once '../core/model.master.php';

class AsistenciaCena extends ModelMaster{

  public function registrarAsistenciaCena(array $data){
    try{
        parent::execProcedure($data, "spu_asistencia_cena_registro", false);
    }catch(Exception $error){
        die($error->getMessage());
    }
  }
  public function ListarInasistenciaCena(){
    try{
        return parent::getRows("spu_asistencia_cena_listar");
    }catch(Exception $error){
        die($error->getMessage());
    }
  }
  
  public function Asistencia_dias_atendidos(){
    try{
        return parent::getRows("spu_asistencia_dias_atendidos");
    }catch(Exception $error){
        die($error->getMessage());
    }
  }

  public function Asistencia_dias_atendidos_fecha(array $data){
    try{
        return parent::execProcedure($data, "spu_asistencia_dias_atendidos", true);
    }catch(Exception $error){
        die($error->getMessage());
    }
  }

  public function ListarAsistenciaCenaFecha(array $data){
    try{
        return parent::execProcedure($data, "spu_asistencia_cena_listar_fecha", true);
    }catch(Exception $error){
        die($error->getMessage());
    }
  } 
}
?>