var x;
x=$(document);
x.ready(inicializarEventos);

function inicializarEventos()
{
  var x=$("#boton1");
  x.mousemove(agregarPropiedadBorder);
  x=$("#boton2");
  x.mousemove(recuperarPropiedadBorder);
  x=$("#boton3");
  x.mousemove(eliminarPropiedadBorder);

}

function agregarPropiedadBorder()
{
  var x=$("#tabla1");
  x.attr("border","1");
  x.attr("bordercolor","");
  

}

function recuperarPropiedadBorder()
{
  var x=$("#tabla1");
  if (x.attr("border")!=undefined)
    alert(x.attr("border"));
  else
    alert("No está definida la propiedad border en la tabla");
}

function eliminarPropiedadBorder()
{
  var x=$("#tabla1");
  x.removeAttr("border");
}