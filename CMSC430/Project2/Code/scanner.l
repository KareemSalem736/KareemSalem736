/*	CMSC 430 Compiler Theory and Design
	Project 2
	Kareem Salem
	March 31, 2025
*/

/* This file contains flex input file */

%{
#include <cstdio>
#include <string>

using namespace std;

#include "listing.h"
#include "tokens.h"

%}

%option noyywrap

ws		[ \t\r]+
comment		"//".*\n
new_comment		"--".*\n
line		[\n]
id		[A-Za-z]([A-Za-z0-9]|(_{1,2}[A-Za-z0-9]))*
digit		[0-9]
dec		{digit}+
char		'([^'\\]|\\[btnrf'])'
punc		[\(\),:;]
real_literal	([0-9]+(\.[0-9]*)?|\.[0-9]+)([eE][+-]?[0-9]+)?
int_literal		#[0-9A-Fa-f]+
%%

{ws}		{ ECHO; }
{comment}	{ ECHO; nextLine(); }
{new_comment}	{ ECHO; nextLine(); }
{line}		{ ECHO; nextLine(); }
"+"		{ ECHO; return(ADDOP); }
"*"		{ ECHO; return(MULOP); }
"&"		{ ECHO; return(ANDOP); }
"<"		{ ECHO; return(RELOP); }
"=>"		{ ECHO; return(ARROW); }
"|"		{ ECHO; return(OROP); }
"!"		{ ECHO; return(NOTOP); }
"="		{ ECHO; return(RELOP); }
"<>"		{ ECHO; return(RELOP); }
">"		{ ECHO; return(RELOP); }
"<="		{ ECHO; return(RELOP); }
">="		{ ECHO; return(RELOP); }
"-"		{ ECHO; return(ADDOP); }
"/"		{ ECHO; return(MULOP); }
"%"		{ ECHO; return(REMOP); }
"^"		{ ECHO; return(EXPOP); }
"~"		{ ECHO; return(NEGOP); }
begin		{ ECHO; return(BEGIN_); }
case		{ ECHO; return(CASE); }
character	{ ECHO; return(CHARACTER); }
end		{ ECHO; return(END); }
endswitch	{ ECHO; return(ENDSWITCH); }
function	{ ECHO; return(FUNCTION); }
integer		{ ECHO; return(INTEGER); }
is		{ ECHO; return(IS); }
list		{ ECHO; return(LIST); }
of		{ ECHO; return(OF); }
others		{ ECHO; return(OTHERS); }
returns		{ ECHO; return(RETURNS); }
switch		{ ECHO; return(SWITCH); }
when		{ ECHO; return(WHEN); }
else	{ ECHO; return(ELSE); }
elsif	{ ECHO; return(ELSIF); }
endfold	{ ECHO; return(ENDFOLD); }
endif	{ ECHO; return(ENDIF); }
fold	{ ECHO; return(FOLD); }
if	{ ECHO; return(IF); }
left	{ ECHO; return(LEFT); }
real	{ ECHO; return(REAL); }
right	{ ECHO; return(RIGHT); }
then	{ ECHO; return(THEN); }
{id}		{ ECHO; return(IDENTIFIER);}
{dec}		{ ECHO; return(INT_LITERAL); }
{char}		{ ECHO; return(CHAR_LITERAL); }
{punc}		{ ECHO; return(yytext[0]); }
{real_literal}		{ ECHO; return(REAL_LITERAL); }
{int_literal}		{ ECHO; return(INT_LITERAL); }
.		{ ECHO; appendError(LEXICAL, yytext); }
%%
