Zeynep Erdogru 
Student ID#1047085
zerdogru@uoguelph.ca

Warmup assignment 1

Description:
The program will filter out the irrelevant information in textual documents and convert the
remaining relevant information into a simple format so that the preprocessed documents may be
used for further processing.

To compile and run:
    Go inside the folder 
    run the make command and "java Scanner < newsdata.txt"
    if you want to print the output to a txt file you can do "java Scanner < newsdata.txt > out.txt"

To clean:
    Type make clean

•I used the warmup assignment files to start, to be more specific, I used professor's Makefile as is and just changed couple lines. I also didn't change anything in Scanner.java file. Most of my code is in News.flex file. I changed the strings in Token.java, I used the Token object that professor created, and it worked very well.

•I did not implement " Reporting errors for mismatched tags"

• I would definetly build a better stack if I could improve this program in the future. I misread the assignment description and I first implemented an algorithm that checks for irrelevant tags. When I realized my mistake, I freaked out and tried to reverse my implementation by checking relevant tags. That is why my code doesn't look so pretty, bt I tried to make sure I implemented the style guidlenes such as making functions and indentation:)

Testing process:
I tested the program/code with a the given sample news. text file. I played/altered the data in the file to check if it can verify correctly. 

# Scanner
