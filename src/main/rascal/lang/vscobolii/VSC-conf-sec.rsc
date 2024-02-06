module lang::vscobolii::\VSC-conf-sec 

extend lang::vscobolii::\VSC-cond;
extend lang::vscobolii::\VSC-expr;


syntax Alphabet_clause =
  \alphabet-clause: 'ALPHABET' Alphabet_name 'IS'? Alphabet_type 
  ;

syntax Memory_size_type =
  \memory-size-type-c2: 'CHARACTERS' 
  | \memory-size-type-c3: 'MODULES' 
  | \memory-size-type-c1: 'WORDS' 
  ;

syntax Memory_size =
  \memory-size: 'MEMORY' 'SIZE'? Integer Memory_size_type 
  ;

syntax Special_names_paragraph =
   \special-names-paragraph: 'SPECIAL-NAMES' "." Special_names_paragraph_phrase* Special_names_paragraph_clause*  "."? 
  ;

syntax On_status =
  \on-status: 'ON' 'STATUS'? 'IS'? Condition 
  ;

syntax Are =
  \are-c2: 'IS' 
  | \are-c1: 'ARE' 
  ;

syntax With_debugging_mode =
  \with-debugging-mode: 'WITH'? 'DEBUGGING' 'MODE' 
  ;

syntax Decimal_point_clause =
  \decimal-point-clause: 'DECIMAL-POINT' 'IS'? 'COMMA' 
  ;

syntax Source_computer_paragraph =
   \source-computer-paragraph: 'SOURCE-COMPUTER' "."
 |  \source-computer-paragraph: 'SOURCE-COMPUTER' "." Computer_name "."
 |  \source-computer-paragraph: 'SOURCE-COMPUTER' "." Computer_name 'WITH'? 'DEBUGGING' 'MODE'  "." 
  ;

syntax Alphabet_type_also =
  \alphabet-type-also: 'ALSO' Literal 
  ;

syntax Currency_sign_clause =
  \currency-sign-clause: 'CURRENCY' 'SIGN'? 'IS'? Literal 
  ;

syntax Special_names_paragraph_phrase =
   \special-names-paragraph-phrase: System_name Special_names_paragraph_phrase_tail 
  ;

syntax Program_collating_sequence =
  \program-collating-sequence: 'PROGRAM'? 'COLLATING'? 'SEQUENCE' 'IS'? Alphabet_name 
  ;

syntax Special_names_paragraph_status_phrase =
   \special-names-paragraph-status-phrase-c1: 'ON' 'STATUS'? 'IS'? Condition
 |  \special-names-paragraph-status-phrase-c1: 'ON' 'STATUS'? 'IS'? Condition 'OFF' 'STATUS'? 'IS'? Condition 
  |  \special-names-paragraph-status-phrase-c2: 'OFF' 'STATUS'? 'IS'? Condition
 |  \special-names-paragraph-status-phrase-c2: 'OFF' 'STATUS'? 'IS'? Condition 'ON' 'STATUS'? 'IS'? Condition 
  ;

syntax In_alphabet_name =
  \in-alphabet-name: 'IN' Alphabet_name 
  ;

syntax Special_names_paragraph_clause =
   \special-names-paragraph-clause-c5: 'DECIMAL-POINT' 'IS'? 'COMMA' 
  |  \special-names-paragraph-clause-c3: 'CLASS' Class_name 'IS'? Literal_through_literal+ 
  |  \special-names-paragraph-clause-c2: 'SYMBOLIC' 'CHARACTERS'? Symbolic_character_mapping+
 |  \special-names-paragraph-clause-c2: 'SYMBOLIC' 'CHARACTERS'? Symbolic_character_mapping+ 'IN' Alphabet_name 
  |  \special-names-paragraph-clause-c4: 'CURRENCY' 'SIGN'? 'IS'? Literal 
  |  \special-names-paragraph-clause-c1: 'ALPHABET' Alphabet_name 'IS'? Alphabet_type 
  ;

syntax Configuration_section =
   \configuration-section: 'CONFIGURATION' 'SECTION' "." Configuration_section_paragraph* 
  ;

syntax Alphabet_type_others =
  \alphabet-type-others: Alphabet_type_other+ 
  ;

syntax Alphabet_type_alsos =
  \alphabet-type-alsos: Alphabet_type_also+ 
  ;

syntax Is_mnemonic_name =
   \is-mnemonic-name: 'IS'? Alphabetic_user_defined_word  Special_names_paragraph_status_phrase? 
  ;

syntax Alphabet_type_other =
  \alphabet-type-other: Literal Alphabet_type_also_through? 
  ;

syntax Symbolic_characters_clause =
   \symbolic-characters-clause: 'SYMBOLIC' 'CHARACTERS'? Symbolic_character_mapping+
 |  \symbolic-characters-clause: 'SYMBOLIC' 'CHARACTERS'? Symbolic_character_mapping+ 'IN' Alphabet_name 
  ;

syntax Class_clause =
  \class-clause: 'CLASS' Class_name 'IS'? Literal_through_literal+ 
  ;

syntax Special_names_paragraph_clauses =
  \special-names-paragraph-clauses: Special_names_paragraph_clause* 
  ;

