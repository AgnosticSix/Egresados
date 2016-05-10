<!DOCTYPE html>
<%@ page import= "javax.servlet.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.DataSource" %>
<%@ page import="conex.*" %>
<%@page session="true"%>
<%@ include file="checaSesion.jsp" %>
<head>
<link rel="stylesheet" href="jq-idealforms/css/normalize.css">
<link rel="stylesheet" href="jq-idealforms/css/jquery.idealforms.css">
<meta charset=utf-8 />
<title>Formato Egresados</title>
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
</head>
<body>
<%
          Conexion objCon = new Conexion(1,tipoBase);                                         
          objCon.getConex();
          
          ResultSet rst=null,rste =null;
         
			rst = objCon.ejecSQL("SELECT * FROM FALUMNOS WHERE ALUM_MATRICULA='"+nombre+"'");
			rst.next();
			out.print("<table>");
			out.print("<tr>");
			out.print("<td>"+rst.getString("ALUM_NOMBRE")+" "+rst.getString("ALUM_APEPAT")+" "+rst.getString("ALUM_APEMAT")+"</td>");
			out.print("</tr>");
			out.print("<tr>");
			out.print("<td>Matricula: "+nombre+"</td>");
			out.print("</tr>");
			out.print("</table>");
			 %>
  <div class="content">

    <div class="idealsteps-container">

      <nav class="idealsteps-nav"></nav>

      <form  action="insertar.jsp" method="post" class="idealforms" >

        <div class="idealsteps-wrap">
          <%for(int j=1;j<=5;j++){
        	  out.print("<section class='idealsteps-step'>");
          rst = objCon.ejecSQL("SELECT * FROM CATPREGUNTAS WHERE SECCION="+j );
          
          while(rst.next()){
        if(rst.getInt("TIPO") == 1){
      	  out.print("<div class='field' id='"+rst.getString("CATPID")+"'>");
      	  out.print("<label class='main'>"+rst.getString("PREGUNTA")+"</label>");
      	  out.print("<input name="+rst.getString("CATPID")+"r></input>");
      	  out.print("</div>");
        }
        else if(rst.getInt("TIPO") == 2){
        	out.print("<div class='field' id='"+rst.getString("CATPID")+"'>");
        	  out.print("<label class='main'>"+rst.getString("PREGUNTA")+"</label>");
        	  out.print("<select name='"+rst.getString("CATPID")+"r' id='"+rst.getString("CATPID")+"r'>");
        	  out.print("<option value='default'>&ndash; Elige una opción &ndash;</option>");
        	  rste = objCon.ejecSQL("SELECT * FROM CATOPCIONES WHERE CATPID='"+rst.getString("CATPID")+"'");
        	  while(rste.next()){
        		 
        	  		out.print("<option value='"+rste.getString("OPCION")+"'>"+rste.getString("OPCION")+"</option>");
        	  		
        	  }
        	  out.print("</select>");
        	  out.print("</div>");
        }
        else if(rst.getInt("TIPO") == 3){
        	out.print("<div class='field' id='"+rst.getString("CATPID")+"'>");
        	  out.print("<label class='main'>"+rst.getString("PREGUNTA")+"</label>");
        	  out.print("<textarea name="+rst.getString("CATPID")+"r cols='30' rows='10'></textarea>");
        	  out.print("</div>");
        }
        else{
        	out.print("<div class='field' id='"+rst.getString("CATPID")+"'>");
      	  out.print("<h3>"+rst.getString("PREGUNTA")+"</h3>");
      	  out.print("</div>");
        }
          }
          out.print( "<div class='field buttons'>");
          out.print("<label class='main'>&nbsp;</label>");
       	  out.print(" <button type='button' class='next'>Next &raquo;</button>");
       	  if(j == 5){
       		out.print(" <button type='submit'  name='submit'>Listo</button>");
       	  }
          out.print(" </div>");
          out.print(" </section>");
          }
          %>
		
          
            
