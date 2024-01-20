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
    
  public function nombrefundoYaRegistrado(array $data){
    try{
        return parent::execProcedureLogin($data, "spu_fundoYaRegistrado", true);
    }
    catch (Exception $error){
        die($error->getMessage());
    }
  }

  public function eliminarProducto(array $data){
    try{
        parent::deleteRows($data, "spu_eliminar_fundo");
    }catch(Exception $error){
        die($error->getMessage());
    }
  }

  public function modificarProducto(array $data){
    try{
        parent::execProcedure($data, "spu_fundo_modificar", false);
    }catch(Exception $error){
        die($error->getMessage());
    }
  } 

  public function getProducto(array $data){
      try{
          return parent::execProcedure($data, "spu_fundos_getdata", true);
      }catch(Exception $error){
          die($error->getMessage());
      }
  }

  public function filtrarFecha(array $data){
    try{
        return parent::execProcedure($data, "spu_fundo_filtrar_fecha_reportes", true);
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