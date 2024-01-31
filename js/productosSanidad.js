$(document).ready(function(){

    idproducto = "";
    var txtProducto = document.querySelector("#idproductomod");
    var botonActualizar = document.querySelector("#actualizar");
    var botonGuardar = document.querySelector("#registrar");

    tinymce.init({
        selector: 'textarea',
        menubar:false,
        height: 200,
        plugins: [
            'advlist', 'autolink', 'lists', 'link', 'image', 'charmap', 'preview',
            'anchor', 'searchreplace', 'visualblocks', 'code', 'fullscreen',
            'insertdatetime', 'media', 'table', 'help', 'wordcount'
        ],
        toolbar: 'undo redo | ' +
        'fontfamily fontsize bold italic underline backcolor  forecolor | ',
    });

    function registrarProducto(){
        var codigoproducto = $("#codigoproducto").val();
        var nombreproducto = $("#nombreproducto").val();
        var unidadproducto = $("#unidadproducto").val();

        if(codigoproducto == "" || nombreproducto == "" || unidadproducto == "" ){
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
                        'op'                : 'registrarProducto',
                        'codigoproducto'       : codigoproducto,
                        'nombreproducto'    : nombreproducto,
                        'unidadproducto'  : unidadproducto,
                    };
                    console.log(datos);
                    $.ajax({
                        url : 'controllers/ProductoSanidad.controller.php',
                        type: 'GET',
                        data: datos,                        
                        success: function(result){
                            mostrarAlerta("success", "¡Registrado con éxito!");
                            $("#formularioProductos")[0].reset();
                            listarProductosFarmaciaPrueba();
                        }
                    });
                }
            });
        }
    }

    function nombreproductoYaExiste(){
        // let nombreproductoYaExiste = $("#nombreproducto").val();
        let nombreproductoYaExiste = $("#nombreproducto").val();

        if(nombreproductoYaExiste == ""){
            mostrarAlerta("warning", "¡Completar los campos necesarios!");
        }else{
            var datos = {
                'op' : 'nombreproductoYaRegistrado',
                'nombreproducto' : nombreproductoYaExiste
            };
            $.ajax({
                type: "GET",
                url:  "controllers/ProductoSanidad.controller.php",
                data: datos,
                success: function(e){
                    if(e == 1){
                        mostrarAlerta("error", "¡Ya existe este producto!");
                    }
                    else if(e == 2){
                        registrarProducto();
                    }else{
                        mostrarAlerta("error", "¡A ocurrido un error!");
                    }
                }
            });
        }
    }


    function listarProductosFarmaciaPrueba(){
        $.ajax({
            url: 'controllers/ProductoSanidad.controller.php',
            type: 'GET',
            data: 'op=ListarProductos',
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

    function ListarProductos(){
        var tabla = $("#tablaProducto").DataTable();
        tabla.destroy();

        tabla = $("#tablaProducto").DataTable({
            "processing" : true,
            "serverSide" : true,
            "order"      : [[2, "asc"]],
            "sAjaxSource": 'controllers/ProductoSanidad.controller.php?op=ListarProductoFarmacia',
            "pageLength" : 10,
            "language": { url: '//cdn.datatables.net/plug-ins/1.10.24/i18n/Spanish.json'},
            "dom": 'Bfrtip',
            "buttons": ['copy', 'print', 'pdf', 'excel'],
            "columnDefs" : [
                {
                    "data": null,
                    render: function(data,type,row){
                        return `
                            <a  href='#' data-idproducto='${data[0]}' class='btn btn-sm btn-outline-secondary modificar'>
                                <i class='fas fa-edit'></i>
                            </a>
                            <a  href='#' data-idproducto='${data[0]}' class='btn btn-sm btn-outline-secondary eliminar'>
                                <i class='fas fa-trash-alt'></i>
                            </a>
                        `;
                    },
                    "targets":5
                }
            ]
        });
    }  

    $("#tablaProducto").on("click", ".eliminar", function(){
        let idproducto = $(this).attr('data-idproducto');
        Swal.fire({
            icon: 'question',
            title: 'COMPLEJO AGROINDUSTRIAL',
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
                    url: 'controllers/ProductoSanidad.controller.php',
                    type: 'GET',
                    data: datos,
                    success: function(e){
                        mostrarAlerta("success", "¡Eliminado correctamente!");
                        listarProductosFarmaciaPrueba();
                    }
                });
            }
            });
    });

    $("#tablaProducto").on('click', ".modificar", function(){
        let idproducto = $(this).attr('data-idproducto');

        var datos = {
            'op' : 'getProducto',
            'idproducto' : idproducto
        };
        // console.log(datos);
        $.ajax({
            url: 'controllers/ProductoSanidad.controller.php',
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
                    $("#codigoproducto").val(resultado[0].codigo_producto);
                    $("#nombreproducto").val(resultado[0].nombre_producto);
                    $("#unidadproducto").val(resultado[0].unidad);
                    txtProducto.setAttribute("data-idproducto", resultado[0].id_producto);
                    $("#idproductomod").hide();
                }else{
                    mostrarAlerta("warning", "¡No encontramos registros!");
                }
            }
        });
    });
    
    $("#cancelar").click(function(){
        $("#formularioProductos")[0].reset();
        $("#Aviso").html("Registrar Producto");
        txtProducto.classList.add('asignar');
        botonActualizar.classList.add('asignar');
        botonGuardar.classList.remove('asignar');
        $("#descripcion").prop('disabled', false);
    });

    function modificarProducto(){
        let id_producto = $("#idproductomod").attr('data-idproducto');
        var codigo_producto = $("#codigoproducto").val();
        var nombre_producto = $("#nombreproducto").val();
        var unidad = $("#unidadproducto").val();

        if(codigo_producto == "" || nombre_producto == "" || unidad == "" ){
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
                        'id_producto'            : id_producto,
                        'codigo_producto'        : codigo_producto,
                        'nombre_producto'        : nombre_producto, 
                        'unidad'                 : unidad, 
                    };  
                    console.log(datos);
                    $.ajax({
                        url: 'controllers/ProductoSanidad.controller.php',
                        type:'GET',
                        data: datos,
                        success:function(e){
                            mostrarAlerta("success", "¡Modificado con éxito!");

                            $("#formularioProductos")[0].reset();
                            $("#Aviso").html("Registrar Producto");
                            txtProducto.classList.add('asignar');
                            botonActualizar.classList.add('asignar');
                            botonGuardar.classList.remove('asignar');

                            listarProductosFarmaciaPrueba();
                        }
                    });
                }
            });
        }
    }
    
    function GestionProducto(tipo, valor, icono, mensaje){
        var datos = {
            'op' : tipo,
            'producto_estado' : valor
        };
        $.ajax({
            url: 'controllers/ProductoSanidad.controller.php',
            type: 'GET',
            data: datos,
            success: function(e){
                mostrarAlerta(icono, mensaje);
            }
        });
    }

    $('#tablaProductolistar').on('change',"#on",function(){
        var productoEstado = $(this).attr('data-productoEstado');
        if(this.checked){
            GestionProducto("reactivarProducto", productoEstado, "success", "¡Restaurado con éxito!");
        }
        else{
            GestionProducto("eliminarProducto", productoEstado, "success", "¡Eliminado con éxito!");
        }
    });
    
    listarProductosFarmaciaPrueba();
    $("#registrar").click(nombreproductoYaExiste);
    $("#actualizar").click(modificarProducto);
});