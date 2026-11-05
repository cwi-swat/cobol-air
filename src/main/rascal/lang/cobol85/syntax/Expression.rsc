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
module lang::cobol85::\syntax::Expression

extend lang::cobol85::\syntax::Lexical;

keyword CobwordKeywords
    = 'ADDRESS'
    | 'ALL'
    | 'ASCENDING'
    | 'BY'
    | 'COPY'
    | 'DESCENDING'
    | 'EQUAL'
    | 'HIGH-VALUE'
    | 'HIGH-VALUES'
    | 'IN'
    | 'LENGTH'
    | 'LINAGE-COUNTER'
    | 'LOW-VALUE'
    | 'LOW-VALUES'
    | 'NULL'
    | 'NULLS'
    | 'OF'
    | 'QUOTE'
    | 'QUOTES'
    | 'RECORD'
    | 'RECORDS'
    | 'REEL'
    | 'REPLACING'
    | 'SPACE'
    | 'SPACES'
    | 'SUPPRESS'
    | 'THROUGH'
    | 'THRU'
    | 'TO'
    | 'UNIT'
    | 'VALUE'
    | 'VALUES'
    | 'ZERO'
    | 'ZEROES'
    | 'ZEROS'
    ;

syntax Identifier
    = linageCounter: 'LINAGE-COUNTER'
    | linageCounter: 'LINAGE-COUNTER' In Id
    | qualifiedDataName: QualifiedDataName SubscriptParentheses*
    | qualifiedDataName: QualifiedDataName SubscriptParentheses* "(" Expression ":" ")"
    | qualifiedDataName: QualifiedDataName SubscriptParentheses* "(" Expression ":" Expression ")"
    ;

// a relative subscript (`I + 1`) is an expression too; a checker rejects the other expressions
syntax SubscriptExpression = operand: Operand;

// an operand in a list of operands, such as the arguments of a function, the subscripts of an identifier, or the
// sending fields of DISPLAY and ADD. Operands are separated by spaces, so an IS-less class or zero condition would
// also read as two operands. OR separates the operands of `DELIMITED BY "A" OR "B"`, so an operand is no conjunction
// or disjunction. A checker rejects the expressions COBOL does not allow in a place.
syntax Operand = expression: Expression ! inClass ! notInClass ! zero ! notZero ! conjunction ! disjunction EndOperand;

// longest match: an operand can not be followed by a binary operator or a subscript, so `MAX(1 - 2)` and `MAX(A (1))`
// have one operand. A sign glued to its number starts the next operand, so `MAX(-1, -2)` has two.
// After a comma a bracket starts the next operand, so `MIN(A, (1 + 2) / 3)` has two.
syntax EndOperand
    = () !>> [*/(] !>> "+ " !>> "- " !>> "+\n" !>> "-\n" !>> "+" !>> "-"
    | "," << () >> "("
    | ", " << () >> "("
    ;

syntax RecordName = qualifiedDataName: QualifiedDataName;

syntax QualifiedDataName
    = length: 'LENGTH' 'OF' Identifier
    | address: 'ADDRESS' 'OF' Id
    | dataName: Id InDataOrFileName*
    ;

syntax ParagraphName
    = word: Id
    | integer: Integer
    ;

syntax CopyOperand
    = literal: Literal
    | identifier: Identifier
    | quotedPseudoText: QuotedPseudoText
    // any COBOL word can be replaced, also a reserved word, as in `REPLACING ==...== BY MOVE`
    | \keyword: NotFigurative CobwordKeywords !>> [A-Za-z0-9\-]
    ;

// figurative constants are literals (copy-operand-c3), not reserved words
syntax NotFigurative = () !>> 'ZERO' !>> 'SPACE' !>> 'QUOTE' !>> 'NULL' !>> 'HIGH-VALUE' !>> 'LOW-VALUE';

syntax FigurativeConstant
    = \all: 'ALL' Literal
    | figurativeConstantSimple: FigurativeConstantSimple !>> [A-Za-z0-9\-]
    // a keyword ends at a word boundary: ZERO-NULL is a data name
    ;

syntax Integer = \num: Num;

syntax ParagraphOrSectionName
    = integer: Integer
    | word: Id
    ;

syntax AltReelUnit
    = reel: 'REEL'
    | unit: 'UNIT'
    ;

syntax FigurativeConstantSimple
    = spaces: 'SPACES'
    | quotes: 'QUOTES'
    | highValues: 'HIGH-VALUES'
    | null: 'NULL'
    | zeroes: 'ZEROES'
    | lowValue: 'LOW-VALUE'
    | highValue: 'HIGH-VALUE'
    | zero: 'ZERO'
    | space: 'SPACE'
    | quote: 'QUOTE'
    | lowValues: 'LOW-VALUES'
    | zeros: 'ZEROS'
    | nulls: 'NULLS'
    ;

syntax AltAscendingDescending
    = descending: 'DESCENDING'
    | ascending: 'ASCENDING'
    ;

syntax AltLibraryNameLiteral
    = word: Id
    | literal: Literal
    ;

syntax AltTextNameLiteral
    = word: Id
    | literal: Literal
    ;

syntax ProcedureName
    = paragraphOrSectionName: ParagraphOrSectionName
    | paragraphOrSectionName: ParagraphOrSectionName In SectionName
    ;

syntax InDataOrFileName = \in: In Id;

// arithmetic expressions; the conditions in Condition.rsc continue this priority chain below minus.
// Priorities follow COBOL-85: unary plus and minus, then exponentiation, then multiplication and division,
// then addition and subtraction; operators of equal priority are evaluated from left to right.
// An operator does not follow the left margin: there `*` and `/` start a comment line and `-` continues a line.
syntax Expression
    = literal: Literal
    | identifier: Identifier
    | brackets: "(" Expression ")"
    > unaryPlus: "+" Expression
    | unaryMinus: [] !<< "-" Expression
    > left power: Expression [] !<< "**" !>> "*" Expression
    > left ( times: Expression [] !<< "*" !>> "*" Expression | dividedBy: Expression [] !<< "/" Expression )
    > left ( plus: Expression "+" Expression | minus: Expression [] !<< "-" Expression )
    ;

syntax Literal
    = \num: Num
    | nonnumeric: Nonnumeric
    | figurativeConstant: FigurativeConstant
    ;

syntax Records
    = records: 'RECORDS'
    | record: 'RECORD'
    ;

syntax Values
    = values: 'VALUES'
    | \value: 'VALUE'
    ;

syntax SectionName
    = word: Id
    | integer: Integer
    ;

syntax Through
    = through: 'THROUGH'
    | thru: 'THRU'
    ;

syntax LiteralThroughLiteral = literal: Literal (Through Literal)?;

syntax CopyStatement = copy: 'COPY' AltTextNameLiteral CopyPhrase* ".";

// the phrases of COPY, in any order; a checker rejects the combinations COBOL does not allow
syntax CopyPhrase
    = \in: In AltLibraryNameLiteral
    | suppress: 'SUPPRESS'
    | replacing: 'REPLACING' CopyStatementByPhrase+
    ;

syntax In
    = of: 'OF'
    | \in: 'IN'
    ;

syntax PriorityNumber = \num: Num;

syntax CopyStatementByPhrase = by: CopyOperand 'BY' CopyOperand;

// a subscript does not follow a comma, so in `FUNCTION MIN(B, (C + 1) / 2)` the bracket starts the next argument
syntax SubscriptParentheses = brackets: "," !<< (", " !<< "(" SubscriptExpression+ ")");

syntax EqualTo
    = equal: 'EQUAL' 'TO'?
    | equalSign: "="
    ;
