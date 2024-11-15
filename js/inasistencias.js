$(document).ready(function(){

    function ListarInasistenciaDesayuno(){
        $.ajax({
            url: 'controllers/Inasistencia.controller.php',
            type: 'GET',
            data: 'op=ListarInasistenciaDesayuno',
            success: function(e){
                var tabla = $("#tablaInasistenciaDesayuno").DataTable();
                tabla.destroy();
                $("#tablaInasistenciaDesayunoListar").html(e);
                $("#tablaInasistenciaDesayuno").DataTable({
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
    function ListarInasistenciaAlmuerzo(){
        $.ajax({
            url: 'controllers/Inasistencia.controller.php',
            type: 'GET',
            data: 'op=ListarInasistenciaAlmuerzo',
            success: function(e){
                var tabla = $("#tablaInasistenciaAlmuerzo").DataTable();
                tabla.destroy();
                $("#tablaInasistenciaAlmuerzoListar").html(e);
                $("#tablaInasistenciaAlmuerzo").DataTable({
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
    function ListarInasistenciaCena(){
        $.ajax({
            url: 'controllers/Inasistencia.controller.php',
            type: 'GET',
            data: 'op=ListarInasistenciaCena',
            success: function(e){
                var tabla = $("#tablaInasistenciaCena").DataTable();
                tabla.destroy();
                $("#tablaInasistenciaCenaListar").html(e);
                $("#tablaInasistenciaCena").DataTable({
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
    
    ListarInasistenciaCena();
    ListarInasistenciaAlmuerzo();
    ListarInasistenciaDesayuno();
});