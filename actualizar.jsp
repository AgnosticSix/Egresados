<!DOCTYPE html>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.DataSource" %>
<%@ page import="conex.*" %>
<%@page session="true"%>
<%@ include file="checaSesion.jsp" %>

<head>

<meta charset=utf-8 />
<%Conexion objCon = new Conexion(1,tipoBase);                                         
objCon.getConex();
String sql="UPDATE SET PREGUNTA='"+request.getParameter("pre")+"', SECCION='"+request.getParameter("sec")+"', TIPO='"+request.getParameter("tipo")+"', AREA='"+request.getParameter("area")+"' WHERE CATPID='"+request.getParameter("f")+"'";
objCon.ejecutar(sql);%>
<title>Insert title here</title>
</head>
<body>

</body>
</html>