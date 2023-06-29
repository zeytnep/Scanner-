/*
  Zeynep Erdogru
  File Name: Scanner.java
  Main class/Scanner class reads the file and creates Lexer.java
*/

import java.io.InputStreamReader;


public class Scanner {
  private Lexer scanner = null;

  //Scanner constructor
  public Scanner( Lexer lexer ) {
    scanner = lexer; 
  }

  // Gets the next token in the file being parsed
  public Token getNextToken() throws java.io.IOException {
    return scanner.yylex();
  }

  //main method/function to run the program
  public static void main(String argv[]) {
    try {
      Scanner scanner = new Scanner(new Lexer(new InputStreamReader(System.in)));
      Token tok = null;
      while( (tok=scanner.getNextToken()) != null )
        System.out.println(tok);
    }
    catch (Exception e) {
      System.out.println("Unexpected exception:");
      e.printStackTrace();
    }
  }
}