<script type='text/javascript' src="//ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
<script type="text/javascript">
$(document).ready(function()
{	
	$('#5').hide();
        $("select[name=4r]").click(function () {  
        	
            if($("#4r option:selected").html()== "Si"){
            	$('#5').show();  
            	
            }
            else{
            	$('#5').hide();
            }
        });
});
</script> 
<script type="text/javascript">
$(document).ready(function()
{
	$('#7').hide();
	$('#8').hide();
	
    $("select[name=6r]").click(function () {  
        	
            if($("#6r option:selected").html()== "No"){
        	$('#7').show();
        	$('#8').show();
        	
        }
        else{
        	$('#7').hide();
        	$('#8').hide();
        }
    });
});
</script>
<script type="text/javascript">
$(document).ready(function()
{
	$('#11').hide();
	$('#13').hide();
	$('#10').hide();
	$('#poster').hide();
	
   $("select[name=9r]").click(function () {  
        	
            if($("#9r option:selected").html()== "No"){
        	$('#11').hide();
        	$('#10').hide();
        	$('#13').hide();
        	$('#14').hide();
        	
        }
        else{
        	$('#11').show();
        	$('#10').show();
        	$('#13').show();
        	$('#14').show();
        }
    });
});
</script>
<script type="text/javascript">
$(document).ready(function()
{
	$('#12').hide();
	
     $("select[name=11r]").click(function () {  
        	
            if($("#11r option:selected").html()== "No"){
        	$('#12').hide();
        	
        }
        else{
        	$('#12').show();
        }
    });
});
</script> 
<script type="text/javascript">
$(document).ready(function()
{
	$('#16').hide();
	$('#17').hide();
	$('#20').hide();
	$('#23').hide();
	$('#24').hide();
	$('#22').hide();
	$('#26').hide();
	$('#27').hide();
	$('#28').hide();
	$('#29').hide();
	$('#30').hide();
	$('#31').hide();
	$('#34').hide();
	$('#35').hide();
	$('#36').hide();
	$('#42').hide();
	$('#43').hide();
	
     $("select[name=15r]").click(function () {  
        	
            if($("#15r option:selected").html()== "No"){
        	$('#16').show();
        	$('#17').hide();
        	$('#20').hide();
        	$('#23').hide();
        	$('#24').hide();
        	$('#22').hide();
        	$('#26').hide();
        	$('#27').hide();
        	$('#28').hide();
        	$('#29').hide();
        	$('#30').hide();
        	$('#31').hide();
        	$('#34').hide();
        	$('#35').hide();
        	$('#36').hide();        	
        	$('#42').hide();
        	$('#43').hide();
        	
        }
        else{
        	$('#16').hide();
        	$('#17').show();
        	$('#20').show();
        	$('#23').show();
        	$('#24').show();
        	$('#22').show();
        	$('#26').show();
        	$('#27').show();
        	$('#28').show();
        	$('#29').show();
        	$('#30').show();
        	$('#31').show();
        	$('#34').show();
        	$('#35').show();
        	$('#36').show();        	
        	$('#42').show();
        	$('#43').show();
        }
    });
});
</script>  
<script type="text/javascript">
$(document).ready(function()
{
	$('#18').hide();
	$('#19').hide();
	
     $("select[name=17r]").click(function () {  
        	
            if($("#17r option:selected").html()== "Si"){
        	$('#18').show();
        	$('#19').show();
        	
        }
        else{
        	$('#18').hide();
        	$('#19').hide();
        }
    });
});
</script> 
<script type="text/javascript">
$(document).ready(function()
{
	$('#33').hide();
	
     $("select[name=32r]").click(function () {  
        	
            if($("#32r option:selected").html()== "No"){
        	$('#33').show();
        	
        }
        else{
        	$('#33').hide();
        }
    });
});
</script>      
            
<script type="text/javascript">
$(document).ready(function()
{
	$('#38').hide();
	$('#39').hide();
     $("select[name=37r]").click(function () {  
            if($("#37r option:selected").html()== "Si"){
        	$('#38').show();
        	$('#39').show();
        }
        else{
        	$('#38').hide();
        	$('#39').hide();
        }
    });
});
</script>
<script type="text/javascript">
$(document).ready(function()
{
	$('#54').hide();
	$('#55').hide();
     $("select[name=53r]").click(function () {  
            if($("#53r option:selected").html()== "No"){
        	$('#54').show();
        	$('#55').hide(); 	
        }
        else{
        	$('#54').hide();
        	$('#55').show();
        }
    });
});
</script>

<%objCon.cierraConex(); %>
        </div>

        <span id="invalid"></span>

      </form>

    </div>
	<div style="position:absolute; float:left; z-index:300; left:83%; top:5%">
		<a class="enlace" href="cierraSesion.jsp">Cerrar Sesi&oacute;n</a>
	</div>
  </div>

  <script src="http://code.jquery.com/jquery-2.1.0.min.js"></script>
  <script src="//ajax.googleapis.com/ajax/libs/jqueryui/1.10.3/jquery-ui.min.js"></script>
  <script src="jq-idealforms/js/out/jquery.idealforms.js"></script>
  <!--<script src="js/out/jquery.idealforms.min.js"></script>-->
  <script>
    $('form.idealforms').idealforms({
      silentLoad: false,
      steps: {
    	  MY_stepsItems: ['Datos Personales', 'Trayectoria Academica', 'Trayectoria Laboral', 'Valoración sobre el contenido del plan de estudios','Actualización'],
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