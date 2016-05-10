<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.sql.DataSource" %>
<%@ page import="javax.naming.*" %>
<%@page session="true"%>

<%
    session.invalidate();
	response.sendRedirect("index.jsp");

%>

