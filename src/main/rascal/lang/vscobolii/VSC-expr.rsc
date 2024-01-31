module lang::vscobolii::\VSC-expr 


extend lang::vscobolii::\VSC-lex;


syntax Identifier =
  \identifier-c2: Identifier_2 
  | \identifier-c1: Identifier_1 
  ;

syntax Subscript =
  subscript: Subscript_expression+ 
  ;

syntax Subscript_expression =
  \subscript-expression-c1: Literal 
  | \subscript-expression-c2: Subscript_expression_ambiguous 
  ;

syntax Data_name =
  \data-name: Alphabetic_user_defined_word 
  ;

syntax Through_qualified_data_name =
  \through-qualified-data-name: Through Qualified_data_name 
  ;

syntax Subscript_expression_ambiguous =
  \subscript-expression-ambiguous: Qualified_data_name Plus_minus_integer? 
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

syntax Equal_to_1 =
  \equal-to-1: "EQUAL" "TO"? 
  ;

syntax System_name =
  \system-name: Cobword \ CobwordKeywords 
  ;

syntax Identifier_1 =
  \identifier-1: Qualified_data_name Subscript_parentheses* Reference_modification? 
  ;

syntax Special_register_1 =
  \special-register-1: "ADDRESS" "OF" Data_name 
  ;

syntax Text_name =
  \text-name: User_defined_word 
  ;

syntax Qualified_data_name =
  \qualified-data-name-c3: Special_register_2 
  | \qualified-data-name-c2: Special_register_1 
  | \qualified-data-name-c1: Qualified_data_name_1 
  ;

syntax Assignment_name =
  \assignment-name: System_name 
  ;

syntax Symbolic_character =
  \symbolic-character: Alphabetic_user_defined_word 
  ;

syntax Identifier_2 =
  \identifier-2: "LINAGE-COUNTER" In_file_name? 
  ;

syntax Paragraph_name =
  \paragraph-name-c1: User_defined_word 
  | \paragraph-name-c2: Integer 
  ;

syntax Special_register_2 =
  \special-register-2: "LENGTH" "OF" Identifier 
  ;

syntax Copy_operand =
  \copy-operand-c3: Literal 
  | \copy-operand-c2: Identifier 
  | \copy-operand-c1: Quoted_pseudo_text 
  ;

syntax Figurative_constant =
  \figurative-constant-c2: Figurative_constant_all 
  | \figurative-constant-c1: Figurative_constant_simple 
  ;

syntax In_section_name =
  \in-section-name: In Section_name 
  ;

syntax Integer =
  integer: Num 
  ;

syntax Basis =
  \basis-c1: Literal 
  | \basis-c2: Identifier 
  | \basis-c3: Basis_1 
  ;

syntax Paragraph_or_section_name =
  \paragraph-or-section-name-c2: Integer 
  | \paragraph-or-section-name-c1: User_defined_word 
  ;

syntax Reference_modification =
  \reference-modification: "(" Leftmost_character_position ":" Length? ")" 
  ;

syntax Basis_1 =
  \basis-1: "(" Arithmetic_expression ")" 
  ;

syntax Through_arithmetic_expression =
  \through-arithmetic-expression: Through Arithmetic_expression 
  ;

syntax Alt_reel_unit =
  \alt-reel-unit-c1: "REEL" 
  | \alt-reel-unit-c2: "UNIT" 
  ;

syntax Figurative_constant_simple =
  \figurative-constant-simple-c5: "SPACES" 
  | \figurative-constant-simple-c11: "QUOTES" 
  | \figurative-constant-simple-c7: "HIGH-VALUES" 
  | \figurative-constant-simple-c12: "NULL" 
  | \figurative-constant-simple-c3: "ZEROES" 
  | \figurative-constant-simple-c8: "LOW-VALUE" 
  | \figurative-constant-simple-c6: "HIGH-VALUE" 
  | \figurative-constant-simple-c1: "ZERO" 
  | \figurative-constant-simple-c4: "SPACE" 
  | \figurative-constant-simple-c10: "QUOTE" 
  | \figurative-constant-simple-c9: "LOW-VALUES" 
  | \figurative-constant-simple-c2: "ZEROS" 
  | \figurative-constant-simple-c13: "NULLS" 
  ;

syntax Class_name =
  \class-name: Alphabetic_user_defined_word 
  ;

syntax Alt_ascending_descending =
  \alt-ascending-descending-c2: "DESCENDING" 
  | \alt-ascending-descending-c1: "ASCENDING" 
  ;

