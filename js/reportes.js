$(document).ready(function(){
    idproducto = "";
    var txtProducto = document.querySelector("#idproductomod");
    var botonActualizar = document.querySelector("#actualizar");
    var botonGuardar = document.querySelector("#registrar");

    function registrarReporte(){
        var fechahoraReporte = $("#fechahoraReporte").val();
        var turno = $("#turno").val();
        var encSanidad = $("#encSanidad").val();
        var encQA = $("#encQA").val();
        var encAlmacen = $("#encAlmacen").val();
        var idcategoria = $("#idcategoria").val();
        var fundo = $("#fundo").val();
        var lote = $("#lote").val();
        var s_lote = $("#s_lote").val();
        var cultivo = $("#cultivo").val();
        var variedad = $("#variedad").val();
        if(encSanidad == "" || encQA == "" || encAlmacen == ""|| variedad == ""){
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
                        'op'                     : 'registrarReporte',
                        'fechahoraReporte'       : fechahoraReporte,
                        'turno'                  : turno,
                        'encSanidad'             : encSanidad,
                        'encQA'                  : encQA,
                        'encAlmacen'             : encAlmacen,
                        'idcategoria'            : idcategoria,
                        'fundo'                  : fundo,
                        'lote'                   : lote,
                        's_lote'                 : s_lote,
                        'cultivo'                : cultivo,
                        'variedad'               : variedad,
                    };
                    console.log(datos);
                    $.ajax({
                        url : 'controllers/Reporte.controller.php',
                        type: 'GET',
                        data: datos,                        
                        success: function(result){
                            mostrarAlerta("success", "¡Registrado con éxito!");
                            $("#formularioReporte")[0].reset();
                            ListarReportes();
                        }
                    });
                }
            });
        }
    }

    function cargarCategorias(select){
        var datos ={
            'op': 'cargarCategoria'
        };
        $.ajax({
            url : 'controllers/CategoriaReporte.controller.php',
            type: 'GET',
            data: datos,
            success:function(e){
                $(select).html(e);
            }
        });
    }
    $("#idcategoria").change(function(){
        let jefe_fundo=$("#idcategoria").val();
        var datos={
            'op'            : 'cargarCategoriaNombreFundo',
            'jefe_fundo'    :jefe_fundo
        }
        $.ajax({
            url: 'controllers/CategoriaReporte.controller.php',
            type: 'GET',
            data: datos,
            success: function(e){
                $("#fundo").html(e);
                $("#lote").html(e);
                $("#s_lote").html(e);
                $("#cultivo").html(e);
                $("#variedad").html(e);
            }
        });
    });
    $("#fundo").change(function(){
        let fundo=$("#fundo").val();
        let jefe_fundo=$("#idcategoria").val();
        var datos={
            'op'            : 'cargarCategoriaLoteNombreFundo',
            'nombre'        :fundo,
            'jefe_fundo'    :jefe_fundo
        }
        $.ajax({
            url: 'controllers/CategoriaReporte.controller.php',
            type: 'GET',
            data: datos,
            success: function(e){
                $("#lote").html(e);
                $("#s_lote").html(e);
                $("#cultivo").html(e);
                $("#variedad").html(e);
            }
        });
    });
    
    $("#lote").change(function(){
        let lote=$("#lote").val();
        console.log(datos);
        var datos={
            'op'           : 'cargarCategoriaSubLote',
            'id_lote'       : lote
        }
        console.log(datos);
        $.ajax({
            url: 'controllers/CategoriaReporte.controller.php',
            type: 'GET',
            data: datos,
            success: function(e){
                $("#s_lote").html(e);
                $("#cultivo").html(e);
                $("#variedad").html(e);
            }
        });
    });

    $("#s_lote").change(function(){
        let id_sub_lote=$("#s_lote").val();
        console.log(datos);
        var datos={
            'op'                : 'cargarCategoriaCultivoLote',
            'id_sub_lote'       : id_sub_lote
        }
        console.log(datos);
        $.ajax({
            url: 'controllers/CategoriaReporte.controller.php',
            type: 'GET',
            data: datos,
            success: function(e){
                $("#cultivo").html(e);
            }
        });
    });

    $("#s_lote").change(function(){
        let id_sub_lote=$("#s_lote").val();
        console.log(datos);
        var datos={
            'op'           : 'cargarCategoriaVariedadLote',
            's_lote'       : id_sub_lote
        }
        console.log(datos);
        $.ajax({
            url: 'controllers/CategoriaReporte.controller.php',
            type: 'GET',
            data: datos,
            success: function(e){
                $("#variedad").html(e);
            }
        });
    });

    function ListarReportes(){
        $.ajax({
            url: 'controllers/Reporte.controller.php',
            type: 'GET',
            data: 'op=ListarReportes',
            success: function(e){
                var tabla = $("#tablareporte").DataTable();
                tabla.destroy();
                $("#tablareportelistar").html(e);
                $("#tablareporte").DataTable({
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

    $("#tablareporte").on("click", ".eliminar", function(){
        let idproducto = $(this).attr('data-idproducto');
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
                    'op' : 'eliminarReporte',
                    'idproducto' : idproducto
                };
                $.ajax({
                    url: 'controllers/Reporte.controller.php',
                    type: 'GET',
                    data: datos,
                    success: function(e){
                        mostrarAlerta("success","¡Eliminado correctamente!");
                        ListarReportes();
                    }
                });
            }
            });
    });

    $("#tablareporte").on("click", ".detalle", function(){
        let idreporte = $(this).data('idproducto');
    
        // Realiza una solicitud AJAX para obtener los detalles del reporte
        $.ajax({
            url: 'administrardetallereporte.php',  // Reemplaza 'tu_archivo_php.php' con la ruta correcta
            type: 'POST',
            data: {
                'op'           : 'envio_id_reporte',
                'idreporte'    : idreporte
            },
            success: function(response) {
                
            },
            error: function(error) {
                console.error(error);
            }
        });
    });
    

    $("#tablareporte").on('click', ".modificar", function(){
        //let id_reporte = $(this).attr('data-idproducto');
        
        let id_reporte = $(this).data('idproducto');
        var datos = {
            'op' : 'getReporte',
            'id_reporte' : id_reporte
        };
        $.ajax({
            url: 'controllers/Reporte.controller.php',
            type: 'GET',
            data: datos,
            success: function(result){                        
                if ($.trim(result) != ""){
                    //Asignamos y quitamos la clase que muestra la caja de texto
                    $("#Aviso").html("Actualizar Producto");
                    txtProducto.classList.remove('asignar');
                    botonActualizar.classList.remove('asignar');
                    botonGuardar.classList.add('asignar');
                    var resultado = JSON.parse(result);
                    $("#fechahoraReporte").val(resultado[0].fecha_hora);
                    $("#turno").val(resultado[0].turno);
                    $("#encSanidad").val(resultado[0].enc_sanidad);
                    $("#encQA").val(resultado[0].enc_QA);
                    $("#encAlmacen").val(resultado[0].enc_almacen);
                    $("#idcategoria").val(resultado[0].jefe_fundo);
                    $("#fundo").val(resultado[0].nom_fundo);
                    $("#lote").val(resultado[0].nombre_lote);
                    $("#s_lote").val(resultado[0]._slote_nombre);
                    $("#cultivo").val(resultado[0].nombre_cultivo);
                    $("#variedad").val(resultado[0].nombre_variedad);
                    txtProducto.setAttribute("data-idproducto", resultado[0].id_reporte);
                    $("#idproductomod").hide();
                }else{
                    mostrarAlerta("warning", "¡No encontramos registros!");
                }
            }
        });
    });
    

    $("#cancelar").click(function(){
        $("#formularioReporte")[0].reset();
        $("#Aviso").html("Registrar Producto");
        txtProducto.classList.add('asignar');
        botonActualizar.classList.add('asignar');
        botonGuardar.classList.remove('asignar');
        $("#descripcion").prop('disabled', false);
    });

    function modificarProducto(){
        let idreporte = $("#idproductomod").attr('data-idproducto');
        var encSanidad = $("#encSanidad").val();
        var encQA = $("#encQA").val();
        var encAlmacen = $("#encAlmacen").val();
        var idcategoria = $("#idcategoria").val();
        var fundo = $("#fundo").val();
        var lote = $("#lote").val();
        var s_lote = $("#s_lote").val();
        var cultivo = $("#cultivo").val();
        var variedad = $("#variedad").val();

        if(idcategoria == "" || fundo==""|| variedad == "" ||encSanidad == "" || encQA==""|| encAlmacen == "" ){
            mostrarAlerta("warning", "¡Completar los campos necesarios!");
        }else{
            Swal.fire({
                icon:'question',
                title:'¿Está seguro de modificar?',
                showCancelButton: true,
                cancelButtonText:'Cancelar',
                confirmButtonText:'Aceptar'
            }).then((result) =>{
                if(result.isConfirmed){
                    var datos = {
                        'op'                     : 'modificarReporte',
                        'idreporte'              : idreporte,
                        'encSanidad'             : encSanidad,
                        'encQA'                  : encQA, 
                        'encAlmacen'             : encAlmacen,
                        'idcategoria'            : idcategoria,
                        'fundo'                  : fundo,
                        'lote'                   : lote,
                        's_lote'                 : s_lote,
                        'cultivo'                : cultivo,
                        'variedad'               : variedad
                    };
                    console.log(datos);
                    $.ajax({
                        url: 'controllers/Reporte.controller.php',
                        type:'GET',
                        data: datos,
                        success:function(e){
                            mostrarAlerta("success", "¡Modificado con éxito!");
                            $("#formularioReporte")[0].reset();
                            $("#Aviso").html("Registrar Producto");
                            txtProducto.classList.add('asignar');
                            botonActualizar.classList.add('asignar');
                            botonGuardar.classList.remove('asignar');
                            $("#idcategoria").prop('disabled', false);
                            ListarReportes();
                        }
                    });
                }
            });
        }
    }

    function buscarFecha(){
    var fechafinal = $("#fechafinal").val();
    var fechainicial = $("#fechainicial").val();
    if((fechafinal=="")&&(fechainicial="")){
        ListarReportes();
    }else{
        $.ajax({
            url: 'controllers/Reporte.controller.php',
            type: 'GET',
            data: {
                'op': 'filtrarFechas',
                'fechainicial' : fechainicial,
                'fechafinal'   : fechafinal
                },
            success: function(result){
                // console.log(result);
                $("#tablareportelistar").html(result);
            }
        });
    }
    if(fechafinal<fechainicial){
        mostrarAlerta("warning", "¡Rango de fechas invalidos!");
    }
    }
    
    ListarReportes();
    $("#registrar").click(registrarReporte);
    $("#actualizar").click(modificarProducto);
    $("#bfecha").click(buscarFecha);
    cargarCategorias("#idcategoria");
    cargarCategoriaNombreFundos("#fundo");
    cargarCategoriaLoteNombreFundos("#lote");
    cargarCategoriaCultivosLotes("#s_lote");
    cargarCategoriaVariedades("#variedad");
});