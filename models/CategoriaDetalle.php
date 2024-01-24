<?php

require_once '../core/model.master.php';

class Categoria extends ModelMaster{

    public function cargarMotivosAplicacion(){
        try{
          return parent::getRows("spu_cargar_motivo_aplicacion");
        }catch(Exception $error){
          die($error->getMessage());
        }
      }
      public function cargarProductos(){
        try{
          return parent::getRows("spu_cargar_productos_sanidad");
        }catch(Exception $error){
          die($error->getMessage());
        }
      }
      public function getProducto(array $data){
        try{
            return parent::execProcedure($data, "spu_detalle_getunidad", true);
        }catch(Exception $error){
            die($error->getMessage());
        }
    }

}
?>
