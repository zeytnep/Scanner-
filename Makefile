#Zeynep Erdogru, zerdogru@uoguelph.ca, Student ID#1047085
JAVAC=javac
JFLEX=jflex

all: Token.class Lexer.class Scanner.class

%.class: %.java
	$(JAVAC) $^

Lexer.java: news.flex
	$(JFLEX) news.flex

clean:
	rm -f Lexer.java *.class *~
