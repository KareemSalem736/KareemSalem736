/* CMSC 430 Compiler Theory and Design
   Project 4 Skeleton
   UMGC CITE
   Summer 2023
   
   Project 4 Parser with semantic actions for static semantic errors */

%{
#include <string>
#include <vector>
#include <map>

using namespace std;

#include "types.h"
#include "listing.h"
#include "symbols.h"

int yylex();
Types find(Symbols<Types>& table, CharPtr identifier, string tableName);
void yyerror(const char* message);

Symbols<Types> scalars;
Symbols<Types> lists;

%}

%define parse.error verbose

%union {
	CharPtr iden;
	Types type;
}

%token <iden> IDENTIFIER

%token <type> INT_LITERAL CHAR_LITERAL REAL_LITERAL

%token ADDOP MULOP RELOP ANDOP ARROW

%token BEGIN_ CASE CHARACTER ELSE END ENDSWITCH FUNCTION INTEGER IS LIST OF OTHERS
	RETURNS SWITCH WHEN ELSIF ENDFOLD ENDIF FOLD IF LEFT REAL RIGHT THEN REAL_LITERAL 
	OROP NOTOP REMOP EXPOP NEGOP

%type <type> list expressions body type statement_ statement cases case expression term 
	primary factor elsif_statements elsif_statement else_statement list_choice function_header

%%

function:
    function_header optional_variable body { checkAssignment($1, $3, "Function Return"); } ;
		
function_header:
    FUNCTION IDENTIFIER parameters RETURNS type ';' { $$ = $5; } |
    FUNCTION error ';' { $$ = MISMATCH; };

parameters:
	parameter_list |
	%empty ;

parameter_list:
	parameter |
	parameter ',' parameter_list ;

parameter:
	IDENTIFIER ':' type ;

type:
	INTEGER {$$ = INT_TYPE;} |
	CHARACTER {$$ = CHAR_TYPE; } |
	REAL {$$ = REAL_TYPE; } ;
	
optional_variable:
	variable optional_variable |
	%empty ;
    
variable:
    IDENTIFIER ':' type IS statement ';' 
        { checkDuplicate(scalars, $1, "Scalar"); checkAssignment($3, $5, "Variable Initialization"); scalars.insert($1, $3); } |
    IDENTIFIER ':' LIST OF type IS list ';' 
        { checkDuplicate(lists, $1, "List"); checkListAssignment($5, $7); lists.insert($1, $5); } |
    error ';' ;

list:
	'(' expressions ')' {$$ = $2;} ;

expressions:
	expressions ',' expression { $$ = checkList($1, $3); } |
	expression { $$ = $1; };

body:
	BEGIN_ statement_ END ';' {$$ = $2;} ;
    
statement_:
	statement ';' |
	error ';' {$$ = MISMATCH;} ;
	
statement:
	expression |
	WHEN condition ',' expression ':' expression {$$ = checkWhen($4, $6);} |
	SWITCH expression IS cases OTHERS ARROW statement ';' ENDSWITCH {$$ = checkSwitch($2, $4, $7);} |
	FOLD direction operator list_choice ENDFOLD { $$ = checkFold($4); }  |
	IF condition THEN statement_ elsif_statements else_statement ENDIF { $$ = checkIf($4, $5, $6); }  ;

direction:
	LEFT | RIGHT ;

operator:
	ADDOP | MULOP | REMOP ;

list_choice:
    list { $$ = $1; } |
    IDENTIFIER { $$ = find(lists, $1, "List"); };

elsif_statements:
    elsif_statement elsif_statements { $$ = checkIf($1, $2, NONE); } |
    %empty { $$ = NONE; };

elsif_statement:
    ELSIF condition THEN statement_ { $$ = $4; };

else_statement:
    ELSE statement_ { $$ = $2; } |
    %empty { $$ = NONE; };

cases:
	cases case {$$ = checkCases($1, $2);} |
	%empty {$$ = NONE;} ;
	
case:
	CASE INT_LITERAL ARROW statement ';' {$$ = $4;} |
	error ';' ; 

condition:
	condition OROP logical_and |
	logical_and ;

logical_and:
	logical_and ANDOP relation |
	relation ;

relation:
	'(' condition ')' |
	expression RELOP expression { checkRelational($1, $3); } |
	NOTOP relation ;
	
expression:
	expression ADDOP term {$$ = checkArithmetic($1, $3);} |
	term ;
      
term:
    term MULOP factor { $$ = checkArithmetic($1, $3); } |
    term REMOP factor { $$ = checkRemainder($1, $3); } |
    factor ;

factor:
	primary |
	primary EXPOP factor { $$ = checkArithmetic($1, $3); } ;

primary:
	'(' expression ')' {$$ = $2;} |
	INT_LITERAL | 
	CHAR_LITERAL |
	IDENTIFIER '(' expression ')' { checkListSubscript($3); $$ = find(lists, $1, "List"); } |
	IDENTIFIER  {$$ = find(scalars, $1, "Scalar");} |
	REAL_LITERAL |
	NEGOP primary { $$ = checkArithmeticOperator($2); } ;

%%

Types find(Symbols<Types>& table, CharPtr identifier, string tableName) {
	Types type;
	if (!table.find(identifier, type)) {
		appendError(UNDECLARED, tableName + " " + identifier);
		return MISMATCH;
	}
	return type;
}

void yyerror(const char* message) {
	appendError(SYNTAX, message);
}

int main(int argc, char *argv[]) {
	firstLine();
	yyparse();
	lastLine();
	return 0;
} 
