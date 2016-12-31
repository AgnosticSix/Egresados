<%@ page language="java" contentType="text/html; charset=ISO-8859-1" import="java.sql.*" errorPage=""
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.DataSource" %>
<%@ page import="conex.*" %>
<%@page session="true"%>
<%@ include file="checaSesion.jsp" %>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<script type="text/javascript" src="js/jquery.js"></script>
<script src="HighCharts/highcharts.js"></script>
<script src="HighCharts/modules/exporting.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
<link rel="stylesheet" href="estilos/graficEstilo.css">
<title>Grafica</title>
</head>
<body>
<%
Conexion objCon = new Conexion(1,tipoBase);                                         
objCon.getConex();

ResultSet rst=null,rste=null, rstq=null, rstw=null;

	//rst = objCon.ejecSQL("SELECT * FROM RESPUESTAS");
	
%>



<%objCon.cierraConex(); %>
</body>
</html>