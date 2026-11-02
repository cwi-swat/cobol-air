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
  = \identifier-c2: 'LINAGE-COUNTER'
  | \identifier-c2: 'LINAGE-COUNTER' In File_name
  | \identifier-c1: Qualified_data_name Subscript_parentheses*
  | \identifier-c1: Qualified_data_name Subscript_parentheses* "(" Arithmetic_expression ":" ")"
  | \identifier-c1: Qualified_data_name Subscript_parentheses* "(" Arithmetic_expression ":" Arithmetic_expression ")"
  ;
syntax Subscript_expression
  = \subscript-expression-c1: Literal
  | \subscript-expression-c2: Qualified_data_name
  | \subscript-expression-c2: Qualified_data_name Alt_plus_minus Integer
  ;

syntax Data_name = \data-name: Alphabetic_user_defined_word;
syntax Record_name = \record-name: Qualified_data_name;

syntax Index_name = \index-name: Alphabetic_user_defined_word;
syntax System_name = \system-name: Cobword \ CobwordKeywords;
syntax Qualified_data_name
  = \qualified-data-name-c3: 'LENGTH' 'OF' Identifier
  | \qualified-data-name-c2: 'ADDRESS' 'OF' Data_name
  | \qualified-data-name-c1: Data_name In_data_or_file_name*
  ;

syntax Assignment_name = \assignment-name: System_name;

syntax Symbolic_character = \symbolic-character: Alphabetic_user_defined_word;
syntax Paragraph_name
  = \paragraph-name-c1: User_defined_word
  | \paragraph-name-c2: Integer
  ;
syntax Copy_operand
  = \copy-operand-c3: Literal
  | \copy-operand-c2: Identifier
  | \copy-operand-c1: Quoted_pseudo_text
  // any COBOL word can be replaced, also a reserved word, as in `REPLACING ==...== BY MOVE`
  | \copy-operand-c4: NotFigurative CobwordKeywords !>> [A-Za-z0-9\-]
  ;

// figurative constants are literals (copy-operand-c3), not reserved words
syntax NotFigurative = () !>> 'ZERO' !>> 'SPACE' !>> 'QUOTE' !>> 'NULL' !>> 'HIGH-VALUE' !>> 'LOW-VALUE';

syntax Figurative_constant
  = \figurative-constant-c2: 'ALL' Literal
  | \figurative-constant-c1: Figurative_constant_simple !>> [A-Za-z0-9\-] // a keyword ends at a word boundary: ZERO-NULL is a data name
  ;
syntax Integer = integer: Num;

syntax Paragraph_or_section_name
  = \paragraph-or-section-name-c2: Integer
  | \paragraph-or-section-name-c1: User_defined_word
  ;
syntax Alt_reel_unit
  = \alt-reel-unit-c1: 'REEL'
  | \alt-reel-unit-c2: 'UNIT'
  ;

syntax Figurative_constant_simple
  = \figurative-constant-simple-c5: 'SPACES'
  | \figurative-constant-simple-c11: 'QUOTES'
  | \figurative-constant-simple-c7: 'HIGH-VALUES'
  | \figurative-constant-simple-c12: 'NULL'
  | \figurative-constant-simple-c3: 'ZEROES'
  | \figurative-constant-simple-c8: 'LOW-VALUE'
  | \figurative-constant-simple-c6: 'HIGH-VALUE'
  | \figurative-constant-simple-c1: 'ZERO'
  | \figurative-constant-simple-c4: 'SPACE'
  | \figurative-constant-simple-c10: 'QUOTE'
  | \figurative-constant-simple-c9: 'LOW-VALUES'
  | \figurative-constant-simple-c2: 'ZEROS'
  | \figurative-constant-simple-c13: 'NULLS'
  ;

syntax Class_name = \class-name: Alphabetic_user_defined_word;

syntax Alt_ascending_descending
  = \alt-ascending-descending-c2: 'DESCENDING'
  | \alt-ascending-descending-c1: 'ASCENDING'
  ;

syntax Through_literal = \through-literal: Through Literal;

