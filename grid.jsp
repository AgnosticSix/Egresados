<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="org.json.*"%>
<%@ page import="conex.*" %>
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
<%@ include  file="checaPermiso.jsp" %>

    <%
      if ((tieneDerecho=="S") && (haySesion)) {      %>
            <center>
    	    <div style="margin:20px 0;"></div>
    		<table id="grid<%=request.getParameter("modulo")%>"  title="Módulo de ..." style="width:98%;height:350px"
    				data-options="rownumbers:true,singleSelect:true,pagination:false,remoteSort:false,multiSort:true,
    				url:'consultaGrid.jsp?modulo=<%=request.getParameter("modulo")%>&modo=<%=request.getParameter("modo")%>&filtro=<%=request.getParameter("filtro")%>',
    				method:'get',toolbar:'#tb<%=request.getParameter("modulo")%>'">
    			<thead>
    				<tr>
    				    <%
    				       //Extraemos Tabla y Descripción del modulo 
    				       CamposGrid cp=new CamposGrid();
    				       String tabla=cp.getTablaOfModulo(request.getParameter("modulo"),tipoBase);    				     
    				      
                           //Creamos arreglo con los campos de la tabla que se va a seleccionar
    				       String[] losCampos=cp.getCampos(tabla,tipoBase);
    				       String llave=losCampos[0];     				      
    				       int numCampos=cp.numCampos;
    				       for (int x=0; x<numCampos;x++){
    				    	   out.println("<th data-options=\"field:'"+losCampos[x]+"',width:"+"100"+",sortable:true\">"+losCampos[x]+"</th>"); 
    				       }
    				       
    				    %>    				    
    				</tr>
    			</thead>
    		</table>
    		
    		<div id="tb<%=request.getParameter("modulo")%>" style="padding:5px;height:auto">
		        <div style="margin-bottom:5px">
		             <a onclick="showBus()" class="easyui-linkbutton" data-options="iconCls:'icon-filter'">Buscar</a>
		             <a onclick="contar()" class="easyui-linkbutton" data-options="iconCls:'icon-remove'">Contar</a>
		             <a onclick="modificar()" class="easyui-linkbutton" data-options="iconCls:'icon-remove'">Modificar</a>		             	
			    </div>
		    </div>		    
    		</center>
    		
    		
    		<div id="dlg<%=request.getParameter("modulo")%>" class="easyui-dialog" title="Toolbar and Buttons" style="width:400px;height:450px;padding:10px"
			data-options="
				iconCls: 'icon-save',	
				closed: 'false',
				modal: 'true',
				buttons: [{
					text:'Buscar',
					iconCls:'icon-ok',
					handler:function(){Buscar();}
				},{
					text:'Cerrar',
					handler:function(){
						 $('#dlg<%=request.getParameter("modulo")%>').dialog('close');;
					}
				}]
			">
			
           <table class="estilotabla" border="0px" width="100%">
	       <%
	       CamposGrid cpBus=new CamposGrid();
	       String tablaBus=cpBus.getTablaOfModulo(request.getParameter("modulo"),tipoBase);
	  
	       //Consultando los campos del modulo
	       Conexion objCon= new Conexion(1,tipoBase);
	       objCon.getConex();
	       ResultSet rsBus;
	       rsBus = objCon.ejecSQL("SELECT * FROM ALL_COL_COMMENT WHERE TABLE_NAME='"+tablaBus+"' ORDER BY NUMERO");	    
	       while (rsBus.next()){
	    	  out.print("<tr>");
	    	  out.print("<td class='estilocelda' width='25%'>"+rsBus.getString("COMMENTS")+"</td>");
		      out.print("<td width='75%'><INPUT type='text' id='"+rsBus.getString("COLUM_NAME")+"'/></td>");	
		      out.print("</tr>");		    
	       }	      
	       objCon.cierraConex();
	      %>
	</table> 
	</div>
          
              		
       
	
    		
    		<script type="text/javascript">
    		   
    		
    		
    			$(function(){
    				var pager = $('#grid<%=request.getParameter("modulo")%>').datagrid().datagrid('getPager');	// get the pager of datagrid    				
    			})
    			
    			
    		   
    		   function showBus(){     	
    			    $('#dlg<%=request.getParameter("modulo")%>').dialog('open');    			       			   
    		   }
    		   
    		   
    		   function modificar(){
    			    
    			    var row = $('#grid<%=request.getParameter("modulo")%>').datagrid('getSelected'); 
    			    
    				if (row){
    					 $('#hoja').tabs('add',{title: 'Mod:'+row.<%out.print(llave);%>,
    	                                        closable: true,
    	                                        href:'modificar.jsp?modulo=<%=request.getParameter("modulo")%>+&reg='+row.<%out.print(llave);%>                       
    	                        });
    				}
    				
    				
    		   }
    		   
    		   function contar(){
    			   var reg = $('#grid<%=request.getParameter("modulo")%>').datagrid('getRows'); 
    			   alert ("Números de registros mostrados: "+reg.length);   
    		   }
    		   
    		   
    		   function Buscar(){
    			     var cadena="";
      			     $('#dlg<%=request.getParameter("modulo")%>').find(':input').each(function() {
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
      			   var tab = $('#hoja').tabs('getSelected'); 
  			       tab.panel('refresh', 'grid.jsp?modulo=<%=request.getParameter("modulo")%>&modo=1&filtro='+cadena);  			       
  			       $('#dlg<%=request.getParameter("modulo")%>').dialog('close'); 
  			       
       		   } 
    		</script>
    			
    	  
    	  <%     	  	          	
      }
      else 
      {   //System.out.print("YA NO HAY USER");
    	  response.sendRedirect("index.jsp");
    	  }
        %>


</body>
</html>