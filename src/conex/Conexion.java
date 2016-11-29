package conex;
import java.sql.*;
import java.util.ArrayList;

import javax.naming.*;
import javax.sql.DataSource;

public class Conexion {
     private Connection cn=null;
     private ResultSet rs = null;
     
     private String db="";
     private String user="";
     private String password="";
     private String server="";
     private String port="";
     private int tipo=1; //1 = Web 2 = Local
     private String tipoBD="FB"; //FB=FireBird OR=Oracle
     private int numConex=0;
	 
	 public Conexion (int tipoCon, String base){
		this.tipo=tipoCon;	 
	    this.tipoBD=base;
	    if (base=="FB") {this.user="SYSDBA"; this.password="masterkey"; this.db="BDSIGEA"; this.server="toshMatrix"; this.port="0";}
	    if (base=="OR") {this.user="UPC"; this.password="UPC";this.db="BDUPC"; this.server="Ricardo"; this.port="1521"; }
	 }
	
	 Connection getConexWeb(String tipoBD){		 		
		 Context initContext;	
		 
		 String laConex = new String();

		 if (tipoBD=="FB") {laConex="java:/comp/env/jdbc/ConexionSigea";}
		
		 if (tipoBD=="OR") {laConex="java:/comp/env/jdbc/ConexionOracle";
			
		 }
		
			 try{
			     initContext = new InitialContext();
			     DataSource ds = (DataSource) initContext.lookup(laConex);
			     cn = ds.getConnection();
			     cn.setAutoCommit(false);
			 }catch(Exception e){
				 e.printStackTrace();
		       }
			 
		return cn;
		 }
	 
	 Connection getConexLocal(String tipoBD){	
		 
		 String elDriver = new String();
		 String laBD = new String();
		 if (tipoBD=="FB") {
			 elDriver="org.firebirdsql.jdbc.FBDriver";
			 laBD="jdbc:firebirdsql://"+this.server+"/" + db;
		 }
		
		 if (tipoBD=="OR") {
			 elDriver="oracle.jdbc.driver.OracleDriver";
			 laBD="jdbc:oracle:thin:@"+this.server+":"+this.port+":"+this.db;
		 }
		
		  try{
              Class.forName(elDriver);
              cn = DriverManager.getConnection(laBD,this.user, this.password);
              cn.setAutoCommit(false);                                   
          }catch(Exception e){
        	  e.printStackTrace();
          }
		 
		return cn;
       }
	 
	 
	 public void getConex(){		 
		 if (this.tipo==2){
			 cn=getConexLocal(this.tipoBD);
		 }
		 else {
			 cn=getConexWeb(this.tipoBD);
		 }
		 numConex++;
		 System.out.println("Abrir Conex: Conexiones abiertas "+numConex);
	 }

	 
	 public ResultSet ejecSQL (String sql){
		 Statement st = null;		  	
		 try {
			st = cn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
			         ResultSet.CONCUR_READ_ONLY);
			rs = st.executeQuery(sql);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return rs;
	 }
	 
	 public boolean ejecutar (String sql){
		 Statement st = null;
		 try{
			 st = cn.createStatement(ResultSet.TYPE_FORWARD_ONLY, ResultSet.CONCUR_READ_ONLY);
			 st.executeUpdate(sql);
			 st.close();
		 }catch(SQLException e){
			 e.printStackTrace();
		        return false;
		 }
		 return true;
	 }
	 
	 public void cierraConex(){           		 
	    	 try {
	    		 if (cn!=null) {
	    			 cn.close();}
	        
		         if (rs!=null) {
		    	     rs.close();}
		         numConex--;
		         System.out.println("Cerrar Conex: Conexiones abiertas "+numConex);
	    	 }
		  catch (SQLException e) { 
			e.printStackTrace(); }
	 }
	 
	 public String  devClave (String tabla, String campoR, String campoB, String valorB) {
		 String res=new String();
		 try {
			rs = ejecSQL("SELECT "+campoR+" FROM "+tabla+" WHERE "+ campoB+"='"+valorB+"'");
			if (rs.next()){res= rs.getString(campoR);	
			}
			else { res="";}		
			} catch (Exception e) {e.printStackTrace();}
		return res;
	 }
	 
	 
	 public int esRol(String usuario){
			int resul=0;
			
			rs=ejecSQL("SELECT COUNT(*) as NUM FROM CUSUARIOS WHERE USUA_USUARIO='"+usuario+"'"+
			" AND USUA_ROL='S'");
		    
			try {
			if (rs.next()){ resul=rs.getInt("NUM");}
			else resul=0;
			} catch (Exception e) {e.printStackTrace();}	
			
			return resul;
		}
	 
