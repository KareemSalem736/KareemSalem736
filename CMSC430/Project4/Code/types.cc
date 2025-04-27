// CMSC 430 Compiler Theory and Design
// Project 4
// Kareem Salem
// April 27, 2025

// This file contains the bodies of the type checking functions

#include <string>
#include <vector>

using namespace std;

#include "types.h"
#include "listing.h"

void checkAssignment(Types lValue, Types rValue, string message) {
    if (lValue == MISMATCH || rValue == MISMATCH)
        return;
    
    if (lValue == INT_TYPE && rValue == REAL_TYPE) {
        if (message == "Function Return")
            appendError(GENERAL_SEMANTIC, "Illegal Narrowing Function Return");
        else
            appendError(GENERAL_SEMANTIC, "Illegal Narrowing Variable Initialization");
    }
    else if (lValue != rValue) {
        appendError(GENERAL_SEMANTIC, "Type Mismatch on " + message);
    }
}

void checkListAssignment(Types listType, Types elementType) {
    if (listType != MISMATCH && elementType != MISMATCH && listType != elementType)
        appendError(GENERAL_SEMANTIC, "List Type Does Not Match Element Types");
}

void checkListSubscript(Types subscriptType) {
    if (subscriptType != MISMATCH && subscriptType != INT_TYPE)
        appendError(GENERAL_SEMANTIC, "List Subscript Must Be Integer");
}

void checkRelational(Types left, Types right) {
    if (left == MISMATCH || right == MISMATCH)
        return;
    
    if ((left == CHAR_TYPE && (right == INT_TYPE || right == REAL_TYPE)) ||
        (right == CHAR_TYPE && (left == INT_TYPE || left == REAL_TYPE))) {
        appendError(GENERAL_SEMANTIC, "Character Literals Cannot be Compared to Numeric Expressions");
    }
}

void checkDuplicate(Symbols<Types>& table, CharPtr identifier, string tableName) {
    Types type;
    if (table.find(identifier, type))
        appendError(GENERAL_SEMANTIC, "Duplicate " + tableName + " " + identifier);
}

Types checkWhen(Types true_, Types false_) {
	if (true_ == MISMATCH || false_ == MISMATCH)
		return MISMATCH;
	if (true_ != false_)
		appendError(GENERAL_SEMANTIC, "When Types Mismatch ");
	return true_;
}

Types checkSwitch(Types case_, Types when, Types other) {
	if (case_ != INT_TYPE)
		appendError(GENERAL_SEMANTIC, "Switch Expression Not Integer");
	return checkCases(when, other);
}

Types checkCases(Types left, Types right) {
	if (left == MISMATCH || right == MISMATCH)
		return MISMATCH;
	if (left == NONE || left == right)
		return right;
	appendError(GENERAL_SEMANTIC, "Case Types Mismatch");
	return MISMATCH;
}

Types checkArithmetic(Types left, Types right) {
	if (left == MISMATCH || right == MISMATCH)
		return MISMATCH;
	if (left == INT_TYPE && right == INT_TYPE)
		return INT_TYPE;
	if (left == REAL_TYPE && right == INT_TYPE)
		return REAL_TYPE;
	if (left == INT_TYPE && right == REAL_TYPE)
		return REAL_TYPE;
	appendError(GENERAL_SEMANTIC, "Arithmetic Operator Requires Numeric Types");
	return MISMATCH;
}

Types checkList(Types left, Types right) {
    if (left == MISMATCH || right == MISMATCH){
		appendError(GENERAL_SEMANTIC, "List Element Types Do Not Match");
		return MISMATCH;
	}
    if (left != right) {
        appendError(GENERAL_SEMANTIC, "List Element Types Do Not Match");
        return MISMATCH;
    }
    return left;
}

Types checkArithmeticOperator(Types type) {
    if (type == MISMATCH)
        return MISMATCH;
    if (type != INT_TYPE && type != REAL_TYPE) {
        appendError(GENERAL_SEMANTIC, "Arithmetic Operator Requires Numeric Types");
        return MISMATCH;
    }
    return type;
}

Types checkRemainder(Types left, Types right) {
    if (left == MISMATCH || right == MISMATCH)
        return MISMATCH;
    if (left == INT_TYPE && right == INT_TYPE)
        return INT_TYPE;
    appendError(GENERAL_SEMANTIC, "Remainder Operator Requires Integer Operands");
    return MISMATCH;
}

Types checkIf(Types thenType, Types elsifType, Types elseType) {
    if (thenType == MISMATCH || elsifType == MISMATCH || elseType == MISMATCH)
        return MISMATCH;
    if (thenType == elseType && (elsifType == NONE || thenType == elsifType))
        return thenType;
    appendError(GENERAL_SEMANTIC, "If-Elsif-Else Type Mismatch");
    return MISMATCH;
}

Types checkFold(Types listType) {
    if (listType == MISMATCH)
        return MISMATCH;
    if (listType != INT_TYPE && listType != REAL_TYPE) {
        appendError(GENERAL_SEMANTIC, "Fold Requires A Numeric List");
        return MISMATCH;
    }
    return listType;
}

