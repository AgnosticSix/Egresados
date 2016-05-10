<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.sql.DataSource" %>
<%@ page import="javax.naming.*" %>
<%@ page import="conex.*" %>

<%
Context initContext;
Connection cn = null;
Statement st = null;
ResultSet rs = null;
try {
    initContext = new InitialContext();
    DataSource ds = (DataSource) initContext.lookup("java:/comp/env/jdbc/ConexionSigea");
    cn = ds.getConnection();
    String sqlBusqueda = "";
    st = cn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
            ResultSet.CONCUR_READ_ONLY);
    

} catch (SQLException ex) {
    out.print("Error (" + ex.getErrorCode() + "): " + ex.getMessage());
}



%>

