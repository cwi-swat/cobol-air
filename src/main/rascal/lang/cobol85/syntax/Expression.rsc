module lang::cobol85::\syntax::Expression

extend lang::cobol85::\syntax::Lexical;

// the reserved words of this module
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

syntax SubscriptExpression
    = literal: Literal
    | qualifiedDataName: QualifiedDataName
    | plus: QualifiedDataName "+" Integer
    | minus: QualifiedDataName "-" Integer
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

syntax ThroughLiteral = through: Through Literal;

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
// then addition and subtraction; operators of equal priority are evaluated from left to right
syntax Expression
    = literal: Literal
    | identifier: Identifier
    | brackets: "(" Expression ")"
    > unaryPlus: "+" Expression
    | unaryMinus: "-" Expression
    > left power: Expression "**" !>> "*" Expression
    > left ( times: Expression "*" !>> "*" Expression | dividedBy: Expression "/" Expression )
    > left ( plus: Expression "+" Expression | minus: Expression "-" Expression )
    ;

syntax Literal
    = \num: Num
    | nonnumeric: Nonnumeric
    | figurativeConstant: FigurativeConstant
    ;

syntax InDataOrFileOrMnemonicName = \in: In Id;

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

syntax LiteralThroughLiteral = literal: Literal ThroughLiteral?;

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
syntax SubscriptParentheses = brackets: "," !<< ", " !<< "(" SubscriptExpression+ ")";

syntax EqualTo
    = equal: 'EQUAL' 'TO'?
    | equalSign: "="
    ;
