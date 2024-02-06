 module lang::vscobolii::\VSC-conf-sec  extend lang::vscobolii::\VSC-cond;
extend lang::vscobolii::\VSC-expr; 
syntax Memory_size_type =
  \memory-size-type-c2: 'CHARACTERS' 
  | \memory-size-type-c3: 'MODULES' 
  | \memory-size-type-c1: 'WORDS' 
  ; 
syntax Are =
  \are-c2: 'IS' 
  | \are-c1: 'ARE' 
  ; 
syntax Alphabet_type_also =
  \alphabet-type-also: 'ALSO' Literal 
  ; 
syntax Special_names_paragraph_phrase =
   \special-names-paragraph-phrase: System_nameSpecial_names_paragraph_phrase_tail 
  ; 
syntax Special_names_paragraph_status_phrase =
   \special-names-paragraph-status-phrase-c1: 'ON' 'STATUS'? 'IS'? Condition Off_status? 
  |  \special-names-paragraph-status-phrase-c2: 'OFF' 'STATUS'? 'IS'? Condition On_status? 
  ; 
syntax Special_names_paragraph_clause =
   \special-names-paragraph-clause-c5: 'DECIMAL-POINT' 'IS'? 'COMMA' 
  |  \special-names-paragraph-clause-c3: 'CLASS' Class_name 'IS'? Literal_through_literal+ 
  |  \special-names-paragraph-clause-c2: 'SYMBOLIC' 'CHARACTERS'? Symbolic_character_mapping+ In_alphabet_name? 
  |  \special-names-paragraph-clause-c4: 'CURRENCY' 'SIGN'? 'IS'? Literal 
  |  \special-names-paragraph-clause-c1: 'ALPHABET' Alphabet_name 'IS'? Alphabet_type 
  ; 
syntax Alphabet_type_other =
  \alphabet-type-other: Literal Alphabet_type_also_through? 
  ; 
syntax Special_names_paragraph_phrase_tail =
   \special-names-paragraph-phrase-tail-c1: 'IS'? Mnemonic_name Special_names_paragraph_status_phrase? 
  | \special-names-paragraph-phrase-tail-c2: Special_names_paragraph_status_phrase 
  ; 
syntax Symbolic_character_mapping =
  \symbolic-character-mapping: Symbolic_character+ Are? Integer+ 
  ;

syntax Configuration_section_paragraph =
   \configuration-section-paragraph-c2: 'OBJECT-COMPUTER' "." Object_computer_name? 
  |  \configuration-section-paragraph-c1: 'SOURCE-COMPUTER' "." Source_computer_name? 
  |  \configuration-section-paragraph-c3: 'SPECIAL-NAMES' "." Special_names_paragraph_phrase* Special_names_paragraph_clauses "."? 
  ; 
syntax Alphabet_type =
  \alphabet-type-c3: 'NATIVE' 
  | \alphabet-type-c4: 'EBCDIC' 
  | \alphabet-type-c2: "STANDARD-2" 
  | \alphabet-type-c1: "STANDARD-1" 
  |  \alphabet-type-c5: Alphabet_type_other+ 
  ;

syntax Alphabet_type_also_through =
   \alphabet-type-also-through-c2: Alphabet_type_also+ 
  | \alphabet-type-also-through-c1: Through_literal 
  ;
