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
<%
try{
	Statement st = null;
Conexion objCon = new Conexion(1,tipoBase);                                         
objCon.getConex();
out.print(objCon);
ResultSet rst=null;
		rst = objCon.ejecSQL("SELECT * FROM CATPREGUNTAS");
		while(rst.next()){
			if(rst.getInt("TIPO") != 4){
				String r= request.getParameter(rst.getInt("CATPID")+"r");
				if(r != "" || r!= "default"){
			 		String sql = "INSERT INTO RESPUESTAS(CATPID,USUA_USUARIO,RESPUESTA) VALUES("+rst.getInt("CATPID")+",'"+nombre+"','"+r+"')";
			 		out.print(nombre);
			 		objCon.ejecutar(sql);
				}
			}
		}     
		 objCon.cierraConex(); 
} catch (Exception ex) {
    out.print("Error (" + ex.getMessage() + "): " + ex.getMessage());
}
response.sendRedirect("http://www.updc.edu.mx/");
	%>

	
	 
</body>
</html>