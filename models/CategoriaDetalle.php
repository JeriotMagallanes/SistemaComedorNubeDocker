<?php

require_once '../core/model.master.php';

class Categoria extends ModelMaster{

    public function cargarCategoria(){
        try{
          return parent::getRows("spu_cargar_jefe_fundo");
        }catch(Exception $error){
          die($error->getMessage());
        }
      }

      public function cargarCategoria2(){
        try{
          return parent::getRows("spu_cargar_jefe_fundo");
        }catch(Exception $error){
          die($error->getMessage());
        }
      }
}
?>
