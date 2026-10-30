module lang::vscobolii::Functions

// Intrinsic functions, as in `COMPUTE X = FUNCTION SQRT(Y)` or `MOVE FUNCTION CURRENT-DATE(1:8) TO D`.
//
// This feature is not part of VS COBOL II. It was introduced by the Intrinsic Function Module
// amendment to COBOL-85 (ANSI X3.23a-1989, ISO 1989:1985/Amd 1:1992), which defines the 42
// functions below. IBM first supported it in COBOL/370; later standards (COBOL 2002, 2014)
// added many more functions that are not included here.

extend lang::vscobolii::\VSC-expr;

keyword CobwordKeywords = 'FUNCTION';

syntax Identifier
  = \function-identifier: 'FUNCTION' Function_name !>> [A-Za-z0-9\-] Function_arguments? Reference_modification?
  ;

syntax Function_arguments = \function-arguments: "(" Function_argument+ ")";

syntax Function_argument = \function-argument: Arithmetic_expression EndFunctionArgument;

// longest match: an argument can not be followed by a binary operator or a subscript, so `MAX(1 - 2)` and `MAX(A (1))`
// have one argument. A sign glued to its number starts the next argument, so `MAX(-1, -2)` has two.
syntax EndFunctionArgument = () !>> [*/(] !>> "+ " !>> "- " !>> "+\n" !>> "-\n";

// the same amendment introduced ALL subscripts, to pass all elements of a table to a function: `FUNCTION MAX(T(ALL))`
syntax Subscript_expression = \subscript-expression-all: 'ALL';

syntax Reference_modification = \reference-modification: "(" Arithmetic_expression ":" Arithmetic_expression? ")";

syntax Function_name
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
