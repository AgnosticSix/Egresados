<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%@page session="true"%>

<%
HttpSession sesion=request.getSession();
String nombre=(String)sesion.getAttribute("user");
String tipoBase=(String)sesion.getAttribute("tipoBase");

boolean haySesion=true;
if ((nombre==null )||  (nombre.isEmpty())) {
	haySesion=false;
}

%>

