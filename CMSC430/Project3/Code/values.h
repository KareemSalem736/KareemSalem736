// CMSC 430 Compiler Theory and Design
// Project 3
// Kareem Salem
// April 15 2025

// This file contains type definitions and the function
// definitions for the evaluation functions

typedef char* CharPtr;

#include <vector>
using std::vector;

enum Operators { ADD, SUBTRACT, MULTIPLY, DIVIDE, REMAINDER, EXPONENT, NEGATE, LESS, LESSEQ, GREATER, GREATEREQ, EQUAL, NOTEQUAL, AND, OR, NOT };

double evaluateArithmetic(double left, Operators operator_, double right);
double evaluateRelational(double left, Operators operator_, double right);
double evaluateFold(int direction, Operators op, vector<double>* list);
