package conex;

import java.util.Random;

public class Seguridad {

	public String desencriptar (String s ) {
		String s1 = new String("");
		int j=0,cont=0,k=0,pos=0;
		boolean ban;
		char ch;

		if (s.codePointAt(0)==1){ ban=false; pos=2;}	
		else {ban=true; pos=1;}
		ch=s.charAt(40);
		k=((int)ch)-65;
		cont=1;
		while (s1.length()<k) {	
			ch=s.charAt(pos);
			j=((int)ch)-65;
			ch=s.charAt(pos-1);
			if (ban) {
				if ((cont%2)==0) { s1=s1+(char)(((int)ch)-j);}
				else { s1=s1+(char)(((int)ch)+j); }	
			}
			else {				
				if ((cont%2)==0) { s1=s1+(char)(((int)ch)+j);}
				else { s1=s1+(char)(((int)ch)-j); }
				}
		   pos+=2;
		   cont++;
		}  
		return s1;
	}
	
	public String encriptar (String s ) {
		String s1 = new String("");
		int j=0,cont=0,k=0,pos=0;
		boolean ban;
		int [] password = new int[42];
        s1=s;
        Random rnd = new Random();
        k=rnd.nextInt(10)+1;
        ban=((k%2)==0);
        pos=k%2+1;
        cont=1;
        
        while (s.length()>0) {
            j=rnd.nextInt(10)+1;
            if (ban) {
            	if ((cont%2)==0){password[pos-1]=s.codePointAt(0)+j;}
            	else {password[pos-1]=s.codePointAt(0)-j;}
            	password[pos]=65+j;
            	}
            else {
            	if ((cont%2)==0){password[pos-1]=s.codePointAt(0)-j;}
            	else {password[pos-1]=s.codePointAt(0)+j;}
            	password[pos]=65+j;
            	}            
            s=s.substring(1,s.length());
            pos+=2;
            cont++;            
            }
        
        
        if(ban) {for (j=pos-1;j<=39;j++) {password[j]=(int)(rnd.nextInt(25)+65);}}
        else { for (j=pos-1;j<=40;j++) {password[j]=(int)(rnd.nextInt(25)+65);}}
        if (!(ban)) { password[0]=1;}	
       
        password[40]=s1.length()+65;
        s1="";
        for (j=0;j<=41;j++){ s1=s1+(char)password[j]; }
		return s1;
	}
	public static void main(String c[]){
		Seguridad a = new Seguridad();
		System.out.println(a.encriptar("JOSE"));
	}
	
}
