<%@ page language="java" pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="org.json.*"%>


<%@page session="true"%>



<html lang="es">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" type="text/css" href="estilos/tablas.css">
    
    <link rel="stylesheet" type="text/css" href="easyUI/themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="easyUI/themes/icon.css">
	<script type="text/javascript" src="easyUI/jquery.min.js"></script>
	<script type="text/javascript" src="easyUI/jquery.easyui.min.js"></script>
	
</head>

<body >
<%@ include  file="checaSesion.jsp" %>
<%@ include  file="getConex.jsp" %>
<%@ include  file="checaPermiso.jsp" %>

    <%
      if (tieneDerecho=="S") {      %>
            <center>
    	    <div style="margin:20px 0;"></div>
    		<table id="grid<%=request.getParameter("modulo")%>"  title="Módulo de ..." style="width:98%;height:350px"
    				data-options="rownumbers:true,singleSelect:true,pagination:false,
    				url:'consultaGrid.jsp?modulo=<%=request.getParameter("modulo")%>&modo=<%=request.getParameter("modo")%>&filtro=<%=request.getParameter("filtro")%>',
    				method:'get',toolbar:'#tb<%=request.getParameter("modulo")%>'">
    			<thead>
    				<tr>
    				    <%
    				       //Extraemos Tabla y Descripción del modulo 
    				       CamposGrid cp=new CamposGrid();
    				       String tabla=cp.getTablaOfModulo(request.getParameter("modulo"));    				     
    				       //Creamos arreglo con los campos de la tabla que se va a seleccionar
    				       String[] losCampos=cp.getCampos(tabla);
    				       int numCampos=cp.numCampos;
    				       for (int x=0; x<numCampos;x++){
    				    	   out.println("<th data-options=\"field:'"+losCampos[x]+"',width:"+"100"+"\">"+losCampos[x]+"</th>"); 
    				       }
    				       
    				    %>    				    
    				</tr>
    			</thead>
    		</table>
    		
    		<div id="tb<%=request.getParameter("modulo")%>" style="padding:5px;height:auto">
		        <div style="margin-bottom:5px">
		             <a onclick="showBus()" class="easyui-linkbutton" data-options="iconCls:'icon-filter'">Buscar</a>
		             <a onclick="buscar()" class="easyui-linkbutton" data-options="iconCls:'icon-remove'">Contar</a>		             	
			    </div>
		    </div>
		    
    		</center>
    		
            <div id="panBus<%=request.getParameter("modulo")%>" 
                 data-options="title:'Criterios de Búsqueda',buttons:'#botones<%=request.getParameter("modulo")%>',modal:true">                                           
            </div>  
              		
                 <div id="botones<%=request.getParameter("modulo")%>">
	             <a onclick="Buscar()" class="easyui-linkbutton">Buscar</a>
                 </div>
	
    		
    		<script type="text/javascript">
    		   
    		
    		
    			$(function(){
    				var pager = $('#grid<%=request.getParameter("modulo")%>').datagrid().datagrid('getPager');	// get the pager of datagrid    				
    			})
    			
    			function nuevoRegistro(){
    	             index++;
    	             $('#hoja').tabs('add',{
    		                               title: 'Sigea 1.0',
    		                               href:'acercade.jsp',
    		                               closable: true
    	                                 });
    	       }
    			
    		   function modificaTab(){  
    			   alert ("hola");
    			   
    			   var tab = $('#hoja').tabs('getSelected');     			   
    			   tab.panel('refresh', 'acercade.jsp');
    		   }
    			
    		   
    		   function showBus(){     	
    			   
    			    $('#panBus<%=request.getParameter("modulo")%>').dialog({
    			        title: 'Criterios de Búsqueda',
    			        width: 400,
    			        height: 400,
    			        closed: false,
    			        cache: false,   
    			     	href: 'busqueda.jsp?modulo=<%=request.getParameter("modulo")%>',	
    			        modal: true
    			        });    			       			   
    		   }
    		   
    		   
    		   function Buscar(){  
    			     var cadena="";
      			     $('#panBus<%=request.getParameter("modulo")%>').find(':input').each(function() {
      		              var elemento= this;      		              
      		              var campo=elemento.value;
      		              var vapos="";
      		              
      		              if (campo!="") {
      		            	  
      		            	  if ((campo.substring(0,1)==">")||(campo.substring(0,1)=="<")||(campo.substring(0,1)=="|")){
      		            		 if (elemento.value.indexOf("/")>0) {
      		            			 vapos="-";
      		            		 }   
      		            	  }
      		            	  
      		            	  if (campo.substring(0,1)=="=") {
      		            		  cadena=cadena+elemento.id+"$-"+campo.substring(1,campo.length)+"- and ";       		            		  
      		            	  }
      		            	  else if (campo.substring(0,2)==">=") {    
      		            	      cadena=cadena+elemento.id+">_"+vapos+elemento.value.substring(2,elemento.value.length)+vapos+" and ";
      		            	  }
      		            	  else if (campo.substring(0,1)==">") {      		            	  
    		            	      cadena=cadena+elemento.id+">"+vapos+elemento.value.substring(1,elemento.value.length)+vapos+" and ";
    		            	  }
      		            	  else if (campo.substring(0,2)=="<=") {      		            	  
    		            	      cadena=cadena+elemento.id+"<_"+vapos+elemento.value.substring(2,elemento.value.length)+vapos+" and ";
    		            	  }
      		            	  else if (campo.substring(0,1)=="<") {      		            	  
  		            	      cadena=cadena+elemento.id+"<"+vapos+elemento.value.substring(1,elemento.value.length)+vapos+" and ";
  		            	      }
      		            	  else if (campo.substring(0,1)=="|") {      		            	  
    		            	      cadena=cadena+elemento.id+">_"+vapos+elemento.value.substring(1,elemento.value.lastIndexOf("|"))+vapos+" "+
    		            	      " and "+elemento.id+"<_"+vapos+elemento.value.substring(elemento.value.lastIndexOf("|")+1,elemento.value.length)+vapos+" and ";
    		            	      }
      		            	  else  {
      		            		 cadena=cadena+elemento.id+" like $_"+elemento.value+"_$ and ";  
      		            	  }
      		            		 
      		              }        		              
      		          });
      			   cadena=cadena.substring(0,cadena.length-4);
      			   alert (cadena);      			   
      			   var tab = $('#hoja').tabs('getSelected'); 
  			       tab.panel('refresh', 'grid.jsp?modulo=<%=request.getParameter("modulo")%>&modo=1&filtro='+cadena);  			       
  			       $('#panBus<%=request.getParameter("modulo")%>').dialog('close'); 
  			       
       		   } 
    		</script>
    			
    	  
    	  <%     	  	      
    	  
    	  rs.close();
    	  cn.close();
      }
      else 
      {   cn.close();
    	  response.sendRedirect("index.jsp");}
        %>


</body>
</html>