<?php

require_once '../core/model.master.php';

class AsistenciaDesayuno extends ModelMaster{

  public function RegistrarAsistenciaDesayuno(array $data){
    try{
        parent::execProcedure($data, "spu_asistencia_desayuno_registro", false);
    }catch(Exception $error){
        die($error->getMessage());
    }
  }
  public function ListarInasistenciaDesayuno(){
    try{
        return parent::getRows("spu_asistencia_desayuno_listar");
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

  public function ListarAsistenciaDesayunoFecha(array $data){
    try{
        return parent::execProcedure($data, "spu_asistencia_desayuno_listar_fecha", true);
    }catch(Exception $error){
        die($error->getMessage());
    }
  } 
}
?>