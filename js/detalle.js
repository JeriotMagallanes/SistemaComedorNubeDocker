$(document).ready(function(){
    idproducto = "";
    var txtProducto = document.querySelector("#idproductomod");
    var botonActualizar = document.querySelector("#actualizar");
    var botonGuardar = document.querySelector("#registrar");

    function pasaridDetalleListar(idreporte) {
        // Hacer algo con el ID en este archivo
        console.log("Función en otro archivo JavaScript. ID del reporte:", idreporte);
    }
    function registrarFundo(){
        var idcategoria = $("#idcategoria").val();
        var nombreproducto = $("#nombreproducto").val();
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
    

    function listardetalles(){
        $.ajax({
            url: 'controllers/Detalle.controller.php',
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

    $("#tablaProducto").on("click", ".eliminar", function(){
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
    });
 
    listardetalles();
    /*$("#registrar").click(registrarFundo);
    $("#actualizar").click(modificarProducto);
    cargarCategorias("#idcategoria");
    cargarCategorias("#categoriaselect");
    cargarCategoriaLotes("#lote");
    cargarCategoriaCultivos("#cultivo");
    cargarCategoriaSubLotes("#s_lote");
    cargarCategoriaVariedades("#variedad");*/
});

<script src="reporte.js"></script>