syntax Alt_library_name_literal
  = \alt-library-name-literal-c1: User_defined_word
  | \alt-library-name-literal-c2: Literal
  ;

syntax User_defined_word = \user-defined-word: Cobword \ CobwordKeywords;
syntax Alt_text_name_literal
  = \alt-text-name-literal-c1: User_defined_word
  | \alt-text-name-literal-c2: Literal
  ;
syntax Alphabet_name = \alphabet-name: Alphabetic_user_defined_word;

syntax Procedure_name
  = \procedure-name: Paragraph_or_section_name
  | \procedure-name: Paragraph_or_section_name In Section_name
  ;
syntax In_data_or_file_name = \in-data-or-file-name: In Alphabetic_user_defined_word;
// priorities follow COBOL-85: unary plus and minus, then exponentiation, then multiplication and division,
// then addition and subtraction; operators of equal priority are evaluated from left to right
syntax Arithmetic_expression
  = literal: Literal
  | identifier: Identifier
  | brackets: "(" Arithmetic_expression ")"
  > positive: "+" Arithmetic_expression
  | negative: "-" Arithmetic_expression
  > left power: Arithmetic_expression "**" !>> "*" Arithmetic_expression
  > left (
      times: Arithmetic_expression "*" !>> "*" Arithmetic_expression
    | dividedBy: Arithmetic_expression "/" Arithmetic_expression
    )
  > left (
      plus: Arithmetic_expression "+" Arithmetic_expression
    | minus: Arithmetic_expression "-" Arithmetic_expression
    )
  ;
syntax Computer_name = \computer-name: System_name;

syntax Literal
  = \literal-c2: Num
  | \literal-c1: Nonnumeric
  | \literal-c3: Figurative_constant
  ;

syntax File_name = \file-name: Alphabetic_user_defined_word;

syntax In_data_or_file_or_mnemonic_name = \in-data-or-file-or-mnemonic-name: In Alphabetic_user_defined_word;
syntax Alt_plus_minus
  = \alt-plus-minus-c1: "+"
  | \alt-plus-minus-c2: "-"
  ;
syntax Records
  = \records-c2: 'RECORDS'
  | \records-c1: 'RECORD'
  ;

syntax Alphabetic_user_defined_word = \alphabetic-user-defined-word: Cobword \ CobwordKeywords;

syntax Values
  = \values-c2: 'VALUES'
  | \values-c1: 'VALUE'
  ;

syntax Section_name
  = \section-name-c1: User_defined_word
  | \section-name-c2: Integer
  ;

syntax Through
  = \through-c1: 'THROUGH'
  | \through-c2: 'THRU'
  ;

syntax Literal_through_literal = \literal-through-literal: Literal Through_literal?;

syntax Copy_statement
  = \copy-statement: 'COPY' Alt_text_name_literal 'SUPPRESS'? "."
  | \copy-statement: 'COPY' Alt_text_name_literal 'SUPPRESS'? 'REPLACING' Copy_statement_by_phrase+ "."
  | \copy-statement: 'COPY' Alt_text_name_literal In Alt_library_name_literal 'SUPPRESS'? "."
  | \copy-statement: 'COPY' Alt_text_name_literal In Alt_library_name_literal 'SUPPRESS'? 'REPLACING' Copy_statement_by_phrase+ "."
  ;

syntax In
  = \in-c1: 'OF'
  | \in-c2: 'IN'
  ;

syntax Priority_number = \priority-number: Num;
syntax Copy_statement_by_phrase = \copy-statement-by-phrase: Copy_operand 'BY' Copy_operand;
// a subscript does not follow a comma, so in `FUNCTION MIN(B, (C + 1) / 2)` the bracket starts the next argument
syntax Subscript_parentheses = \subscript-parentheses: "," !<< ", " !<< "(" Subscript_expression+ ")";

syntax Equal_to
  = \equal-to-c1: 'EQUAL' 'TO'?
  | \equal-to-c2: "="
  ;

syntax Program_name = \program-name: User_defined_word;