<?php

require_once '../core/model.master.php';

class Reporte extends ModelMaster{

  public function registrarReporte(array $data){
      try{
        parent::execProcedure($data, "spu_reporte_registro", false);
      }catch(Exception $error){
        die($error->getMessage());
      }
    }

  public function eliminarReportes(array $data){
    try{
        parent::deleteRows($data, "spu_eliminar_reporte");
    }catch(Exception $error){
        die($error->getMessage());
    }
  }

  public function modificarReporte(array $data){
    try{
        parent::execProcedure($data, "spu_reporte_modificar", false);
    }catch(Exception $error){
        die($error->getMessage());
    }
  } 

  public function getReporte(array $data){
      try{
          return parent::execProcedure($data, "spu_reporte_getdata", true);
      }catch(Exception $error){
          die($error->getMessage());
      }
  }

  public function filtrarFecha(array $data){
    try{
        return parent::execProcedure($data, "spu_filtrar_fecha_reportes", true);
    }catch(Exception $error){
        die($error->getMessage());
    }
  }

  public function listarReporte(){
    try{
        return parent::getRows("spu_reporte_listar");
    }catch(Exception $error){
        die($error->getMessage());
    }
  }

}
?>