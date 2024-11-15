<?php

require_once '../core/model.master.php';

class AsistenciaAlmuerzo extends ModelMaster{

  public function RegistrarAsistenciaAlmuerzo(array $data){
    try{
        parent::execProcedure($data, "spu_asistencia_almuerzo_registro", false);
    }catch(Exception $error){
        die($error->getMessage());
    }
  }
  public function ListarInasistenciaAlmuerzo(){
    try{
        return parent::getRows("spu_asistencia_almuerzo_listar");
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

  public function ListarAsistenciaAlmuerzoFecha(array $data){
    try{
        return parent::execProcedure($data, "spu_asistencia_almuerzo_listar_fecha", true);
    }catch(Exception $error){
        die($error->getMessage());
    }
  } 
}
?>