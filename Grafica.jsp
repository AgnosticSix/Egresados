<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html>
<html>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.DataSource" %>
<%@ page import="conex.*" %>
<%@page session="true"%>
<%@ include file="checaSesion.jsp" %>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script type="text/javascript" src="js/jquery.js"></script>
<script src="HighCharts/highcharts.js"></script>
<script src="HighCharts/modules/exporting.js"></script>
<link rel="stylesheet" href="estilos/graficEstilo.css">
<title>Primera Prueba</title>


</head>
<body>
<%
Conexion objCon = new Conexion(1,tipoBase);                                         
objCon.getConex();

ResultSet rst=null,rste=null, rstq=null, rstw=null;

	//rst = objCon.ejecSQL("SELECT * FROM RESPUESTAS");
	
%>


<%
int contSi = 0, contNo = 0;
String si="Si";
String no="No";
rste = objCon.ejecSQL("SELECT * FROM CATPREGUNTAS WHERE TIPO=2" );

out.print("<div>");
out.print("<select id='list' onchange='cambiaGrafica()'>");
out.print("<option value='default'>&ndash; Elige una opción &ndash;</option>");

while(rste.next()){
		out.print("<option value='"+rste.getString("CATPID")+"'>"+rste.getString("PREGUNTA")+"</option>");		
}

out.print("</select>");
out.print("</div>");
%>
	<div id="container" style="width:100%; height:400px;"></div>
	
<script>

document.getElementById("list");

function loadSeries(){
	var chart = $('#container').highcharts(),
	series = chart.series[0];
	
	<% 
	int i = 0;
	rstq = objCon.ejecSQL("select * from CATOPCIONES a where a.CATPID='"+request.getParameter("idPregunta")+"'");
	while(rstq.next()){
		rstw = objCon.ejecSQL("SELECT count(*) FROM RESPUESTAS b WHERE b.RESPUESTA='"+rstq.getString("OPCION")+"'");
		%>
		chart.series[0].data[i].update(<%=rstw.getInt("b")%>);
		<%
		i++;
	}
   
	%>
}

function cambiaGrafica(){
	location.href = "Grafica.jsp?idPregunta="+$('#list').val();

}

$(function () {

    // Radialize the colors
    Highcharts.getOptions().colors = Highcharts.map(Highcharts.getOptions().colors, function (color) {
        return {
            radialGradient: {
                cx: 0.5,
                cy: 0.3,
                r: 0.7
            },
            stops: [
                [0, color],
                [1, Highcharts.Color(color).brighten(-0.3).get('rgb')] // darken
            ]
        };
    });

    // Build the chart
    $('#container').highcharts({
        chart: {
            plotBackgroundColor: null,
            plotBorderWidth: null,
            plotShadow: false,
            type: 'pie'
        },
        title: {
            text:  ""
        },
        tooltip: {
            pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
        },
        plotOptions: {
            pie: {
                allowPointSelect: true,
                cursor: 'pointer',
                dataLabels: {
                    enabled: true,
                    format: '<b>{point.name}</b>: {point.y}',
                    style: {
                        color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'
                    },
                    connectorColor: 'silver'
                }
            }
        },
        series: [{
            name: 'Brands',
            data: [
                { <%
                	rstq.beforeFirst();
                	while(rstq.next())
                	{
                		out.print("name: '"+rstq.getString("OPCION")+"'");
                		out.print("y: '"+rstw.getInt("b")+"'");
                	}
                	%>
                	
                },                
            ]
        }]
    });
    loadSeries()});
		</script>
		<%objCon.cierraConex(); %>

</body>
</html>