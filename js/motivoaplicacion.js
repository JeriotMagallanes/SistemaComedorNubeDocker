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

    function registrarMotivo(){
        var nombremotivo = $("#nombremotivo").val();

        if(nombremotivo == ""  ){
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
                        'op'                : 'registrarMotivo',
                        'nombremotivo'       : nombremotivo,
                    };
                    console.log(datos);
                    $.ajax({
                        url : 'controllers/MotivoAplicacion.controller.php',
                        type: 'GET',
                        data: datos,                        
                        success: function(result){
                            mostrarAlerta("success", "¡Registrado con éxito!");
                            $("#formularioMotivoAplicacion")[0].reset();
                            ListarMotivos();
                        }
                    });
                }
            });
        }
    }

    function nombreMotivoYaExiste(){
        let nombreMotivoYaExiste = $("#nombremotivo").val();
        if(nombreMotivoYaExiste == ""){
            mostrarAlerta("warning", "¡Completar los campos necesarios!");
        }else{
            var datos = {
                'op' : 'nombreMotivoYaRegistrado',
                'nombremotivo' : nombreMotivoYaExiste
            };
            $.ajax({
                type: "GET",
                url:  "controllers/MotivoAplicacion.controller.php",
                data: datos,
                success: function(e){
                    if(e == 1){
                        mostrarAlerta("error", "¡Ya existe este producto!");
                    }
                    else if(e == 2){
                        registrarMotivo();
                    }else{
                        mostrarAlerta("error", "¡A ocurrido un error!");
                    }
                }
            });
        }
    }


    function ListarMotivos(){
        $.ajax({
            url: 'controllers/MotivoAplicacion.controller.php',
            type: 'GET',
            data: 'op=ListarMotivos',
            success: function(e){
                var tabla = $("#tablamotivoaplicacion").DataTable();
                tabla.destroy();
                $("#tablaMotivolistar").html(e);
                $("#tablamotivoaplicacion").DataTable({
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
        
    function GestionMotivo(tipo, valor, icono, mensaje){
        var datos = {
            'op' : tipo,
            'motivo_estado' : valor
        };
        $.ajax({
            url: 'controllers/MotivoAplicacion.controller.php',
            type: 'GET',
            data: datos,
            success: function(e){
                mostrarAlerta(icono, mensaje);
            }
        });
    }

    $('#tablaMotivolistar').on('change',"#on",function(){
        var MotivoEstado = $(this).attr('data-motivoEstado');
        if(this.checked){
            GestionMotivo("reactivarMotivo", MotivoEstado, "success", "¡Restaurado con éxito!");
        }
        else{
            GestionMotivo("eliminarMotivo", MotivoEstado, "success", "¡Eliminado con éxito!");
        }
    });

    $("#tablamotivoaplicacion").on('click', ".modificar", function(){
        let idmotivo = $(this).attr('data-idproducto');

        var datos = {
            'op' : 'getMotivo',
            'idmotivo' : idmotivo
        };
        $.ajax({
            url: 'controllers/MotivoAplicacion.controller.php',
            type: 'GET',
            data: datos,
            success: function(result){                        
                if ($.trim(result) != ""){
                    $("#Aviso").html("Actualizar Producto");
                    txtProducto.classList.remove('asignar');
                    botonActualizar.classList.remove('asignar');
                    botonGuardar.classList.add('asignar');
                    var resultado = JSON.parse(result);
                    $("#nombremotivo").val(resultado[0].nombre_motivo);
                    txtProducto.setAttribute("data-idproducto", resultado[0].id_motivo);
                    $("#idproductomod").hide();
                }else{
                    mostrarAlerta("warning", "¡No encontramos registros!");
                }
            }
        });
    });
    
    $("#cancelar").click(function(){
        $("#formularioMotivoAplicacion")[0].reset();
        $("#Aviso").html("Registrar Producto");
        txtProducto.classList.add('asignar');
        botonActualizar.classList.add('asignar');
        botonGuardar.classList.remove('asignar');
        $("#descripcion").prop('disabled', false);
    });

    function modificarMotivo(){
        let id_motivo = $("#idproductomod").attr('data-idproducto');
        var nombre_motivo = $("#nombremotivo").val();

        if(nombre_motivo == "" ){
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
                        'op'                   : 'modificarProducto',
                        'id_motivo'            : id_motivo,
                        'nombre_motivo'        : nombre_motivo
                    };  
                    console.log(datos);
                    $.ajax({
                        url: 'controllers/MotivoAplicacion.controller.php',
                        type:'GET',
                        data: datos,
                        success:function(e){
                            mostrarAlerta("success", "¡Modificado con éxito!");
                            $("#formularioMotivoAplicacion")[0].reset();
                            $("#Aviso").html("Registrar Producto");
                            txtProducto.classList.add('asignar');
                            botonActualizar.classList.add('asignar');
                            botonGuardar.classList.remove('asignar');
                            ListarMotivos();
                        }
                    });
                }
            });
        }
    }

    ListarMotivos();
    $("#registrar").click(nombreMotivoYaExiste);
    $("#actualizar").click(modificarMotivo);
});