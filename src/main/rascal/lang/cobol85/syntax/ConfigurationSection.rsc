 module lang::cobol85::\syntax::ConfigurationSection  extend lang::cobol85::\syntax::Condition;
extend lang::cobol85::\syntax::Expression; 

// the reserved words of this module
keyword CobwordKeywords
  = 'ALPHABET'
  | 'ALSO'
  | 'ARE'
  | 'CHARACTERS'
  | 'CLASS'
  | 'COLLATING'
  | 'COMMA'
  | 'CURRENCY'
  | 'DEBUGGING'
  | 'DECIMAL-POINT'
  | 'EBCDIC'
  | 'IN'
  | 'IS'
  | 'MEMORY'
  | 'MODE'
  | 'MODULES'
  | 'NATIVE'
  | 'OBJECT-COMPUTER'
  | 'OFF'
  | 'ON'
  | 'PROGRAM'
  | 'SEGMENT-LIMIT'
  | 'SEQUENCE'
  | 'SIGN'
  | 'SIZE'
  | 'SOURCE-COMPUTER'
  | 'SPECIAL-NAMES'
  | 'STANDARD-1'
  | 'STANDARD-2'
  | 'STATUS'
  | 'SYMBOLIC'
  | 'WITH'
  | 'WORDS'
  ;
syntax Memory_size_type =
  characters: 'CHARACTERS' 
  | modules: 'MODULES' 
  | words: 'WORDS' 
  ; 
syntax Are =
  \is: 'IS' 
  | are: 'ARE' 
  ; 
syntax Alphabet_type_also =
  also: 'ALSO' Literal 
  ; 
syntax Special_names_paragraph_phrase =
   systemName: Id Special_names_paragraph_phrase_tail 
  ; 
syntax Special_names_paragraph_status_phrase =
   \on: 'ON' 'STATUS'? 'IS'? Expression
 |  \on: 'ON' 'STATUS'? 'IS'? Expression 'OFF' 'STATUS'? 'IS'? Expression 
  |  \off: 'OFF' 'STATUS'? 'IS'? Expression
 |  \off: 'OFF' 'STATUS'? 'IS'? Expression 'ON' 'STATUS'? 'IS'? Expression 
  ; 
syntax Special_names_paragraph_clause =
   decimalPoint: 'DECIMAL-POINT' 'IS'? 'COMMA' 
  |  class: 'CLASS' Id 'IS'? Literal_through_literal+ 
  |  symbolic: 'SYMBOLIC' 'CHARACTERS'? Symbolic_character_mapping+
 |  symbolic: 'SYMBOLIC' 'CHARACTERS'? Symbolic_character_mapping+ 'IN' Id 
  |  currency: 'CURRENCY' 'SIGN'? 'IS'? Literal 
  |  alphabet: 'ALPHABET' Id 'IS'? Alphabet_type 
  ; 
syntax Alphabet_type_other =
  literal: Literal Alphabet_type_also_through? 
  ; 
syntax Special_names_paragraph_phrase_tail =
   word: 'IS'? Id  Special_names_paragraph_status_phrase? 
  | status: Special_names_paragraph_status_phrase 
  ; 
syntax Symbolic_character_mapping =
  symbolicCharacter: Id+ Are? Integer+ 
  ;

syntax Configuration_section_paragraph =
   objectComputer: 'OBJECT-COMPUTER' "."
 |  objectComputer: 'OBJECT-COMPUTER' "." Id "."
 |  objectComputer: 'OBJECT-COMPUTER' "." Id 'SEGMENT-LIMIT' 'IS'? Priority_number  "."
 |  objectComputer: 'OBJECT-COMPUTER' "." Id 'PROGRAM'? 'COLLATING'? 'SEQUENCE' 'IS'? Id "."
 |  objectComputer: 'OBJECT-COMPUTER' "." Id 'PROGRAM'? 'COLLATING'? 'SEQUENCE' 'IS'? Id 'SEGMENT-LIMIT' 'IS'? Priority_number  "."
 |  objectComputer: 'OBJECT-COMPUTER' "." Id 'MEMORY' 'SIZE'? Integer Memory_size_type "."
 |  objectComputer: 'OBJECT-COMPUTER' "." Id 'MEMORY' 'SIZE'? Integer Memory_size_type 'SEGMENT-LIMIT' 'IS'? Priority_number  "."
 |  objectComputer: 'OBJECT-COMPUTER' "." Id 'MEMORY' 'SIZE'? Integer Memory_size_type 'PROGRAM'? 'COLLATING'? 'SEQUENCE' 'IS'? Id "."
 |  objectComputer: 'OBJECT-COMPUTER' "." Id 'MEMORY' 'SIZE'? Integer Memory_size_type 'PROGRAM'? 'COLLATING'? 'SEQUENCE' 'IS'? Id 'SEGMENT-LIMIT' 'IS'? Priority_number  "." 
  |  sourceComputer: 'SOURCE-COMPUTER' "."
 |  sourceComputer: 'SOURCE-COMPUTER' "." Id "."
 |  sourceComputer: 'SOURCE-COMPUTER' "." Id 'WITH'? 'DEBUGGING' 'MODE'  "." 
  |  specialNames: 'SPECIAL-NAMES' "." Special_names_paragraph_phrase* Special_names_paragraph_clause*  "."? 
  // the contents of a paragraph can come from a copybook
  |  objectComputer: 'OBJECT-COMPUTER' "." Copy_statement
  |  sourceComputer: 'SOURCE-COMPUTER' "." Copy_statement
  |  specialNames: 'SPECIAL-NAMES' "." Copy_statement
  ; 
syntax Alphabet_type =
  native: 'NATIVE' 
  | ebcdic: 'EBCDIC' 
  | standard2: 'STANDARD-2' 
  | standard1: 'STANDARD-1' 
  |  alphabetTypeOther: Alphabet_type_other+ 
  ;

syntax Alphabet_type_also_through =
   alphabetTypeAlso: Alphabet_type_also+ 
  | throughLiteral: Through_literal 
  ;
