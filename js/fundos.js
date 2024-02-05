$(document).ready(function(){
    $('.money').mask("#,##0.00", {reverse: true});
    idproducto = "";
    var txtProducto = document.querySelector("#idproductomod");
    var botonActualizar = document.querySelector("#actualizar");
    var botonGuardar = document.querySelector("#registrar");

    function registrarFundo(){
        var idcategoria = $("#idcategoria").val();
        var nombreproducto = $("#fundo").val();
        var lote = $("#lote").val();
        var s_lote = $("#s_lote").val();
        var hectareas = $("#hectareas").val();
        var cultivo = $("#cultivo").val();
        var variedad = $("#variedad").val();

        
        if(idcategoria == "" || nombreproducto == "" || lote == ""|| s_lote == ""|| hectareas == ""|| cultivo == ""|| variedad == ""){
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
                        'lote'              : lote,
                        's_lote'            : s_lote,
                        'hectareas'         : hectareas,
                        'cultivo'           : cultivo,
                        'variedad'          : variedad,
                    };
                    console.log(datos);
                    $.ajax({
                        url : 'controllers/Fundo.controller.php',
                        type: 'GET',
                        data: datos,                        
                        success: function(result){
                            mostrarAlerta("success", "¡Registrado con éxito!");
                            $("#formularioFundo")[0].reset();
                            listarfundos();
                        }
                    });
                }
            });
        }
    }
    
    function listarfundos(){
        $.ajax({
            url: 'controllers/Fundo.controller.php',
            type: 'GET',
            data: 'op=listarfundo',
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
    
    function cargarFundos(select){
        var datos ={
            'op': 'cargarCategoriaFundo'
        };
        $.ajax({
            url : 'controllers/CategoriaFundo.controller.php',
            type: 'GET',
            data: datos,
            success:function(e){
                $(select).html(e);
                $("#lote").html(e);
                $("s_lote").html(e);
            }
        });
    }

    $("#fundo").change(function(){
        let fundo=$("#fundo").val();
        var datos={
            'op'         : 'cargarLoteGET',
            'id_fundo'   :fundo
        }
        $.ajax({
            url: 'controllers/CategoriaFundo.controller.php',
            type: 'GET',
            data: datos,
            success: function(e){
                $("#lote").html(e);
                $("s_lote").html(e);
            }
        });
    });

    $("#lote").change(function(){
        let lote=$("#lote").val();
        var datos={
            'op'           : 'cargarCategoriaSubLote',
            'id_lote'       : lote
        }
        console.log("Recibe" + datos);
        console.log(datos);
        $.ajax({
            url: 'controllers/CategoriaFundo.controller.php',
            type: 'GET',
            data: datos,
            success: function(e){
                $("#s_lote").html(e);
            }
        });
    });

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
                    var resultado = JSON.parse(result);
                    $("#idcategoria").val(resultado[0].jefe_fundo);
                    $("#fundo").val(resultado[0].nombre);
                    const fundoE= resultado[0].nombre;
                    const fundo_lote= resultado[0].lote;
                    var datos={
                        'op'         : 'cargarLoteGET',
                        'id_fundo'   : fundoE,
                        'id_lote'    : fundo_lote
                    }
                    $.ajax({
                        url: 'controllers/CategoriaFundo.controller.php',
                        type: 'GET',
                        data: datos,
                        success: function(e){
                            $("#lote").html(e);
                        }
                    });
                    const fundo_lote1= resultado[0].lote;
                    const sublote= resultado[0].s_lote;
                    var datos={
                        'op'           : 'cargarCategoriaSubLoteGET',
                        'id_lote'       : fundo_lote1,
                        'id_sublote'    : sublote
                    }
                    $.ajax({
                        url: 'controllers/CategoriaFundo.controller.php',
                        type: 'GET',
                        data: datos,
                        success: function(e){
                            $("#s_lote").html(e);
                        }
                    });
                    $("#hectareas").val(resultado[0].hectareas);
                    $("#cultivo").val(resultado[0].cultivo);
                    let id_cultivo= resultado[0].cultivo;
                    let variedad_get= resultado[0].variedad;
                    var datos={
                        'op'            : 'cargarCategoriaVariedadesGET',
                        'id_cultivo'    :id_cultivo,
                        'variedad_get'  :variedad_get
                    }
                    $.ajax({
                        url: 'controllers/CategoriaFundo.controller.php',
                        type: 'GET',
                        data: datos,
                        success: function(e){
                            $("#variedad").html(e);
                        }
                    });
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

    function modificarFundo(){
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
                            listarfundos();
                        }
                    });
                }
            });
        }
    }

    $("#categoriaselect").change(function(){
        let jefe_fundo=$("#categoriaselect").val();
        if(jefe_fundo==""){
            listarfundos();
        }else{
            $.ajax({
                url: 'controllers/Fundo.controller.php',
                type: 'GET',
                data: {
                    'op': 'filtrarCategorias',
                    'jefe_fundo' : jefe_fundo
                    },
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
    });

    listarfundos();
    $("#registrar").click(registrarFundo);
    $("#actualizar").click(modificarFundo);
    cargarFundos('#fundo');
    cargarCategorias("#idcategoria");
    cargarCategorias("#categoriaselect");
    cargarCategoriaCultivos("#cultivo");
    cargarCategoriaSubLotes("#s_lote");
});