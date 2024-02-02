$(document).ready(function(){
    function cargarJoperacionnes(select){
        var datos ={
            'op': 'cargarJOperaciones'
        };
        $.ajax({
            url : 'controllers/JOperaciones.controller.php',
            type: 'GET',
            data: datos,
            success:function(e){
                $(select).html(e);
            }
        });
    }

    $("#joperaciones").change(function(){
        let joperaciones=$("#joperaciones").val();
        console.log(joperaciones);
        var datos = {
            'op': 'getJOperaciones',
            'joperaciones': joperaciones
        }
        $.ajax({
            url: 'controllers/JOperaciones.controller.php',
            type: 'GET',
            data: datos,
            success: function(result){                        
                if ($.trim(result) != ""){
                    var resultado = JSON.parse(result);
                    $("#apellidos").val(resultado[0].apellidos);
                    $("#nombres").val(resultado[0].nombres);
                }
            }
        });
    });

    function listarJefeFundo(){
        $.ajax({
            url: 'controllers/JOperaciones.controller.php',
            type: 'GET',
            data: 'op=listarJefeFundo',
            success: function(e){
                var tabla = $("#tablaJOperaciones").DataTable();
                tabla.destroy();
                $("#tablaJOperacionesListar").html(e);
                $("#tablaJOperaciones").DataTable({
                    language: { url: '//cdn.datatables.net/plug-ins/1.10.24/i18n/Spanish.json' },
                    columnDefs: [
                    {
                        visible: true,
                        searchable: true
                    }
                    ],
                    dom: 'Bfrtip',
                    buttons: ['copy', 'print', 'pdf', 'excel']
                });
            }
        });
    }
    $("#joperaciones").change(function(){
        let jefeOperaciones=$("#joperaciones").val();
        if(jefeOperaciones==""){
            listarJefeFundo();
            
        }else{
            $.ajax({
                url: 'controllers/JOperaciones.controller.php',
                type: 'GET',
                data: {
                    'op': 'filtrar_JFundo_JOperaciones',
                    'jefeOperaciones' : jefeOperaciones
                    },
                success: function(e){
                    var tabla = $("#tablaJOperaciones").DataTable();
                    tabla.destroy();
                    $("#tablaJOperacionesListar").html(e);
                    $("#tablaJOperaciones").DataTable({
                        language: { url: '//cdn.datatables.net/plug-ins/1.10.24/i18n/Spanish.json' },
                        columnDefs: [
                        {
                            visible: true,
                            searchable: true
                        }
                        ],
                        dom: 'Bfrtip',
                        buttons: ['copy', 'print', 'pdf', 'excel']
                    });
                }
            });
        }
    });
    function GestionJOperaciones(tipo, valor,valor2, icono, mensaje){
        var datos = {
            'op' : tipo,
            'JOperaccionesasignar' : valor,
            'id_JOperaciones' : valor2
        };
        $.ajax({
            url: 'controllers/JOperaciones.controller.php',
            type: 'GET',
            data: datos,
            success: function(e){
                mostrarAlerta(icono, mensaje);
            }
        });
        console.log(datos);
    }

    $('#tablaJOperacionesListar').on('change',"#on",function(){
        var JOperacionesAsignar = $(this).attr('data-estado_JOperaciones');
        let id_JOperaciones=$("#id_JOperaciones").val();
        if(this.checked){
            GestionJOperaciones("asignarJOperaciones", JOperacionesAsignar,id_JOperaciones, "success", "¡Asignado con éxito!");
        }
        else{
            GestionJOperaciones("desasignarJOperaciones", JOperacionesAsignar,id_JOperaciones, "success", "¡Desasignado con éxito!");
        }
    });
    listarJefeFundo();
    cargarJoperacionnes('#joperaciones');
});
