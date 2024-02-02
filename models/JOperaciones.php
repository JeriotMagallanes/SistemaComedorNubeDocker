<?php

require_once '../core/model.master.php';

class JOperaciones extends ModelMaster{
 
    public function cargarJoperaciones(){
        try{
          return parent::getRows("spu_cargar_JOperaciones");
        }catch(Exception $error){
          die($error->getMessage());
        }
    }

    public function getJOperaciones(array $data){
        try{
            return parent::execProcedure($data, "spu_JOperaciones_getdata", true);
        }catch(Exception $error){
            die($error->getMessage());
        }
    } 

    public function listarJefeFundo(){
        try{
            return parent::getRows("spu_listar_JFundo_JOperaciones");
        }catch(Exception $error){
            die($error->getMessage());
        }
    }

    public function filtrar_JFundo_JOperaciones(array $data){
        try{
            return parent::execProcedure($data, "spu_listarfiltro_JFundo_JOperaciones", true);
        }catch(Exception $error){
            die($error->getMessage());
        }
    }

    public function desasignarJOperaciones(array $data){
        try{
            parent::execProcedure($data,"spu_desasignar_JOperaciones",false);
        }catch(Exception $error){
            die($error->getMessage());
        }
    }
    
    public function asignarJOperaciones(array $data){
        try{
            parent::execProcedure($data,"spu_asignar_JOperaciones", false);
        }catch(Exception $error){
            die($error->getMessage());
        }
    }
}
?>