<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.DataSource" %>
<%@ page import="conex.*" %>
<%@page session="true"%>

<% 					
                    String tipoBase="OR";
                    Seguridad pass = new Seguridad();
                    Conexion objCon = new Conexion(1,tipoBase);                                         
                    objCon.getConex();
                  
                   
                    ResultSet rs=null;
                    
                    
					rs = objCon.ejecSQL("SELECT * FROM CUSUARIOS WHERE USUA_USUARIO='"+request.getParameter("login")+"'");
					out.print(rs);
				out.print(objCon);
				
					if (rs.next()) {
						String claveDes=rs.getString("USUA_CLAVE");
						//String claveDes=pass.desencriptar(rs.getString("USUA_CLAVE"));
						String rol = rs.getString("USUA_ROL");
			            if (claveDes.equals(request.getParameter("password"))) {
			            	if(rol.equals("N")){
							HttpSession sesion=request.getSession();
							sesion.setAttribute("user",request.getParameter("login"));
							sesion.setAttribute("tipoBase",tipoBase);
							response.sendRedirect("indexPrincipal.jsp");
			            	}
			            	else{
			            		HttpSession sesion=request.getSession();
								sesion.setAttribute("user",request.getParameter("login"));
								sesion.setAttribute("tipoBase",tipoBase);
								response.sendRedirect("adminPag.jsp?idPregunta=4");
			            	}
						}
						else {response.sendRedirect("index.jsp?error=El password es incorrecto");} 
					}
					else 
					{
					rs = objCon.ejecSQL("SELECT * FROM FALUMNOS WHERE ALUM_MATRICULA='"+request.getParameter("login")+"'");
					out.print(rs);
				out.print(objCon);
				
					if (rs.next()) {
						String claveDes=rs.getString("ALUM_CLAVE");
						
			            if (claveDes.equals(request.getParameter("password"))) {
							HttpSession sesion=request.getSession();
							sesion.setAttribute("user",request.getParameter("login"));
							sesion.setAttribute("tipoBase",tipoBase);
							response.sendRedirect("formatoEgr.jsp");
							
						}
					
						else {response.sendRedirect("index.jsp?error=El password es incorrecto");} 
					}
					else {response.sendRedirect("index.jsp?error=El usuario no existe");}
					}
					
					objCon.cierraConex();
							 
%> 
