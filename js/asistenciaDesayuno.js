$(document).ready(function(){

    function ListarAsistenciaDesayuno(){
        $.ajax({
            url: 'controllers/asistenciaDesayuno.controller.php',
            type: 'GET',
            data: 'op=ListarInasistenciaDesayuno',
            success: function(e){
                var tabla = $("#tablaAsistenciaDesayuno").DataTable();
                tabla.destroy();
                $("#tablaAsistenciaDesayunoListar").html(e);
                $("#tablaAsistenciaDesayuno").DataTable({
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
    function ListarAsistenciaDesayunoFecha(){
        var anio = $("#anio").val();
        var mes = $("#mes").val();
        if((anio=="")&&(mes=="")){
            ListarAsistenciaDesayuno();
        }else{
            $.ajax({
                url: 'controllers/asistenciaDesayuno.controller.php',
                type: 'GET',
                data: {
                    'op': 'ListarAsistenciaDesayunoFecha',
                    'anio' : anio,
                    'mes'   : mes
                    },
                    success: function(e){
                        var tabla = $("#tablaAsistenciaDesayuno").DataTable();
                        tabla.destroy();
                        $("#tablaAsistenciaDesayunoListar").html(e);
                        $("#tablaAsistenciaDesayuno").DataTable({
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

    ListarAsistenciaDesayuno();
    $("#bfecha").click(ListarAsistenciaDesayunoFecha);
});