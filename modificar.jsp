<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <link rel="stylesheet" type="text/css" href="estilos/principal.css"/>	
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" type="text/css" href="estilos/tablas.css">
    
    <link rel="stylesheet" type="text/css" href="easyUI/themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="easyUI/themes/icon.css">
	<script type="text/javascript" src="easyUI/jquery.min.js"></script>
	<script type="text/javascript" src="easyUI/jquery.easyui.min.js"></script>
</head>
   
<body class="bodyp">
    
<%@ include  file="checaSesion.jsp" %>
<%@ include  file="checaPermiso.jsp" %>



<%
    if ((tieneDerecho=="S") && (haySesion)) {   

    	     //Extraemos Tabla y Descripción del modulo 
    	     CamposGrid cp=new CamposGrid();
    	     String tabla=cp.getTablaOfModulo(request.getParameter("modulo").trim(),tipoBase);
    	     
    	     
    	     String campoLlave=cp.getCampoLlave(request.getParameter("modulo").trim(),tipoBase);
    	     String esLlave=new String(); 
    	    
	        Conexion objCon= new Conexion(1,tipoBase);
		    objCon.getConex();
		    ResultSet rsBus;
		    ResultSet rsCampos;
		    	  
		   // rsBus = objCon.ejecSQL("SELECT * FROM "+tabla+" WHERE "+campoLlave+"='"+request.getParameter("reg")+"'");
		    rsBus = objCon.ejecSQL("SELECT * FROM CICLOSESC WHERE CICL_CLAVE='201501'");
            rsCampos = objCon.ejecSQL("SELECT * FROM CAMPOSABC WHERE TABLA='"+tabla+"'");
            rsBus.next();
           
     
%>
<div style="margin:15px 0;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-cancel" plain="true" onclick="salir()">Cancelar</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-save" plain="true"  onclick="guardar()">Guardar</a>
</div>

<div id="tt" class="easyui-tabs" style="width:100%;height:400px;tabPosition:bottom" >

<div title="Datos 1" style="padding:10px">
      <form id="ff" method="post">
	  <table cellpadding='0' cellspacing='0' width='75%' align="center">
<% 
		    while (rsCampos.next()){
		    	/*  esLlave="";
		    	  out.println("<tr><td>");
		    	  out.println(rsCampos.getString("ETIQUETA")+"<br>");  
		    	  if (rsCampos.getString("LLAVE").equals("S")) { esLlave="disabled='disabled'";}
		    	  
		    	  if (rsCampos.getString("TIPO").equals("INPUT")) {
		    		  out.print("<INPUT  id='"+rsCampos.getString("CAMPO")+"' class='easyui-textbox' "+esLlave+" data-options='required:true' type='text' value='"+
		    	                 rsBus.getString(rsCampos.getString("CAMPO"))+"'/></td></tr>");  
		    	  }
		    	  
		    	  if (rsCampos.getString("TIPO").equals("DATE")) {
		    		  out.print("<INPUT id='"+rsCampos.getString("CAMPO")+"' class='easyui-datebox' "+esLlave+" data-options='required:true' type='text' value='"+
		    	                 rsBus.getString(rsCampos.getString("CAMPO"))+"'/></td></tr>");  
		    	  }*/
		    	 out.println(rsBus.getString("CICL_FIN"));	
		    	 out.print("<INPUT class='easyui-datebox' "+esLlave+" data-options='required:true' type='text' value='"+
		    			 rsBus.getString("CICL_FIN")+"'/></td></tr>");  
		    
		    	  		    	  
		       }
		    objCon.cierraConex();  
%> 
     </table>
     </form>
</div>
</div>    

   

	

          
<%     	  	          	
      }
      else 
      {   //System.out.print("YA NO HAY USER");
    	  response.sendRedirect("index.jsp");
    	  }
        %>


<script type="text/javascript">
                
    			
$.fn.datebox.defaults.formatter = function(date){
	var y = date.getFullYear();
	var m = date.getMonth()+1;
	var d = date.getDate();
	return (d<10?('0'+d):d)+'-'+(m<10?('0'+m):m)+'-'+y;
};

$.fn.datebox.defaults.parser = function(s){
	if (!s) return new Date();
	var ss = s.split('-');
	var d = parseInt(ss[0],10);
	var m = parseInt(ss[1],10);
	var y = parseInt(ss[2],10);
	if (!isNaN(y) && !isNaN(m) && !isNaN(d)){
		return new Date(y,m-1,d);
	} else {
		return new Date();
	}
};


    		   function salir(){  
    			   var tab = $('#hoja').tabs('getSelected');
    			   var index = $('#hoja').tabs('getTabIndex',tab);
    			   $('#hoja').tabs('close',index);
    			 
    			   
    			   
    			   }
    		   
    		   function guardar(){     	
       			   alert ("guardaremos los datos");
    		   }
</script>
        
</body>
</html>
