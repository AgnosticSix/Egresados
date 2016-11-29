package conex;
import java.sql.*;

public class CamposGrid {
	public String[] losCampos;
	public int numCampos=-1;
	public String cadSQL=new String();

	
	
	public String getCampoLlave(String tabla,String tipoBD){
		
	    String campoLLave=new String();
		Conexion objConex= new Conexion(2,tipoBD);		
		objConex.getConexLocal(tipoBD);	
		ResultSet rs=null;	
		
		rs = objConex.ejecSQL("SELECT COLUM_NAME FROM ALL_COL_COMMENT WHERE TABLE_NAME='"+tabla+"'"+" AND KEYS='S' AND ROWNUM<=1");
		try {
		rs.next();
		campoLLave=rs.getString("COLUM_NAME");
		rs.close();
		
		} catch (Exception e) {e.printStackTrace();}

		return campoLLave;
	}
	
	
	public String[] getCampos(String tabla,String tipoBD){
		Conexion objConex= new Conexion(2,tipoBD);		
		objConex.getConexLocal(tipoBD);	
		ResultSet rs=null;	
		
		
		rs = objConex.ejecSQL("SELECT COUNT(*) AS NUM FROM ALL_COL_COMMENT WHERE TABLE_NAME='"+tabla+"'");
		try {
		rs.next();
		numCampos=rs.getInt("NUM");
		losCampos = new String[numCampos];
		rs.close();
		
		System.out.println("Numero de campos "+numCampos+" "+tabla);
		
		rs = objConex.ejecSQL("SELECT * FROM ALL_COL_COMMENT WHERE TABLE_NAME='"+tabla+"' ORDER BY NUMERO");
		int i=0;		
		while (rs.next()) {
			  losCampos[i]=rs.getString("COMMENTS");
			  i++;
			  cadSQL=cadSQL+rs.getString("COLUM_NAME")+',';	    	 
		}
		cadSQL=cadSQL.substring(0,cadSQL.length()-1);
		objConex.cierraConex();
		} catch (Exception e) {e.printStackTrace();}

		return losCampos;
	}
	
    public String getTablaOfModulo(String modulo,String tipoBD){
    	Conexion objConex= new Conexion(2,tipoBD);		
		objConex.getConex();	
		String tabla=new String();
		ResultSet rs=null;	
		
    	rs = objConex.ejecSQL("SELECT MODU_TABLA, MODU_DESCRIP FROM CMODULOS WHERE MODU_MODULO='"+modulo+"'");
    	try {
    	rs.next();
    	tabla=rs.getString("MODU_TABLA");
    	objConex.cierraConex();
    	} catch (Exception e) {tabla=":El modulo "+modulo+" No existe en Tabla CMODULOS"; e.printStackTrace();}
		return tabla;	
    }
    
  /*  
    public static void main (String [] c){	
    	   CamposGrid cp=new CamposGrid();
	       String tabla=cp.getCampoLlave("CICLOSESC","OR");	       
	       System.out.print(tabla);	       
    }*/
    
}

