/* CMSC 430 Compiler Theory and Design
   Project 3
   Kareem Salem
   April 15 2025 */

/* This file contains flex input file */

%{
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <string>
#include <vector>

using namespace std;

#include "values.h"
#include "listing.h"
#include "tokens.h"

static int decode_char(const char *s) {
    if (s[1] != '\\') 
        return s[1];
    static const char *escapes = "nrtbfv0'\"\\?";
    static const char  values[]  = { '\n','\r','\t','\b','\f','\v','\0','\'','\"','\\','?' };
    char e = s[2];
    const char *pos = strchr(escapes, e);
    return pos ? values[pos - escapes] : e;
}

%}

%option noyywrap

ws		[ \t\r]+
comment		"//".*\n
new_comment		"--".*\n
line		[\n]
id		[A-Za-z]([A-Za-z0-9])*
digit		[0-9]
dec		{digit}+
char		\'(\\.|[^\\'])\'
punc		[\(\),:;]
real_literal	([0-9]+(\.[0-9]*)?|\.[0-9]+)([eE][+-]?[0-9]+)?
int_literal		#[0-9A-Fa-f]+
%%

{ws}		{ ECHO; }
{comment}	{ ECHO; nextLine(); }
{new_comment}	{ ECHO; nextLine(); }
{line}		{ ECHO; nextLine(); }

"+"		{ ECHO; yylval.oper = ADD; return(ADDOP); }
"*"		{ ECHO; yylval.oper = MULTIPLY; return(MULOP); }
"&"		{ ECHO; yylval.oper = AND; return(ANDOP); }
"<"		{ ECHO; yylval.oper = LESS; return(RELOP); }
"=>"		{ ECHO; return(ARROW); }
"|"		{ ECHO; yylval.oper = OR; return(OROP); }
"!"		{ ECHO; yylval.oper = NOT; return(NOTOP); }
"="		{ ECHO; yylval.oper = EQUAL;    return(RELOP); }
"<>"		{ ECHO; yylval.oper = NOTEQUAL; return(RELOP); }
">"		{ ECHO; yylval.oper = GREATER;  return(RELOP); }
"<="		{ ECHO; yylval.oper = LESSEQ;   return(RELOP); }
">="		{ ECHO; yylval.oper = GREATEREQ;  return(RELOP); }
"-"		{ ECHO; yylval.oper = SUBTRACT;  return(ADDOP); }
"/"		{ ECHO; yylval.oper = DIVIDE;    return(MULOP); }
"%"		{ ECHO; yylval.oper = REMAINDER; return(REMOP); }
"^"		{ ECHO; yylval.oper = EXPONENT;  return(EXPOP); }
"~"		{ ECHO; yylval.oper = NEGATE;    return(NEGOP); }

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

{id}		{ ECHO; yylval.iden = (CharPtr)malloc(yyleng + 1); 
			strcpy(yylval.iden, yytext); return(IDENTIFIER);}
{dec}		{ ECHO; yylval.value = atoi(yytext); return(INT_LITERAL); }
{char}		{ ECHO; yylval.value = decode_char(yytext); return(CHAR_LITERAL); }
{punc}		{ ECHO; return(yytext[0]); }
{real_literal}		{ ECHO; yylval.value = atof(yytext); return(REAL_LITERAL); }
{int_literal}		{ ECHO; yylval.value = strtol(yytext + 1, NULL, 16); return(INT_LITERAL); }
.		{ ECHO; appendError(LEXICAL, yytext); }
%%
