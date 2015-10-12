grammar FunLa;

@header {
package parser;
import ast.*;
}

@members {
	int annotIndex = 1;
}

program returns [AbstrExp e]
	: exp				{$e = $exp.e;}
;

primaryExp returns [AbstrExp e]
	: 'true'			{$e = (AbstrExp) new BoolExp(true);}
	| 'false'			{$e = (AbstrExp) new BoolExp(false);}
	| a=Identifier		{$e = (AbstrExp) new VarExp($a.text);}
	| b=Constant		{$e = (AbstrExp) new IntExp(Integer.parseInt($b.text));}
	| '(' exp ')'		{$e = $exp.e;}
;

consExp returns [ConsExp e]
	: 'Cons' '(' a=exp ',' b=exp ')'
						{
							Annot annot = new Annot(annotIndex);
							$e = new ConsExp($a.e, $b.e, annot);
							annotIndex++;
						}
;

nilExp returns [NilExp e]
	: 'Nil'				{$e = new NilExp();}
;

sdataExp returns [AbstrExp e]
	: primaryExp		{$e = $primaryExp.e;}
	| nilExp			{$e = (AbstrExp) $nilExp.e;}
	| consExp			{$e = (AbstrExp) $consExp.e;}
;

funcAppExp returns [AbstrExp e]
	: sdataExp			{$e = $sdataExp.e;}
	| a=funcAppExp b=sdataExp
						{$e = (AbstrExp) new FunAppExp($a.e, $b.e);}
;

unaryExp returns [AbstrExp e]
	: funcAppExp		{$e = $funcAppExp.e;}
	| op='!' a=unaryExp	{$e = (AbstrExp) new UnaryExp($op.text, $a.e);}
	| op='-' a=unaryExp	{$e = (AbstrExp) new UnaryExp($op.text, $a.e);}
;

multiplicativeExp returns [AbstrExp e]
	: unaryExp			{$e = $unaryExp.e;}
	| a=multiplicativeExp op='*' b=multiplicativeExp
						{$e = (AbstrExp) new BinaryExp($op.text, $a.e, $b.e);}
	| multiplicativeExp '/' multiplicativeExp
						{$e = (AbstrExp) new BinaryExp($op.text, $a.e, $b.e);}
;

additiveExp returns [AbstrExp e]
	: multiplicativeExp 
						{$e = $multiplicativeExp.e;}
	| a=additiveExp op='+' b=additiveExp
						{$e = (AbstrExp) new BinaryExp($op.text, $a.e, $b.e);}
	| a=additiveExp op='-' b=additiveExp
						{$e = (AbstrExp) new BinaryExp($op.text, $a.e, $b.e);}
;

relationalExp returns [AbstrExp e]
	: additiveExp		{$e = $additiveExp.e;}
	| a=relationalExp op='<' b=relationalExp
						{$e = (AbstrExp) new BinaryExp($op.text, $a.e, $b.e);}
	| a=relationalExp op='>' b=relationalExp
						{$e = (AbstrExp) new BinaryExp($op.text, $a.e, $b.e);}
	| a=relationalExp op='<=' b=relationalExp
						{$e = (AbstrExp) new BinaryExp($op.text, $a.e, $b.e);}
	| a=relationalExp op='>=' b=relationalExp
						{$e = (AbstrExp) new BinaryExp($op.text, $a.e, $b.e);}
;

equalityExp returns [AbstrExp e]
	: relationalExp		{$e = $relationalExp.e;}
	| a=equalityExp op='==' b=equalityExp
						{$e = (AbstrExp) new BinaryExp($op.text, $a.e, $b.e);}
	| a=equalityExp op='!=' b=equalityExp
						{$e = (AbstrExp) new BinaryExp($op.text, $a.e, $b.e);}
;

logicalAndExp returns [AbstrExp e]
	: equalityExp		{$e = $equalityExp.e;}
	| a=logicalAndExp op='&&' b=logicalAndExp
						{$e = (AbstrExp) new BinaryExp($op.text, $a.e, $b.e);}
;

logicalOrExp returns [AbstrExp e]
	: logicalAndExp		{$e = $logicalAndExp.e;}
	| a=logicalOrExp op='||' b=logicalOrExp
						{$e = (AbstrExp) new BinaryExp($op.text, $a.e, $b.e);}
;

binaryExp returns [AbstrExp e]
	: logicalOrExp		{$e = $logicalOrExp.e;}
;

funcExp returns [AbstrExp e]
	: 'fn' a=Identifier '=>' exp
						{
							VarExp arg = new VarExp($a.text);
							Annot annot = new Annot(annotIndex);
							$e = (AbstrExp) new FunNamelessExp(arg, $exp.e, annot);
							annotIndex++;
						}
	| 'fun' a=Identifier b=Identifier '=>' exp
						{
							VarExp name = new VarExp($a.text);
							VarExp arg = new VarExp($b.text);
							Annot annot = new Annot(annotIndex);
							$e = (AbstrExp) new FunNamedExp(name, arg, $exp.e, annot);
							annotIndex++;
						}
;

ifExp returns [AbstrExp e]
	: 'if' a=exp 'then' b=exp 'else' c=exp
						{$e = (AbstrExp) new IfExp($a.e, $b.e, $c.e);}
;

letExp returns [AbstrExp e]
	: 'let' a=Identifier '=' b=exp 'in' c=exp
						{
							VarExp var = new VarExp($a.text);
							$e = (AbstrExp) new LetExp(var, $b.e, $c.e);
						}
;

patternConsExp returns [ConsExp e]
	: 'Cons' '(' a=Identifier ',' b=Identifier ')'
						{
							VarExp e1 = new VarExp($a.text);
							VarExp e2 = new VarExp($b.text);
							$e = new ConsExp(e1, e2);
						}
;

caseExp returns [AbstrExp e]
	: 'case' a=exp 'of' b=patternConsExp '=>' c=exp 'or' nilExp '=>' d=exp
						{$e = (AbstrExp) new CaseExp($a.e, $b.e, $c.e, $d.e);}
;

exp returns [AbstrExp e]
	: binaryExp			{$e = $binaryExp.e;}
	| ifExp				{$e = $ifExp.e;}
	| funcExp			{$e = $funcExp.e;}
	| funcAppExp		{$e = $funcAppExp.e;}
	| letExp			{$e = $letExp.e;}
	| caseExp			{$e = $caseExp.e;}
;

Identifier : Nondigit (Nondigit|Digit)*;

fragment
Nondigit : [a-zA-Z_];

fragment
Digit : [0-9];

fragment
NonzeroDigit : [1-9];

Constant
	: Digit
	| NonzeroDigit Digit+;

Whitespace
	: [ \t]+ -> skip
;

Newline
	: ('\r' '\n'? | '\n') -> skip
;
