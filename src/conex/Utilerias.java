package conex;

import java.util.ArrayList;

public class Utilerias {
     
	public String getCadenaApos(String cad) {
		ArrayList<String> lis= new ArrayList<String>();
		String cap=cad;
		while (cap.indexOf(",")>0) {
			lis.add(cap.substring(0,cap.indexOf(",")));
			cap=cap.substring(cap.indexOf(",")+1,cap.length());
		}
		lis.add(cap);
		cap="";
		for(int i=0; i<=lis.size()-1; i++){
			    {
			    	cap=cap+"'"+lis.get(i)+"',";			    	
			    	}
		}
		cap=cap.substring(0,cap.length()-1);
	    return cap;
	}

	
	public ArrayList<String> devTablas (String csql){
		ArrayList<String> l = new ArrayList<String>();
		String csq=csql.substring(csql.indexOf("FROM")+4,csql.length()).trim();
		if (csq.indexOf(" ")>=0) {
			csq=csq.substring(0,csq.indexOf(" ")).trim();	
		}
		while (csq.indexOf(",")>=0){
			l.add(csq.substring(0,csq.indexOf(",")));
			csq=csq.substring(csq.indexOf(",")+1,csq.length());
		}
		l.add(csq);
		return l;		
	}
	
	
	
	public String addFiltro (String filtroAdd, String sql){
		String sqlNew = new String("");
		String sq1 = new String("");
		String sq2 = new String("");
		String sq3 = new String("");
		String filtro = filtroAdd.replace("-", "'").replace("$_", "'%").replace("_$","%'").replace("$", "=").replace(">_", ">=").replace("<_","<=");
		
		if (sql.toUpperCase().indexOf("WHERE")>0) {
			sq1=sql.substring(0,sql.toUpperCase().indexOf("WHERE")).trim();
			if (sql.toUpperCase().indexOf("ORDER BY")>0) {
				sq2=sql.substring(sql.toUpperCase().indexOf("WHERE")+6,sql.toUpperCase().indexOf("ORDER BY")).trim();
				sq3=sql.substring(sql.toUpperCase().indexOf("ORDER BY")+9,sql.length()).trim();
			}
			else {
				sq2=sql.substring(sql.toUpperCase().indexOf("WHERE")+6,sql.length()).trim();
				sq3="";
				}
			}
		else {
			if (sql.toUpperCase().indexOf("ORDER BY")>0) {
				sq1=sql.substring(0,sql.toUpperCase().indexOf("ORDER BY")).trim();
				sq2="";
				sq3=sql.substring(sql.toUpperCase().indexOf("ORDER BY")+9,sql.length()).trim();
			}
		if ((sql.toUpperCase().indexOf("WHERE")<0)&&(sql.toUpperCase().indexOf("ORDER BY")<0)){
			sq1=sql;
			sq2="";
			sq3="";
			}
		}
		
		if (sq2.length()>0) {sqlNew=sq1+" WHERE "+filtro+" AND "+sq2; }
		else { sqlNew=sq1+" WHERE "+filtro; }
		
		if (sq3.length()>0) {
			sqlNew=sqlNew+" ORDER BY "+sq3;	
		}		

		return sqlNew;
		
	}
	
	
	/*
	public static void main (String c[]){
		Utilerias ut = new Utilerias();
		//System.out.print(ut.getCadenaApos("1,2,3,4"));
		//System.out.print(ut.addFiltro("MATE_DESCRIP LIKE #UNO$","SELECT * FROM CMATERIAS WHERE MATE_CLAVE IN ('MAT1') AND MATE_ACTIVO IN ('S') ORDER BY 1"));
		
		//System.out.print(ut.addFiltro("MATE_DESCRIP LIKE '%UNO%'","SELECT * FROM CMATERIAS ORDER BY 1"));
		
		System.out.print(ut.addFiltro("","SELECT * FROM CMATERIAS"));
	}
	*/
	
}
