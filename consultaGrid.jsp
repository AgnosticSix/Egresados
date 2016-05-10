<%@ page language="java" pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="org.json.*"%>
<%@ page import="conex.*"%>
<%@ page import="java.io.PrintWriter"%>
<%@ include  file="checaSesion.jsp" %>
<% 

//response.setContentType("text/json");

//Extraemos Tabla y Descripción del modulo 
CamposGrid cp=new CamposGrid();
String tabla=cp.getTablaOfModulo(request.getParameter("modulo"),tipoBase);

 
//Creamos arreglo con los campos de la tabla que se va a seleccionar
String[] losCampos=cp.getCampos(tabla,tipoBase);
int numCampos=cp.numCampos;
String cadSQL=cp.cadSQL;


//Creando archivo JSON para el menu
Conexion objCon= new Conexion(1,tipoBase);
objCon.getConex();
ResultSet rs=null;

//Obtenemos el limite de registros a mostrar 
String limite = objCon.devClave("CONFIGMAIN", "CONF_LIMITE", "CONF_NUMERO", "0");


//Se ejecuta por primera vez desde el menu PARA EL CASO DE FIREBIRD
if (request.getParameter("modo").equals("0")&&(tipoBase.equals("FB"))){
    cadSQL="SELECT FIRST "+limite+" "+cadSQL+" FROM "+tabla+" ORDER BY 1";
}
//Se ejecuta por primera vez desde el menu PARA EL CASO DE ORACLE
if (request.getParameter("modo").equals("0")&&(tipoBase.equals("OR"))){
    cadSQL="SELECT "+cadSQL+" FROM "+tabla+" WHERE ROWNUM<="+limite+" ORDER BY 1";
}




//Se solicita una consulta de busqueda
if (request.getParameter("modo").equals("1")){
    cadSQL="SELECT "+cadSQL+" FROM "+tabla+"  ORDER BY 1";
}



//Verficamos si es superusuario o se agrega filtro de usuario normal
String usuario=nombre;
String rolu= new String();
if (objCon.superUsuario(usuario).equals("N")) {
	rolu=objCon.losRoles(usuario);
	if (rolu.length()>0) { usuario=rolu;}
	cadSQL=objCon.convSQLFiltro(cadSQL, usuario);
}

//Si es una consulta de filtro se agrega las condiciones del filtro 	
Utilerias ut=new Utilerias();
if (request.getParameter("modo").equals("1")){
	if (!(request.getParameter("filtro").equals(""))) {
        cadSQL=ut.addFiltro(request.getParameter("filtro"), cadSQL);
	}
}


rs = objCon.ejecSQL(cadSQL);	
if (rs.next()) {
    rs.last();
    int numReg=rs.getRow();
    rs.beforeFirst();

    PrintWriter pw = response.getWriter();
	pw.print("{\"total\":"+numReg+",\"rows\":[");
	String elCampo = new String();
	String comaCam=",";
	String comaFin=",";
	while (rs.next()) {	 
		  comaCam=",";
		  pw.print("{");
		  for (int x=0; x<numCampos; x++) {
			  if (x==numCampos-1){comaCam="";}
			  elCampo= (rs.getString(x+1)!=null)? rs.getString(x+1).replace("\"", "").replace("\\", ""):"";		 
			  pw.print("\""+losCampos[x]+"\":\""+elCampo+"\""+comaCam);		  
		  }	
		  if (rs.getRow()==numReg) {comaFin="";}
		  pw.print("}"+comaFin);		  
	}
	pw.print("]}");
	pw.flush();
}

objCon.cierraConex();  



%>