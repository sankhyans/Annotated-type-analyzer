                    Assignment 3 - Annotated type analyzer


1. More detail about syntax of FunLa.
  Bool constants: true, false
  Binary operators: + - * /  &&  || >  <  >=  <=  ==  !=
    + - * /         : arithmetic operators over integers
    &&  ||          : logical binary operators over booleans
    >  <  >=  <=    : relational operators over integers
    ==  !=          : equality comparison operators over integers or booleans
  Unary operators: - , !
    -               : minus, over integers
    !               : logical 'not', over booleans


2. How to run FunLa project?

I use the ANTLR library to write parser for FunLa so you need to add this
library  to Java's classpath in order to run the program. It is located at:
    funla/lib/antlr-4.5-complete.jar

- If you are using Eclipse IDE, please add it to the Referenced Library.

- If you run by command line, the command to run project is:
    java -cp path/to/antlr:path/to/Main Main <input_file>
  in which:
    path/to/antlr: the path to ANTLR library, e.g ./lib/antlr-4.5-complete.jar
    path/to/Main:  the path to folder where Main class is built
    Main: name of Main class of this project


3. Customize grammar of FunLa.

In the case you want to customize FunLa parser, you can modify its grammar file,
which is funla/src/parser/FunLa.g4

After modifying, you need to call antlr to update Java source code for parser:
  java -jar funla/lib/antlr-4.5.complete.jar FunLa.g4


4. Test cases.

Some test cases are located at: funla/test


5. Your job.

Your job is to build an annotated type analyzer, which takes input as a program
(actually, it is an expression) and infers type information of all of its
sub-expressions.

I created some classes to representing the type information at
funla/src/type/*Type.java. The most general type is AbstrType.java, 
the others inherit from it

The classes model expressions are at funla/src/ast/*Exp.java. The most general
expression is AbstrExp.java. 

I also provide some printing function for these expressions, for example:
  println() : simply print expression
  printlnAnnot() : print expression with annotation of function and Cons
  printlnType() : print expression with type information.
  printDetailTypeInfo() : print type information of all declared variables and
    functions inside the expression.
You are encouraged to use these printing functions (without modifying) so that 
I can mark your assignment precisely.

After building your own analyzer, you need to invoke it inside Main.java class.
More detail can be found in source code of Main.java.


6. Feedback.

Please inform me if you found any bugs or problems in the project.
I will try to fix them as soon as possible.
