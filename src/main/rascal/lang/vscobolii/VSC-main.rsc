module lang::vscobolii::\VSC-main 

extend lang::vscobolii::\VSC-proc-div;
extend lang::vscobolii::\VSC-id-div;
extend lang::vscobolii::\VSC-env-div;
extend lang::vscobolii::\VSC-data-div;
extend lang::vscobolii::\VSC-expr;


syntax Nested_program =
  \nested-program: Nested_cobol_source_program* "END" !>> [\- 0-9 A-Z _ a-z] "PROGRAM" !>> [\- 0-9 A-Z _ a-z] Program_name "." 
  ;

syntax Common_initial =
  \common-initial-c2: Common_initial_2 
  | \common-initial-c1: Common_initial_1 
  ;

syntax Common_initial_program =
  \common-initial-program: "IS"? Common_initial "PROGRAM"? 
  ;

syntax Nested_cobol_source_program =
  \nested-cobol-source-program: Identification "DIVISION" !>> [\- 0-9 A-Z _ a-z] "." Program_id_nested_cobol_source_program Identification_division_content? Environment_division? Data_division? Procedure_division? Nested_cobol_source_program* "END" !>> [\- 0-9 A-Z _ a-z] "PROGRAM" !>> [\- 0-9 A-Z _ a-z] Program_name "." 
  ;

syntax Program_id_nested_cobol_source_program =
  \program-id-nested-cobol-source-program: "PROGRAM-ID" !>> [\- 0-9 A-Z _ a-z] "."? Program_name Common_initial_program? "."? 
  ;

syntax Cobol_source_program =
  \cobol-source-program: Identification_division Environment_division? Data_division? Procedure_division? Nested_program? 
  ;

syntax Programs =
  programs: Cobol_source_program+ 
  ;

syntax Common_initial_2 =
  \common-initial-2: "INITIAL" !>> [\- 0-9 A-Z _ a-z] "COMMON"? 
  ;

syntax Common_initial_1 =
  \common-initial-1: "COMMON" !>> [\- 0-9 A-Z _ a-z] "INITIAL"? 
  ;
