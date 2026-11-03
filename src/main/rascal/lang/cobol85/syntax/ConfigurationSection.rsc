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
syntax MemorySizeType =
  characters: 'CHARACTERS' 
  | modules: 'MODULES' 
  | words: 'WORDS' 
  ; 
syntax Are =
  \is: 'IS' 
  | are: 'ARE' 
  ; 
syntax AlphabetTypeAlso =
  also: 'ALSO' Literal 
  ; 
syntax SpecialNamesParagraphPhrase =
   systemName: Id SpecialNamesParagraphPhraseTail 
  ; 
syntax SpecialNamesParagraphStatusPhrase =
   \on: 'ON' 'STATUS'? 'IS'? Expression ('OFF' 'STATUS'? 'IS'? Expression)?
  |  \off: 'OFF' 'STATUS'? 'IS'? Expression ('ON' 'STATUS'? 'IS'? Expression)?
  ; 
syntax SpecialNamesParagraphClause =
   decimalPoint: 'DECIMAL-POINT' 'IS'? 'COMMA' 
  |  class: 'CLASS' Id 'IS'? LiteralThroughLiteral+ 
  |  symbolic: 'SYMBOLIC' 'CHARACTERS'? SymbolicCharacterMapping+ ('IN' Id)?
  |  currency: 'CURRENCY' 'SIGN'? 'IS'? Literal 
  |  alphabet: 'ALPHABET' Id 'IS'? AlphabetType 
  ; 
syntax AlphabetTypeOther =
  literal: Literal AlphabetTypeAlsoThrough? 
  ; 
syntax SpecialNamesParagraphPhraseTail =
   word: 'IS'? Id  SpecialNamesParagraphStatusPhrase? 
  | status: SpecialNamesParagraphStatusPhrase 
  ; 
syntax SymbolicCharacterMapping =
  symbolicCharacter: Id+ Are? Integer+ 
  ;

// the clauses of SOURCE-COMPUTER and OBJECT-COMPUTER, in any order; a checker rejects the combinations COBOL does not allow
syntax ComputerClause
  = memory: 'MEMORY' 'SIZE'? Integer MemorySizeType
  | sequence: 'PROGRAM'? 'COLLATING'? 'SEQUENCE' 'IS'? Id
  | segmentLimit: 'SEGMENT-LIMIT' 'IS'? PriorityNumber
  | debugging: 'WITH'? 'DEBUGGING' 'MODE'
  ;
syntax AlphabetType =
  native: 'NATIVE' 
  | ebcdic: 'EBCDIC' 
  | standard2: 'STANDARD-2' 
  | standard1: 'STANDARD-1' 
  |  alphabetTypeOther: AlphabetTypeOther+ 
  ;

syntax AlphabetTypeAlsoThrough =
   alphabetTypeAlso: AlphabetTypeAlso+ 
  | throughLiteral: ThroughLiteral 
  ;
