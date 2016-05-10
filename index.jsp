<!DOCTYPE html>
<html lang="en">
    <head>
		<meta charset="UTF-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"> 
		<meta name="viewport" content="width=device-width, initial-scale=1.0"> 
        <title>Seguimiento de Egresados</title>
        <meta name="description" content="" />
      
        <link rel="stylesheet" type="text/css" href="estilos/login.css" />
		<link rel="stylesheet" type="text/css" href="estilos/mensajes.css" />
		<script src="CustomLoginFormStyling/js/modernizr.custom.63321.js"></script>
		
		<script type="text/javascript" src="js/jquery.js"></script>
        <script type="text/javascript">
             $(document).ready(function(){
             setTimeout(function(){ $(".error").fadeOut(800).fadeIn(800).fadeOut(500).fadeIn(500).fadeOut(300);}, 3000); 
             });
        </script>

    </head>
    <body>
	<center>
	<table width="100%" cellspacing="0">
    <tr><td><BR/></td></tr>
	<TR><TD align="center"><img src="imagenes/login/logoUPC.png" ></TD></TR>
	<tr><td bgcolor="#C81A1A" align="center"><br/></td></tr>
	<TR>
	    <TD bgcolor="#787777">
				<form class="form-1" action="acceso.jsp">
					<p class="field">
						<input type="text" name="login" id="login" placeholder="Usuario">
						<i class="icon-user icon-large"></i>					</p>
						<p class="field">
							<input type="password" name="password" id="password" placeholder="Password">
							<i class="icon-lock icon-large"></i>					</p>
					<p class="submit">
						<button type="submit" name="submit"><i class="icon-arrow-right icon-large"></i></button>
					</p>
					<input type="hidden" name="error">
				</form>
	    </TD>
	</TR>
	<tr>
	    <td bgcolor="#C81A1A" align="center">
	     <% 
		     String verror=request.getParameter("error");
		     if (verror!="" && verror!=null) {
			     out.print("<div class='error'>"+verror+"</div>");}
			 else
			    {out.print("<br/>");}								 
		 %>		  
	    </td>
	</tr>
	</table>
	</center>


	
			
 </body>
</html>