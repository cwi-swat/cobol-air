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
   \special-names-paragraph-phrase: System_name Special_names_paragraph_phrase_tail 
  ; 
syntax Special_names_paragraph_status_phrase =
   \special-names-paragraph-status-phrase-c1: 'ON' 'STATUS'? 'IS'? Condition
 |  \special-names-paragraph-status-phrase-c1: 'ON' 'STATUS'? 'IS'? Condition 'OFF' 'STATUS'? 'IS'? Condition 
  |  \special-names-paragraph-status-phrase-c2: 'OFF' 'STATUS'? 'IS'? Condition
 |  \special-names-paragraph-status-phrase-c2: 'OFF' 'STATUS'? 'IS'? Condition 'ON' 'STATUS'? 'IS'? Condition 
  ; 
syntax Special_names_paragraph_clause =
   \special-names-paragraph-clause-c5: 'DECIMAL-POINT' 'IS'? 'COMMA' 
  |  \special-names-paragraph-clause-c3: 'CLASS' Class_name 'IS'? Literal_through_literal+ 
  |  \special-names-paragraph-clause-c2: 'SYMBOLIC' 'CHARACTERS'? Symbolic_character_mapping+
 |  \special-names-paragraph-clause-c2: 'SYMBOLIC' 'CHARACTERS'? Symbolic_character_mapping+ 'IN' Alphabet_name 
  |  \special-names-paragraph-clause-c4: 'CURRENCY' 'SIGN'? 'IS'? Literal 
  |  \special-names-paragraph-clause-c1: 'ALPHABET' Alphabet_name 'IS'? Alphabet_type 
  ; 
syntax Alphabet_type_other =
  \alphabet-type-other: Literal Alphabet_type_also_through? 
  ; 
syntax Special_names_paragraph_phrase_tail =
   \special-names-paragraph-phrase-tail-c1: 'IS'? Alphabetic_user_defined_word  Special_names_paragraph_status_phrase? 
  | \special-names-paragraph-phrase-tail-c2: Special_names_paragraph_status_phrase 
  ; 
syntax Symbolic_character_mapping =
  \symbolic-character-mapping: Symbolic_character+ Are? Integer+ 
  ;

syntax Configuration_section_paragraph =
   \configuration-section-paragraph-c2: 'OBJECT-COMPUTER' "."
 |  \configuration-section-paragraph-c2: 'OBJECT-COMPUTER' "." Computer_name "."
 |  \configuration-section-paragraph-c2: 'OBJECT-COMPUTER' "." Computer_name 'SEGMENT-LIMIT' 'IS'? Priority_number  "."
 |  \configuration-section-paragraph-c2: 'OBJECT-COMPUTER' "." Computer_name 'PROGRAM'? 'COLLATING'? 'SEQUENCE' 'IS'? Alphabet_name "."
 |  \configuration-section-paragraph-c2: 'OBJECT-COMPUTER' "." Computer_name 'PROGRAM'? 'COLLATING'? 'SEQUENCE' 'IS'? Alphabet_name 'SEGMENT-LIMIT' 'IS'? Priority_number  "."
 |  \configuration-section-paragraph-c2: 'OBJECT-COMPUTER' "." Computer_name 'MEMORY' 'SIZE'? Integer Memory_size_type "."
 |  \configuration-section-paragraph-c2: 'OBJECT-COMPUTER' "." Computer_name 'MEMORY' 'SIZE'? Integer Memory_size_type 'SEGMENT-LIMIT' 'IS'? Priority_number  "."
 |  \configuration-section-paragraph-c2: 'OBJECT-COMPUTER' "." Computer_name 'MEMORY' 'SIZE'? Integer Memory_size_type 'PROGRAM'? 'COLLATING'? 'SEQUENCE' 'IS'? Alphabet_name "."
 |  \configuration-section-paragraph-c2: 'OBJECT-COMPUTER' "." Computer_name 'MEMORY' 'SIZE'? Integer Memory_size_type 'PROGRAM'? 'COLLATING'? 'SEQUENCE' 'IS'? Alphabet_name 'SEGMENT-LIMIT' 'IS'? Priority_number  "." 
  |  \configuration-section-paragraph-c1: 'SOURCE-COMPUTER' "."
 |  \configuration-section-paragraph-c1: 'SOURCE-COMPUTER' "." Computer_name "."
 |  \configuration-section-paragraph-c1: 'SOURCE-COMPUTER' "." Computer_name 'WITH'? 'DEBUGGING' 'MODE'  "." 
  |  \configuration-section-paragraph-c3: 'SPECIAL-NAMES' "." Special_names_paragraph_phrase* Special_names_paragraph_clause*  "."? 
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
