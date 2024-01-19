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
      
    public function cargarCategoriaNombreFundos(array $data){
      try{
          return parent::execProcedure($data, "spu_cargar_nombre_fundos", true);
      }catch(Exception $error){
          die($error->getMessage());
      }
     }

     public function cargarCategoriaLoteNombreFundos(array $data){
      try{
          return parent::execProcedure($data, "spu_cargar_lote_nombreFundo", true);
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
    public function cargarCategoriaCultivosLotes(array $data){
      try{
          return parent::execProcedure($data, "spu_cargar_cultivos_lotes", true);
      }catch(Exception $error){
          die($error->getMessage());
      }
    }
    
    public function cargarCategoriaVariedadLotes(array $data){
      try{
          return parent::execProcedure($data, "spu_cargar_variedad_lotes", true);
      }catch(Exception $error){
          die($error->getMessage());
      }
    }
}
?>
