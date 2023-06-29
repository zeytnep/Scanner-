/*
  Zeynep Erdogru - zerdogru@uoguelph.ca - student ID#1047085
  File Name: Token.java
  This class has the constructor to make the token object and tells what to print out for the tags
*/


class Token {

  //int type (m_type ) for token
  public final static int ERROR = 0;
  public final static int wSPACE = 1;
  public final static int APOSTROPHIZED = 2;
  public final static int OPEN = 3;
  public final static int CLOSE = 4;
  public final static int WORD = 5;
  public final static int HYPHENATED = 6;
  public final static int PUNCTUATION = 7;
  public final static int ID = 8;
  public final static int NUM = 9;

  public int m_type;
  public String token_string_value;
  public int m_line;
  public int m_column;
  
  //Token object structure 
  Token (int type, String value, int line, int column) {
    m_type = type;
    token_string_value = value;
    m_line = line;
    m_column = column;
  }


  public String toString() {
    //Use switch statement (m_type) to determine if it's an ERROR or WORD or PUNCTUATION
    //return a string 
    switch (m_type) {
      case wSPACE:
        return "wSPACE(" + token_string_value + ")";
      case APOSTROPHIZED:
        return "APOSTROPHIZED(" + token_string_value + ")";
      case OPEN:
      String OPENString = new String("OPEN-"+ token_string_value +"");
        return OPENString;
      case CLOSE:
      String CLOSEString = new String("CLOSE-"+ token_string_value +"");
        return CLOSEString;
      case HYPHENATED:
        return "HYPHENATED(" + token_string_value + ")";
      case PUNCTUATION:
        return "PUNCTUATION(" + token_string_value + ")";
      case ID:
        return "WORD(" + token_string_value + ")";
      case NUM:
        String NUMString = new String("NUMBER(" + token_string_value + ")");
        return NUMString;
      case ERROR:
        return "ERROR(" + token_string_value + ")";
      default:
        return "UNKNOWN(" + token_string_value + ")";
    }
  }
}

