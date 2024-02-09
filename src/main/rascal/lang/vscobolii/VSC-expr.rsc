 module lang::vscobolii::\VSC-expr  extend lang::vscobolii::\VSC-lex;


syntax Identifier =
   \identifier-c2: 'LINAGE-COUNTER'
 |  \identifier-c2: 'LINAGE-COUNTER' In File_name 
  |  \identifier-c1: Qualified_data_name Subscript_parentheses*
 |  \identifier-c1: Qualified_data_name Subscript_parentheses* "(" Arithmetic_expression  ":" ")"
 |  \identifier-c1: Qualified_data_name Subscript_parentheses* "(" Arithmetic_expression  ":" Arithmetic_expression  ")" 
  ; 
syntax Subscript_expression =
  \subscript-expression-c1: Literal 
  |  \subscript-expression-c2: Qualified_data_name
 |  \subscript-expression-c2: Qualified_data_name Alt_plus_minus Integer 
  ;

syntax Data_name =
  \data-name: Alphabetic_user_defined_word 
  ; 
syntax Record_name =
  \record-name: Qualified_data_name 
  ;

syntax Times_div =
  \times-div: Power Times_div_tail* 
  ;

syntax Index_name =
  \index-name: Alphabetic_user_defined_word 
  ; 
syntax System_name =
  \system-name: Cobword \ CobwordKeywords 
  ; 
syntax Qualified_data_name =
   \qualified-data-name-c3: 'LENGTH' 'OF' Identifier 
  |  \qualified-data-name-c2: 'ADDRESS' 'OF' Data_name 
  |  \qualified-data-name-c1: Data_name In_data_or_file_name* 
  ;

syntax Assignment_name =
  \assignment-name: System_name 
  ;

syntax Symbolic_character =
  \symbolic-character: Alphabetic_user_defined_word 
  ; 
syntax Paragraph_name =
  \paragraph-name-c1: User_defined_word 
  | \paragraph-name-c2: Integer 
  ; 
syntax Copy_operand =
  \copy-operand-c3: Literal 
  | \copy-operand-c2: Identifier 
  | \copy-operand-c1: Quoted_pseudo_text 
  ;

syntax Figurative_constant =
   \figurative-constant-c2: 'ALL' Literal 
  | \figurative-constant-c1: Figurative_constant_simple 
  ; 
syntax Integer =
  integer: Num 
  ;

syntax Basis =
  \basis-c1: Literal 
  | \basis-c2: Identifier 
  |  \basis-c3: "(" Arithmetic_expression ")" 
  ;

syntax Paragraph_or_section_name =
  \paragraph-or-section-name-c2: Integer 
  | \paragraph-or-section-name-c1: User_defined_word 
  ; 
syntax Alt_reel_unit =
  \alt-reel-unit-c1: 'REEL' 
  | \alt-reel-unit-c2: 'UNIT' 
  ;

syntax Figurative_constant_simple =
  \figurative-constant-simple-c5: 'SPACES' 
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

syntax Class_name =
  \class-name: Alphabetic_user_defined_word 
  ;

syntax Alt_ascending_descending =
  \alt-ascending-descending-c2: 'DESCENDING' 
  | \alt-ascending-descending-c1: 'ASCENDING' 
  ;

syntax Through_literal =
  \through-literal: Through Literal 
  ;

syntax Alt_library_name_literal =
   \alt-library-name-literal-c1: User_defined_word 
  | \alt-library-name-literal-c2: Literal 
  ;

syntax User_defined_word =
  \user-defined-word: Cobword \ CobwordKeywords 
  ; 
syntax Alt_text_name_literal =
   \alt-text-name-literal-c1: User_defined_word 
  | \alt-text-name-literal-c2: Literal 
  ; 
syntax Times_div_tail =
  \times-div-tail: Alt_times_div Power 
  ;

syntax Alphabet_name =
  \alphabet-name: Alphabetic_user_defined_word 
  ;

syntax Procedure_name =
   \procedure-name: Paragraph_or_section_name
 |  \procedure-name: Paragraph_or_section_name In Section_name 
  ; 
syntax Power_tail =
  \power-tail: "**" Basis 
  ; 
syntax In_data_or_file_name =
   \in-data-or-file-name: In Alphabetic_user_defined_word 
  ; 
syntax Arithmetic_expression =
  \arithmetic-expression: Times_div Arithmetic_expression_tail* 
  ; 
syntax Computer_name =
  \computer-name: System_name 
  ;

syntax Literal =
   \literal-c2: Num 
  | \literal-c1: Nonnumeric 
  | \literal-c3: Figurative_constant 
  ;

syntax File_name =
  \file-name: Alphabetic_user_defined_word 
  ;

syntax In_data_or_file_or_mnemonic_name =
   \in-data-or-file-or-mnemonic-name: In Alphabetic_user_defined_word 
  ; 
syntax Alt_plus_minus =
  \alt-plus-minus-c1: "+" 
  | \alt-plus-minus-c2: [a-zA-Z] !<< "-" !>> [a-zA-Z]
  ; 
syntax Records =
  \records-c2: 'RECORDS' 
  | \records-c1: 'RECORD' 
  ;

syntax Alphabetic_user_defined_word =
  \alphabetic-user-defined-word: Cobword \ CobwordKeywords 
  ;

syntax Values =
  \values-c2: 'VALUES' 
  | \values-c1: 'VALUE' 
  ;

syntax Arithmetic_expression_tail =
  \arithmetic-expression-tail: Alt_plus_minus Times_div 
  ;

syntax Alt_times_div =
  \alt-times-div-c1: "*" 
  | \alt-times-div-c2: "/" 
  ;

syntax Section_name =
  \section-name-c1: User_defined_word 
  | \section-name-c2: Integer 
  ;

syntax Through =
  \through-c1: 'THROUGH' 
  | \through-c2: 'THRU' 
  ;

syntax Literal_through_literal =
  \literal-through-literal: Literal Through_literal? 
  ;

syntax Power =
  power: Alt_plus_minus? Basis Power_tail* 
  ;

syntax Copy_statement =
   \copy-statement: 'COPY' Alt_text_name_literal 'SUPPRESS'? "."
 |  \copy-statement: 'COPY' Alt_text_name_literal 'SUPPRESS'? 'REPLACING' Copy_statement_by_phrase+  "."
 |  \copy-statement: 'COPY' Alt_text_name_literal In Alt_library_name_literal  'SUPPRESS'? "."
 |  \copy-statement: 'COPY' Alt_text_name_literal In Alt_library_name_literal  'SUPPRESS'? 'REPLACING' Copy_statement_by_phrase+  "." 
  ;

syntax In =
  \in-c1: 'OF' 
  | \in-c2: 'IN' 
  ;

syntax Priority_number =
  \priority-number: Num 
  ; 
syntax Copy_statement_by_phrase =
  \copy-statement-by-phrase: Copy_operand 'BY' Copy_operand 
  ; 
syntax Subscript_parentheses =
   \subscript-parentheses: "(" Subscript_expression+  ")" 
  ;

syntax Equal_to =
   \equal-to-c1: 'EQUAL' 'TO'? 
  | \equal-to-c2: "=" 
  ;

syntax Program_name =
  \program-name: User_defined_word 
  ;
