<?php

require_once '../core/model.master.php';

class Producto extends ModelMaster{

  public function registrarProducto(array $data){
      try{
        parent::execProcedure($data, "spu_productos_sanidad_registro", false);
      }catch(Exception $error){
        die($error->getMessage());
      }
    }
    
  public function nombreproductoYaRegistrado(array $data){
    try{
        return parent::execProcedureLogin($data, "spu_nombreproducto_sanidad_registrado", true);
    }
    catch (Exception $error){
        die($error->getMessage());
    }
  }

  public function eliminarProducto(array $data){
    try{
        parent::execProcedure($data,"spu_eliminar_producto_sanidad",false);
    }catch(Exception $error){
        die($error->getMessage());
    }
  }
  
  public function reactivarProducto(array $data){
    try{
        parent::execProcedure($data,"spu_reactivar_producto_sanidad", false);
    }catch(Exception $error){
        die($error->getMessage());
    }
}

  public function modificarProducto(array $data){
    try{
        parent::execProcedure($data, "spu_productos_sanidad_modificar", false);
    }catch(Exception $error){
        die($error->getMessage());
    }
  } 

  public function getProducto(array $data){
      try{
          return parent::execProcedure($data, "spu_productosSanidad_getdata", true);
      }catch(Exception $error){
          die($error->getMessage());
      }
  }

  public function listarProducto(){
    try{
        return parent::getRows("spu_productos_sanidad_listar");
    }catch(Exception $error){
        die($error->getMessage());
    }
  }

}
?>