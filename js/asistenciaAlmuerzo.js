$(document).ready(function(){

    function ListarAsistenciaAlmuerzo(){
        $.ajax({
            url: 'controllers/asistenciaAlmuerzo.controller.php',
            type: 'GET',
            data: 'op=ListarInasistenciaAlmuerzo',
            success: function(e){
                var tabla = $("#tablaAsistenciaAlmuerzo").DataTable();
                tabla.destroy();
                $("#tablaAsistenciaAlmuerzoListar").html(e);
                $("#tablaAsistenciaAlmuerzo").DataTable({
                    language: { url: '//cdn.datatables.net/plug-ins/1.10.24/i18n/Spanish.json' },
                    columnDefs: [
                    {
                        visible: true,
                        searchable: true,
                        targets: 6, // Asegúrate de que esta sea la columna correcta que contiene las fechas
                        type: 'number' // Especifica el tipo de datos como fecha
                    }
                    ],
                    order: [[6, 'desc']], // Ordena por la primera columna (índice 0) en orden descendente (más reciente primero)
                    dom: 'Bfrtip',
                    buttons: ['copy', 'print', 'pdf', 'excel']
                });
            }
        });
    }    

    function ListarAsistenciaAlmuerzoFecha(){
        var anio = $("#anio").val();
        var mes = $("#mes").val();
        
        console.log(anio);
        console.log(mes);
        if((anio=="")&&(mes=="")){
            ListarAsistenciaAlmuerzo();
        }else{
            $.ajax({
                url: 'controllers/asistenciaAlmuerzo.controller.php',
                type: 'GET',
                data: {
                    'op': 'ListarAsistenciaAlmuerzoFecha',
                    'anio' : anio,
                    'mes'   : mes
                    },
                    success: function(e){
                        var tabla = $("#tablaAsistenciaAlmuerzo").DataTable();
                        tabla.destroy();
                        $("#tablaAsistenciaAlmuerzoListar").html(e);
                        $("#tablaAsistenciaAlmuerzo").DataTable({
                            language: { url: '//cdn.datatables.net/plug-ins/1.10.24/i18n/Spanish.json' },
                            columnDefs: [
                            {
                                visible: true,
                                searchable: true,
                                targets: 6, // Asegúrate de que esta sea la columna correcta que contiene las fechas
                                type: 'number' // Especifica el tipo de datos como fecha
                            }
                            ],
                            order: [[6, 'desc']], // Ordena por la primera columna (índice 0) en orden descendente (más reciente primero)
                            dom: 'Bfrtip',
                            buttons: ['copy', 'print', 'pdf', 'excel']
                        });
                    }
            });
        }
    }

    ListarAsistenciaAlmuerzo();
    $("#bfecha").click(ListarAsistenciaAlmuerzoFecha);
});