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
    public function cargarCategoriaCultivos(){
        try{
          return parent::getRows("spu_cargar_categoria_cultivo");
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
    
    public function cargarCategoriaLote(){
      try{
        return parent::getRows("spu_cargar_categoria_lote");
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
