module lang::vscobolii::\VSC-main 

extend lang::vscobolii::\VSC-proc-div;
extend lang::vscobolii::\VSC-id-div;
extend lang::vscobolii::\VSC-env-div;
extend lang::vscobolii::\VSC-data-div;
extend lang::vscobolii::\VSC-expr;


syntax Nested_program =
  \nested-program: Nested_cobol_source_program* 'END' 'PROGRAM' Program_name "." 
  ;

syntax Common_initial =
   \common-initial-c2: 'INITIAL' 'COMMON'? 
  |  \common-initial-c1: 'COMMON' 'INITIAL'? 
  ;

syntax Common_initial_program =
  \common-initial-program: 'IS'? Common_initial 'PROGRAM'? 
  ;

syntax Nested_cobol_source_program =
   \nested-cobol-source-program: Identification 'DIVISION' "." 'PROGRAM-ID' "."? Program_name "."?  Identification_division_content? Environment_division? Data_division? Procedure_division? Nested_cobol_source_program* 'END' 'PROGRAM' Program_name "."
 |  \nested-cobol-source-program: Identification 'DIVISION' "." 'PROGRAM-ID' "."? Program_name 'IS'? Common_initial 'PROGRAM'?  "."?  Identification_division_content? Environment_division? Data_division? Procedure_division? Nested_cobol_source_program* 'END' 'PROGRAM' Program_name "." 
  ;

syntax Program_id_nested_cobol_source_program =
   \program-id-nested-cobol-source-program: 'PROGRAM-ID' "."? Program_name "."?
 |  \program-id-nested-cobol-source-program: 'PROGRAM-ID' "."? Program_name 'IS'? Common_initial 'PROGRAM'?  "."? 
  ;

syntax Cobol_source_program =
   \cobol-source-program: Identification 'DIVISION' "." 'PROGRAM-ID' "."? Program_name "."?  Identification_division_content Environment_division? Data_division? Procedure_division?
 |  \cobol-source-program: Identification 'DIVISION' "." 'PROGRAM-ID' "."? Program_name "."?  Identification_division_content Environment_division? Data_division? Procedure_division? Nested_cobol_source_program* 'END' 'PROGRAM' Program_name "."
 |  \cobol-source-program: Identification 'DIVISION' "." 'PROGRAM-ID' "."? Program_name 'IS'? 'INITIAL' 'PROGRAM'?  "."?  Identification_division_content Environment_division? Data_division? Procedure_division?
 |  \cobol-source-program: Identification 'DIVISION' "." 'PROGRAM-ID' "."? Program_name 'IS'? 'INITIAL' 'PROGRAM'?  "."?  Identification_division_content Environment_division? Data_division? Procedure_division? Nested_cobol_source_program* 'END' 'PROGRAM' Program_name "." 
  ;

syntax Programs =
  programs: Cobol_source_program+ 
  ;

syntax Common_initial_2 =
  \common-initial-2: 'INITIAL' 'COMMON'? 
  ;

syntax Common_initial_1 =
  \common-initial-1: 'COMMON' 'INITIAL'? 
  ;
