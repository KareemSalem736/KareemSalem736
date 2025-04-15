// CMSC 430 Compiler Theory and Design
// Project 3 Skeleton
// UMGC CITE
// Summer 2023

// This file contains the bodies of the evaluation functions

#include <string>
#include <cmath>
#include <vector>

using namespace std;

#include "values.h"
#include "listing.h"

double evaluateArithmetic(double left, Operators operator_, double right) {
	switch (operator_) {
		case ADD:       return left + right;
		case SUBTRACT:  return left - right;
		case MULTIPLY:  return left * right;
		case DIVIDE:    return left / right;
		case REMAINDER: return fmod(left, right);
		case EXPONENT:  return pow(left, right);
		default:        return NAN;
	}
}

double evaluateRelational(double left, Operators operator_, double right) {
	double result;
	switch (operator_) {
		case LESS:     return left < right;
		case LESSEQ:   return left <= right;
		case GREATER:  return left > right;
		case GREATEREQ:  return left >= right;
		case EQUAL:    return left == right;
		case NOTEQUAL: return left != right;
		default:       return NAN;
	}
}

double evaluateFold(int direction, Operators op, vector<double>* list) {
	int n = list->size();
	if (n == 0) return NAN;
	double result;
	if (direction == 1) {
		result = (*list)[n-1];
		for (int i = n-2; i >= 0; --i)
		result = evaluateArithmetic((*list)[i], op, result);
	} else {
		result = (*list)[0];
		for (int i = 1; i < n; ++i)
		result = evaluateArithmetic(result, op, (*list)[i]);
	}
	return result;
}
