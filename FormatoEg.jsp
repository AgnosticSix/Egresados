<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="conex.*" %>

<head>
	
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" type="text/css" href="dhtmlx/dhtmlx.css"/>	
	<link rel="stylesheet" type="text/css" href="estilos/principal.css"/>	
	<link rel="stylesheet" type="text/css" href="easyUI/themes/icon.css">
	<script src="dhtmlx/dhtmlx.js"></script>
	
	<link rel="stylesheet" type="text/css" href="easyUI/themes/default/easyui.css">
	<script type="text/javascript" src="easyUI/jquery.min.js"></script>
	<script type="text/javascript" src="easyUI/jquery.easyui.min.js"></script>
<title>Documento sin titulo</title>
</head>
<script>
$('#tt').tabs('add',{
    title:'New Tab',
    content:'Tab Body',
    closable:true,
    tools:[{
        iconCls:'icon-mini-refresh',
        handler:function(){
            alert('refresh');
        }
    }]
});
</script>
<div id="tabs" class="easyui-tabs" style="width:100%;height:500px;">
    <div title="DATOS P." style="">
    DATOS PERSONALES
    <table cellpadding="0" cellspacing="0" width="90%" > 
    <tr>
        <td>Matricula:<input type="text" name="Matricula"></td></tr>
    <tr>
        <td >Nombre:<input type="text" name="nombre" > </td>
        <td >Apellido Paterno: <input type="text" name="apellido_pat" > </td> 
        <TD > Apellido Materno: <input type="text" name="apellido_mat" > </TD></tr>
    <tr>
    	<td>Edad:<input type="text" name="edad"></td>
        <td>Correo electronico:<input type="text" name="correo" ></td></tr>
    <tr>
    	<td>Estado civil <select name"estadoc">
        <option value="soltero">Soltero</option>
  		<option value="casado">Casado</option>
  		<option value="viudo">Viudo</option>
  		<option value="divorsiado">Divorsiado</option>
        <option value="unionlibre">Union libre</option>
        <option value="madresoltera">Madre soltera</option>
  		</select></td></tr>
    </table>
    <hr />
    <br>
    	Domicilio Actual
     <table cellpadding="0" cellspacing="0" width="90%">
     <tr>
        <td>Localidad:<input type="text" name="localidad"></td>
        <td>Codigo postal:<input type="text" name="codigo p"></td></tr>
    <tr>
    	<td>Telefono de casa<input type="text" name="telcasa"></td>
        <td>Telefono celular<input type="text" name="cel"></td></tr>
    </table>
  	<hr />
    <br>
    En caso de ser necesario, en liste personas a traves de las cuales podriamos establecer contacto con usted
    <table cellpadding="0" cellspacing="0" width="90%" border="1">
     <tr>
        <td>Nombre</td>
        <td>Telefono</td></tr>
    <tr>
    	<td><input type="text" name="conacto1" size="40"></td>
        <td><input type="text" name="telcon1" ></td></tr>
    <tr>
    	<td><input type="text" name="conacto2" size="40"></td>
        <td><input type="text" name="telcon2" ></td></tr>
   	<tr>
    	<td><input type="text" name="conacto3" size="40"></td>
        <td><input type="text" name="telcon3" ></td></tr>
    </table>
    </div>
    <div title="TRAYECTORIA A."  style="overflow:auto;padding:20px;">
    <h3>&iquest;Actualmente cuenta con su titulo profecional de la ingenieria que curso en la UPC?</h3>
        <form>
  			<input type="radio" name="titulo" value="siT" checked>Si
	  		<input type="radio" name="titulo" value="noT">No
		</form>
        <br>
        
        <h3></h3>
    </div>
    <div title="TRAYECTORIA L." style="">
        tab3
    </div>
    <div title="VALORACION EL PLAN DE ESTUDIOS"  style="">
        tab3
    </div>
    <div title="ACTUALIZACI&Oacute;N"  style="">
        tab3
    </div>
</div>
<body>
</body>
</html>