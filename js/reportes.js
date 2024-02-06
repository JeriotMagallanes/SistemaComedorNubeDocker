$(document).ready(function(){
    idproducto = "";
    jefe_fundo="";
    var txtProducto = document.querySelector("#idproductomod");
    var botonActualizar = document.querySelector("#actualizar");
    var botonGuardar = document.querySelector("#registrar");
    var bitacoraReporte = {};

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
        var nreserva = $("#nreserva").val();
        var ninstructivo = $("#ninstructivo").val();
        var pep = $("#pep").val();
        var etcultivo = $("#etcultivo").val();
        if(encSanidad == "" || encQA == "" || encAlmacen == ""|| variedad == ""||cultivo==null  ||nreserva== ""|| ninstructivo == ""||pep== ""||etcultivo== ""){
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
                        'nreserva'               : nreserva,
                        'ninstructivo'           : ninstructivo,
                        'pep'                    : pep,
                        'etcultivo'              : etcultivo
                    };
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
    $("#tablareporte").on("click", ".eliminar", function(){
        let idproducto = $(this).attr('data-idproducto');
        var observacionInput = '<label>¿Esta seguro de elminar el reporte con codigo '+idproducto+'?</label><input type="text" class="swal2-input" id="observacion" placeholder="Observacion">';
        Swal.fire({
            icon: 'question',
            title: 'AGROINDUSTRIAL BETA',
            html: observacionInput,
            showCancelButton: true,
            cancelButtonText: 'Cancelar',
            confirmButtonText: 'Confirmar',
            preConfirm: () => {
                var observacion = Swal.getPopup().querySelector('#observacion').value;
                if (!observacion) {
                    Swal.showValidationMessage('¡La observación es obligatoria!');
                }
                return { observacion: observacion };
            }
        }).then((result)=>{
            if(result.isConfirmed){
                var observacion = result.value.observacion;
    
                var datos = {
                    'op' : 'eliminarReporte',
                    'idproducto' : idproducto,
                    'observacion' : observacion
                };
    
                $.ajax({
                    url: 'controllers/Reporte.controller.php',
                    type: 'GET',
                    data: datos,
                    success: function(e){
                        mostrarAlerta("success", "¡Eliminado correctamente!");
                        ListarReportes();
                    }
                });
            }
        });
    });

    $("#tablareporteJfundo").on("click", ".aprobar", function(){
        let id_reporte = $(this).attr('data-idproducto');
        Swal.fire({
            icon: 'question',
            title: 'AGROINDUSTRIAL BETA',
            text: 'Esta seguro de Aprobar el Reporte N°'+id_reporte+'?',
            showCancelButton: true,
            cancelButtonText: 'Cancelar',
            confirmButtonText: 'Confirmar',
        }).then((result)=>{
            if(result.isConfirmed){
                var datos = {
                    'op' : 'aprobarreporteJfundo',
                    'idproducto' : id_reporte
                };
                $.ajax({
                    url: 'controllers/Reporte.controller.php',
                    type: 'GET',
                    data: datos,
                    success: function(e){
                        mostrarAlerta("success","¡Aprobado correctamente!");
                        ListarReportesJFundo();
                    }
                });
            }
            });
    });
   
    $("#tablareporteSanidad").on("click", ".aprobar", function(){
        let id_reporte = $(this).attr('data-idproducto');
        var id_jefe_sanidad = $("#id_jefe_sanidad").val();
        Swal.fire({
            icon: 'question',
            title: 'AGROINDUSTRIAL BETA',
            text: 'Esta seguro de Aprobar el Reporte N°'+id_reporte+'?',
            showCancelButton: true,
            cancelButtonText: 'Cancelar',
            confirmButtonText: 'Confirmar',
        }).then((result)=>{
            if(result.isConfirmed){
                var datos = {
                    'op' : 'aprobarreporteSanidad',
                    'idproducto' : id_reporte,
                    'id_jefe_sanidad' : id_jefe_sanidad
                };
                $.ajax({
                    url: 'controllers/Reporte.controller.php',
                    type: 'GET',
                    data: datos,
                    success: function(e){
                        mostrarAlerta("success","¡Aprobado correctamente!");
                        ListarReportesSanidad();
                    }
                });
            }
            });
    });

    $("#tablareporteCalidad").on("click", ".aprobar", function(){
        let id_reporte = $(this).attr('data-idproducto');
        Swal.fire({
            icon: 'question',
            title: 'AGROINDUSTRIAL BETA',
            text: 'Esta seguro de Aprobar el Reporte N°'+id_reporte+'?',
            showCancelButton: true,
            cancelButtonText: 'Cancelar',
            confirmButtonText: 'Confirmar',
        }).then((result)=>{
            if(result.isConfirmed){
                var datos = {
                    'op' : 'aprobarreporteCalidad',
                    'idproducto' : id_reporte
                };
                $.ajax({
                    url: 'controllers/Reporte.controller.php',
                    type: 'GET',
                    data: datos,
                    success: function(e){
                        mostrarAlerta("success","¡Aprobado correctamente!");
                        ListarReportesCalidad();
                    }
                });
            }
            });
    });
    
    $("#tablallegadaProductos").on("click", ".fechallegada", function(){
        let idreporte = $(this).attr('data-idproducto');
        var observacionInput = '<label>¡Esta por ingresar la fecha de llegada al reporte con codigo '+idreporte+'!</label><input type="date" class="swal2-input" id="fechaLlegada">';
        Swal.fire({
            icon: 'question',
            title: 'AGROINDUSTRIAL BETA',
            html: observacionInput,
            showCancelButton: true,
            cancelButtonText: 'Cancelar',
            confirmButtonText: 'Confirmar',
            preConfirm: () => {
                var fechaLlegada = Swal.getPopup().querySelector('#fechaLlegada').value;
                if (!fechaLlegada) {
                    Swal.showValidationMessage('¡La fecha es obligatoria!');
                }
                return { fechaLlegada: fechaLlegada };
            }
        }).then((result)=>{
            if(result.isConfirmed){
                var fechaLlegada = result.value.fechaLlegada;
    
                var datos = {
                    'op' : 'asignarFechaLlegada',
                    'idreporte' : idreporte,
                    'fechaLlegada' : fechaLlegada
                };
    
                $.ajax({
                    url: 'controllers/Reporte.controller.php',
                    type: 'GET',
                    data: datos,
                    success: function(e){
                        mostrarAlerta("success", "Fecha Asignadda Correctamente!");
                        ListarReportes();
                    }
                });
            }
        });
    });

    $("#tablallegadaProductos").on("click", ".volverasignarfechallegada", function(){
        let idreporte = $(this).attr('data-idproducto');
        var observacionInput = '<label>¡Esta por volver a asignar la fecha de llegada del reporte con codigo '+idreporte+'!</label><input type="date" class="swal2-input" id="fechaLlegada">';
        Swal.fire({
            icon: 'question',
            title: 'AGROINDUSTRIAL BETA',
            html: observacionInput,
            showCancelButton: true,
            cancelButtonText: 'Cancelar',
            confirmButtonText: 'Confirmar',
            preConfirm: () => {
                var fechaLlegada = Swal.getPopup().querySelector('#fechaLlegada').value;
                if (!fechaLlegada) {
                    Swal.showValidationMessage('¡La fecha es obligatoria!');
                }
                return { fechaLlegada: fechaLlegada };
            }
        }).then((result)=>{
            if(result.isConfirmed){
                var fechaLlegada = result.value.fechaLlegada;
    
                var datos = {
                    'op' : 'asignarFechaLlegada',
                    'idreporte' : idreporte,
                    'fechaLlegada' : fechaLlegada
                };
    
                $.ajax({
                    url: 'controllers/Reporte.controller.php',
                    type: 'GET',
                    data: datos,
                    success: function(e){
                        mostrarAlerta("success", "Fecha Asignadda Correctamente!");
                        ListarReportes();
                    }
                });
            }
        });
    });
    

    function modificarReporte() {
        var datosAntesLocal = {bitacoraReporte};
        console.log(datosAntesLocal);
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
        var nreserva = $("#nreserva").val();
        var ninstructivo = $("#ninstructivo").val();
        var pep = $("#pep").val();
        var etcultivo = $("#etcultivo").val();
        if (encQA=="" || encSanidad=="" ||encAlmacen==""|| variedad == null || cultivo==null ||nreserva== ""|| ninstructivo == ""||pep== ""||etcultivo== "" ) {
            mostrarAlerta("warning", "¡Completar los campos necesarios!");
        } else {
            Swal.fire({
                icon: 'question',
                title: '¿Está seguro de modificar?',
                showCancelButton: true,
                cancelButtonText: 'Cancelar',
                confirmButtonText: 'Aceptar',
                html: '<input type="text" id="observacion" class="swal2-input" placeholder="Observación">'
            }).then((result) => {
                if (result.isConfirmed) {
                    var observacion = $('#observacion').val();
                    if (observacion.trim() !== "") {
                        var datos = {
                            'op': 'modificarReporte',
                            'idreporte': idreporte,
                            'encSanidad': encSanidad,
                            'encQA': encQA,
                            'encAlmacen': encAlmacen,
                            'idcategoria': idcategoria,
                            'fundo': fundo,
                            'lote': lote,
                            's_lote': s_lote,
                            'cultivo': cultivo,
                            'variedad': variedad,
                            'observacion': observacion,
                            'nreserva': nreserva,
                            'ninstructivo': ninstructivo,
                            'pep': pep,
                            'etcultivo': etcultivo
                        };
                        $.ajax({
                            url: 'controllers/Reporte.controller.php',
                            type: 'GET',
                            data: datos,
                            success: function (e) {
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
                    } else {
                        mostrarAlerta("warning", "¡La observación es obligatoria para la modificación!");
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
        console.log(jefe_fundo);
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
            }
        });
    });

    $("#lote").change(function(){
        let lote=$("#lote").val();
        var datos={
            'op'           : 'cargarCategoriaSubLote',
            'id_lote'       : lote
        }
        $.ajax({
            url: 'controllers/CategoriaReporte.controller.php',
            type: 'GET',
            data: datos,
            success: function(e){
                $("#s_lote").html(e);
            }
        });
    });

    $("#s_lote").change(function(){
        let id_sub_lote=$("#s_lote").val();
        var datos={
            'op'                : 'cargarCategoriaCultivoLote',
            'id_sub_lote'       : id_sub_lote
        }
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
        var datos={
            'op'           : 'cargarCategoriaVariedadLote',
            's_lote'       : id_sub_lote
        }
        $.ajax({
            url: 'controllers/CategoriaReporte.controller.php',
            type: 'GET',
            data: datos,
            success: function(e){
                $("#variedad").html(e);
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
                    $("#idcategoria").val(resultado[0].fk_jefe_fundo);
                    //$("#fundo").val(resultado[0].nom_fundo);
                    const jefeGET= resultado[0].fk_jefe_fundo;
                    const fundoGET= resultado[0].nom_fundo;
                    var datos={
                        'op'         : 'cargarFundoGET',
                        'jefeGET'   : jefeGET,
                        'fundoGET'    : fundoGET
                    }
                    $.ajax({
                        url: 'controllers/CategoriaFundo.controller.php',
                        type: 'GET',
                        data: datos,
                        success: function(e){
                            $("#fundo").html(e);
                        }
                    });
                    //$("#lote").val(resultado[0].fk_lote);
                    const fundoE= resultado[0].nom_fundo;
                    const fundo_lote= resultado[0].fk_lote;
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
                    //$("#s_lote").val(resultado[0].fk_slote);
                    const fundo_lote1= resultado[0].fk_lote;
                    const sublote= resultado[0].fk_slote;
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
                    //$("#cultivo").val(resultado[0].fk_cutivo);
                    const fundo_slote1= resultado[0].fk_slote;
                    const cultivo= resultado[0].fk_cultivo;
                    var datos={
                        'op'           : 'cargarCategoriaCultivoGET',
                        'fundo_slote1' : fundo_slote1,
                        'cultivo'      : cultivo
                    }
                    $.ajax({
                        url: 'controllers/CategoriaFundo.controller.php',
                        type: 'GET',
                        data: datos,
                        success: function(e){
                            $("#cultivo").html(e);
                        }
                    }); 
                    $("#variedad").val(resultado[0].fk_variedad);
                    console.log(resultado);
                    let id_cultivo= resultado[0].fk_cultivo;
                    let variedad_get= resultado[0].fk_variedad;
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
                    $("#nreserva").val(resultado[0].nrReserva);
                    $("#ninstructivo").val(resultado[0].nrInstructivo);
                    $("#pep").val(resultado[0].pep);
                    $("#etcultivo").val(resultado[0].etapa_cultivo);
                    txtProducto.setAttribute("data-idproducto", resultado[0].id_reporte);
                    $("#idproductomod").hide();
                    bitacoraReporte = {
                        fecha_hora: $("#fechahoraReporte").val(),
                        turno: $("#turno").val(),
                        enc_sanidad: $("#encSanidad").val(),
                        enc_QA: $("#encQA").val(),
                        enc_almacen: $("#encAlmacen").val(),
                        fk_jefe_fundo: $("#idcategoria").val(),
                        nom_fundo: $("#fundo").val(),
                        fk_lote: $("#lote").val(),
                        fk_slote: $("#s_lote").val(),
                        fk_cultivo: $("#cultivo").val(),
                        fk_variedad: $("#variedad").val(),
                        nrReserva: $("#nreserva").val(),
                        nrInstructivo: $("#ninstructivo").val(),
                        pep: $("#pep").val(),
                        etapa_cultivo: $("#etcultivo").val(),
                        id_reporte: resultado[0].id_reporte
                    };
                }else{
                    mostrarAlerta("warning", "¡No encontramos registros!");
                }
            }
        });
    });

    $("#tablareporte").on('click', ".modificar", function(){
        var fechafinal = $("#fechafinal").val();
        var fechainicial = $("#fechainicial").val();
        let id_reporte = $(this).data('idproducto');
        if(fechafinal=="" && fechainicial==""){   
            $.ajax({
                url: 'controllers/Reporte.controller.php',
                type: 'GET',
                data: {
                    'op': 'listarReporteAmodificar',
                    'id_reporte' : id_reporte
                    },
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
        }else{ 
            $.ajax({
            url: 'controllers/Reporte.controller.php',
            type: 'GET',
            data: {
                'op': 'listarReporteAmodificarFecha',
                'fechainicial' : fechainicial,
                'fechafinal' : fechafinal,
                'id_reporte' : id_reporte
                },
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
            if(fechafinal<fechainicial){
                mostrarAlerta("warning", "¡Rango de fechas invalidos!");
            }
    }

    function ListarReportesGeneralAdministrador() {
        $.ajax({
            url: 'controllers/Reporte.controller.php',
            type: 'GET',
            data: 'op=ListarReportesGeneralAdministrador',
            success: function (e) {
                var tabla = $("#tablareporteGeneralAdministrador").DataTable();
                tabla.destroy();
                $("#tablareporteGeneralAdministradorListar").html(e);
    
                $("#tablareporteGeneralAdministrador").DataTable({
                    language: { url: '//cdn.datatables.net/plug-ins/1.10.24/i18n/Spanish.json' },
                    columnDefs: [
                        {
                            visible: true,
                            searchable: true
                        }
                    ],
                    dom: 'Bfrtip',
                    buttons: [
                        'copy', 'print', {
                            extend: 'pdfHtml5',
                            orientation: 'landscape',
                            pageSize: 'LEGAL'
                        }, 'excel'
                    ],
                    initComplete: function (settings, json) {
                        // Mover el botón de imprimir al contenedor deseado
                        var printButton = new $.fn.dataTable.Buttons(settings, {
                            buttons: ['print']
                        });
                        printButton.container().appendTo($('#botonesTabla'));
                    }
                });
            }
        });
    }
    
    function buscarFechaAdministrador() {
        var fechafinal = $("#fechafinal").val();
        var fechainicial = $("#fechainicial").val();
    
        if ((fechafinal == "") && (fechainicial == "")) {
            ListarReportesGeneralAdministrador();
        } else {
            $.ajax({
                url: 'controllers/Reporte.controller.php',
                type: 'GET',
                data: {
                    'op': 'filtrarFechasAdministrador',
                    'fechainicial': fechainicial,
                    'fechafinal': fechafinal
                },
                success: function (e) {
                    var tabla = $("#tablareporteGeneralAdministrador").DataTable();
                    tabla.destroy();
                    $("#tablareporteGeneralAdministradorListar").html(e);
                    $("#tablareporteGeneralAdministrador").DataTable({
                        language: { url: '//cdn.datatables.net/plug-ins/1.10.24/i18n/Spanish.json' },
                        columnDefs: [
                            {
                                visible: true,
                                searchable: true
                            }
                        ],
                        dom: 'Bfrtip',
                        buttons: [
                            'copy', 'print', {
                                extend: 'pdfHtml5',
                                orientation: 'landscape',
                                pageSize: 'LEGAL'
                            }, 'excel'
                        ]
                    });
                }
            });
        }
    
        if (fechafinal < fechainicial) {
            mostrarAlerta("warning", "¡Rango de fechas inválidos!");
        }
    }
    
    function ListarReportesCalidad(){
        $.ajax({
            url: 'controllers/Reporte.controller.php',
            type: 'GET',
            data: 'op=ListarReportesCalidad',
            success: function(e){
                var tabla = $("#tablareporteCalidad").DataTable();
                tabla.destroy();
                $("#tablareporteCalidadListar").html(e);
                $("#tablareporteCalidad").DataTable({
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
        
    function buscarFechaCalidad(){
        var fechafinal = $("#fechafinal").val();
        var fechainicial = $("#fechainicial").val();
        if((fechafinal=="")&&(fechainicial="")){
            ListarReportesCalidad();
        }else{
            $.ajax({
                url: 'controllers/Reporte.controller.php',
                type: 'GET',
                data: {
                    'op': 'filtrarFechasCalidad',
                    'fechainicial' : fechainicial,
                    'fechafinal'   : fechafinal
                    },
                    success: function(e){
                        var tabla = $("#tablareporteCalidad").DataTable();
                        tabla.destroy();
                        $("#tablareporteCalidadListar").html(e);
                        $("#tablareporteCalidad").DataTable({
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
        if(fechafinal<fechainicial){
            mostrarAlerta("warning", "¡Rango de fechas invalidos!");
        }
    }

    function buscarFechaOperario(){
    var fechafinal = $("#fechafinal").val();
    var fechainicial = $("#fechainicial").val();
    if((fechafinal=="")&&(fechainicial="")){
        ListarReportesOperario();
    }else{
        $.ajax({
            url: 'controllers/Reporte.controller.php',
            type: 'GET',
            data: {
                'op': 'filtrarFechasOperario',
                'fechainicial' : fechainicial,
                'fechafinal'   : fechafinal
                },
                success: function(e){
                    var tabla = $("#tablareporteOperario").DataTable();
                    tabla.destroy();
                    $("#tablareporteOperarioListar").html(e);
                    $("#tablareporteOperario").DataTable({
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
    if(fechafinal<fechainicial){
        mostrarAlerta("warning", "¡Rango de fechas invalidos!");
    }
    }

    function ListarReportesOperario(){
        $.ajax({
            url: 'controllers/Reporte.controller.php',
            type: 'GET',
            data: 'op=ListarReportesOperario',
            success: function(e){
                var tabla = $("#tablareporteOperario").DataTable();
                tabla.destroy();
                $("#tablareporteOperarioListar").html(e);
                $("#tablareporteOperario").DataTable({
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

    function ListarReportesJFundo(){
        var idusuario = $("#idusuario").val();
        var estadousuario = $("#estadousuario").val();
        if(estadousuario==0){
            $.ajax({
                url: 'controllers/Reporte.controller.php',
                type: 'GET',
                data: 'op=ListarReportesJFundo',
                success: function(e){
                    var tabla = $("#tablareporteJfundo").DataTable();
                    tabla.destroy();
                    $("#tablareporteJFundoListar").html(e);
                    $("#tablareporteJfundo").DataTable({
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
        if(estadousuario==1){
            $.ajax({
                url: 'controllers/Reporte.controller.php',
                type: 'GET',
                data: {
                    'op': 'ListarPorJefeReportesJFundo',
                    'id_jefe_fundo' : idusuario
                    },
                    success: function(e){
                        var tabla = $("#tablareporteJfundo").DataTable();
                        tabla.destroy();
                        $("#tablareporteJFundoListar").html(e);
                        $("#tablareporteJfundo").DataTable({
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
        if(estadousuario==2){
            $.ajax({
                url: 'controllers/Reporte.controller.php',
                type: 'GET',
                data: {
                    'op': 'ListarPorJefeReportesJOperaciones',
                    'id_jefe_operaciones' : idusuario
                    },
                    success: function(e){
                        var tabla = $("#tablareporteJfundo").DataTable();
                        tabla.destroy();
                        $("#tablareporteJFundoListar").html(e);
                        $("#tablareporteJfundo").DataTable({
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
    }

    function buscarFechaJFundo(){
        var fechafinal = $("#fechafinal").val();
        var fechainicial = $("#fechainicial").val();
        if((fechafinal=="")&&(fechainicial="")){
            ListarReportesJFundo();
        }else{
            $.ajax({
                url: 'controllers/Reporte.controller.php',
                type: 'GET',
                data: {
                    'op': 'filtrarFechasJFundo',
                    'fechainicial' : fechainicial,
                    'fechafinal'   : fechafinal
                    },
                    success: function(e){
                        var tabla = $("#tablareporteJfundo").DataTable();
                        tabla.destroy();
                        $("#tablareporteJFundoListar").html(e);
                        $("#tablareporteJfundo").DataTable({
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
        if(fechafinal<fechainicial){
            mostrarAlerta("warning", "¡Rango de fechas invalidos!");
        }
    }

    function ListarReportesSanidad(){
        var idusuario = $("#idusuariosanidad").val();
        var estadousuario = $("#estadousuariosanidad").val();
        if(estadousuario==0){
            $.ajax({
                url: 'controllers/Reporte.controller.php',
                type: 'GET',
                data: 'op=ListarReportesSanidadAdministrador',
                success: function(e){
                    var tabla = $("#tablareporteSanidad").DataTable();
                    tabla.destroy();
                    $("#tablareporteSanidadListar").html(e);
                    $("#tablareporteSanidad").DataTable({
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
        if(estadousuario==1){
            $.ajax({
                url: 'controllers/Reporte.controller.php',
                type: 'GET',
                data: {
                    'op': 'ListarReportesSanidad',
                    'id_jefe_sanidad' : idusuario
                    },
                success: function(e){
                    var tabla = $("#tablareporteSanidad").DataTable();
                    tabla.destroy();
                    $("#tablareporteSanidadListar").html(e);
                    $("#tablareporteSanidad").DataTable({
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
    }

    function buscarFechaSanidad(){
        var fechafinal = $("#fechafinal").val();
        var fechainicial = $("#fechainicial").val();
        if((fechafinal=="")&&(fechainicial="")){
            ListarReportesSanidad();
        }else{
            $.ajax({
                url: 'controllers/Reporte.controller.php',
                type: 'GET',
                data: {
                    'op': 'filtrarFechasSanidad',
                    'fechainicial' : fechainicial,
                    'fechafinal'   : fechafinal
                    },
                    success: function(e){
                        var tabla = $("#tablareporteSanidad").DataTable();
                        tabla.destroy();
                        $("#tablareporteSanidadListar").html(e);
                        $("#tablareporteSanidad").DataTable({
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
        if(fechafinal<fechainicial){
            mostrarAlerta("warning", "¡Rango de fechas invalidos!");
        }
    }
    
    function ListarReportesFechaLlegada(){
        $.ajax({
            url: 'controllers/Reporte.controller.php',
            type: 'GET',
            data: 'op=ListarLlegadaProductos',
            success: function(e){
                var tabla = $("#tablallegadaProductos").DataTable();
                tabla.destroy();
                $("#tablallegadaProductosListar").html(e);
                $("#tablallegadaProductos").DataTable({
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

    function ListarReportesAcciones(){
        $.ajax({
            url: 'controllers/Reporte.controller.php',
            type: 'GET',
            data: 'op=ListarReporteAcciones',
            success: function(e){
                var tabla = $("#tablaAccionesReporte").DataTable();
                tabla.destroy();
                $("#tablaAccionesReporteListar").html(e);
                $("#tablaAccionesReporte").DataTable({
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

    function buscarFechasListarReportesAcciones(){
        var fechafinal = $("#fechafinal").val();
        var fechainicial = $("#fechainicial").val();
        if((fechafinal=="")&&(fechainicial="")){
            ListarReportesAcciones();
        }else{
            $.ajax({
                url: 'controllers/Reporte.controller.php',
                type: 'GET',
                data: {
                    'op': 'filtrarFechasReportesAcciones',
                    'fechainicial' : fechainicial,
                    'fechafinal'   : fechafinal
                    },
                    success: function(e){
                        var tabla = $("#tablaAccionesReporte").DataTable();
                        tabla.destroy();
                        $("#tablaAccionesReporteListar").html(e);
                        $("#tablaAccionesReporte").DataTable({
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
        if(fechafinal<fechainicial){
            mostrarAlerta("warning", "¡Rango de fechas invalidos!");
        }
    }
     
    function ListarProductosAcciones(){
        $.ajax({
            url: 'controllers/Reporte.controller.php',
            type: 'GET',
            data: 'op=ListarProductosAcciones',
            success: function(e){
                var tabla = $("#tablaAccionesProductos").DataTable();
                tabla.destroy();
                $("#tablaAccionesProductosListar").html(e);
                $("#tablaAccionesProductos").DataTable({
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

    function buscarFechasListarProductosAcciones(){
        var fechafinal = $("#fechafinal").val();
        var fechainicial = $("#fechainicial").val();
        if((fechafinal=="")&&(fechainicial="")){
            ListarProductosAcciones();
        }else{
            $.ajax({
                url: 'controllers/Reporte.controller.php',
                type: 'GET',
                data: {
                    'op': 'filtrarFechasProductosAcciones',
                    'fechainicial' : fechainicial,
                    'fechafinal'   : fechafinal
                    },
                    success: function(e){
                        var tabla = $("#tablaAccionesProductos").DataTable();
                        tabla.destroy();
                        $("#tablaAccionesProductosListar").html(e);
                        $("#tablaAccionesProductos").DataTable({
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
        if(fechafinal<fechainicial){
            mostrarAlerta("warning", "¡Rango de fechas invalidos!");
        }
    }

    function ListarReportesSanidad(){
        var idusuario = $("#idusuariosanidad").val();
        var estadousuario = $("#estadousuariosanidad").val();
        if(estadousuario==0){
            $.ajax({
                url: 'controllers/Reporte.controller.php',
                type: 'GET',
                data: 'op=ListarReportesSanidadAdministrador',
                success: function(e){
                    var tabla = $("#tablareporteSanidad").DataTable();
                    tabla.destroy();
                    $("#tablareporteSanidadListar").html(e);
                    $("#tablareporteSanidad").DataTable({
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
        if(estadousuario==1){
            $.ajax({
                url: 'controllers/Reporte.controller.php',
                type: 'GET',
                data: {
                    'op': 'ListarReportesSanidad',
                    'id_jefe_sanidad' : idusuario
                    },
                success: function(e){
                    var tabla = $("#tablareporteSanidad").DataTable();
                    tabla.destroy();
                    $("#tablareporteSanidadListar").html(e);
                    $("#tablareporteSanidad").DataTable({
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
    }
    
    function ListarLlegadaProductos(){
            $.ajax({
                url: 'controllers/Reporte.controller.php',
                type: 'GET',
                data: 'op=ListarLlegadaProductos',
                success: function(e){
                    var tabla = $("#tablallegadaProductos").DataTable();
                    tabla.destroy();
                    $("#tablallegadaProductosListar").html(e);
                    $("#tablallegadaProductos").DataTable({
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
    
    function buscaFechaLlegadaProductos(){
        var fechafinal = $("#fechafinal").val();
        var fechainicial = $("#fechainicial").val();
        if((fechafinal=="")&&(fechainicial="")){
            ListarLlegadaProductos();
        }else{
            $.ajax({
                url: 'controllers/Reporte.controller.php',
                type: 'GET',
                data: {
                    'op': 'filtrarFechasLlegadaProducto',
                    'fechainicial' : fechainicial,
                    'fechafinal'   : fechafinal
                    },
                    success: function(e){
                        var tabla = $("#tablallegadaProductos").DataTable();
                        tabla.destroy();
                        $("#tablallegadaProductosListar").html(e);
                        $("#tablallegadaProductos").DataTable({
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
        if(fechafinal<fechainicial){
            mostrarAlerta("warning", "¡Rango de fechas invalidos!");
        }
    }
        
    function ListarRegistroTotalReportes(){
        $.ajax({
            url: 'controllers/Reporte.controller.php',
            type: 'GET',
            data: 'op=ListarRegistroTotalProductos',
            success: function(e){
                var tabla = $("#tablaregistroTotalesReportes").DataTable();
                tabla.destroy();
                $("#tablaregistroTotalesReportesListar").html(e);
                $("#tablaregistroTotalesReportes").DataTable({
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
    
    function buscaFechaRegistroTotalesReportes(){
        var fechafinal = $("#fechafinal").val();
        var fechainicial = $("#fechainicial").val();
        if((fechafinal=="")&&(fechainicial="")){
            ListarRegistroTotalReportes();
        }else{
            $.ajax({
                url: 'controllers/Reporte.controller.php',
                type: 'GET',
                data: {
                    'op': 'filtrarFechasReportesTotales',
                    'fechainicial' : fechainicial,
                    'fechafinal'   : fechafinal
                    },
                    success: function(e){
                        var tabla = $("#tablaregistroTotalesReportes").DataTable();
                        tabla.destroy();
                        $("#tablaregistroTotalesReportesListar").html(e);
                        $("#tablaregistroTotalesReportes").DataTable({
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
        if(fechafinal<fechainicial){
            mostrarAlerta("warning", "¡Rango de fechas invalidos!");
        }
    }

    $("#tablareporte").on("click", ".detalle", function(e) {
        e.preventDefault(); 
        let idreporte = $(this).data('idproducto');
        window.location.href = 'main.php?view=administrardetallereporte.php?id=' + idreporte;
    });

    $("#tablareporteOperario").on("click", ".detalle", function(e) {
        e.preventDefault(); 
        let idreporte = $(this).data('idproducto');
        window.location.href = 'main.php?view=vistaDetalle.php?id=' + idreporte;
    });
    
    $("#tablareporteCalidad").on("click", ".detalle", function(e) {
        e.preventDefault(); 
        let idreporte = $(this).data('idproducto');
        window.location.href = 'main.php?view=vistaDetalleCalidad.php?id=' + idreporte;
    });

    $("#tablareporteJfundo").on("click", ".detalle", function(e) {
        e.preventDefault(); 
        let idreporte = $(this).data('idproducto');
        window.location.href = 'main.php?view=vistaDetalleJFundo.php?id=' + idreporte;
    });
    
    $("#tablareporteSanidad").on("click", ".detalle", function(e) {
        e.preventDefault(); 
        let idreporte = $(this).data('idproducto');
        window.location.href = 'main.php?view=vistaDetalleSanidad.php?id=' + idreporte;
    });

    $("#cancelar").click(function(){
        $("#formularioReporte")[0].reset();
        $("#Aviso").html("Registrar Producto");
        txtProducto.classList.add('asignar');
        botonActualizar.classList.add('asignar');
        botonGuardar.classList.remove('asignar');
        $("#descripcion").prop('disabled', false);
    });
    cargarCategorias("#idcategoria");
    ListarReportes();
    ListarReportesGeneralAdministrador();
    ListarReportesCalidad();
    ListarReportesOperario();
    ListarReportesJFundo();
    ListarReportesSanidad();
    ListarReportesAcciones();
    ListarProductosAcciones();
    ListarLlegadaProductos();
    ListarReportesFechaLlegada();
    ListarRegistroTotalReportes();
    $("#registrar").click(registrarReporte);
    $("#actualizar").click(modificarReporte);
    $("#bfecha").click(buscarFecha);
    $("#bfecha").click(buscarFechaAdministrador);
    $("#bfecha").click(buscarFechaCalidad);
    $("#bfecha").click(buscarFechaOperario);
    $("#bfecha").click(buscarFechaJFundo);
    $("#bfecha").click(buscarFechaSanidad);
    $("#bfecha").click(buscaFechaLlegadaProductos);
    $("#bfecha").click(buscarFechasListarReportesAcciones);
    $("#bfecha").click(buscarFechasListarProductosAcciones);
    $("#bfecha").click(buscaFechaRegistroTotalesReportes);
});