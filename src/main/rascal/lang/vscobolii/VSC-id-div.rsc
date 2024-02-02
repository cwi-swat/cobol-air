module lang::vscobolii::\VSC-id-div 

extend lang::vscobolii::\VSC-expr;


syntax Identification_division_content =
  \identification-division-content: Identification_division_phrase* 
  ;

syntax Identification_division =
  \identification-division: Identification 'DIVISION' "." Program_id_cobol_source_program Identification_division_content 
  ;

syntax Remarks =
  remarks: 'REMARKS' "."? MetaDataContentLine*
  ;

syntax Program_id_cobol_source_program =
  \program-id-cobol-source-program: 'PROGRAM-ID' "."? Program_name Initial_program? "."? 
  ;

syntax Initial_program =
  \initial-program: 'IS'? 'INITIAL' 'PROGRAM'? 
  ;

syntax Author =
  author: 'AUTHOR' "."?  MetaDataContentLine*
  ;

syntax Identification =
  \identification-c2: 'ID' 
  | \identification-c1: 'IDENTIFICATION' 
  ;

syntax Security =
  security: 'SECURITY' "."?  MetaDataContentLine*
  ;

syntax Date_compiled =
  \date-compiled: 'DATE-COMPILED' "."?  MetaDataContentLine*
  ;

syntax Date_written =
  \date-written: 'DATE-WRITTEN' "."? MetaDataContentLine*
  ;

syntax Installation =
  installation: 'INSTALLATION' "."? MetaDataContentLine*
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
  \identification-division-phrase-c5: Security 
  | \identification-division-phrase-c4: Date_compiled 
  | \identification-division-phrase-c1: Author 
  | \identification-division-phrase-c3: Date_written 
  | \identification-division-phrase-c6: Remarks 
  | \identification-division-phrase-c2: Installation 
  ;