syntax Through_literal =
  \through-literal: Through Literal 
  ;

syntax Alt_library_name_literal =
  \alt-library-name-literal-c1: Library_name 
  | \alt-library-name-literal-c2: Literal 
  ;

syntax User_defined_word =
  \user-defined-word: Cobword \ CobwordKeywords 
  ;

syntax Leftmost_character_position =
  \leftmost-character-position: Arithmetic_expression 
  ;

syntax In_file_name =
  \in-file-name: In File_name 
  ;

syntax Alt_text_name_literal =
  \alt-text-name-literal-c1: Text_name 
  | \alt-text-name-literal-c2: Literal 
  ;

syntax Environment_name =
  \environment-name: System_name 
  ;

syntax Times_div_tail =
  \times-div-tail: Alt_times_div Power 
  ;

syntax Alphabet_name =
  \alphabet-name: Alphabetic_user_defined_word 
  ;

syntax Procedure_name =
  \procedure-name: Paragraph_or_section_name In_section_name? 
  ;

syntax Mnemonic_name =
  \mnemonic-name: Alphabetic_user_defined_word 
  ;

syntax Data_or_file_or_mnemonic_name =
  \data-or-file-or-mnemonic-name: Alphabetic_user_defined_word 
  ;

syntax Power_tail =
  \power-tail: "**" Basis 
  ;

syntax Plus_minus_integer =
  \plus-minus-integer: Alt_plus_minus Integer 
  ;

syntax In_data_or_file_name =
  \in-data-or-file-name: In Data_or_file_name 
  ;

syntax Numeric =
  numeric: Num 
  ;

syntax Arithmetic_expression =
  \arithmetic-expression: Times_div Arithmetic_expression_tail* 
  ;

syntax Condition_name =
  \condition-name: Alphabetic_user_defined_word 
  ;

syntax Library_name =
  \library-name: User_defined_word 
  ;

syntax Qualified_data_name_1 =
  \qualified-data-name-1: Data_name In_data_or_file_name* 
  ;

syntax Computer_name =
  \computer-name: System_name 
  ;

syntax Literal =
  \literal-c2: Numeric 
  | \literal-c1: Nonnumeric 
  | \literal-c3: Figurative_constant 
  ;

syntax File_name =
  \file-name: Alphabetic_user_defined_word 
  ;

syntax In_data_or_file_or_mnemonic_name =
  \in-data-or-file-or-mnemonic-name: In Data_or_file_or_mnemonic_name 
  ;

syntax In_library =
  \in-library: In Alt_library_name_literal 
  ;

syntax Alt_plus_minus =
  \alt-plus-minus-c1: "+" 
  | \alt-plus-minus-c2: "-" 
  ;

syntax Copy_statement_replacing_phrase =
  \copy-statement-replacing-phrase: "REPLACING" Copy_statement_by_phrase+ 
  ;

syntax Figurative_constant_all =
  \figurative-constant-all: "ALL" Literal 
  ;

syntax Records =
  \records-c2: "RECORDS" 
  | \records-c1: "RECORD" 
  ;

syntax Alphabetic_user_defined_word =
  \alphabetic-user-defined-word: Cobword \ CobwordKeywords 
  ;

syntax Values =
  \values-c2: "VALUES" 
  | \values-c1: "VALUE" 
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
  \through-c1: "THROUGH" 
  | \through-c2: "THRU" 
  ;

syntax Literal_through_literal =
  \literal-through-literal: Literal Through_literal? 
  ;

syntax Power =
  power: Alt_plus_minus? Basis Power_tail* 
  ;

syntax Copy_statement =
  \copy-statement: "COPY" Alt_text_name_literal In_library? "SUPPRESS"? Copy_statement_replacing_phrase? "." 
  ;

syntax In =
  \in-c1: "OF" 
  | \in-c2: "IN" 
  ;

syntax Priority_number =
  \priority-number: Num 
  ;

syntax Level_number =
  \level-number: Num 
  ;

syntax Data_or_file_name =
  \data-or-file-name: Alphabetic_user_defined_word 
  ;

syntax Copy_statement_by_phrase =
  \copy-statement-by-phrase: Copy_operand "BY" Copy_operand 
  ;

syntax Length =
  length: Arithmetic_expression 
  ;

syntax Subscript_parentheses =
  \subscript-parentheses: "(" Subscript ")" 
  ;

syntax Equal_to =
  \equal-to-c1: Equal_to_1 
  | \equal-to-c2: "=" 
  ;

syntax Program_name =
  \program-name: User_defined_word 
  ;
