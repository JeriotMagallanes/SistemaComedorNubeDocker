$(document).ready(function(){

    idestudiante = "";
    var txtEstudiante = document.querySelector("#idestudiante");
    var botonActualizar = document.querySelector("#actualizar");
    var botonGuardar = document.querySelector("#registrar");
    

    function registrarEstudiante(){
        let coduniversitario = $("#coduniversitario").val();
        let dni = $("#dni").val();
        let nombres = $("#nombres").val();
        let apaterno = $("#apaterno").val();
        let amaterno = $("#amaterno").val();
        let carrera = $("#carrera").val();
        let desayuno = $("#desayuno").val();
        let almuerzo = $("#almuerzo").val();
        let cena = $("#cena").val();
        if(coduniversitario == "" || dni == "" || nombres == ""|| apaterno == "" || amaterno == "" || carrera == "" || desayuno == "" || almuerzo == "" || cena == ""){
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
                        'op'                : 'registrarEstudiantes',
                        'coduniversitario'  : coduniversitario, 
                        'dni'               : dni,
                        'nombres'           : nombres,
                        'apaterno'          : apaterno,
                        'amaterno'          : amaterno,
                        'carrera'           : carrera,
                        'desayuno'          : desayuno,
                        'almuerzo'          : almuerzo,
                        'cena'              : cena
                    };
                    console.log(datos);
                    $.ajax({
                        url : 'controllers/Estudiante.controller.php',
                        type: 'GET',
                        data: datos,                        
                        success: function(result){
                            mostrarAlerta("success", "¡Registrado con éxito!");
                            $("#formularioEstudiante")[0].reset();
                            listarEstudiantes();
                        }
                    });
                }
            });
        }
    }

    function listarEstudiantes(){
        $.ajax({
            url: 'controllers/Estudiante.controller.php',
            type: 'GET',
            data: 'op=listarEstudiantes',
            success: function(e){
                var tabla = $("#tablaEstudiante").DataTable();
                tabla.destroy();
                $("#datosEstudiante").html(e);
                $("#tablaEstudiante").DataTable({
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

    function GestionEstudiante(tipo, valor, icono, mensaje){
        var datos = {
            'op' : tipo,
            'idestudiante' : valor
        };
        $.ajax({
            url: 'controllers/Estudiante.controller.php',
            type: 'GET',
            data: datos,
            success: function(e){
                mostrarAlerta(icono, mensaje);
            }
        });
    }

    $('#datosEstudiante').on('change',"#on",function(){
        var idestudiante = $(this).attr('data-idestudiante');
        if(this.checked){
            GestionEstudiante("reactivarEstudiante", idestudiante, "success", "¡Restaurado con éxito!");
        }
        else{
            GestionEstudiante("eliminarEstudiante", idestudiante, "success", "¡Eliminado con éxito!");
        }
    });

    $("#tablaEstudiante").on('click', ".modificar", function(){
        var idestudiante = $(this).attr('data-idestudiante');
        $.ajax({
            url: 'controllers/Estudiante.controller.php',
            type: 'GET',
            data: {
                'op': 'getEstudiante',
                'idestudiante' : idestudiante
            },
            success: function(result){                        
                if ($.trim(result) != ""){
                    $("#Aviso").html("Actualizar Usuario");
                    txtEstudiante.classList.remove('asignar');
                    botonActualizar.classList.remove('asignar');
                    botonGuardar.classList.add('asignar');
                    var resultado = JSON.parse(result);
                    $("#coduniversitario").val(resultado[0].cUniversitario);
                    $("#dni").val(resultado[0].	dni);
                    $("#nombres").val(resultado[0].nombres);
                    $("#apaterno").val(resultado[0].aPaterno);
                    $("#amaterno").val(resultado[0].aMaterno);
                    $("#carrera").val(resultado[0].carrera);
                    $("#desayuno").val(resultado[0].desayuno);
                    $("#almuerzo").val(resultado[0].almuerzo);
                    $("#cena").val(resultado[0].cena);
                    txtEstudiante.setAttribute("data-idestudiante", resultado[0].id);
                    $("#idestudiante").hide();
                }else{
                    mostrarAlerta("warning", "¡No encontramos registros!");
                }
            }
        });
    });

    function modificarEstudiantes(){
        let idestudiante = $("#idestudiante").attr('data-idestudiante');
        let coduniversitario = $("#coduniversitario").val();
        let dni = $("#dni").val();
        let nombres = $("#nombres").val();
        let apaterno = $("#apaterno").val();
        let amaterno = $("#amaterno").val();
        let carrera = $("#carrera").val();
        let desayuno = $("#desayuno").val();
        let almuerzo = $("#almuerzo").val();
        let cena = $("#cena").val();
        if(coduniversitario == "" || dni == "" || nombres == ""|| apaterno == "" || amaterno == "" || carrera == "" || desayuno == "" || almuerzo == "" || cena == ""){
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
                        'op'                : 'modificarEstudiante',
                        'idestudiante'      : idestudiante,
                        'coduniversitario'  : coduniversitario, 
                        'dni'               : dni,
                        'nombres'           : nombres,
                        'apaterno'          : apaterno,
                        'amaterno'          : amaterno,
                        'carrera'           : carrera,
                        'desayuno'          : desayuno,
                        'almuerzo'          : almuerzo,
                        'cena'              : cena
                    };
                    $.ajax({
                        url: 'controllers/Estudiante.controller.php',
                        type:'GET',
                        data: datos,
                        success:function(e){
                            mostrarAlerta("success", "¡Modificado con éxito!");
                            $("#formularioEstudiante")[0].reset();
                            $("#Aviso").html("Estudiantes");
                            txtEstudiante.classList.add('asignar');
                            botonActualizar.classList.add('asignar');
                            botonGuardar.classList.remove('asignar');
                            listarEstudiantes();
                        }
                    });
                }
            });
        }
    }

    function nombreEstudianteYaExiste(){
        let nombreEstudianteYaExiste = $("#dni").val();
        
        if(nombreEstudianteYaExiste == ""){
            mostrarAlerta("warning", "¡Completar los campos necesarios!");
        }else{
            var datos = {
                'op' : 'nombreestudianteYaRegistrado',
                'dniestudiante' : nombreEstudianteYaExiste
            };
            $.ajax({
                type: "GET",
                url:  "controllers/Estudiante.controller.php",
                data: datos,
                success: function(e){
                    if(e == 1){
                        mostrarAlerta("error", "¡Ya existe este nombre de usuario!");
                    }
                    else if(e == 2){
                        registrarEstudiante();
                    }else{
                        mostrarAlerta("error", "¡A ocurrido un error!");
                    }
                }
            });
        }
    }
    $("#cancelar").click(function(){
        $("#formularioEstudiante")[0].reset();
        $("#Aviso").html("Registrar Estudiante");
        txtEstudiante.classList.add('asignar');
        botonActualizar.classList.add('asignar');
        botonGuardar.classList.remove('asignar');
    });

    $("#registrar").click(nombreEstudianteYaExiste);
    $("#actualizar").click(modificarEstudiantes);
    listarEstudiantes();
});