/* CMSC 430 Compiler Theory and Design
   Project 2 Skeleton
   Kareem Salem
   March 31, 2025

   Project 2 Parser */

%{

#include <string>
#include <cstring>

using namespace std;

#include "listing.h"

int yylex();
void yyerror(const char* message);


%}

%define parse.error verbose

%token IDENTIFIER INT_LITERAL CHAR_LITERAL

%token ADDOP MULOP ANDOP RELOP ARROW

%token BEGIN_ CASE CHARACTER ELSE END ENDSWITCH FUNCTION INTEGER IS LIST OF OTHERS
	RETURNS SWITCH WHEN ELSIF ENDFOLD ENDIF FOLD IF LEFT REAL RIGHT THEN REAL_LITERAL 
	OROP NOTOP REMOP EXPOP NEGOP

%%

function:	
	function_header optional_variable body ;

function_header:	
	FUNCTION IDENTIFIER parameters RETURNS type ';' |
	FUNCTION error ';' ;

parameters:
	parameter_list |
	%empty ;

parameter_list:
	parameter |
	parameter ',' parameter_list ;

parameter:
	IDENTIFIER ':' type ;

type:
	INTEGER |
	CHARACTER |
	REAL ;
	
optional_variable:
	variable optional_variable |
	%empty ;   

variable:	
	IDENTIFIER ':' type IS statement ';' |
	IDENTIFIER ':' LIST OF type IS list ';' |
	error ';' ;

list:
	'(' expressions ')' ;

expressions:
	expressions ',' expression| 
	expression ;

body:
	BEGIN_ statement_ END ';' ;

statement_:
	statement ';' |
	error ';' ;
    
statement:
	expression |
	WHEN condition ',' expression ':' expression |
	SWITCH expression IS cases OTHERS ARROW statement_ ENDSWITCH  |
	FOLD direction operator list_choice ENDFOLD  |
	IF condition THEN statement_ elsif_statements else_statement ENDIF  ;

direction:
	LEFT | RIGHT ;

operator:
	ADDOP | MULOP | REMOP ;

list_choice:
	list | IDENTIFIER ;

elsif_statements:
	elsif_statement elsif_statements |
	%empty ;

elsif_statement:
	ELSIF condition THEN statement_ ;

else_statement:
	ELSE statement_ |
	%empty ;

cases:
	cases case |
	%empty ;
	
case:
	CASE INT_LITERAL ARROW statement_ |
	error ';' ; 

condition:
	condition OROP logical_and |
	logical_and ;

logical_and:
	logical_and ANDOP relation |
	relation ;

relation:
	'(' condition ')' |
	expression RELOP expression |
	NOTOP relation ;

expression:
	expression ADDOP term |
	term ;

term:
	term MULOP factor |
	term REMOP factor |
	factor ;

factor:
	primary |
	primary EXPOP factor ;

primary:
	'(' expression ')' |
	INT_LITERAL |
	CHAR_LITERAL |
	IDENTIFIER '(' expression ')' |
	IDENTIFIER |
	REAL_LITERAL |
	NEGOP primary ;

%%

void yyerror(const char* message) {
	appendError(SYNTAX, message);
}

int main(int argc, char *argv[]) {
	firstLine();
	yyparse();
	lastLine();
	return 0;
} 
