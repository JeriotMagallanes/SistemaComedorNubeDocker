<?php 
	session_start(); 
	if (isset($_SESSION['acceso'])){
		if ($_SESSION['acceso'] == true){
			header('Location:main.php');
		}
	}
?>
<!DOCTYPE html>
<html lang="en">
<head>
	<title>Comedor UNDC</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
<!--===============================================================================================-->	
	<link rel="icon" type="image/png" href="images/favicon.png"/>
<!--===============================================================================================-->
	<!-- <link rel="stylesheet" type="text/css" href="vendor/bootstrap/css/bootstrap.min.css"> -->
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="fonts/font-awesome-4.7.0/css/font-awesome.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="fonts/Linearicons-Free-v1.0.0/icon-font.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="vendor/animate/animate.css">
<!--===============================================================================================-->	
	<link rel="stylesheet" type="text/css" href="vendor/css-hamburgers/hamburgers.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="vendor/animsition/css/animsition.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="vendor/select2/select2.min.css">
<!--===============================================================================================-->	
	<link rel="stylesheet" type="text/css" href="vendor/daterangepicker/daterangepicker.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="css/util.css">
	<link rel="stylesheet" type="text/css" href="css/main.css">

<!--===============================================================================================-->
</head>
<body style="background-color: #09b451;">
	<div class="limiter">
		<div class="container-login100">
			<div class="wrap-login100">
				
			<div class="login100-more" style="background-image: url('images/comedor.png');">
				</div>
				<form class="login100-form validate-form" style="background-color: #808280;">
						<img class="img-fluid" src="images/logoundc.png" style=" margin-top: -80px;">
					<div class="wrap-input100 validate-input" data-validate = "Por favor escriba su usuario">
					<input class="input100" type="text" name="email" id="usuario">
						<span class="focus-input100"></span>
						<span class="label-input100" style="color:#ffffff">Usuario</span>
					</div>
					
					
					<div class="wrap-input100 validate-input" data-validate="Por favor escriba su contraseña">
						<input class="input100" type="password" id="clave" name="pass">
						<span class="focus-input100"></span>
						<span class="label-input100" style="color:#ffffff">Contraseña</span>
					</div>
					<div class="container-login100-form-btn">
						<a type="btn" class="login100-form-btn" style="background-color:#648BE4; color: white" id="login">Ingresar</a>
					</div>
					
				</form>

			</div>
		</div>
	</div>

</div>


<!--===============================================================================================-->
	<script src="vendor/jquery/jquery-3.2.1.min.js"></script>
<!--===============================================================================================-->
	<script src="vendor/animsition/js/animsition.min.js"></script>
<!--===============================================================================================-->

<!--===============================================================================================-->
	<script src="vendor/select2/select2.min.js"></script>
<!--===============================================================================================-->
	<script src="vendor/daterangepicker/moment.min.js"></script>
	<script src="vendor/daterangepicker/daterangepicker.js"></script>
<!--===============================================================================================-->
	<script src="vendor/countdowntime/countdowntime.js"></script>
<!--===============================================================================================-->
	<script src="js/main.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.min.js" integrity="sha384-+sLIOodYLS7CIrQpBjl+C7nPvqq+FbNUBDunl/OZv93DB7Ln/533i8e/mZXLi/P+" crossorigin="anonymous"></script>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">
</body>
</html>

<script src="js/validacion.js"></script>
<script src="js/alertas.js"></script>
<script src="//cdn.jsdelivr.net/npm/sweetalert2@10"></script>

<script>	
	$(document).ready(function(){
		function iniciarSesion(){
			if ($("#usuario").val() == "" || $("#clave").val() == ""){
				Swal.fire({
					icon: 'warning',
					title: 'Complete los campos solicitados',
					position: 'bottom-end',
					timerProgressBar: true,
					timer: 1000,
					toast:true,
					showConfirmButton:false,
					didOpen: (toast) => {
					toast.addEventListener('mouseenter', Swal.stopTimer)
					toast.addEventListener('mouseleave', Swal.resumeTimer)
					}
				});
			}else{
				$.ajax({
					url: 'controllers/Usuario.controller.php',
					type: 'GET',
					data: {
						op          	: 'login',
						nombreusuario   : $("#usuario").val(),
						clave			: $("#clave").val()
					},
					success: function (result){
						console.log(result);
						if ($.trim(result) == ""){
							window.location.href = 'main.php'
						}else{
							Swal.fire(result);
						}
					}
				});
			}
      	}
		$("#login").click(iniciarSesion);
		$("#clave").keypress(function (e){
			if (e.keyCode == 13){
				iniciarSesion();
			}
    	});	

		$("#correoverificacion").keypress(function (e){
			if (e.keyCode == 13){
				iniciarSesion();
			}
    	});	

	});
</script>