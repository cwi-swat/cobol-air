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
  | qualifiedDataName: Qualified_data_name Subscript_parentheses*
  | qualifiedDataName: Qualified_data_name Subscript_parentheses* "(" Expression ":" ")"
  | qualifiedDataName: Qualified_data_name Subscript_parentheses* "(" Expression ":" Expression ")"
  ;
syntax Subscript_expression
  = literal: Literal
  | qualifiedDataName: Qualified_data_name
  | plus: Qualified_data_name "+" Integer
  | minus: Qualified_data_name "-" Integer
  ;

syntax Record_name = qualifiedDataName: Qualified_data_name;

syntax Qualified_data_name
  = length: 'LENGTH' 'OF' Identifier
  | address: 'ADDRESS' 'OF' Id
  | dataName: Id In_data_or_file_name*
  ;


syntax Paragraph_name
  = word: Id
  | integer: Integer
  ;
syntax Copy_operand
  = literal: Literal
  | identifier: Identifier
  | quotedPseudoText: Quoted_pseudo_text
  // any COBOL word can be replaced, also a reserved word, as in `REPLACING ==...== BY MOVE`
  | \keyword: NotFigurative CobwordKeywords !>> [A-Za-z0-9\-]
  ;

// figurative constants are literals (copy-operand-c3), not reserved words
syntax NotFigurative = () !>> 'ZERO' !>> 'SPACE' !>> 'QUOTE' !>> 'NULL' !>> 'HIGH-VALUE' !>> 'LOW-VALUE';

syntax Figurative_constant
  = \all: 'ALL' Literal
  | figurativeConstantSimple: Figurative_constant_simple !>> [A-Za-z0-9\-] // a keyword ends at a word boundary: ZERO-NULL is a data name
  ;
syntax Integer = \num: Num;

syntax Paragraph_or_section_name
  = integer: Integer
  | word: Id
  ;
syntax Alt_reel_unit
  = reel: 'REEL'
  | unit: 'UNIT'
  ;

syntax Figurative_constant_simple
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


syntax Alt_ascending_descending
  = descending: 'DESCENDING'
  | ascending: 'ASCENDING'
  ;

syntax Through_literal = through: Through Literal;

syntax Alt_library_name_literal
  = word: Id
  | literal: Literal
  ;

syntax Alt_text_name_literal
  = word: Id
  | literal: Literal
  ;

syntax Procedure_name
  = paragraphOrSectionName: Paragraph_or_section_name
  | paragraphOrSectionName: Paragraph_or_section_name In Section_name
  ;
syntax In_data_or_file_name = \in: In Id;
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
  > left (
      times: Expression "*" !>> "*" Expression
    | dividedBy: Expression "/" Expression
    )
  > left (
      plus: Expression "+" Expression
    | minus: Expression "-" Expression
    )
  ;

syntax Literal
  = \num: Num
  | nonnumeric: Nonnumeric
  | figurativeConstant: Figurative_constant
  ;


syntax In_data_or_file_or_mnemonic_name = \in: In Id;
syntax Records
  = records: 'RECORDS'
  | record: 'RECORD'
  ;


syntax Values
  = values: 'VALUES'
  | \value: 'VALUE'
  ;

syntax Section_name
  = word: Id
  | integer: Integer
  ;

syntax Through
  = through: 'THROUGH'
  | thru: 'THRU'
  ;

syntax Literal_through_literal = literal: Literal Through_literal?;

syntax Copy_statement
  = copy: 'COPY' Alt_text_name_literal 'SUPPRESS'? "."
  | copy: 'COPY' Alt_text_name_literal 'SUPPRESS'? 'REPLACING' Copy_statement_by_phrase+ "."
  | copy: 'COPY' Alt_text_name_literal In Alt_library_name_literal 'SUPPRESS'? "."
  | copy: 'COPY' Alt_text_name_literal In Alt_library_name_literal 'SUPPRESS'? 'REPLACING' Copy_statement_by_phrase+ "."
  ;

syntax In
  = of: 'OF'
  | \in: 'IN'
  ;

syntax Priority_number = \num: Num;
syntax Copy_statement_by_phrase = by: Copy_operand 'BY' Copy_operand;
// a subscript does not follow a comma, so in `FUNCTION MIN(B, (C + 1) / 2)` the bracket starts the next argument
syntax Subscript_parentheses = brackets: "," !<< ", " !<< "(" Subscript_expression+ ")";

syntax Equal_to
  = equal: 'EQUAL' 'TO'?
  | equalSign: "="
  ;

