
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

</body>
</html>
<!DOCTYPE html >
<%@ page import= "javax.servlet.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.DataSource" %>
<%@ page import="conex.*" %>
<%@page session="true"%>
<%@ include file="checaSesion.jsp" %>
<html>
<head><link rel="stylesheet" href="jq-idealforms/css/normalize.css">
<link rel="stylesheet" href="jq-idealforms/css/jquery.idealforms.css">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
 <script src="http://code.jquery.com/jquery-2.1.0.min.js"></script>
  <script src="//ajax.googleapis.com/ajax/libs/jqueryui/1.10.3/jquery-ui.min.js"></script>
  <script src="jq-idealforms/js/out/jquery.idealforms.js"></script>
<title>Pregunas</title>
<style>
  body {
    max-width: 1350px;
    margin: 2em auto;
    font: normal 15px/1.5 Arial, sans-serif;
    color: #353535;
    overflow-y: scroll;
  }
  .content {
    margin: 0 50px;
  }

  .field.buttons button {
    margin-right: .5em;
  }

  #invalid {
    display: none;
    float: left;
    width: 290px;
    margin-left: 200px;
    margin-top: 2em;
    color: #CC2A18;
    font-size: 130%;
    font-weight: bold;
  }

  .idealforms.adaptive #invalid {
    margin-left: 0px !important;
  }

  .idealforms.adaptive .field.buttons label {
    height: 200px;
  }
  form.idealforms label.main {
  width: 350px;
  
}

</style>
<script type="text/javascript">
function getRadioB(ctrl)
{
    for(i=0;i<ctrl.length;i++)
        if(ctrl[i].checked) return ctrl[i].value;
}</script>
<script type="text/javascript">
document.getElementById("list");
function cambiaGrafica(){
	location.href = "editarPreg.jsp?idPregunta="+$('#list').val();

}
$(document).ready(function()
{
	$('#num').hide();
	$('#f').hide();
	
     $("select[name=tipoPre]").click(function () {  
        	
            if($("#tipoPre option:selected").html()== "2"){
        	$('#num').show();
        	
        }
        else{
        	$('#num').hide();
        }
    });
});
</script>
</head>
<body>
<%  Conexion objCon = new Conexion(1,tipoBase);                                         
objCon.getConex();
int i=1;
ResultSet rst=null,re=null,rste=null; %>
<div class="content">

    <div class="idealsteps-container">

      <nav class="idealsteps-nav"></nav>
		<center><h3>Editar Pregunta</h3></center>
      <form  action="insertar.jsp" method="post" class="idealforms" >

        <div class="idealsteps-wrap">
        <section class='idealsteps-step'>
        	<div class="field">
   			 <label class="main">Seleccione la pregunta que va a editar: </label>
    		<select name="Pre" id="list" onchange='cambiaGrafica()'>
      		<%rst = objCon.ejecSQL("SELECT * FROM CATPREGUNTAS");
      	  while(rst.next()){
     		 
  	  		out.print("<option value='"+rst.getString("CATPID")+"'>"+rst.getString("PREGUNTA")+"</option>");
  	  		
  	 	 } %>
    		</select>
    	<span class="error"></span>
    	<input name="f" value="<%request.getParameter("idPregunta"); %>"></input>
  		</div>
  		<%re=objCon.ejecSQL("SELECT * FROM CATPREGUNTAS WHERE CATPID="+request.getParameter("idPregunta"));
  		out.print("<div class='field' >");
    	  out.print("<label class='main'>Pregunta: "+re.getString("PREGUNTA")+"</label>");
    	  out.print("</div>");
    	  out.print("<div class='field' >");
    	  out.print("<label class='main'>Tipo: "+re.getString("TIPO")+"</label>");
    	  out.print("</div>");
    	  out.print("<div class='field' >");
    	  out.print("<label class='main'>Sección: "+re.getString("SECCION")+"</label>");
    	  out.print("</div>");
    	  out.print("<div class='field' >");
    	  out.print("<label class='main'>Área: "+re.getString("AREA")+"</label>");
    	  out.print("</div>");
    	  if(re.getString("TIPO")=="2"){
        	  rste = objCon.ejecSQL("SELECT * FROM CATOPCIONES WHERE CATPID='"+rst.getString("CATPID")+"'");
        	  
        	  while(rste.next()){
        		  out.print("<div class='field'>");
        	  		out.print("<label value='"+rste.getString("OPCION")+"'>Opcion "+i+" :"+rste.getString("OPCION")+"</label>");
              	  out.print("</div>");
        	  		i++;
        	  }
    	  }
  		%>
  				
			 	
  			<div class='field buttons'>
  			<label class='main'>&nbsp;</label>
  			<button type='submit'  name='submit'>Eliminar</button>
  			</div>
        	</section>
        
        </div>
        
	</form>
	</div>
</div>
<script>
    $('form.idealforms').idealforms({
      silentLoad: false,
      steps: {
    	  MY_stepsItems: ['Editar Pregunta' ],
    	  buildNavItems: function(i) {
    	    return this.opts.steps.MY_stepsItems[i];
    	  }
    	},
    	  rules: {
    		    'options': 'select:default'
    		  }
    });

    $('form.idealforms').find('input, select, textarea').on('change keyup', function() {
      $('#invalid').hide();
    });

    $('.prev').click(function(){
      $('.prev').show();
      $('form.idealforms').idealforms('prevStep');
    });
    $('.next').click(function(){
      $('.next').show();
      $('form.idealforms').idealforms('nextStep');
    });
  </script>
</body>
</html>