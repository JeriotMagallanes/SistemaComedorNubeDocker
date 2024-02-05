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
  
  public function registrarEliminacionReporte(array $data){
    try{
        parent::execProcedure($data, "Spu_eliminar_reporte_seguimiento", false);
    }catch(Exception $error){
        die($error->getMessage());
    }
  } 

  public function aprobarReporteJFundo(array $data){
    try{
        parent::deleteRows($data, "spu_aprobar_reporteJFundo");
    }catch(Exception $error){
        die($error->getMessage());
    }
  }
  
  public function aprobarreporteSanidad(array $data){
    try{
        parent::deleteRows($data, "spu_aprobar_reporteSanidad");
    }catch(Exception $error){
        die($error->getMessage());
    }
  } 
  
  public function aprobarreporteCalidad(array $data){
    try{
        parent::deleteRows($data, "spu_aprobar_reporteCalidad");
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

  public function registrarModificacionReporte(array $data){
    try{
        parent::execProcedure($data, "Spu_modificar_reporte_seguimiento", false);
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

  public function filtrarFechaJFundoAdmiinistrar(array $data){
    try{
        return parent::execProcedure($data, "spu_filtrar_fecha_reportes_jfundoAdministrador", true);
    }catch(Exception $error){
        die($error->getMessage());
    }
  } 

  public function filtrarFechaJFundo(array $data){
    try{
        return parent::execProcedure($data, "spu_filtrar_fecha_reportes_jfundo", true);
    }catch(Exception $error){
        die($error->getMessage());
    }
  } 

  public function filtrarFechaJOperaciones(array $data){
    try{
        return parent::execProcedure($data, "spu_filtrar_fecha_reportes_joperaciones", true);
    }catch(Exception $error){
        die($error->getMessage());
    }
  } 

  public function filtrarFechaAdministrador(array $data){
    try{
        return parent::execProcedure($data, "spu_filtrar_fecha_reportes_administrador", true);
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

  public function listarReporteCalidad(){
    try{
        return parent::getRows("spu_reporte_listar_calidad");
    }catch(Exception $error){
        die($error->getMessage());
    }
  }

  public function filtrarFechaCalidad(array $data){
    try{
        return parent::execProcedure($data, "spu_filtrar_fecha_reportes_calidad", true);
    }catch(Exception $error){
        die($error->getMessage());
    }
  } 

  public function ListarReportesPorJefeFundo(array $data){
    try{
        return parent::execProcedure($data, "spu_listar_reportes_porJefeFundo", true);
    }catch(Exception $error){
        die($error->getMessage());
    }
  }  
  
  public function ListarPorJefeReportesJOperaciones(array $data){
    try{
        return parent::execProcedure($data, "spu_listar_reportes_porJefeOperaciones", true);
    }catch(Exception $error){
        die($error->getMessage());
    }
  } 

  public function listarReporteAdministrador(){
    try{
        return parent::getRows("spu_reporte_administrador_listar");
    }catch(Exception $error){
        die($error->getMessage());
    }
  }  

  public function listarReporteLlegadaProductos(){
    try{
        return parent::getRows("spu_reporte_listar_llegadaProductos");
    }catch(Exception $error){
        die($error->getMessage());
    }
  }

  public function filtrarFechaLlegadaProducto(array $data){
    try{
        return parent::execProcedure($data, "spu_filtrar_fecha_LlegadaProductos", true);
    }catch(Exception $error){
        die($error->getMessage());
    }
  } 

  public function AsignarFechallegada(array $data){
    try{
        parent::execProcedure($data, "spu_asignar_fecha_llegada", false);
    }catch(Exception $error){
        die($error->getMessage());
    }
  } 

  public function listarReporteAcciones(){
    try{
        return parent::getRows("spu_listar_reporte_acciones");
    }catch(Exception $error){
        die($error->getMessage());
    }
  }
  
  public function filtrarFechaReporteAccion(array $data){
    try{
        return parent::execProcedure($data, "spu_filtrar_fecha_reportes_accion", true);
    }catch(Exception $error){
        die($error->getMessage());
    }
  } 

  public function listarProductosAcciones(){
    try{
        return parent::getRows("spu_listar_producto_acciones");
    }catch(Exception $error){
        die($error->getMessage());
    }
  }
  
  public function filtrarFechaProductosAccion(array $data){
    try{
        return parent::execProcedure($data, "spu_filtrar_fecha_producto_accion", true);
    }catch(Exception $error){
        die($error->getMessage());
    }
  } 
}
?>