<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="conex.*" %>
<%@page session="true"%>
<%@ include  file="checaSesion.jsp" %>

<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" type="text/css" href="dhtmlx/dhtmlx.css"/>	
	<link rel="stylesheet" type="text/css" href="estilos/principal.css"/>	
	<link rel="stylesheet" type="text/css" href="easyUI/themes/icon.css">
	<script src="dhtmlx/dhtmlx.js"></script>
	
	<link rel="stylesheet" type="text/css" href="easyUI/themes/default/easyui.css">
	<script type="text/javascript" src="easyUI/jquery.min.js"></script>
	<script type="text/javascript" src="easyUI/jquery.easyui.min.js"></script>
	    
<% if (haySesion) { %>    
    <script>
    var index = 0;
    function addInicio(){
             index++;
             $('#hoja').tabs('add',{
	                               title: 'Sigea 1.0',
	                               href:'acercade.jsp'
	                               
                                 });
     }


           
    
            var myMenu;
             function doOnLoad() {
            	myMenu = new dhtmlXMenuObject("menuObj");
     			myMenu.setIconsPath("imagenes/menu/");
     			myMenu.loadFromHTML("menuData", true);
     			document.getElementById("buttonHere").style.display = "none";     			
     			myMenu.attachEvent("onClick", function(id){
                     index++;
                     $('#hoja').tabs('add',{
                                         title: 'Modulo: '+id,
                                         href:'grid.jsp?modulo='+id+'&modo=0&filtro=',
                                         closable: true
                                        })
                      });
     			
     			<%
     			     			 
     	         //Extraemos el rol del Usuario 
     	         Conexion objCon = new Conexion(1,tipoBase);     
                 objCon.getConex();
                 ResultSet rs = objCon.ejecSQL("SELECT * FROM SROLUSER WHERE ROLU_USUARIO='"+nombre+"'");
     	         String rol= new String("'"+nombre+"',");
     	         while (rs.next()){
     	        	rol=rol+"'"+rs.getString("ROLU_ROL")+"',"; 
     	         }
     	    	rol=rol.substring(0, rol.length()-1);
     	    	
     	    	
     	    	//Checamos si es superusuario 
     	    	 rs = objCon.ejecSQL("SELECT * FROM CUSUARIOS WHERE USUA_USUARIO='"+nombre+"'");
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
     	        
     	         rs = objCon.ejecSQL(sqp);
     	         String padre = new String("");
				 String ico = new String("''");
				 
                 while (rs.next()) {
              	   padre="'"+rs.getString("MODU_PRED")+"'";				   
              	   if (rs.getString("MODU_PRED").equals("*")||rs.getString("MODU_PRED").equals(" ")) {padre=null;}   
				   
				   
				   if ((rs.getString("MODU_ICONON")==null)|| (rs.getString("MODU_ICONON").isEmpty())) {ico="''";} 
				   else  {ico="'"+rs.getString("MODU_ICONON")+"'";}
				                     		   
              	   out.println("myMenu.addNewChild("+padre+", 0, '"+rs.getString("MODU_MODULO")+"', '"+rs.getString("MODU_DESCRIP")+"', false,"+ico+", '');");
              	   
              	   
                 }
                 
                
                 objCon.cierraConex();
     			%>
     			addInicio();
     			}
             
    </script>
        
</head>
<body onLoad="doOnLoad();">
<center>
<div style="margin:0px; width:80%;">

     <div style="width:100%;">
	      <img src="imagenes/login/barra.png" width="100%" border="0">
		  <div style="position:absolute; float:left; z-index:300; left:83%; top:10%">
		         <a class="enlace" href="cierraSesion.jsp">Cerrar Sesi&oacute;n</a>
		  </div>
    </div>
     
     <div style="width:100%;" id="buttonHere"></div>
     
     <div style="width:100%; background: #eaf2ff; " id="menuObj"></div>
     
     <div style="width:100%; " id="menuData"></div>
     
     <div style="width:100%; height:500px;" id="hoja"  class="easyui-tabs"></div>

</div>

    	  
</center>    		
</body>
<% } else {response.sendRedirect("index.jsp");}%>
             
</html>