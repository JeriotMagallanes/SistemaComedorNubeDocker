$(document).ready(function(){

    idcomida = "";
    var txtAlmuerzo = document.querySelector("#idcomida");
    var botonActualizar = document.querySelector("#actualizar");
    var botonGuardar = document.querySelector("#registrar");


    function registrarAlmuerzo(){
        var fecha = $("#fecha").val();
        var desayuno = $("#desayuno").val();
        var almuerzo = $("#almuerzo").val();
        var cena = $("#cena").val();
        var rdesayuno = $("#rdesayuno").val();
        var ralmuerzo = $("#ralmuerzo").val();
        var rcena = $("#rcena").val();
        if(fecha == "" || desayuno == "" || cena == "" || almuerzo =="" || rdesayuno == "" || rcena == "" || ralmuerzo ==""){
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
                        'op'                : 'registrarAlmuerzo',
                        'fecha'             : fecha,
                        'desayuno'          : desayuno,
                        'almuerzo'          : almuerzo,
                        'cena'              : cena,
                        'rdesayuno'         : rdesayuno,
                        'ralmuerzo'         : ralmuerzo,
                        'rcena'             : rcena
                    };
                    console.log(datos);
                    $.ajax({
                        url : 'controllers/Almuerzo.controller.php',
                        type: 'GET',
                        data: datos,                        
                        success: function(result){
                            mostrarAlerta("success", "¡Registrado con éxito!");
                            $("#formularioAlmuerzo")[0].reset();
                            ListarAlmuerzo();
                        }
                    });
                }
            });
        }
    }

    function ListarAlmuerzo(){
        $.ajax({
            url: 'controllers/Almuerzo.controller.php',
            type: 'GET',
            data: 'op=ListarAlmuerzo',
            success: function(e){
                var tabla = $("#tablaAlmuerzo").DataTable();
                tabla.destroy();
                $("#tablaAlmuerzolistar").html(e);
                $("#tablaAlmuerzo").DataTable({
                    language: { url: '//cdn.datatables.net/plug-ins/1.10.24/i18n/Spanish.json' },
                    columnDefs: [
                    {
                        visible: true,
                        searchable: true,
                        targets: 0, // Asegúrate de que esta sea la columna correcta que contiene las fechas
                        type: 'date' // Especifica el tipo de datos como fecha
                    }
                    ],
                    order: [[0, 'desc']], // Ordena por la primera columna (índice 0) en orden descendente (más reciente primero)
                    dom: 'Bfrtip',
                    buttons: ['copy', 'print', 'pdf', 'excel']
                });
            }
        });
    }
    

    $("#tablaAlmuerzo").on('click', ".modificar", function(){
        let idcomida = $(this).attr('data-idcomida');
        var datos = {
            'op' : 'getAlmuerzo',
            'idcomida' : idcomida
        };
        $.ajax({
            url: 'controllers/Almuerzo.controller.php',
            type: 'GET',
            data: datos,
            success: function(result){                        
                if ($.trim(result) != ""){
                    $("#Aviso").html("Actualizar Almuerzo");
                    txtAlmuerzo.classList.remove('asignar');
                    botonActualizar.classList.remove('asignar');
                    botonGuardar.classList.add('asignar');
                    var resultado = JSON.parse(result);
                    $("#fecha").val(resultado[0].fecha);
                    $("#desayuno").val(resultado[0].desayuno);
                    $("#almuerzo").val(resultado[0].almuerzo);
                    $("#cena").val(resultado[0].cena);
                    $("#rdesayuno").val(resultado[0].rdesayuno);
                    $("#ralmuerzo").val(resultado[0].ralmuerzo);
                    $("#rcena").val(resultado[0].rcena);
                    txtAlmuerzo.setAttribute("data-idcomida", resultado[0].idAlmuerzo);
                    $("#idcomida").hide();
                }else{
                    mostrarAlerta("warning", "¡No encontramos registros!");
                }
            }
        });
    });
    
    $("#cancelar").click(function(){
        $("#formularioAlmuerzo")[0].reset();
        $("#Aviso").html("Registrar Desayuno");
        txtAlmuerzo.classList.add('asignar');
        botonActualizar.classList.add('asignar');
        botonGuardar.classList.remove('asignar');
    });

    function modificarAlmuerzo(){
        let idcomida = $("#idcomida").attr('data-idcomida');
        var fecha = $("#fecha").val();
        var desayuno = $("#desayuno").val();
        var almuerzo = $("#almuerzo").val();
        var cena = $("#cena").val();
        var rdesayuno = $("#rdesayuno").val();
        var ralmuerzo = $("#ralmuerzo").val();
        var rcena = $("#rcena").val();
        if(fecha == "" || desayuno == "" || cena == "" || almuerzo =="" || rdesayuno == "" || rcena == "" || ralmuerzo ==""){
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
                        'op'                     : 'modificarAlmuerzo',
                        'idcomida'               : idcomida,
                        'fecha'                  : fecha,
                        'desayuno'               : desayuno,
                        'almuerzo'               : almuerzo,
                        'cena'              : cena,
                        'rdesayuno'         : rdesayuno,
                        'ralmuerzo'         : ralmuerzo,
                        'rcena'             : rcena
                    };  
                    $.ajax({
                        url: 'controllers/Almuerzo.controller.php',
                        type:'GET',
                        data: datos,
                        success:function(e){
                            mostrarAlerta("success", "¡Modificado con éxito!");

                            $("#formularioAlmuerzo")[0].reset();
                            $("#Aviso").html("Registrar Desayuno");
                            txtAlmuerzo.classList.add('asignar');
                            botonActualizar.classList.add('asignar');
                            botonGuardar.classList.remove('asignar');
                            ListarAlmuerzo();
                        }
                    });
                }
            });
        }
    }

    ListarAlmuerzo();
    $("#registrar").click(registrarAlmuerzo);
    $("#actualizar").click(modificarAlmuerzo);
});