<?php
session_start();
if ($_SESSION['acceso'] == false){
header('Location:../');
}
?>

