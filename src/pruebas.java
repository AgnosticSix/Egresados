
public class pruebas {

	public static void main (String a[]){
		String sq="SELECT * FROM ALUMNOS order BY 1";
		
		System.out.print(sq.substring(0,sq.toUpperCase().indexOf("ORDER BY")));
		
	}
}
