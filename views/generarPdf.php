<?php

require '../vendor/autoload.php';

use Dompdf\Dompdf;
use Dompdf\Options;

// Obtener el valor del id desde el formulario
$reporteId = $_POST['reporte_id'] ?? null;
$nombreImagen = "../images/logobetaPDF.png";
$imagenBase64 = "data:image/png;base64," . base64_encode(file_get_contents($nombreImagen));
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "sistemasanidad";
$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die("Conexión fallida: " . $conn->connect_error);
}

// Llamamos al procedimiento almacenado
$sql = "CALL spu_reporte_pdf($reporteId)";
$result = $conn->query($sql);

if ($reporteId !== null && $result) {
    // Obtener los resultados como un array asociativo
    $reporteData = $result->fetch_assoc();

    // Resto del código para generar el PDF
    $options = new Options();
    $options->set('isHtml5ParserEnabled', true);
    $options->set('isPhpEnabled', true);

    $dompdf = new Dompdf($options);

    // Construir el HTML con los datos obtenidos del procedimiento almacenado
    $html = "
    <html>
    <body>
    <div style='text-align: center;'>
    <h4 style='display: inline-block; margin-right: 20px;'>ORDEN DE SALIDA DE PRODUCTOS DEL REPORTE N° $reporteId </h4>
	<img src='$imagenBase64' style='width: 120px; height: 50px;'/>
    </div>
    <br>
    <div>
    <table style='float: left; margin-right: 20px;'>
        <tr>
            <td  style='width: 100px;'>Jefe de Fundo:</td>
            <td>{$reporteData['jefe_fundo']}</td>
            <td  style=''></td>
            <td  style='width: 130px;'></td>
        </tr>
        <tr>
            <td  style='width: 100px;'>Fundo:</td>
            <td>{$reporteData['nom_fundo']}</td>
        </tr>
        <tr>
            <td  style='width: 100px;'>Lote:</td>
            <td>{$reporteData['nombre_lote']}</td>
            <td  style='width: 70px;'>Sub-Lote:</td>
            <td>{$reporteData['_slote_nombre']}</td>
        </tr>
        <tr>
            <td  style='width: 100px;'>Cultivo:</td>
            <td>{$reporteData['nombre_cultivo']}</td>
            <td  style='width: 70px;'>Variedad:</td>
            <td>{$reporteData['nombre_variedad']}</td>
        </tr>
    </table>
    <table style='float: left; border-collapse: collapse;'>
        <tr>
            <td style='width: 100px; border: 1px solid #000;'>Fecha y Hora:</td>
            <td style='border: 1px solid #000;'>{$reporteData['fecha_hora']}</td>
        </tr>
        <tr>
            <td style='width: 100px; border: 1px solid #000;'>Turno:</td>
            <td style='border: 1px solid #000;'>{$reporteData['turno']}</td>
        </tr>
    </table>
    </div>
    <br>
    <div style='text-align: center;'>
    <h4>DETALLE DE PRODUTOS DEL REPORTE</h4>
    </div>
    </body>
    </html>
";


    $dompdf->loadHtml($html);
    $dompdf->setPaper('A4', 'portrait');

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