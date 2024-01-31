module lang::vscobolii::\VSC-id-div 

extend lang::vscobolii::\VSC-expr;


syntax Identification_division_content =
  \identification-division-content: Identification_division_phrase* 
  ;

syntax Identification_division =
  \identification-division: Identification "DIVISION" !>> [\- 0-9 A-Z _ a-z] "." Program_id_cobol_source_program Identification_division_content 
  ;

syntax Remarks =
  remarks: "REMARKS" !>> [\- 0-9 A-Z _ a-z] "."? 
  ;

syntax Program_id_cobol_source_program =
  \program-id-cobol-source-program: "PROGRAM-ID" !>> [\- 0-9 A-Z _ a-z] "."? Program_name Initial_program? "."? 
  ;

syntax Initial_program =
  \initial-program: "IS"? "INITIAL" !>> [\- 0-9 A-Z _ a-z] "PROGRAM"? 
  ;

syntax Author =
  author: "AUTHOR" !>> [\- 0-9 A-Z _ a-z] "."? 
  ;

syntax Identification =
  \identification-c2: "ID" !>> [\- 0-9 A-Z _ a-z] 
  | \identification-c1: "IDENTIFICATION" !>> [\- 0-9 A-Z _ a-z] 
  ;

syntax Security =
  security: "SECURITY" !>> [\- 0-9 A-Z _ a-z] "."? 
  ;

syntax Date_compiled =
  \date-compiled: "DATE-COMPILED" !>> [\- 0-9 A-Z _ a-z] "."? 
  ;

syntax Date_written =
  \date-written: "DATE-WRITTEN" !>> [\- 0-9 A-Z _ a-z] "."? 
  ;

syntax Installation =
  installation: "INSTALLATION" !>> [\- 0-9 A-Z _ a-z] "."? 
  ;

syntax Identification_division_phrase =
  \identification-division-phrase-c5: Security 
  | \identification-division-phrase-c4: Date_compiled 
  | \identification-division-phrase-c1: Author 
  | \identification-division-phrase-c3: Date_written 
  | \identification-division-phrase-c6: Remarks 
  | \identification-division-phrase-c2: Installation 
  ;
