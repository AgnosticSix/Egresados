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
	<script src="HighCharts/highcharts.js"></script>
	<link rel="stylesheet" type="text/css" href="easyUI/themes/default/easyui.css">
	<script type="text/javascript" src="easyUI/jquery.min.js"></script>
	<script type="text/javascript" src="easyUI/jquery.easyui.min.js"></script>
	    
<% if (haySesion) { %>    
    <script>
    var index = 0;
    function addInicio(){
             index++;
             $('#hoja').tabs('add',{
	                               title: 'Grafica',
	                               href:'Grafica.jsp?idPregunta='+<%=request.getParameter("idPregunta")%>
	                               
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
     
     <div style="width:100%; " id="menuData" >
     </div>
     
     <div style="width:100%; height:500px;" id="hoja"  class="easyui-tabs"></div>

</div>

    	  
</center>    		
</body>
<% } else {response.sendRedirect("index.jsp");}%>
             
</html>