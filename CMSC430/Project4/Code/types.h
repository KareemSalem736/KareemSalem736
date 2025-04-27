// CMSC 430 Compiler Theory and Design
// Project 4
// Kareem Salem
// April 27, 2025

// This file contains type definitions and the function
// prototypes for the type checking functions

#include <map>
#include <string>
#include "symbols.h"
using namespace std;
typedef char* CharPtr;

enum Types {MISMATCH, INT_TYPE, CHAR_TYPE, NONE, REAL_TYPE};

void checkAssignment(Types lValue, Types rValue, string message);
void checkListAssignment(Types listType, Types elementType);
void checkListSubscript(Types subscriptType);
void checkRelational(Types left, Types right);
void checkDuplicate(Symbols<Types>& table, CharPtr identifier, string tableName);
Types checkWhen(Types true_, Types false_);
Types checkSwitch(Types case_, Types when, Types other);
Types checkCases(Types left, Types right);
Types checkArithmetic(Types left, Types right);
Types checkList(Types left, Types right);
Types checkArithmeticOperator(Types type);
Types checkRemainder(Types left, Types right);
Types checkIf(Types thenType, Types elsifType, Types elseType);
Types checkFold(Types listType);
