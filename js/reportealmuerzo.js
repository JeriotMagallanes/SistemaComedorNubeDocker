$(document).ready(function(){


    function ListarReporteAlmuerzo(){
        $.ajax({
            url: 'controllers/reporteAlmuerzo.controller.php',
            type: 'GET',
            data: 'op=ListarReporteAlmuerzo',
            success: function(e){
                var tabla = $("#tablaReporteAlmuerzo").DataTable();
                tabla.destroy();
                $("#tablaReporteAlmuerzoListar").html(e);
                $("#tablaReporteAlmuerzo").DataTable({
                    language: { url: '//cdn.datatables.net/plug-ins/1.10.24/i18n/Spanish.json' },
                    columnDefs: [
                        {
                            visible: true,
                            searchable: true,
                        }
                    ],
                    dom: 'Bfrtip',
                    buttons: [
                        {
                            extend: 'pdf',
                            text: 'Exportar PDF',
                            filename: function() {
                                // Extrae la fecha completa de la primera fila, segunda columna (índice 1)
                                var fechaHoraReporte = $("#tablaReporteAlmuerzo tbody tr:eq(0) td:eq(1)").text();
                                
                                // Extrae solo la parte de la fecha (primeros 10 caracteres)
                                var fechaReporte = fechaHoraReporte.slice(0, 10);
                                
                                return 'Reporte_Almuerzo_' + fechaReporte; // Usa la fecha como parte del nombre
                            },
                            title: function() {
                                // Extrae la fecha completa de la primera fila, segunda columna (índice 1)
                                var fechaHoraReporte = $("#tablaReporteAlmuerzo tbody tr:eq(0) td:eq(1)").text();
                                
                                // Extrae solo la parte de la fecha (primeros 10 caracteres)
                                var fechaReporte = fechaHoraReporte.slice(0, 10);
                                
                                // Retorna el título con la fecha
                                return 'Reporte de Almuerzo - Fecha: ' + fechaReporte;
                            },
                            customize: function(doc) {
                                // El título ya se ha establecido arriba en la opción "title"
                                doc.styles.title = {
                                    fontSize: 16,
                                    bold: true,
                                    alignment: 'center'
                                };
                            }
                        },
                        'copy', 'print', 'excel'
                    ]
                });
            }
        });
    }
    
    function ListarReporteAlmuerzoFecha(){
        var fecha = $("#fecha").val();
        
        if(fecha==""){
            ListarReporteAlmuerzo();
        }else{
            $.ajax({
                url: 'controllers/reporteAlmuerzo.controller.php',
                type: 'GET',
                data: {
                    'op': 'ListarReporteAlmuerzoFecha',
                    'fecha' : fecha
                    },
                    success: function(e){
                        var tabla = $("#tablaReporteAlmuerzo").DataTable();
                        tabla.destroy();
                        $("#tablaReporteAlmuerzoListar").html(e);
                        $("#tablaReporteAlmuerzo").DataTable({
                            language: { url: '//cdn.datatables.net/plug-ins/1.10.24/i18n/Spanish.json' },
                            columnDefs: [
                                {
                                    visible: true,
                                    searchable: true,
                                }
                            ],
                            dom: 'Bfrtip',
                            buttons: [
                                {
                                    extend: 'pdf',
                                    text: 'Exportar PDF',
                                    filename: function() {
                                        // Extrae la fecha completa de la primera fila, segunda columna (índice 1)
                                        var fechaHoraReporte = $("#tablaReporteAlmuerzo tbody tr:eq(0) td:eq(1)").text();
                                        
                                        // Extrae solo la parte de la fecha (primeros 10 caracteres)
                                        var fechaReporte = fechaHoraReporte.slice(0, 10);
                                        
                                        return 'Reporte_Almuerzo_' + fechaReporte; // Usa la fecha como parte del nombre
                                    },
                                    title: function() {
                                        // Extrae la fecha completa de la primera fila, segunda columna (índice 1)
                                        var fechaHoraReporte = $("#tablaReporteAlmuerzo tbody tr:eq(0) td:eq(1)").text();
                                        
                                        // Extrae solo la parte de la fecha (primeros 10 caracteres)
                                        var fechaReporte = fechaHoraReporte.slice(0, 10);
                                        
                                        // Retorna el título con la fecha
                                        return 'Reporte de Almuerzo - Fecha: ' + fechaReporte;
                                    },
                                    customize: function(doc) {
                                        // El título ya se ha establecido arriba en la opción "title"
                                        doc.styles.title = {
                                            fontSize: 16,
                                            bold: true,
                                            alignment: 'center'
                                        };
                                    }
                                },
                                'copy', 'print', 'excel'
                            ]
                        });
                    }
            });
        }
    }

    ListarReporteAlmuerzo();
    $("#bfecha").click(ListarReporteAlmuerzoFecha);
});