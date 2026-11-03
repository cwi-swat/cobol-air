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
  | linageCounter: 'LINAGE-COUNTER' In File_name
  | qualifiedDataName: Qualified_data_name Subscript_parentheses*
  | qualifiedDataName: Qualified_data_name Subscript_parentheses* "(" Arithmetic_expression ":" ")"
  | qualifiedDataName: Qualified_data_name Subscript_parentheses* "(" Arithmetic_expression ":" Arithmetic_expression ")"
  ;
syntax Subscript_expression
  = literal: Literal
  | qualifiedDataName: Qualified_data_name
  | plus: Qualified_data_name "+" Integer
  | minus: Qualified_data_name "-" Integer
  ;

syntax Data_name = word: Alphabetic_user_defined_word;
syntax Record_name = qualifiedDataName: Qualified_data_name;

syntax Index_name = word: Alphabetic_user_defined_word;
syntax System_name = word: Cobword \ CobwordKeywords;
syntax Qualified_data_name
  = length: 'LENGTH' 'OF' Identifier
  | address: 'ADDRESS' 'OF' Data_name
  | dataName: Data_name In_data_or_file_name*
  ;

syntax Assignment_name = systemName: System_name;

syntax Symbolic_character = word: Alphabetic_user_defined_word;
syntax Paragraph_name
  = word: User_defined_word
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
  | word: User_defined_word
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

syntax Class_name = word: Alphabetic_user_defined_word;

syntax Alt_ascending_descending
  = descending: 'DESCENDING'
  | ascending: 'ASCENDING'
  ;

syntax Through_literal = through: Through Literal;

syntax Alt_library_name_literal
  = word: User_defined_word
  | literal: Literal
  ;

syntax User_defined_word = word: Cobword \ CobwordKeywords;
syntax Alt_text_name_literal
  = word: User_defined_word
  | literal: Literal
  ;
syntax Alphabet_name = word: Alphabetic_user_defined_word;

syntax Procedure_name
  = paragraphOrSectionName: Paragraph_or_section_name
  | paragraphOrSectionName: Paragraph_or_section_name In Section_name
  ;
syntax In_data_or_file_name = \in: In Alphabetic_user_defined_word;
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
syntax Computer_name = systemName: System_name;

syntax Literal
  = \num: Num
  | nonnumeric: Nonnumeric
  | figurativeConstant: Figurative_constant
  ;

syntax File_name = word: Alphabetic_user_defined_word;

syntax In_data_or_file_or_mnemonic_name = \in: In Alphabetic_user_defined_word;
syntax Records
  = records: 'RECORDS'
  | record: 'RECORD'
  ;

syntax Alphabetic_user_defined_word = word: Cobword \ CobwordKeywords;

syntax Values
  = values: 'VALUES'
  | \value: 'VALUE'
  ;

syntax Section_name
  = word: User_defined_word
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

syntax Program_name = word: User_defined_word;