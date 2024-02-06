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
      public function cargarCategoriaFundoFundos(){
        try{
          return parent::getRows("spu_cargar_fundos_fundos");
        }catch(Exception $error){
          die($error->getMessage());
        }
      }
      public function cargarCategoriaLoteBitacora(){
        try{
          return parent::getRows("spu_cargar_lotes_SJefefundo");
        }catch(Exception $error){
          die($error->getMessage());
        }
      }
      public function cargarCategoriaSLoteBitacora(){
        try{
          return parent::getRows("spu_cargar_slotes_SLote");
        }catch(Exception $error){
          die($error->getMessage());
        }
      }
       public function cargarCategoriaVariedadesBitacora(){
        try{
          return parent::getRows("spu_cargar_variedadesBitacora");
        }catch(Exception $error){
          die($error->getMessage());
        }
      }
    public function cargarCategoriaFundoGET(array $data){
      try{
          return parent::execProcedure($data, "spu_cargar_nombre_fundos", true);
      }catch(Exception $error){
          die($error->getMessage());
      }
    }  
  
    public function cargarCategoriaCultivos(){
        try{
          return parent::getRows("spu_cargar_categoria_cultivo");
        }catch(Exception $error){
          die($error->getMessage());
        }
      }
      public function cargarCategoriaCultivoGET(array $data){
        try{
            return parent::execProcedure($data, "spu_cargar_cultivoGET", true);
        }catch(Exception $error){
            die($error->getMessage());
        }
    }
    public function cargarCategoriaVariedades(array $data){
        try{
            return parent::execProcedure($data, "spu_cargar_variedades", true);
        }catch(Exception $error){
            die($error->getMessage());
        }
    }
    
    public function cargarCategoriaLote(array $data){
      try{
          return parent::execProcedure($data, "spu_cargar_categoria_lote", true);
      }catch(Exception $error){
          die($error->getMessage());
      }
    }
    public function cargarCategoriaSubLotes(array $data){
        try{
            return parent::execProcedure($data, "spu_cargar_s_lotes", true);
        }catch(Exception $error){
            die($error->getMessage());
        }
    }
   
}
?>