syntax Special_names_paragraph_phrase_tail =
   \special-names-paragraph-phrase-tail-c1: 'IS'? Alphabetic_user_defined_word  Special_names_paragraph_status_phrase? 
  | \special-names-paragraph-phrase-tail-c2: Special_names_paragraph_status_phrase 
  ;

syntax Configuration_section_paragraphs =
  \configuration-section-paragraphs: Configuration_section_paragraph* 
  ;

syntax Special_names_paragraph_status_phrase_2 =
   \special-names-paragraph-status-phrase-2: 'OFF' 'STATUS'? 'IS'? Condition
 |  \special-names-paragraph-status-phrase-2: 'OFF' 'STATUS'? 'IS'? Condition 'ON' 'STATUS'? 'IS'? Condition 
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

syntax Source_computer_name =
   \source-computer-name: Computer_name "."
 |  \source-computer-name: Computer_name 'WITH'? 'DEBUGGING' 'MODE'  "." 
  ;

syntax Special_names_paragraph_status_phrase_1 =
   \special-names-paragraph-status-phrase-1: 'ON' 'STATUS'? 'IS'? Condition
 |  \special-names-paragraph-status-phrase-1: 'ON' 'STATUS'? 'IS'? Condition 'OFF' 'STATUS'? 'IS'? Condition 
  ;

syntax Object_computer_paragraph =
   \object-computer-paragraph: 'OBJECT-COMPUTER' "."
 |  \object-computer-paragraph: 'OBJECT-COMPUTER' "." Computer_name "."
 |  \object-computer-paragraph: 'OBJECT-COMPUTER' "." Computer_name 'SEGMENT-LIMIT' 'IS'? Priority_number  "."
 |  \object-computer-paragraph: 'OBJECT-COMPUTER' "." Computer_name 'PROGRAM'? 'COLLATING'? 'SEQUENCE' 'IS'? Alphabet_name "."
 |  \object-computer-paragraph: 'OBJECT-COMPUTER' "." Computer_name 'PROGRAM'? 'COLLATING'? 'SEQUENCE' 'IS'? Alphabet_name 'SEGMENT-LIMIT' 'IS'? Priority_number  "."
 |  \object-computer-paragraph: 'OBJECT-COMPUTER' "." Computer_name 'MEMORY' 'SIZE'? Integer Memory_size_type "."
 |  \object-computer-paragraph: 'OBJECT-COMPUTER' "." Computer_name 'MEMORY' 'SIZE'? Integer Memory_size_type 'SEGMENT-LIMIT' 'IS'? Priority_number  "."
 |  \object-computer-paragraph: 'OBJECT-COMPUTER' "." Computer_name 'MEMORY' 'SIZE'? Integer Memory_size_type 'PROGRAM'? 'COLLATING'? 'SEQUENCE' 'IS'? Alphabet_name "."
 |  \object-computer-paragraph: 'OBJECT-COMPUTER' "." Computer_name 'MEMORY' 'SIZE'? Integer Memory_size_type 'PROGRAM'? 'COLLATING'? 'SEQUENCE' 'IS'? Alphabet_name 'SEGMENT-LIMIT' 'IS'? Priority_number  "." 
  ;

syntax Segment_limit =
  \segment-limit: 'SEGMENT-LIMIT' 'IS'? Priority_number 
  ;

syntax Object_computer_name =
   \object-computer-name: Computer_name "."
 |  \object-computer-name: Computer_name 'SEGMENT-LIMIT' 'IS'? Priority_number  "."
 |  \object-computer-name: Computer_name 'PROGRAM'? 'COLLATING'? 'SEQUENCE' 'IS'? Alphabet_name "."
 |  \object-computer-name: Computer_name 'PROGRAM'? 'COLLATING'? 'SEQUENCE' 'IS'? Alphabet_name 'SEGMENT-LIMIT' 'IS'? Priority_number  "."
 |  \object-computer-name: Computer_name 'MEMORY' 'SIZE'? Integer Memory_size_type "."
 |  \object-computer-name: Computer_name 'MEMORY' 'SIZE'? Integer Memory_size_type 'SEGMENT-LIMIT' 'IS'? Priority_number  "."
 |  \object-computer-name: Computer_name 'MEMORY' 'SIZE'? Integer Memory_size_type 'PROGRAM'? 'COLLATING'? 'SEQUENCE' 'IS'? Alphabet_name "."
 |  \object-computer-name: Computer_name 'MEMORY' 'SIZE'? Integer Memory_size_type 'PROGRAM'? 'COLLATING'? 'SEQUENCE' 'IS'? Alphabet_name 'SEGMENT-LIMIT' 'IS'? Priority_number  "." 
  ;

syntax Object_computer_paragraph_sequence_phrase =
   \object-computer-paragraph-sequence-phrase: 
 |  \object-computer-paragraph-sequence-phrase: 'PROGRAM'? 'COLLATING'? 'SEQUENCE' 'IS'? Alphabet_name
 |  \object-computer-paragraph-sequence-phrase: 'SEGMENT-LIMIT' 'IS'? Priority_number
 |  \object-computer-paragraph-sequence-phrase: 'PROGRAM'? 'COLLATING'? 'SEQUENCE' 'IS'? Alphabet_name  'SEGMENT-LIMIT' 'IS'? Priority_number 
  ;

syntax Off_status =
  \off-status: 'OFF' 'STATUS'? 'IS'? Condition 
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
