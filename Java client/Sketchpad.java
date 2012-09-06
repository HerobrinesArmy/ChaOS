import java.io.*;
/**
* Nonlinear Interface
* Jan 20, 2012
*/

class Sketchpad{
public static void main(String[] args)throws IOException{
	byte[]inb=new byte[16];
	String in;
/*--------------------------------------------------*/
for(;;){
	System.out.print("\n[>]");
	System.in.read(inb);
	in=new String(inb);
	switch(new String(in)){
/*--------------------------------------------------*/
	case "/toHash":toHash(in);
					break;
	default:		readFile(in);
/*--------------------------------------------------*/
}}}
	
	private static void readFile(byte[]in){try{
		byte[]bytelist=new byte[128];
		FileInputStream file =new FileInputStream(System.getProperty("user.dir")+"/bin/help.txt");
		file.read(bytelist);
		file.close();

		System.out.print(new String(bytelist));
		}
	catch(java.io.IOException e){System.out.println(e);}}

/*--------------------------------------------------*/
}