module lang::vscobolii::\VSC-conf-sec 

extend lang::vscobolii::\VSC-cond;
extend lang::vscobolii::\VSC-expr;


syntax Alphabet_clause =
  \alphabet-clause: "ALPHABET" !>> [\- 0-9 A-Z _ a-z] Alphabet_name "IS"? Alphabet_type 
  ;

syntax Memory_size_type =
  \memory-size-type-c2: "CHARACTERS" !>> [\- 0-9 A-Z _ a-z] 
  | \memory-size-type-c3: "MODULES" !>> [\- 0-9 A-Z _ a-z] 
  | \memory-size-type-c1: "WORDS" !>> [\- 0-9 A-Z _ a-z] 
  ;

syntax Memory_size =
  \memory-size: "MEMORY" !>> [\- 0-9 A-Z _ a-z] "SIZE"? Integer Memory_size_type 
  ;

syntax Special_names_paragraph =
  \special-names-paragraph: "SPECIAL-NAMES" !>> [\- 0-9 A-Z _ a-z] "." Special_names_paragraph_phrase* Special_names_paragraph_clauses "."? 
  ;

syntax On_status =
  \on-status: "ON" !>> [\- 0-9 A-Z _ a-z] "STATUS"? "IS"? Condition 
  ;

syntax Are =
  \are-c2: "IS" !>> [\- 0-9 A-Z _ a-z] 
  | \are-c1: "ARE" !>> [\- 0-9 A-Z _ a-z] 
  ;

syntax With_debugging_mode =
  \with-debugging-mode: "WITH"? "DEBUGGING" !>> [\- 0-9 A-Z _ a-z] "MODE" !>> [\- 0-9 A-Z _ a-z] 
  ;

syntax Decimal_point_clause =
  \decimal-point-clause: "DECIMAL-POINT" !>> [\- 0-9 A-Z _ a-z] "IS"? "COMMA" !>> [\- 0-9 A-Z _ a-z] 
  ;

syntax Source_computer_paragraph =
  \source-computer-paragraph: "SOURCE-COMPUTER" !>> [\- 0-9 A-Z _ a-z] "." Source_computer_name? 
  ;

syntax Alphabet_type_also =
  \alphabet-type-also: "ALSO" !>> [\- 0-9 A-Z _ a-z] Literal 
  ;

syntax Currency_sign_clause =
  \currency-sign-clause: "CURRENCY" !>> [\- 0-9 A-Z _ a-z] "SIGN"? "IS"? Literal 
  ;

syntax Special_names_paragraph_phrase =
  \special-names-paragraph-phrase: Environment_name Special_names_paragraph_phrase_tail 
  ;

syntax Program_collating_sequence =
  \program-collating-sequence: "PROGRAM"? "COLLATING"? "SEQUENCE" !>> [\- 0-9 A-Z _ a-z] "IS"? Alphabet_name 
  ;

syntax Special_names_paragraph_status_phrase =
  \special-names-paragraph-status-phrase-c1: Special_names_paragraph_status_phrase_1 
  | \special-names-paragraph-status-phrase-c2: Special_names_paragraph_status_phrase_2 
  ;

syntax In_alphabet_name =
  \in-alphabet-name: "IN" !>> [\- 0-9 A-Z _ a-z] Alphabet_name 
  ;

syntax Special_names_paragraph_clause =
  \special-names-paragraph-clause-c5: Decimal_point_clause 
  | \special-names-paragraph-clause-c3: Class_clause 
  | \special-names-paragraph-clause-c2: Symbolic_characters_clause 
  | \special-names-paragraph-clause-c4: Currency_sign_clause 
  | \special-names-paragraph-clause-c1: Alphabet_clause 
  ;

syntax Configuration_section =
  \configuration-section: "CONFIGURATION" !>> [\- 0-9 A-Z _ a-z] "SECTION" !>> [\- 0-9 A-Z _ a-z] "." Configuration_section_paragraphs 
  ;

