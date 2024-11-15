<?php

require_once '../core/model.master.php';

class Estudiante extends ModelMaster{

    
    public function nombreestudianteYaRegistrado(array $data){
        try{
            return parent::execProcedureLogin($data, "spu_estudiante_YaRegistrado", true);
        }
        catch (Exception $error){
            die($error->getMessage());
        }
    }

    public function RegistrarEstudiantes(array $data){
        try {
            parent::execProcedure($data, "spu_estudiantes_registro", false);
        } catch(Exception $error) {
            // Lanzar la excepción para que pueda ser capturada en el controlador
            throw new Exception($error->getMessage());
        }
    }
    
    public function listarEstudiantes(){
        try{
            return parent::getRows("spu_estudiantes_listar");
        }catch(Exception $error){
            die($error->getMessage());
        }
    }

    public function eliminarEstudiante(array $data){
        try{
            parent::execProcedure($data, "spu_estudiante_eliminar", false);
        }catch(Exception $error){
            die($error->getMessage());
        }
    }

    public function reactivarEstudiante(array $data){
        try{
            parent::execProcedure($data, "spu_estudiante_reactivar", false);
        }catch(Exception $error){
            die($error->getMessage());
        }
    }
    
    public function modificarEstudiante(array $data){
        try{
            parent::execProcedure($data, "spu_estudiantes_modificar", false);
        }catch(Exception $error){
            die($error->getMessage());
        }
    }

    public function getEstudiante(array $data){
        try{
            return parent::execProcedure($data, "spu_estudiantes_getdata", true);
        }catch(Exception $error){
            die($error->getMessage());
        }
    }

}
?>