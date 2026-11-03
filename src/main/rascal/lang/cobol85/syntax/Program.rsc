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
syntax CommonInitial
    = initial: 'INITIAL' 'COMMON'?
    | common: 'COMMON' 'INITIAL'?
    ;

syntax NestedCobolSourceProgram = programId: Identification 'DIVISION' "." 'PROGRAM-ID' "."? Id ('IS'? CommonInitial 'PROGRAM'?)? "."? ReplaceDirective* IdentificationDivisionContent EnvironmentDivision? DataDivision? ProcedureDivision? NestedCobolSourceProgram* 'END' 'PROGRAM' Id ".";

syntax CobolSourceProgram = programId: Identification 'DIVISION' "." 'PROGRAM-ID' "."? Id ('IS'? CommonInitial 'PROGRAM'?)? "."? ReplaceDirective* IdentificationDivisionContent EnvironmentDivision? DataDivision? ProcedureDivision? (NestedCobolSourceProgram* 'END' 'PROGRAM' Id ".")?;
