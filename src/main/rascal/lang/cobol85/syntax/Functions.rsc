@license{
Copyright (c) 2026, CWI - Software Analysis and Transformation

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this
   list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice,
   this list of conditions and the following disclaimer in the documentation
   and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
}
module lang::cobol85::\syntax::Functions

// Intrinsic functions, as in `COMPUTE X = FUNCTION SQRT(Y)` or `MOVE FUNCTION CURRENT-DATE(1:8) TO D`.
//
// This feature is not part of VS COBOL II. It was introduced by the Intrinsic Function Module
// amendment to COBOL-85 (ANSI X3.23a-1989, ISO 1989:1985/Amd 1:1992), which defines the 42
// functions below. IBM first supported it in COBOL/370; later standards (COBOL 2002, 2014)
// added many more functions that are not included here.
extend lang::cobol85::\syntax::Expression;

keyword CobwordKeywords
    = 'ALL'
    | 'FUNCTION'
    | 'LENGTH'
    | 'RANDOM'
    ;

syntax Identifier = \function: 'FUNCTION' FunctionName !>> [A-Za-z0-9\-] FunctionArguments? ReferenceModification?;

syntax FunctionArguments = brackets: "(" Operand+ ")";

// the same amendment introduced ALL subscripts, to pass all elements of a table to a function: `FUNCTION MAX(T(ALL))`
syntax SubscriptExpression = \all: 'ALL';

syntax ReferenceModification = brackets: "(" Expression ":" Expression? ")";

syntax FunctionName
    = 'ACOS'
    | 'ANNUITY'
    | 'ASIN'
    | 'ATAN'
    | 'CHAR'
    | 'COS'
    | 'CURRENT-DATE'
    | 'DATE-OF-INTEGER'
    | 'DAY-OF-INTEGER'
    | 'FACTORIAL'
    | 'INTEGER'
    | 'INTEGER-OF-DATE'
    | 'INTEGER-OF-DAY'
    | 'INTEGER-PART'
    | 'LENGTH'
    | 'LOG'
    | 'LOG10'
    | 'LOWER-CASE'
    | 'MAX'
    | 'MEAN'
    | 'MEDIAN'
    | 'MIDRANGE'
    | 'MIN'
    | 'MOD'
    | 'NUMVAL'
    | 'NUMVAL-C'
    | 'ORD'
    | 'ORD-MAX'
    | 'ORD-MIN'
    | 'PRESENT-VALUE'
    | 'RANDOM'
    | 'RANGE'
    | 'REM'
    | 'REVERSE'
    | 'SIN'
    | 'SQRT'
    | 'STANDARD-DEVIATION'
    | 'SUM'
    | 'TAN'
    | 'UPPER-CASE'
    | 'VARIANCE'
    | 'WHEN-COMPILED'
    ;
