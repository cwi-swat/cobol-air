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

syntax Identifier
  = \function: 'FUNCTION' FunctionName !>> [A-Za-z0-9\-] FunctionArguments? ReferenceModification?
  ;

syntax FunctionArguments = brackets: "(" FunctionArgument+ ")";

// arguments are separated by spaces, so an IS-less class or zero condition would also read as two arguments
syntax FunctionArgument = expression: Expression!inClass!notInClass!zero!notZero EndFunctionArgument;

// longest match: an argument can not be followed by a binary operator or a subscript, so `MAX(1 - 2)` and `MAX(A (1))`
// have one argument. A sign glued to its number starts the next argument, so `MAX(-1, -2)` has two.
// After a comma a bracket starts the next argument, so `MIN(A, (1 + 2) / 3)` has two.
syntax EndFunctionArgument
  = () !>> [*/(] !>> "+ " !>> "- " !>> "+\n" !>> "-\n"
  | "," << () >> "("
  | ", " << () >> "("
  ;

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