syntax Alphabet_type_others =
  \alphabet-type-others: Alphabet_type_other+ 
  ;

syntax Alphabet_type_alsos =
  \alphabet-type-alsos: Alphabet_type_also+ 
  ;

syntax Is_mnemonic_name =
  \is-mnemonic-name: "IS"? Mnemonic_name Special_names_paragraph_status_phrase? 
  ;

syntax Alphabet_type_other =
  \alphabet-type-other: Literal Alphabet_type_also_through? 
  ;

syntax Symbolic_characters_clause =
  \symbolic-characters-clause: "SYMBOLIC" !>> [\- 0-9 A-Z _ a-z] "CHARACTERS"? Symbolic_character_mapping+ In_alphabet_name? 
  ;

syntax Class_clause =
  \class-clause: "CLASS" !>> [\- 0-9 A-Z _ a-z] Class_name "IS"? Literal_through_literal+ 
  ;

syntax Special_names_paragraph_clauses =
  \special-names-paragraph-clauses: Special_names_paragraph_clause* 
  ;

syntax Special_names_paragraph_phrase_tail =
  \special-names-paragraph-phrase-tail-c1: Is_mnemonic_name 
  | \special-names-paragraph-phrase-tail-c2: Special_names_paragraph_status_phrase 
  ;

syntax Configuration_section_paragraphs =
  \configuration-section-paragraphs: Configuration_section_paragraph* 
  ;

syntax Special_names_paragraph_status_phrase_2 =
  \special-names-paragraph-status-phrase-2: "OFF" !>> [\- 0-9 A-Z _ a-z] "STATUS"? "IS"? Condition On_status? 
  ;

syntax Symbolic_character_mapping =
  \symbolic-character-mapping: Symbolic_character+ Are? Integer+ 
  ;

syntax Configuration_section_paragraph =
  \configuration-section-paragraph-c2: Object_computer_paragraph 
  | \configuration-section-paragraph-c1: Source_computer_paragraph 
  | \configuration-section-paragraph-c3: Special_names_paragraph 
  ;

syntax Source_computer_name =
  \source-computer-name: Computer_name With_debugging_mode? "." 
  ;

syntax Special_names_paragraph_status_phrase_1 =
  \special-names-paragraph-status-phrase-1: "ON" !>> [\- 0-9 A-Z _ a-z] "STATUS"? "IS"? Condition Off_status? 
  ;

syntax Object_computer_paragraph =
  \object-computer-paragraph: "OBJECT-COMPUTER" !>> [\- 0-9 A-Z _ a-z] "." Object_computer_name? 
  ;

syntax Segment_limit =
  \segment-limit: "SEGMENT-LIMIT" !>> [\- 0-9 A-Z _ a-z] "IS"? Priority_number 
  ;

syntax Object_computer_name =
  \object-computer-name: Computer_name Memory_size? Object_computer_paragraph_sequence_phrase "." 
  ;

syntax Object_computer_paragraph_sequence_phrase =
  \object-computer-paragraph-sequence-phrase: Program_collating_sequence? Segment_limit? 
  ;

syntax Off_status =
  \off-status: "OFF" !>> [\- 0-9 A-Z _ a-z] "STATUS"? "IS"? Condition 
  ;

syntax Alphabet_type =
  \alphabet-type-c3: "NATIVE" !>> [\- 0-9 A-Z _ a-z] 
  | \alphabet-type-c4: "EBCDIC" !>> [\- 0-9 A-Z _ a-z] 
  | \alphabet-type-c2: "STANDARD-2" !>> [\- 0-9 A-Z _ a-z] 
  | \alphabet-type-c1: "STANDARD-1" !>> [\- 0-9 A-Z _ a-z] 
  | \alphabet-type-c5: Alphabet_type_others 
  ;

syntax Alphabet_type_also_through =
  \alphabet-type-also-through-c2: Alphabet_type_alsos 
  | \alphabet-type-also-through-c1: Through_literal 
  ;
