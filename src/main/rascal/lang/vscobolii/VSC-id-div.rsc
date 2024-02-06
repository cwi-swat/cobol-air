 module lang::vscobolii::\VSC-id-div  extend lang::vscobolii::\VSC-expr;


syntax Identification_division_content =
  \identification-division-content: Identification_division_phrase* 
  ; 
syntax Initial_program =
  \initial-program: 'IS'? 'INITIAL' 'PROGRAM'? 
  ; 
syntax Identification =
  \identification-c2: 'ID' 
  | \identification-c1: 'IDENTIFICATION' 
  ; 
lexical MetaDataContentLine
   = Word \ NoIDKeyword  ![\n]* [\n]; // $ seems to trigger bug

lexical Word
  = [a-zA-Z0-9\"()\-]+ !>> [a-zA-Z0-9\"()\-];

keyword NoIDKeyword
  = 'DATE-WRITTEN'
  | 'SECURITY'
  | 'DATE-COMPILED'
  | 'REMARKS'
  | 'INSTALLATION'
  | 'AUTHOR'
  | 'ENVIRONMENT'
  | 'DATA'
  | 'PROCEDURE'
  ;

syntax Identification_division_phrase =
   \identification-division-phrase-c5: 'SECURITY' "."?  MetaDataContentLine* 
  |  \identification-division-phrase-c4: 'DATE-COMPILED' "."?  MetaDataContentLine* 
  |  \identification-division-phrase-c1: 'AUTHOR' "."?  MetaDataContentLine* 
  |  \identification-division-phrase-c3: 'DATE-WRITTEN' "."? MetaDataContentLine* 
  |  \identification-division-phrase-c6: 'REMARKS' "."? MetaDataContentLine* 
  |  \identification-division-phrase-c2: 'INSTALLATION' "."? MetaDataContentLine* 
  ;
