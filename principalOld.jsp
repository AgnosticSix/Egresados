<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="conex.*" %>
<%@page session="true"%>
<%@ include  file="checaSesion.jsp" %>
<%@ include  file="getConex.jsp" %>

<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" type="text/css" href="dhtmlx/dhtmlx.css"/>	
	<link rel="stylesheet" type="text/css" href="estilos/principal.css"/>	
	<script src="dhtmlx/dhtmlx.js"></script>
	
	<link rel="stylesheet" type="text/css" href="easyUI/themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="easyUI/themes/icon.css">
	<link rel="stylesheet" type="text/css" href="easyUI/demo.css">
	<script type="text/javascript" src="easyUI/jquery.min.js"></script>
	<script type="text/javascript" src="easyUI/jquery.easyui.min.js"></script>
	    
    
    <script>

            var myMenu;
             function doOnLoad() {
            	myMenu = new dhtmlXMenuObject("menuObj");
     			myMenu.setIconsPath("imagenes/menu/");
     			myMenu.loadFromHTML("menuData", true);
     			document.getElementById("buttonHere").style.display = "none";
     			myMenu.attachEvent("onClick", function(id){
     				     window.framep.location="grid.jsp?modulo="+id; });
     			
     			<%
     	         //Extraemos el rol del Usuario 
     	         rs = st.executeQuery("SELECT * FROM SROLUSER WHERE ROLU_USUARIO='"+nombre+"'");
     	         String rol= new String("'"+nombre+"',");
     	         while (rs.next()){
     	        	rol=rol+"'"+rs.getString("ROLU_ROL")+"',"; 
     	         }
     	    	rol=rol.substring(0, rol.length()-1);
     	    	
     	    	
     	    	//Checamos si es superusuario 
     	    	 rs = st.executeQuery("SELECT * FROM CUSUARIOS WHERE USUA_USUARIO='"+nombre+"'");
     	         String superU= new String("");
     	         while (rs.next()){
     	        	superU=rs.getString("USUA_SUPER"); 
     	         }
     	         
     	         
     	         String sqp=new String("");
     	         sqp="select DISTINCT(MODU_MODULO), MODU_PRED, MODU_DESCRIP, MODU_APLICACION,"+
     	              " MODU_VERSION, MODU_EJECUTA, MODU_ICONO,  MODU_CANCEL, MODU_TECLARAP, "+
     	              " MODU_AUXILIAR, MODU_AUTOMATICO, PERM_MODULO, MODU_ICONON from Cpermisos,Cmodulos where "+
     	              " Cmodulos.modu_modulo=Cpermisos.perm_modulo and modu_cancel='N'"+
     	              " and modu_auxiliar<>'S'";
     	         
     	         if (superU.equals("S")){
     	             sqp="select * from cmodulos where modu_cancel='N' and modu_auxiliar<>'S' order by modu_aplicacion, modu_pred, modu_descrip DESC";
     	             }
     	         else
     	             {sqp=sqp+ " and perm_usuario in ("+rol+") order by modu_aplicacion, modu_pred, modu_descrip DESC";}
     	        
     	         rs = st.executeQuery(sqp);
     	         String padre = new String("");
				 String ico = new String("''");
                 while (rs.next()) {
              	   padre="'"+rs.getString("MODU_PRED")+"'";				   
              	   if (rs.getString("MODU_PRED").equals("*")) {padre=null;}   
				   
				   
				   if ((rs.getString("MODU_ICONON")==null)|| (rs.getString("MODU_ICONON").isEmpty())) {ico="''";} 
				   else  {ico="'"+rs.getString("MODU_ICONON")+"'";}
				                     		   
              	   out.println("myMenu.addNewChild("+padre+", 0, '"+rs.getString("MODU_MODULO")+"', '"+rs.getString("MODU_DESCRIP")+"', false,"+ico+", '');");
                 }
                 cn.close(); 
                 rs.close();
     			%>
            }
             
             
            
    </script>
        
</head>
<body onLoad="doOnLoad();">
<center>
<table width=75%  CELLPADDING=0 cellspacing="0" >
<tr>
   <td background="imagenes/login/barra.png" align="right"  height="35px"> <a href="cierraSesion.jsp"><div id="btn" class="btn"> </div></a></td>
</tr>
<tr> 
<td>
 <div style="height: 30px;" id="buttonHere"></div>
	<div style="height:20px;">
	<div id="menuObj"></div></div>
	<div id="menuData" style="display: none;">
	
	</div>
	</td>
</tr>
<TR>
  <TD>
      <iframe scrolling="no" width="100%" height="800px" id="framep"  name="framep" src="acercade.jsp" frameborder="0" align="top"> </iframe>
  </TD>
</TR>

</table>
</center>
</body>
</html>