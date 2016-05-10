<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.sql.DataSource" %>
<%@ page import="javax.naming.*" %>
<%@ page import="conex.*" %>
<%@page session="true"%>

<%

 String tieneDerecho=new String("N");

//Consultando los campos del modulo
Conexion objConDer= new Conexion(1,"OR");
objConDer.getConex();
ResultSet rs=null;
//Checamos si es superusuario 
 rs = objConDer.ejecSQL("SELECT * FROM CUSUARIOS WHERE USUA_USUARIO='"+nombre+"'");
 String superU= new String("");
 while (rs.next()){
	superU=rs.getString("USUA_SUPER"); 
 }
 
  String rol= new String("");
  if (superU.equals("S")){tieneDerecho="S";}
  else {//Extraemos el rol del Usuario 
	     rs = objConDer.ejecSQL("SELECT * FROM SROLUSER WHERE ROLU_USUARIO='"+nombre+"'");
	     rol="'"+nombre+"',";
	     while (rs.next()){
	 	    rol=rol+"'"+rs.getString("ROLU_ROL")+"',"; 
	     }
	     rol=rol.substring(0, rol.length()-1);
	  
	     rs =objConDer.ejecSQL("SELECT COUNT(*) FROM SDERMODU A WHERE A.DERM_MODULO='"+request.getParameter("modulo")+"'"+
	    		              " AND A.DERM_USUARIO IN ("+rol+")");	 
	     rs.next();
	     if (rs.getInt(1)>=1) {tieneDerecho="S";}
  }
  objConDer.cierraConex();
  
%>

