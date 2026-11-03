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
  | 'OFF'
  | 'ON'
  | 'PROGRAM'
  | 'SEGMENT-LIMIT'
  | 'SEQUENCE'
  | 'SIGN'
  | 'SIZE'
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
   \on: 'ON' 'STATUS'? 'IS'? Expression ('OFF' 'STATUS'? 'IS'? Expression)?
  |  \off: 'OFF' 'STATUS'? 'IS'? Expression ('ON' 'STATUS'? 'IS'? Expression)?
  ; 
syntax Special_names_paragraph_clause =
   decimalPoint: 'DECIMAL-POINT' 'IS'? 'COMMA' 
  |  class: 'CLASS' Id 'IS'? Literal_through_literal+ 
  |  symbolic: 'SYMBOLIC' 'CHARACTERS'? Symbolic_character_mapping+ ('IN' Id)?
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

// the clauses of SOURCE-COMPUTER and OBJECT-COMPUTER, in any order; a checker rejects the combinations COBOL does not allow
syntax Computer_clause
  = memory: 'MEMORY' 'SIZE'? Integer Memory_size_type
  | sequence: 'PROGRAM'? 'COLLATING'? 'SEQUENCE' 'IS'? Id
  | segmentLimit: 'SEGMENT-LIMIT' 'IS'? Priority_number
  | debugging: 'WITH'? 'DEBUGGING' 'MODE'
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
