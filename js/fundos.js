$(document).ready(function(){
    $('.money').mask("#,##0.00", {reverse: true});
    idproducto = "";
    var txtProducto = document.querySelector("#idproductomod");
    var botonActualizar = document.querySelector("#actualizar");
    var botonGuardar = document.querySelector("#registrar");

    function registrarFundo(){
        var idcategoria = $("#idcategoria").val();
        var nombreproducto = $("#nombreproducto").val();

        
        if(idcategoria == "" || nombreproducto == "" ){
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
                        'op'                : 'registrarFundo',
                        'idcategoria'       : idcategoria,
                        'nombreproducto'    : nombreproducto,
                    };
                    console.log(datos);
                    $.ajax({
                        url : 'controllers/Fundo.controller.php',
                        type: 'GET',
                        data: datos,                        
                        success: function(result){
                            mostrarAlerta("success", "¡Registrado con éxito!");
                            $("#formularioFundo")[0].reset();
                            listarProductosFarmaciaPrueba();
                            listarProductosMedicosPrueba();
                        }
                    });
                }
            });
        }
    }

    function nombreproductoYaExiste(){
        let nombreproductoYaExiste = $("#nombreproducto").val();

        if(nombreproductoYaExiste == ""){
            mostrarAlerta("warning", "¡Completar los campos necesarios!");
        }else{
            var datos = {
                'op' : 'nombrefundoYaRegistrado',
                'nombreproducto' : nombreproductoYaExiste
            };
            $.ajax({
                type: "GET",
                url:  "controllers/Fundo.controller.php",
                data: datos,
                success: function(e){
                    if(e == 1){
                        mostrarAlerta("error", "¡Ya existe este Fundo!");
                    }
                    else if(e == 2){
                        registrarFundo();
                    }else{
                        mostrarAlerta("error", "¡A ocurrido un error!");
                    }
                }
            });
        }
    }

    function cargarCategorias(select){
        var datos ={
            'op': 'cargarCategoria'
        };
        $.ajax({
            url : 'controllers/CategoriaFundo.controller.php',
            type: 'GET',
            data: datos,
            success:function(e){
                $(select).html(e);
            }
        });
    }
    function cargarCategoriaCultivos(select){
        var datos ={
            'op': 'cargarCategoriaCultivos'
        };
        $.ajax({
            url : 'controllers/CategoriaFundo.controller.php',
            type: 'GET',
            data: datos,
            success:function(e){
                $(select).html(e);
            }
        });
    }

    $("#cultivo").change(function(){
        let cultivo=$("#cultivo").val();
        // console.log(filtros);
        var datos={
            'op'            : 'cargarCategoriaVariedades',
            'id_cultivo'   :cultivo
        }
        $.ajax({
            url: 'controllers/CategoriaFundo.controller.php',
            type: 'GET',
            data: datos,
            success: function(e){
                $("#variedad").html(e);
            }
        });
    });
    function listarProductosMedicosPrueba(){
        $.ajax({
            url: 'controllers/Fundo.controller.php',
            type: 'GET',
            data: 'op=ListarProductoMedicoPrueba',
            success: function(e){
                var tabla = $("#tablaProductoMedico").DataTable();
                tabla.destroy();
                $("#tablaProductoMedicolistar").html(e);
                $("#tablaProductoMedico").DataTable({
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

    function listarProductosFarmaciaPrueba(){
        $.ajax({
            url: 'controllers/Fundo.controller.php',
            type: 'GET',
            data: 'op=ListarProductoFarmaciaPrueba',
            success: function(e){
                var tabla = $("#tablaProducto").DataTable();
                tabla.destroy();
                $("#tablaProductolistar").html(e);
                $("#tablaProducto").DataTable({
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


    /*$("#tablaProducto").on("click", ".eliminar", function(){
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
                    'op' : 'eliminarProducto',
                    'idproducto' : idproducto
                };
                $.ajax({
                    url: 'controllers/Producto.controller.php',
                    type: 'GET',
                    data: datos,
                    success: function(e){
                        mostrarAlerta("success", "¡Eliminado correctamente!");
                        listarProductosFarmaciaPrueba();
                        listarProductosMedicosPrueba();
                    }
                });
            }
            });
    });*/

    $("#tablaProducto").on('click', ".modificar", function(){
        let idproducto = $(this).attr('data-idproducto');
        
        var datos = {
            'op' : 'getProducto',
            'idproducto' : idproducto
        };
        
        $.ajax({
            url: 'controllers/Fundo.controller.php',
            type: 'GET',
            data: datos,
            success: function(result){                        
                if ($.trim(result) != ""){
                    //Asignamos y quitamos la clase que muestra la caja de texto
                    $("#Aviso").html("Actualizar Producto");
                    txtProducto.classList.remove('asignar');
                    botonActualizar.classList.remove('asignar');
                    botonGuardar.classList.add('asignar');
                    //$("#idcategoria").prop('disabled', true);
                    // $("#descripcion").prop('disabled', true);
                    

                    var resultado = JSON.parse(result);
                    // console.log(resultado);
                    
                    $("#idcategoria").val(resultado[0].jefe_fundo);
                    $("#nombreproducto").val(resultado[0].nombre);
                    $("#lote").val(resultado[0].lote);
                    $("#s_lote").val(resultado[0].s_lote);
                    $("#hectareas").val(resultado[0].hectareas);
                    $("#cultivo").val(resultado[0].cultivo);
                    $("#variedad").val(resultado[0].variedad);

                    // tinymce.get("nombreproducto").setContent(resultado[0].nombre);
                    txtProducto.setAttribute("data-idproducto", resultado[0].id_fundo);
                    $("#idproductomod").hide();
                }else{
                    mostrarAlerta("warning", "¡No encontramos registros!");
                }
            }
        });
    });
    
    $("#cancelar").click(function(){
        $("#formularioFundo")[0].reset();
        $("#Aviso").html("Registrar Producto");
        txtProducto.classList.add('asignar');
        botonActualizar.classList.add('asignar');
        botonGuardar.classList.remove('asignar');
        $("#descripcion").prop('disabled', false);
    });

    function modificarProducto(){
        let idproducto = $("#idproductomod").attr('data-idproducto');
        var idcategoria = $("#idcategoria").val();
        var nombreproducto = $("#nombreproducto").val();
        var lote = $("#lote").val();
        var s_lote = $("#s_lote").val();
        var hectareas = $("#hectareas").val();
        var cultivo = $("#cultivo").val();
        var variedad = $("#variedad").val();

        if(idcategoria == "" ||nombreproducto==""|| lote == "" || s_lote == "" || hectareas == "" || cultivo == "" || variedad == ""){
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
                        'op'                     : 'modificarProducto',
                        'idproducto'             : idproducto,
                        'idcategoria'            : idcategoria,
                        'nombreproducto'         : nombreproducto,
                        'lote'                   : lote, 
                        's_lote'                 : s_lote,
                        'hectareas'              : hectareas,
                        'cultivo'                : cultivo,
                        'variedad'               : variedad
                    };
                    console.log(datos);
                    $.ajax({
                        url: 'controllers/Fundo.controller.php',
                        type:'GET',
                        data: datos,
                        success:function(e){
                            mostrarAlerta("success", "¡Modificado con éxito!");

                            $("#formularioFundo")[0].reset();
                            $("#Aviso").html("Registrar Producto");
                            txtProducto.classList.add('asignar');
                            botonActualizar.classList.add('asignar');
                            botonGuardar.classList.remove('asignar');
                            $("#idcategoria").prop('disabled', false);

                            listarProductosFarmaciaPrueba();
                        }
                    });
                }
            });
        }
    }

    $("#categoriaselect").change(function(){
        var filtros = $(this).val();
        // console.log(filtros);
        if(filtros==""){
            listarProductosFarmaciaPrueba();
        }else{

            $.ajax({
                url: 'controllers/Fundo.controller.php',
                type: 'GET',
                data: {
                    'op': 'filtrarCategorias',
                    'idcategoria' : filtros
                    },
                success: function(result){
                    // console.log(result);
                    $("#tablaProductolistar").html(result);
                }
            });
        }
    });
    
    listarProductosFarmaciaPrueba();
    listarProductosMedicosPrueba();
    $("#registrar").click(nombreproductoYaExiste);
    $("#actualizar").click(modificarProducto);
    cargarCategorias("#idcategoria");
    cargarCategorias("#categoriaselect");
    cargarCategoriaCultivos("#cultivo");
    cargarCategoriaVariedades("#variedad");
});