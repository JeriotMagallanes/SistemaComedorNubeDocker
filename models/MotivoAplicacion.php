<?php

require_once '../core/model.master.php';

class Motivo extends ModelMaster{

  public function registrarMotivo(array $data){
      try{
        parent::execProcedure($data, "spu_motivo_aplicacion_registro", false);
      }catch(Exception $error){
        die($error->getMessage());
      }
    }
    
  public function nombreMotivoYaRegistrado(array $data){
    try{
        return parent::execProcedureLogin($data, "spu_nombre_motivo_aplicacion_registrado", true);
    }
    catch (Exception $error){
        die($error->getMessage());
    }
  }

  public function modificarMotivo(array $data){
    try{
        parent::execProcedure($data, "spu_motivo_aplicacion_modificar", false);
    }catch(Exception $error){
        die($error->getMessage());
    }
  } 
  public function eliminarMotivo(array $data){
    try{
        parent::execProcedure($data,"spu_eliminar_motivo_sanidad",false);
    }catch(Exception $error){
        die($error->getMessage());
    }
  }
  
  public function reactivarMotivo(array $data){
    try{
        parent::execProcedure($data,"spu_reactivar_motivo_sanidad", false);
    }catch(Exception $error){
        die($error->getMessage());
    }
    }
  public function getMotivo(array $data){
      try{
          return parent::execProcedure($data,"spu_motivoAplicacion_getdata", true);
      }catch(Exception $error){
          die($error->getMessage());
      }
  }

  public function listarMotivo(){
    try{
        return parent::getRows("spu_motivo_aplicacion_listar");
    }catch(Exception $error){
        die($error->getMessage());
    }
  }

}
?>