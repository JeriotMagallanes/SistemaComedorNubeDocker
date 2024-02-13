<?php

require '../vendor/autoload.php';
require_once '../config/database.php';
use Dompdf\Dompdf;
use Dompdf\Options;


// Obtener el valor del id desde el formulario
$reporteId = $_POST['reporte_id'] ?? null;
$nombrelogoBeta = "../images/logobetaPDF.png";
$imagenlogobetaBase64 = "data:image/png;base64," . base64_encode(file_get_contents($nombrelogoBeta));
$servername = HOST; 
$username = USER;
$password = PASS;
$dbname = DATABASE;
$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die("Conexión fallida: " . $conn->connect_error);
}

// Llamamos al procedimiento almacenado
$sql1 = "CALL spu_reporte_pdf($reporteId)";
$resultsql1 = $conn->query($sql1);

// Liberar los resultados de la primera consulta
$conn->next_result();

$sql2 = "CALL spu_listar_detalle($reporteId)";
$resultsql2 = $conn->query($sql2);

$conn->next_result();

$nombrsello_jfundo= "../images/sello_jefe_fundo.png";
$imagensello_jfundo64 = "data:image/png;base64," . base64_encode(file_get_contents($nombrsello_jfundo));

$nombresello_jsanidad = "../images/sello_jefe_sanidad.png";
$imagensello_jsanidadBase64 = "data:image/png;base64," . base64_encode(file_get_contents($nombresello_jsanidad));

$nombrsello_jcalidad= "../images/sello_jefe_calidad.png";
$imagensello_jcalidadBase64 = "data:image/png;base64," . base64_encode(file_get_contents($nombrsello_jcalidad));

