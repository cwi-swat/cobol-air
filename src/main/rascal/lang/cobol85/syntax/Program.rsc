module lang::cobol85::\syntax::Program

extend lang::cobol85::\syntax::ProcedureDivision;
extend lang::cobol85::\syntax::IdentificationDivision;
extend lang::cobol85::\syntax::EnvironmentDivision;
extend lang::cobol85::\syntax::DataDivision;
extend lang::cobol85::\syntax::Expression;
extend lang::cobol85::\syntax::Functions;

// the reserved words of this module
keyword CobwordKeywords
  = 'COMMON'
  | 'DIVISION'
  | 'END'
  | 'INITIAL'
  | 'IS'
  | 'PROGRAM'
  | 'PROGRAM-ID'
  ;
syntax Common_initial
  = \common-initial-c2: 'INITIAL' 'COMMON'?
  | \common-initial-c1: 'COMMON' 'INITIAL'?
  ;
syntax Nested_cobol_source_program
  = \nested-cobol-source-program: Identification 'DIVISION' "." 'PROGRAM-ID' "."? Program_name "."? Replace_directive* Identification_division_content Environment_division? Data_division? Procedure_division? Nested_cobol_source_program* 'END' 'PROGRAM' Program_name "."
  | \nested-cobol-source-program: Identification 'DIVISION' "." 'PROGRAM-ID' "."? Program_name 'IS'? Common_initial 'PROGRAM'? "."? Replace_directive* Identification_division_content Environment_division? Data_division? Procedure_division? Nested_cobol_source_program* 'END' 'PROGRAM' Program_name "."
  ;
syntax Cobol_source_program
  = \cobol-source-program: Identification 'DIVISION' "." 'PROGRAM-ID' "."? Program_name "."? Replace_directive* Identification_division_content Environment_division? Data_division? Procedure_division?
  | \cobol-source-program: Identification 'DIVISION' "." 'PROGRAM-ID' "."? Program_name "."? Replace_directive* Identification_division_content Environment_division? Data_division? Procedure_division? Nested_cobol_source_program* 'END' 'PROGRAM' Program_name "."
  | \cobol-source-program: Identification 'DIVISION' "." 'PROGRAM-ID' "."? Program_name 'IS'? 'INITIAL' 'PROGRAM'? "."? Replace_directive* Identification_division_content Environment_division? Data_division? Procedure_division?
  | \cobol-source-program: Identification 'DIVISION' "." 'PROGRAM-ID' "."? Program_name 'IS'? 'INITIAL' 'PROGRAM'? "."? Replace_directive* Identification_division_content Environment_division? Data_division? Procedure_division? Nested_cobol_source_program* 'END' 'PROGRAM' Program_name "."
  ;