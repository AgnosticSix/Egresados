
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
<head>
<link rel="stylesheet" href="jq-idealforms/css/normalize.css">
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
$(document).ready(function()
{
	$('#blog-test-cont').hide();
	
     $("select[name=tipoPre]").click(function () {  
        	
            if($("#tipoPre option:selected").html()== "Pregunta de opcion"){
        	$('#blog-test-cont').show();
        	
        }
        else{
        	$('#blog-test-cont').hide();
        }
    });
});
</script>
</head>
<body>
<%  Conexion objCon = new Conexion(1,tipoBase);                                         
objCon.getConex();

ResultSet rst=null; %>
<div class="content">

    <div class="idealsteps-container">

      <nav class="idealsteps-nav"></nav>
		<center><h3>Ingresar una nueva pregunta</h3></center>
      <form  action="inser.jsp" method="post" class="idealforms" >

        <div class="idealsteps-wrap">
        <section class='idealsteps-step'>
        	<div class="field">
   			 <label class="main">Tipo de pregunta: </label>
    		<select name="tipoPre" id="tipoPre">
    		<option value="1">Pregunta abierta</option>
      		<option value="2">Pregunta de opcion</option>
      		<option value="3">Pregunta abierta con texto largo</option>
      		
      		<%/*rst = objCon.ejecSQL("SELECT * FROM CATTIPOPREG");
      	  while(rst.next()){
     		 
  	  		out.print("<option value='"+rst.getString("CATTID")+"'>"+rst.getString("TIPOPRE")+"</option>");
  	  		
  	 	 }*/ %>
    		</select>
    	<span class="error"></span>
  		</div>
  		<div class="field">
   			 <label class="main">Sección: </label>
    		<select name="sec" id="sec">
      		<option value="1">1</option>
      		<option value="2">2</option>
      		<option value="3">3</option>
      		<option value="4">4</option>
      		<option value="5">5</option>
    		</select>
    	<span class="error"></span>
  		</div>
  		<div class="field">
   			 <label class="main">Área: </label>
    		<select name="area" id="area">
      		<option value="Personal">Personal</option>
      		<option value="Estudio">Estudio</option>
      		<option value="Trabajo">Trabajo</option>
    		</select>
    	<span class="error"></span>
  		</div>
  		<div class="field" id="nombre">
    		<label class="main">Escriba la pregunta:</label>
    		<input name="nom" type="text">
    		<span class="error"></span>
  		</div>
  		<div class="field" id="blog-test-cont">
			<input type="button" value="Añadir Opción" class="blog-test"/>
		</div>
  		
  		<script type="text/javascript">
  		$(document).ready(function() {
  			var bt_count = 0;
  			$("#blog-test-cont .blog-test").bind("click", function(){
  				$(this).after("</div>");
	  			$(this).after("<div class='field' >");
	  			$(this).after("<label class='main'></label> " );
	  			$(this).after("<input class=\"blog-test\"name="+ (++bt_count)+"> " );
	  			$(this).after("<label class=\"main\">Opcion: " + (bt_count))+"</label>";
	  			$(this).after("</div>");
  			});
  		});
  		</script>
  		<div class='field buttons'>
  		<label class='main'>&nbsp;</label>
  		<button type='submit'  name='submit'>Listo</button>
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
    	  MY_stepsItems: ['Pregunta' ],
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