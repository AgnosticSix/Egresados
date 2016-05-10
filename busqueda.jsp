<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="conex.*" %>
<%@page session="true"%>
<%@ include  file="checaSesion.jsp" %>

<html>
<head>
     <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">	
     <link rel="stylesheet" type="text/css" href="estilos/tablas.css">
     <link rel="stylesheet" type="text/css" href="easyUI/themes/icon.css">
     <link rel="stylesheet" type="text/css" href="easyUI/themes/default/easyui.css">
</head>
    
 <body>
	<table class="estilotabla" border="0px" width="100%">
	<%
	       CamposGrid cp=new CamposGrid();
	       String tabla=cp.getTablaOfModulo(request.getParameter("modulo"));
	  
	       //Consultando los campos del modulo
	       Conexion objCon= new Conexion(1);
	       objCon.getConex();
	       ResultSet rs;
	       rs = objCon.ejecSQL("SELECT * FROM ALL_COL_COMMENT WHERE TABLE_NAME='"+tabla+"' ORDER BY NUMERO");	    
	       while (rs.next()){
	    	  out.print("<tr>");
	    	  out.print("<td class='estilocelda' width='25%'>"+rs.getString("COMMENTS")+"</td>");
		      out.print("<td width='75%'><INPUT type='text' id='"+rs.getString("COLUM_NAME")+"'/></td>");	
		      out.print("</tr>");		    
	       }	      
	       objCon.cierraConex();
	%>
	</table> 
</body>
</html>