	 public String superUsuario(String usuario){
			String resul=new String("");
			
			rs=ejecSQL("SELECT * FROM CUSUARIOS WHERE USUA_USUARIO='"+usuario+"'");
		    
			try {
			if (rs.next()){ resul=rs.getString("USUA_SUPER");}
			else resul="N";
			} catch (Exception e) {e.printStackTrace();}	
			
			return resul;
		}
	 
	 
	 public String losRoles(String user){
		 String resul=new String();
		 rs=ejecSQL("SELECT * FROM SROLUSER WHERE ROLU_USUARIO='"+user+"'");
		 try {
			    resul="'"+user+"',";
				while (rs.next()){
					resul=resul+"'"+rs.getString("ROLU_ROL")+"',";
				}
				resul=resul.substring(0, resul.length()-1);
				} catch (Exception e) {e.printStackTrace();}	
				
				return resul;
	 }
	
	 public String getPermisoTabla (String tab, String user){
		 String cad=new String();
		 rs=ejecSQL("SELECT * FROM SDERCAMPOS WHERE DERC_MODULO='"+tab+"' and DERC_USUARIO IN ("+user+")");
		 try {			 
				while (rs.next()){	
					if (rs.getString("DERC_VALUES").length()>0){
						if(cad.length()>0) {		
							cad=cad+" and ";}
						
						if (rs.getString("DERC_VALUES").equals("USER")) {
							cad=cad+rs.getString("DERC_CAMPO")+" IN ("+user+")";
						}
						
						else {
							Utilerias ut =new Utilerias();
							cad=cad+rs.getString("DERC_CAMPO")+" IN ("+
							ut.getCadenaApos(rs.getString("DERC_VALUES"))+")";
							}
						}
					}		
				} catch (Exception e) {e.printStackTrace();}	
		 return cad;
	 }
	 
	 
	 
	 public String convSQLFiltro(String sq, String user){
		 ArrayList<String> l = new ArrayList<String>();
		 String o= new String();
		 Utilerias ut = new Utilerias ();
		 l=ut.devTablas(sq);
		 String sqNew=new String("");
		 String cad=new String("");
		 
		 if (sq.toUpperCase().indexOf("ORDER BY")>=0) {
			 o=sq.substring(sq.toUpperCase().indexOf("ORDER BY"),sq.length());
		     sqNew=sq.substring(0,sq.toUpperCase().indexOf("ORDER BY"));
		     }
		 
		 String ope= new String();
		 String pt= new String();
		 for (int x=0; x<l.size(); x++) {
			 ope="";
			 pt=getPermisoTabla(l.get(x),user);
			 if ((cad.length()>0)&&(pt.length()>0)){
				 ope=" AND ";
			 }
			 cad=cad+ope+pt;
		 }
		 System.out.println("Valor de cad="+cad);
		 
		 String sq1= new String();
		 String sq2= new String();
		 String res= new String();
		 
		 if (sqNew.toUpperCase().indexOf("WHERE")>=0) {
			 sq1=sqNew.substring(0,sqNew.toUpperCase().indexOf("WHERE")+5);
			 sq2=sqNew.substring(sqNew.toUpperCase().indexOf("WHERE")+5,sqNew.length());
			 if (cad.length()>0) {
				 res=sq1+" "+cad+" AND "+sq2;						 
			 }
			 else {
				 res=sq1+" "+sq2;
			 }
		 }
		 else {
			 sq1=sqNew;
			 if (cad.length()>0) {
				 res=sq1+" WHERE "+cad;
			 }
			 else {
				 res=sq1;
			 }
		 }
		 
		 return res+" "+o;
			 
	 }
	 
	 

	   public static void main (String a[]){
    	 Conexion objCon=new Conexion(2,"OR");
    	// objCon.getConex();
    	 System.out.print(objCon);
    	// System.out.print(objCon.losRoles("JGAH9999"));
         //System.out.print(objCon.getPermisoTabla("FALUMNOS","'PRUEBA'"));
    	 //System.out.println(objCon.convSQLFiltro("SELECT * FROM FALUMNOS ORDER BY 1", objCon.losRoles("JOSE")));  
    	 //System.out.println(objCon.esRol("RCOMPRAS"));
     }
 
	
	 
}