if ($reporteId !== null && $resultsql1 && $resultsql2) {
    // Obtener los resultados como un array asociativo
    $reporteData = $resultsql1->fetch_assoc();

    // Resto del código para generar el PDF
    $options = new Options();
    $options->set('isHtml5ParserEnabled', true);
    $options->set('isPhpEnabled', true);

    $dompdf = new Dompdf($options);

    // Construir el HTML con los datos obtenidos del procedimiento almacenado
    $html = "
    <html>
    <head>
    <link rel='icon' href='../images/favicon.png'>
    </head>
    <body>
    <div style='text-align: center;'>
	<img src='$imagenlogobetaBase64' style='width: 160px; height: 65px;margin-left:-300px; margin-right:150px;'/>
    <h4 style='display: inline-block;'> ORDEN DE SALIDA DE PRODUCTOS DEL REPORTE N° $reporteId </h4></div>
    <br>
    <br>
    <div>
    <table style='float: left; margin-right: 150px;'>
        <tr>
            <td  style='width: 100px;'>Jefe de Fundo:</td>
            <td>{$reporteData['jefe_fundo']}</td>
            <td  style=''></td>
            <td  style='width: 130px;'></td>
        </tr>
        <tr>
            <td  style='width: 100px;'>Fundo:</td>
            <td>{$reporteData['nombre_fundo']}</td>
        </tr>
        <tr>
            <td  style='width: 100px;'>Lote:</td>
            <td>{$reporteData['nombre_lote']}</td>
            <td  style='width: 80px;'>Sub-Lote:</td>
            <td>{$reporteData['_slote_nombre']}</td>
        </tr>
        <tr>
            <td  style='width: 100px;'>Cultivo:</td>
            <td>{$reporteData['nombre_cultivo']}</td>
            <td  style='width: 80px;'>Variedad:</td>
            <td>{$reporteData['nombre_variedad']}</td>
        </tr>
        <tr>
            <td  style='width: 100px;'>PEP:</td>
            <td>{$reporteData['nombre_pep']}</td>
            <td  style='width: 80px;'>Sub-Lote:</td>
            <td>{$reporteData['nombreEcultivo']}</td>
        </tr>
        <tr>
            <td  style='width: 100px;'>N° Instructivo:</td>
            <td>{$reporteData['nrInstructivo']}</td>
            <td  style='width: 80px;'>N° Reserva:</td>
            <td>{$reporteData['nrReserva']}</td>
        </tr>
        <tr>
            <td  style='width: 100px;'>Encargado de Sanidad</td>
            <td>{$reporteData['enc_sanidad']}</td>
        </tr>
        <tr>
            <td  style='width: 100px;'>Encargado de QA:</td>
            <td>{$reporteData['enc_QA']}</td>
        </tr>
        <tr>
            <td  style='width: 150px;'>Encargado Almacen:</td>
            <td>{$reporteData['enc_almacen']}</td>
        </tr>
    </table>
	<img src='$imagensello_jfundo64' style='width: 150px; height: 150px;'/>
	<img src='$imagensello_jsanidadBase64' style='width: 150px; height: 150px; margin-left: 40px;'/>
        
    <table style='float: right; border-collapse: collapse;'>
        <tr>
            <td style='width: 120px; border: 1px solid #000;'>Fecha y Hora:</td>
            <td style='border: 1px solid #000;'>{$reporteData['fecha_hora']}</td>
        </tr>
        <tr>
            <td style='width: 120px; border: 1px solid #000;'>Fecha Llegada:</td>
            <td style='border: 1px solid #000;'>{$reporteData['fecha_llegada']}</td>
        </tr>
        <tr>
            <td style='width: 120px; border: 1px solid #000;'>Turno:</td>
            <td style='border: 1px solid #000;'>{$reporteData['turno']}</td>
        </tr>
    </table>
    </div>
    <br>
    <br>
    <br>
    <div style='text-align: center;'>
    <h4>DETALLE DE PRODUTOS DEL REPORTE</h4>
    </div>
    <table style='border-collapse: collapse; width: 100%;'>
        <thead>
            <tr>
                <th style='border: 1px solid #000; background-color: #e6e6e6;'>Motivo</th>
                <th style='border: 1px solid #000; background-color: #e6e6e6;'>Producto</th>
                <th style='border: 1px solid #000; background-color: #e6e6e6;'>Unidad</th>
                <th style='border: 1px solid #000; background-color: #e6e6e6;'>Carencia (d)</th>
                <th style='border: 1px solid #000; background-color: #e6e6e6;'>Dosis Cil</th>
                <th style='border: 1px solid #000; background-color: #e6e6e6;'>N° CIL</th>
                <th style='border: 1px solid #000; background-color: #e6e6e6;'>Dosis Tanque</th>
                <th style='border: 1px solid #000; background-color: #e6e6e6;'>Total Producto</th>
                <th style='border: 1px solid #000; background-color: #e6e6e6;'>Dosis HA</th>
                <th style='border: 1px solid #000; background-color: #e6e6e6;'>HA Aplicada</th>
            </tr>
        </thead>
        <tbody>
    ";
    
$counter = 0;

while ($fila = $resultsql2->fetch_assoc()) {
    $counter++;
    
    // Aplicar estilo para centrar el contenido y sombreado intercalado más fuerte
    $background_color = ($counter % 2 === 0) ? '#d9d9d9' : '#f2f2f2';

    $html .= "<tr style='background-color: $background_color;'>";
    $html .= "<td style='border: 1px solid #000; width: 200px;'>{$fila['nombre_motivo']}</td>";
    $html .= "<td style='border: 1px solid #000; width: 200px;'>{$fila['nombre_producto']}</td>";
    $html .= "<td style='text-align: center; border: 1px solid #000; width: 50px;'>{$fila['unidad']}</td>";
    $html .= "<td style='text-align: center; border: 1px solid #000; width: 75px;'>{$fila['diascarencia']}</td>";
    $html .= "<td style='text-align: center; border: 1px solid #000; width: 75px;'>{$fila['dosiscil']}</td>";
    $html .= "<td style='text-align: center; border: 1px solid #000; width: 75px;'>{$fila['ncil']}</td>";
    $html .= "<td style='text-align: center; border: 1px solid #000; width: 75px;'>{$fila['dosistanque']}</td>";
    $html .= "<td style='text-align: center; border: 1px solid #000; width: 75px;'>{$fila['totalproducto']}</td>";
    $html .= "<td style='text-align: center; border: 1px solid #000; width: 75px;'>{$fila['dosisHA']}</td>";
    $html .= "<td style='text-align: center; border: 1px solid #000; width: 75px;'>{$fila['HAaplicada']}</td>";
    
    $html .= "</tr>";
}

$html .= "
        </tbody>
    </table>
    </body>
    </html>
";


    $dompdf->loadHtml($html);
    $dompdf->setPaper('A4', 'landscape');

    $dompdf->render();

    // Configurar las cabeceras para indicar que se está enviando un archivo PDF
    header('Content-Type: application/pdf');
    header('Content-Disposition: inline; filename="mi_pdf_dompdf.pdf"');

    // Enviar el contenido binario del PDF
    echo $dompdf->output();
} else {
    // Manejar el caso en el que no se proporciona el id o hay un error en el procedimiento almacenado
    echo "Error: No se proporcionó el id del reporte o hubo un error en el procedimiento almacenado.";
}

// Cerrar la conexión a la base de datos
$conn->close();
?>
