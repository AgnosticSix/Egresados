package conex;
import java.sql.*;

public class User {
	
	public int esRol(String usuario, String tipoBD){
		int resul=0;
		Conexion objConex= new Conexion(2,tipoBD);		
		Connection cn=objConex.getConexLocal(tipoBD);
		
		ResultSet rs=null;
		rs=objConex.ejecSQL("SELECT COUNT(*) as NUM FROM CUSUARIOS WHERE USUA_USUARIO='"+usuario+"'");
	    
		try {
		rs.next();	
		resul=rs.getInt("NUM");
		cn.close();
		} catch (Exception e) {;}	
		
		return resul;
	}
	
	 public static void main(String[] args){
		 User a = new User();
		 String cadena=null;
		 if (cadena!=null)
		 {
		     System.out.print(cadena.replace("\"", ""));
		 }
		 else
		     System.out.print("era nulo");
	 }
}
	

