// CMSC 430 Compiler Theory and Design
// Project 1 Skeleton
// UMGC CITE
// Summer 2023

// This file contains the bodies of the functions that produces the 
// compilation listing

#include <iostream>
#include <cstdio>
#include <string>
#include <queue>

using namespace std;

#include "listing.h"

static int lineNumber;
static string error = "";
static int totalErrors = 0;
static int lexicalErrors = 0;
static int syntaxErrors = 0;
static int semanticErrors = 0;
queue<string> errorMessages;

static void displayErrors();

void firstLine()
{
	lineNumber = 1;
	printf("\n%4d  ",lineNumber);
}

void nextLine()
{
	displayErrors();
	lineNumber++;
	printf("%4d  ",lineNumber);	
	
}

int lastLine()
{
	displayErrors();
	int totalErrors = lexicalErrors + syntaxErrors + semanticErrors;
	if (totalErrors == 0) {
        printf("\nCompiled Successfully\n");
    } else {
        printf("\nLexical Errors: %d\n", lexicalErrors);
        printf("Syntax Errors: %d\n", syntaxErrors);
        printf("Semantic Errors: %d\n", semanticErrors);
    }

	return totalErrors;
}
    
void appendError(ErrorCategories errorCategory, string message)
{
	string messages[] = { "Lexical Error, Invalid Character ", "",
		"Semantic Error, ", "Semantic Error, Duplicate ",
		"Semantic Error, Undeclared " };

	error = messages[errorCategory] + message;

	switch (errorCategory) {
        case LEXICAL:
            lexicalErrors++;
            break;
        case SYNTAX:
            syntaxErrors++;
            break;
        case GENERAL_SEMANTIC:
            semanticErrors++;
            break;
        default:
            break;
    }
	errorMessages.push(error);
}

void displayErrors()
{
	if (!errorMessages.empty()){
		printf(" ");
	}
	while (!errorMessages.empty()) {
		printf(" %s\n", errorMessages.front().c_str());
        errorMessages.pop();
	}
}
