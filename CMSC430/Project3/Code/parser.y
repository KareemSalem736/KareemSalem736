/* CMSC 430 Compiler Theory and Design
   Project 3 Skeleton
   UMGC CITE
   Summer 2023
   
   Project 3 Parser with semantic actions for the interpreter */

%{

#include <iostream>
#include <cmath>
#include <string>
#include <vector>
#include <map>

using namespace std;

#include "values.h"
#include "listing.h"
#include "symbols.h"

int yylex();
void yyerror(const char* message);
double extract_element(CharPtr list_name, double subscript);

Symbols<double> scalars;
Symbols<vector<double>*> lists;
double result;

double *paramValues;
int paramCount;
int paramIndex;

%}

%define parse.error verbose

%union {
	CharPtr iden;
	Operators oper;
	double value;
	vector<double>* list;
	int dir;
}

%token <iden> IDENTIFIER

%token <value> INT_LITERAL CHAR_LITERAL REAL_LITERAL

%token <oper> ADDOP MULOP ANDOP RELOP OROP NOTOP REMOP EXPOP NEGOP

%token ARROW

%token BEGIN_ CASE CHARACTER ELSE END ENDSWITCH FUNCTION INTEGER IS LIST OF OTHERS
	RETURNS SWITCH WHEN ELSIF ENDFOLD ENDIF FOLD IF LEFT REAL RIGHT THEN 

%type <value> body statement_ statement cases case expression term factor primary
	 condition relation elsif_statements elsif_statement else_statement

%type <list> list expressions list_choice

%type <dir> direction

%type  <oper> operator

%%

function:	
	function_header optional_variable  body ';' {result = $3;} ;
	
function_header:	
	FUNCTION IDENTIFIER parameters RETURNS type ';' ;

parameters:
	parameter_list |
	%empty ;

parameter_list:
	parameter |
	parameter_list ',' parameter ;

parameter:
	IDENTIFIER ':' type { scalars.insert($1, paramValues[paramIndex++]); } ;

type:
	INTEGER |
	CHARACTER |
	REAL ;
	
optional_variable:
	variable optional_variable |
	%empty ;
	
variable:	
	IDENTIFIER ':' type IS statement ';' {scalars.insert($1, $5);}; |
	IDENTIFIER ':' LIST OF type IS list ';' {lists.insert($1, $7);} |
	error ';' ;

list:
	'(' expressions ')' {$$ = $2;} ;

expressions:
	expressions ',' expression {$1->push_back($3); $$ = $1;} | 
	expression {$$ = new vector<double>(); $$->push_back($1);}

body:
	BEGIN_ statement_ END {$$ = $2;} ;

statement_:
	statement ';' |
	error ';' {$$ = 0;} ;
    
statement:
	expression |
	WHEN condition ',' expression ':' expression {$$ = $2 ? $4 : $6;} |
	SWITCH expression IS cases OTHERS ARROW statement ';' ENDSWITCH {$$ = !isnan($4) ? $4 : $7;} |
	FOLD direction operator list_choice ENDFOLD{ $$ = evaluateFold($2, $3, $4); } |
	IF condition THEN statement_ elsif_statements else_statement ENDIF { $$ = $2 ? $4 : !isnan($5) ? $5 : $6;} ;

direction:
	LEFT { $$ = 0; } |
	RIGHT { $$ = 1; } ;

operator:
	ADDOP | MULOP | REMOP ;

list_choice:
	list |
	IDENTIFIER {if (!lists.find($1, $$)) appendError(UNDECLARED, $1);} ;

elsif_statements:
	%empty { $$ = NAN; } |
	elsif_statement elsif_statements { $$ = !isnan($1) ? $1 : $2; } ;

elsif_statement:
	ELSIF condition THEN statement_ { $$ = $2 ? $4 : NAN; } ;

else_statement:
	ELSE statement_ { $$ = $2; } |
	%empty { $$ = NAN; } ;

cases:
	cases case {$$ = !isnan($1) ? $1 : $2;} |
	%empty {$$ = NAN;} ;
	
case:
	CASE INT_LITERAL ARROW statement ';' {$$ = $<value>-2 == $2 ? $4 : NAN;} |
	error ';' ; 

condition:
	condition OROP relation { $$ = $1 || $3; } |
	condition ANDOP relation {$$ = $1 && $2;} |
	relation ;

relation:
	'(' condition ')' {$$ = $2;} |
	expression RELOP expression {$$ = evaluateRelational($1, $2, $3);} |
	NOTOP relation ;

expression:
	expression ADDOP term {$$ = evaluateArithmetic($1, $2, $3);} |
	term ;
      
term:
	term MULOP factor {$$ = evaluateArithmetic($1, $2, $3);}  |
	term REMOP factor { $$ = evaluateArithmetic($1, $2, $3); } |
	factor ;

factor:
	primary EXPOP factor { $$ = evaluateArithmetic($1, $2, $3); } |
	primary ;

primary:
	'(' expression ')' {$$ = $2;} |
	INT_LITERAL { $$ = $1; } | 
	CHAR_LITERAL { $$ = $1; } |
	IDENTIFIER '(' expression ')' {$$ = extract_element($1, $3); } |
	IDENTIFIER {if (!scalars.find($1, $$)) appendError(UNDECLARED, $1);} |
	REAL_LITERAL { $$ = $1; } |
	NEGOP primary { $$ = -$2; } ;

%%

void yyerror(const char* message) {
	appendError(SYNTAX, message);
}

double extract_element(CharPtr list_name, double subscript) {
	vector<double>* list; 
	if (lists.find(list_name, list))
		return (*list)[subscript];
	appendError(UNDECLARED, list_name);
	return NAN;
}

int main(int argc, char *argv[]) {
	paramCount = argc - 1;
    paramValues = new double[paramCount];
    for(int i = 0; i < paramCount; ++i)
        paramValues[i] = atof(argv[i+1]);
    paramIndex = 0;
 
    firstLine();
	yyparse();
	if (lastLine() == 0)
		cout << "Result = " << result << endl;
	return 0;
} 
