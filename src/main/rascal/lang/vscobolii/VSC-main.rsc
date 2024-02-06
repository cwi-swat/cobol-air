 module lang::vscobolii::\VSC-main  extend lang::vscobolii::\VSC-proc-div;
extend lang::vscobolii::\VSC-id-div;
extend lang::vscobolii::\VSC-env-div;
extend lang::vscobolii::\VSC-data-div;
extend lang::vscobolii::\VSC-expr;


syntax Nested_program =
   \nested-program: Nested_cobol_source_program* 'END' 'PROGRAM' User_defined_word  "." 
  ;

syntax Common_initial =
   \common-initial-c2: 'INITIAL' 'COMMON'? 
  |  \common-initial-c1: 'COMMON' 'INITIAL'? 
  ;

syntax Common_initial_program =
  \common-initial-program: 'IS'? Common_initial 'PROGRAM'? 
  ;

syntax Nested_cobol_source_program =
   \nested-cobol-source-program: Identification 'DIVISION' "." 'PROGRAM-ID' "."? Program_name Common_initial_program? "."?  Identification_division_content? Environment_division? Data_division? Procedure_division? Nested_cobol_source_program* 'END' 'PROGRAM' Program_name "." 
  ; 
syntax Cobol_source_program =
   \cobol-source-program: Identification 'DIVISION' "." Program_id_cobol_source_program Identification_division_content Environment_division? Data_division? Procedure_division? Nested_program? 
  ;

syntax Programs =
  programs: Cobol_source_program+ 
  ;
