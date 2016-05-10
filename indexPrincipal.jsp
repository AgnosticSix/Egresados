<!DOCTYPE HTML>
<html>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.DataSource" %>
<%@ page import="conex.*" %>
<%@page session="true"%>
<%@ include file="checaSesion.jsp" %>
	<head>
		<title>UPC</title>
		<link rel="shortcut icon" href="images/favicon.ico" type="image/vnd.microsoft.icon" />
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<!--[if lte IE 8]><script src="assets/js/ie/html5shiv.js"></script><![endif]-->
		<link rel="stylesheet" href="assets/css/main.css" />
		<!--[if lte IE 9]><link rel="stylesheet" href="assets/css/ie9.css" /><![endif]-->
		<!--[if lte IE 8]><link rel="stylesheet" href="assets/css/ie8.css" /><![endif]-->
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
		<script type="text/javascript" src="js/jquery.js"></script>
		<script src="HighCharts/highcharts.js"></script>
		<script src="HighCharts/modules/exporting.js"></script>
	</head>
	<body class="landing">
		<div id="page-wrapper">

			<!-- Header -->
				<header id="header">
					<h1 id="logo"><a href="indexPrincipal.jsp">Sistema de Seguimiento a Egresados</a></h1>
					<nav id="nav">
						<ul>
							<li><a href="indexPrincipal.jsp">Inicio</a></li>
							<li>
								<a href="#">Preguntas</a>
								<ul>
									<li><a href="Grafica.jsp?idPregunta=0">Graficas</a></li>
									<li>
										<a href="#">Gestion</a>
										<ul>
											<li><a href="formPre.jsp">Ingresar</a></li>
											<li><a href="editarPreg.jsp">Editar</a></li>
											<li><a href="eliminarPre.jsp">Eliminar</a></li>
										</ul>
									</li>
								</ul>
							</li>
							
							<li><a href="cierraSesion.jsp" class="button special">Cerrar Sesion</a></li>
						</ul>
					</nav>
				</header>

			<!-- Banner -->
				<section id="banner">
					<div class="content">
						<header>
							<h2>Bienvenido</h2>
							
						</header>
						<span class="image"><img src="images/logo.png" alt="" /></span>
					</div>
					<a href="#one" class="goto-next scrolly">Next</a>
				</section>

			<!-- Footer -->
				<footer id="footer">
					<ul class="icons">
						<li><a href="#" class="icon alt fa-twitter"><span class="label">Twitter</span></a></li>
						<li><a href="#" class="icon alt fa-facebook"><span class="label">Facebook</span></a></li>
						<li><a href="#" class="icon alt fa-instagram"><span class="label">Instagram</span></a></li>
						<li><a href="#" class="icon alt fa-github"><span class="label">GitHub</span></a></li>
						<li><a href="#" class="icon alt fa-envelope"><span class="label">Email</span></a></li>
					</ul>
					<ul class="copyright">
						<li>&copy; Copyright. Todos los derechos reservados.</li><li>Diseño: Alumnos de Software Generacion 2013 - 2016</li>
					</ul>
				</footer>

		</div>

		<!-- Scripts -->
			<script src="assets/js/jquery.min.js"></script>
			<script src="assets/js/jquery.scrolly.min.js"></script>
			<script src="assets/js/jquery.dropotron.min.js"></script>
			<script src="assets/js/jquery.scrollex.min.js"></script>
			<script src="assets/js/skel.min.js"></script>
			<script src="assets/js/util.js"></script>
			<!--[if lte IE 8]><script src="assets/js/ie/respond.min.js"></script><![endif]-->
			<script src="assets/js/main.js"></script>

	</body>
</html>