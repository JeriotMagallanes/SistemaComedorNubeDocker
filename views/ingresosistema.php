<?php
    require_once 'datatable.php';
    require_once 'acceso-seguro.php';
    if($_SESSION['nivelacceso']!= "Administrador"){
        echo "<strong>No tiene el nivel de acceso requerido</strong>";
        exit();
    }
?>
<style>
    .asignar{
        display: none !important;
    }
</style>

<div class="row">
    
    <div class="col-md-12">
        <div  class=" card card-outline card-info">
            <div class="card-header">
                <p class="card-title" style="font-size: 22px; margin-top: 10px;">Ingreso de usuarios al sistema desde
                <?php
                        $conexion = mysqli_connect("127.0.0.1", "root","", "sistemasanidad");
                        $query = "SELECT * FROM asistencia;";
                        $resultado = $conexion->query($query);
                        while ($i=$resultado->fetch_assoc()) {
                            echo $i["fecha_des"];
                        }     
                        ?>
                 hasta 
                <?php
                        date_default_timezone_set('America/Lima');
                        $fecha_public=date("Y-m-d");    
                        echo $fecha_public;
                        ?>
             </p>
             <div class="card-footer text-right bg-white">
                <form method="POST" action="views/asistencia.php">
                <button class="btn bg-gradient-info" type="submit">Limpiar</button>
                </form>
            </div>
            </div>
                
            <div class="card-body table-responsive">
                <table class="table" id="">
                    <thead>
                        <tr>
                            <th class="text-center">N°</th>
                            <th class="text-center">Nombres</th>
                            <th class="text-center">Apellidos</th>
                            <th class="text-center">Usuario</th>
                            <th class="text-center">Ingreso</th>
                        </tr>
                    </thead>
                    <tbody class="table" id="">
                        <?php
                        $query = "CALL spu_asistencia";
                        $resultado = $conexion->query($query);
                             
                        ?>
                        <tbody>
                        <?php while ($i=$resultado->fetch_assoc()) {?>
                        <tr>
                          <td class='text-center'><?php  
                              echo $i["idusuario"];
                              ?></td>
                          <td class='text-center'><?php  
                              echo $i["nombres"];
                              ?></td>
                          <td class='text-center'><?php  
                              echo $i["apellidos"];
                              ?></td>
                          <td class='text-center'><?php  
                              echo $i["nombreusuario"];
                              ?></td>
                          <td class='text-center'><?php  
                              echo $i["ingreso"];
                              ?></td>
                        </tr>

                        <?php }?>
                      </tbody>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<script src="js/usuarios.js"></script>

