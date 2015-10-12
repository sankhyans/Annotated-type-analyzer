# Annotated-type-analyzer
CS5218 Principles of Program Analysis

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


5.  Constraint Explanation :
I have used the Constraints explained on page number 308,309 in book Principles of Program Analysis by Nielson, Nielson and Hankin.

When the program is executed, it will assign an annotation type to each function expression, function type and cons expression. When the types are unified and the substitutions are applied on them in the program, the annotations and substitutions are also applied at the same time.

For example, the constraint set generated from program t11.fun is :
{$3} >= {$10}
{$2} >= {$2}
{$2} >= {$5}
{$7} >= {$7}
{$8} >= {$1}
{$3} >= {$13}
{$8} >= {$4}
This can be explained as shown in the figure on the right.
{ $3 } >= { $10, $13}
{ $2 } >= { $2, $5}
{ $8 } >= { $1, $4}
{ $7 } >= { $7}
Failure Handling :
Whenever the program encounters below mentioned cases, it throws an exception, prints the error and terminates.
1) Undefined variable
2) types that cannot be unified like int, bool
3) Binary expression with different types
4) Type of condition is not BoolType
5) If and else blocks have different types
6) ConsEx.e2 is of invalid type i.e. the expression e2 is not of Cons or Nil type
7) Expression that does not map to the defined expressions in ast folder
8) Unification failure case.
Example:
8.1) TVar occurs in FunType
8.2) TVar occurs in ListType

How to run the program :

1) From command line:
java -cp path/to/antlr:path/to/Main Main <input_file>
in which:
path/to/antlr: the path to ANTLR library, e.g ./lib/antlr-4.5-complete.jar
path/to/Main: the path to folder where Main class is built
Main: name of Main class of this project
Example:
java -cp funla/lib/antlr-4.5-complete.jar:bin/ Main abs.fun


2) From Eclipse:
For the 1st part -> <filename> or <filename> false
For the 2nd part -> <filename> true
Use “true” as the 2nd parameter to the command line in order for the program to run
the advanced part i.e. for the cons, nil and case expressions.
Test Case Organization:
Test cases related to the first part are inside the folder "basic" and test cases related
to Advanced part are inside the folder “Advanced".
The output obtained after running this test cases is stored in corresponding txt files.
