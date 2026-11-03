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
  = initial: 'INITIAL' 'COMMON'?
  | common: 'COMMON' 'INITIAL'?
  ;
syntax Nested_cobol_source_program
  = programId: Identification 'DIVISION' "." 'PROGRAM-ID' "."? Id ('IS'? Common_initial 'PROGRAM'?)? "."? Replace_directive* Identification_division_content Environment_division? Data_division? Procedure_division? Nested_cobol_source_program* 'END' 'PROGRAM' Id "."
  ;
syntax Cobol_source_program
  = programId: Identification 'DIVISION' "." 'PROGRAM-ID' "."? Id ('IS'? Common_initial 'PROGRAM'?)? "."? Replace_directive* Identification_division_content Environment_division? Data_division? Procedure_division? (Nested_cobol_source_program* 'END' 'PROGRAM' Id ".")?
  ;