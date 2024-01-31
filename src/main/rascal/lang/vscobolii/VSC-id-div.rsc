module lang::vscobolii::\VSC-id-div 

extend lang::vscobolii::\VSC-expr;


syntax Identification_division_content =
  \identification-division-content: Identification_division_phrase* 
  ;

syntax Identification_division =
  \identification-division: Identification "DIVISION" "." Program_id_cobol_source_program Identification_division_content 
  ;

syntax Remarks =
  remarks: "REMARKS" "."? 
  ;

syntax Program_id_cobol_source_program =
  \program-id-cobol-source-program: "PROGRAM-ID" "."? Program_name Initial_program? "."? 
  ;

syntax Initial_program =
  \initial-program: "IS"? "INITIAL" "PROGRAM"? 
  ;

syntax Author =
  author: "AUTHOR" "."? 
  ;

syntax Identification =
  \identification-c2: "ID" 
  | \identification-c1: "IDENTIFICATION" 
  ;

syntax Security =
  security: "SECURITY" "."? 
  ;

syntax Date_compiled =
  \date-compiled: "DATE-COMPILED" "."? 
  ;

syntax Date_written =
  \date-written: "DATE-WRITTEN" "."? 
  ;

syntax Installation =
  installation: "INSTALLATION" "."? 
  ;

syntax Identification_division_phrase =
  \identification-division-phrase-c5: Security 
  | \identification-division-phrase-c4: Date_compiled 
  | \identification-division-phrase-c1: Author 
  | \identification-division-phrase-c3: Date_written 
  | \identification-division-phrase-c6: Remarks 
  | \identification-division-phrase-c2: Installation 
  ;
