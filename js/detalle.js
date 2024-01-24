$(document).ready(function(){
    idproducto = "";
    var txtProducto = document.querySelector("#idproductomod");
    var botonActualizar = document.querySelector("#actualizar");
    var botonGuardar = document.querySelector("#registrar");

    function registrardetalle(){
        var motaplicacion = $("#motaplicacion").val();
        var producto_san = $("#producto_san").val();
        var unidad = $("#unidad").val();
        var diascarencia = $("#diascarencia").val();
        var dosiscil = $("#dosiscil").val();
        var ncil = $("#ncil").val();
        var dosistanque = $("#dosistanque").val();
        var tproducto = $("#tproducto").val();
        var dosisha = $("#dosisha").val();
        var haaplicada = $("#haaplicada").val();
        var gastoh20 = $("#gastoh20").val();
        var id_reporte = $("#id_reporte").val();
        if(motaplicacion==""||producto_san==""||unidad==""||diascarencia==""||dosiscil==""||ncil==""||dosistanque==""||tproducto == ""|| dosiscil == ""|| dosisha == ""|| haaplicada == ""|| gastoh20
        == ""){
            mostrarAlerta("warning", "¡Completar los campos necesarios!");
        }else{
            Swal.fire({
                icon:'question',
                title:'¿Está seguro de registrar?',
                showCancelButton: true,
                cancelButtonText:'Cancelar',
                confirmButtonText:'Aceptar'
            }).then((result) => {
                
                if(result.isConfirmed){
                    var datos = { 
                        'op'                : 'registrarDetalle',
                        'motaplicacion'     : motaplicacion,
                        'producto_san'      : producto_san,
                        'unidad'            : unidad,
                        'diascarencia'      : diascarencia,
                        'dosiscil'          : dosiscil,
                        'ncil'              : ncil,
                        'dosistanque'       : dosistanque,
                        'tproducto'         : tproducto,
                        'dosisha'           : dosisha,
                        'haaplicada'        : haaplicada,
                        'gastoh20'          : gastoh20,
                        'id_reporte'        : id_reporte,
                    };
                    console.log(datos);
                    $.ajax({
                        url : 'controllers/Detalle.controller.php',
                        type: 'GET',
                        data: datos,                        
                        success: function(result){
                            mostrarAlerta("success", "¡Registrado con éxito!");
                            $("#formularioDetalle")[0].reset();
                            listardetalles();
                        }
                    });
                }
            });
        }
    }
    

    function listardetalles(){
        let id_reporte=$("#id_reporte").val();
        console.log(id_reporte);
        $.ajax({
            url: 'controllers/Detalle.controller.php',
            type: 'GET',
            data: {
                'op': 'listardetalles',
                'id_reporte' : id_reporte
                },
                success: function(e){
                var tabla = $("#tablaDetalle").DataTable();
                tabla.destroy();
                $("#tablaDetallelistar").html(e);
                $("#tablaDetalle").DataTable({
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
    
    function listardetallesOperario(){
        let id_reporte=$("#id_reporte").val();
        console.log(id_reporte);
        $.ajax({
            url: 'controllers/Detalle.controller.php',
            type: 'GET',
            data: {
                'op': 'listardetallesOperario',
                'id_reporte' : id_reporte
                },
                success: function(e){
                var tabla = $("#tablaDetalleOperario").DataTable();
                tabla.destroy();
                $("#tablaDetallelistarOperario").html(e);
                $("#tablaDetalleOperario").DataTable({
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
    
    function cargarMotivoAplicacion(select){
        var datos ={
            'op': 'cargarMotivoAplicacion'
        };
        $.ajax({
            url : 'controllers/Categoriadetalle.controller.php',
            type: 'GET',
            data: datos,
            success:function(e){
                $(select).html(e);
            }
        });
    }
    function cargarProducto(select){
        var datos ={
            'op': 'cargarProducto'
        };
        $.ajax({
            url : 'controllers/Categoriadetalle.controller.php',
            type: 'GET',
            data: datos,
            success:function(e){
                $(select).html(e);
            }
        });
    }

    $("#producto_san").change(function(){
        let producto_san = $("#producto_san").val();
        var datos = {
            'op': 'cargarUnidad',
            'id_producto': producto_san
        }
        $.ajax({
            url: 'controllers/Categoriadetalle.controller.php',
            type: 'GET',
            data: datos,
            success: function(result){                        
                if ($.trim(result) != ""){
                    var resultado = JSON.parse(result);
                    $("#unidad").val(resultado[0].unidad);
                    console.log(resultado[0].unidad);
                }
            }
        });
    });

    $("#tablaDetalle").on("click", ".eliminar", function(){
        let id_detalle = $(this).attr('data-idproducto');
        console.log(id_detalle);
        Swal.fire({
            icon: 'question',
            title: 'AGROINDUSTRIAL BETA',
            text: 'Esta seguro de eliminar?',
            showCancelButton: true,
            cancelButtonText: 'Cancelar',
            confirmButtonText: 'Confirmar',
        }).then((result)=>{
            if(result.isConfirmed){
                var datos = {
                    'op' : 'eliminarDetalles',
                    'id_detallereporte' : id_detalle
                };
                $.ajax({
                    url: 'controllers/Detalle.controller.php',
                    type: 'GET',
                    data: datos,
                    success: function(e){
                        mostrarAlerta("success", "¡Eliminado correctamente!");
                        listardetalles();
                    }
                });
            }
            });
    });
 
    listardetalles();
    listardetallesOperario();
    cargarMotivoAplicacion("#motaplicacion");
    cargarProducto("#producto_san");
    $("#registrar").click(registrardetalle);
});
