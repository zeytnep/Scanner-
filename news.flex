/*
  Zeynep Erdogru - zerdogru@uoguelph.ca - student ID#1047085
  File Name: news.flex
  JFlex specification for the newsdata.txt
  This is where all the regex and stack is
*/

//import statement for the arraylist 
import java.util.ArrayList;
   
%%
 
%class Lexer
%type Token
%line //this is used to activate yyline 
%column //this is used to activate yycolumn (like import)
    
%eofval{
  //System.out.println("*** Reaching end of file");
  return null;
%eofval};

//braces and % can't be changed we need to write the code inside of this
%{
  boolean is_zey_stack_empty = true;
  private static ArrayList<String> zey = new ArrayList<String>();

  //Arraylist that works like a stack 
  private static ArrayList<String> tagStack = new ArrayList<String>();

  public static ArrayList<String> taglist = new ArrayList<String>();

  //methodd to add relevant tags to taglist
  public static void add_relevant_tags(ArrayList<String> list) {
   list.add("DOC");
   list.add("TEXT");
   list.add("DATE");
   list.add("DOCNO");
   list.add("HEADLINE");
   list.add("LENGTH");

   list.add("Doc");
   list.add("Text");
   list.add("Date");
   list.add("Docno");
   list.add("Headline");
   list.add("Length");

   list.add("doc");
   list.add("text");
   list.add("date");
   list.add("docno");
   list.add("headline");
   list.add("length");

  }
  //method to remove the > and < symbols
  public static String filter_symbols(String str) {
      if (str != null && str.length() > 0 && str.charAt(str.length() - 1) == '>') {
         str = str.substring(0, str.length() - 1);
         str = str.replaceFirst("<", "");
      }
      return str;
  }
  //method to remove the / symbol
  public static String filter_slash_symbol(String str) {
      if (str != null && str.length() > 0) {
         str = str.replaceFirst("/", "");
      }
      return str;
  }

%};

//Regex part

/* A line terminator is a \r (carriage return), \n (line feed), or
   \r\n. */
LineTerminator = \r|\n|\r\n
   
/* White space is a line terminator, space, tab, or form feed. */
WhiteSpace     = {LineTerminator} | [ \t\f]
   
/* A literal integer is is a number beginning with a number between
   one and nine followed by zero or more numbers between zero and nine
   or just a zero.  */
digit = [0-9]
number = {digit}+(\.{digit}+)*
   
/* A identifier integer is a word beginning a letter between A and
   Z, a and z, or an underscore followed by zero or more letters
   between A and Z, a and z, zero and nine, or an underscore. */
letter = [a-zA-Z]

//(word) regex
identifier = {diglet}*{letter}+{diglet}*

diglet = [0-9a-zA-Z]

//apostraphized hypenated regex
apostraphized = {diglet}+(-{diglet}+)*('{diglet}+)+
hypenated = {diglet}+(-{diglet}+)+

//open and close regex
openTag = <[^\/][^>]*>
closeTag = <\/[^>]*>

%%
   
/*
   This section contains regular expressions and actions, i.e. Java
   code, that will be executed when the scanner matches the associated
   regular expression. */
   

{number}           {  

      //init taglist
      add_relevant_tags(taglist);

      boolean val = false;
   
      for (int counter = 0; counter < taglist.size(); counter++) {
         if(tagStack.contains(taglist.get(counter))) {
            val = true;
            break;
         }
      }
      //return new Token if tagStack contains relevant tag
      if (val) return new Token(Token.NUM, yytext(), yyline, yycolumn);

   }
{identifier}       { 

      //init taglist
      add_relevant_tags(taglist);

      boolean val = false;

      for (int counter = 0; counter < taglist.size(); counter++) {
         if(tagStack.contains(taglist.get(counter))) {
            val = true;
            break;
         }
      }
      //return new Token if tagStack contains relevant tag
      if (val) return new Token(Token.ID, yytext(), yyline, yycolumn); 
   }

{WhiteSpace}       { /* skip whitespace */ } 
{apostraphized}        {

      //init taglist
      add_relevant_tags(taglist);

      String token_val = yytext();

      boolean val = false;

      for (int counter = 0; counter < taglist.size(); counter++) {
         if(tagStack.contains(taglist.get(counter))) {
            val = true;
            break;
         }
      }
      //return new Token if tagStack contains relevant tag
      if (val) return new Token(Token.APOSTROPHIZED, yytext(), yyline, yycolumn); 
   } 

{openTag}          { 
      // filter out irellevant symbols
      String  token_val = yytext();
      token_val = filter_symbols(token_val);

      //init taglist
      add_relevant_tags(taglist);

      /*if the stack is not empty and tokenval is a relevant token
      then get the first object from the stack and store in zey(zey_stack).
      That's how I can keep track of nested structures*/
      if (!(tagStack.isEmpty()) && taglist.contains(token_val)) {
         is_zey_stack_empty = false;
         zey.add(tagStack.get(0));
      }

      if (taglist.contains(token_val)) tagStack.add(token_val);

      boolean does_stack_has_relevant_tag = false;

      for (int counter = 0; counter < taglist.size(); counter++) {
         if (tagStack.contains(taglist.get(counter))) {
            does_stack_has_relevant_tag = true;
            break;
         }
      }

      //return new Token if tagStack contains relevant tag
      if ((does_stack_has_relevant_tag)) return new Token(Token.OPEN, token_val, yyline, yycolumn);
   }  

{closeTag}         { 

      // filter out irellevant symbols
      String  token_val = yytext();
      token_val = filter_symbols(token_val);
      token_val = filter_slash_symbol(token_val);
   
      //init taglist
      add_relevant_tags(taglist);
      //init val = true if token_val is a valid token
      boolean val = taglist.contains(token_val);

      boolean does_stack_has_relevant_tag = false;

      for (int counter = 0; counter < taglist.size(); counter++) {
         if (tagStack.contains(taglist.get(counter))) {
         does_stack_has_relevant_tag = true;
            break;
         }
      }

      //empty the stack before return 
      if (val) {
         tagStack.clear();
      }

      //return new Token if tagStack contains relevant tag
      if ((does_stack_has_relevant_tag)) return new Token(Token.CLOSE, token_val, yyline, yycolumn);
      //second stack so I can close the nested tags
      if(!is_zey_stack_empty) {
         if (zey.contains(token_val)) {
            is_zey_stack_empty= true;
            zey.clear();
            return new Token(Token.CLOSE, token_val, yyline, yycolumn);
         }
      }
   }


{hypenated}        { 

      //init taglist
      add_relevant_tags(taglist);
      String token_val = yytext();

      boolean val = false;

      for (int counter = 0; counter < taglist.size(); counter++) {
         if(tagStack.contains(taglist.get(counter))) {
            val = true;
            break;
         }
      }
      //return new Token if tagStack contains relevant tag
      if (val)  return new Token(Token.HYPHENATED, yytext(), yyline, yycolumn); 
   }

"{"[^\}]*"}"       { /* skip comments */ }
.                  { 
   
      //init taglist
      add_relevant_tags(taglist);
      String token_val = yytext();

      boolean val = false;

      for (int counter = 0; counter < taglist.size(); counter++) {
         if(tagStack.contains(taglist.get(counter))) {
            val = true;
            break;
         }
      }
      //return new Token if tagStack contains relevant tag
      if (val) return new Token(Token.PUNCTUATION, yytext(), yyline, yycolumn); 
}
