<%@ page language="java" pageEncoding="ISO-8859-1"%>
<%@ include  file="getConex.jsp" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="org.json.*"%>

<% 

//response.setContentType("text/json");

//Extraemos Tabla y Descripción del modulo 
rs = st.executeQuery("SELECT MODU_TABLA, MODU_DESCRIP FROM CMODULOS WHERE MODU_MODULO='"+request.getParameter("modulo")+"'");
rs.next();
String tabla=rs.getString("MODU_TABLA");
rs.close();	      
 
//Creamos arreglo con los campos de la tabla que se va a seleccionar
rs = st.executeQuery("SELECT * FROM ALL_COL_COMMENT WHERE TABLE_NAME='"+tabla+"' ORDER BY NUMERO");
rs.last();
int numCampos=rs.getRow();
rs.beforeFirst();
String[] losCampos = new String[numCampos];
int i=0;
String cadSQL =new String();
while (rs.next()) {
	  losCampos[i]=rs.getString("COMMENTS");
	  i++;
	  cadSQL=cadSQL+rs.getString("COLUM_NAME")+',';	    	 
}
cadSQL=cadSQL.substring(0,cadSQL.length()-1);



	      
rs.close();	      
rs=st.executeQuery("SELECT "+cadSQL+" FROM "+tabla);	      	    	   
rs.last();
int numReg=rs.getRow();
rs.beforeFirst();

JSONObject obj = new JSONObject();
obj.put("total", numReg);                 
JSONArray list = new JSONArray();
JSONObject campos;

while (rs.next()) {	  
	  campos=new JSONObject();
	  for (int x=0; x<numCampos; x++) {
		  campos.put(losCampos[x],rs.getString(x+1));
	  }	  
	  list.put(campos);
}
obj.put("rows", list);
out.println(obj);
%>