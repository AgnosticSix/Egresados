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

</head>
<body>
<%Conexion objCon = new Conexion(1,tipoBase);                                         
objCon.getConex();
out.print(objCon);
ResultSet rst=null;

	String sql = "INSERT INTO CATPREGUNTAS(PREGUNTA,TIPO,SECCION,AREA) VALUES('"+request.getParameter("nom")+"',"+request.getParameter("tipoPre")+","+request.getParameter("sec")+",'"+request.getParameter("area")+"')";		 		
	//out.print(sql);		 		
	//objCon.ejecutar(sql);
			 		
			 		int i=1;
			 		out.print(request.getParameter(""+i));
			 		if(request.getParameter("tipoPre")=="2"){
			 			out.print(request.getParameter(""+i));	
			 			while(request.getParameter(""+i)!= ""){
			 				 sql = "INSERT INTO CATOPCIONES(CATPID,OPCION) VALUES(SEQ_CATPREGUNTAS_CATPID.currval,'"+request.getParameter(""+i)+"')";		 		
			 				out.print(sql);	
			 				 objCon.ejecutar(sql);
			 				 i++;
			 			}
			 			
			  		
			  		
			 		}
			 	objCon.cierraConex();
			 		%>
			 		
			 		
</body>
</html>