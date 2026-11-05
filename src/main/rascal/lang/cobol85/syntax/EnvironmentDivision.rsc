module lang::cobol85::\syntax::EnvironmentDivision

extend lang::cobol85::\syntax::ConfigurationSection;
extend lang::cobol85::\syntax::InputOutputSection;

keyword CobwordKeywords
    = 'ASSIGN'
    | 'CONFIGURATION'
    | 'DIVISION'
    | 'ENVIRONMENT'
    | 'FILE-CONTROL'
    | 'I-O-CONTROL'
    | 'INPUT-OUTPUT'
    | 'OBJECT-COMPUTER'
    | 'OPTIONAL'
    | 'SECTION'
    | 'SELECT'
    | 'SOURCE-COMPUTER'
    | 'SPECIAL-NAMES'
    | 'TO'
    ;

// the sections, paragraphs and entries of the environment division, in any order; a checker rejects the orders
// COBOL does not allow. One flat list, so that a COPY statement has only one place to go.
syntax EnvironmentDivision = environmentDivision: 'ENVIRONMENT' 'DIVISION' "." EnvironmentEntry*;

syntax EnvironmentEntry
    = configurationSection: 'CONFIGURATION' 'SECTION' "."
    // not `(Id Computer_clause* ".")?`: rascal 0.43.1-RC1 fails on that group when the list in it is empty
    | sourceComputer: 'SOURCE-COMPUTER' "." Id? ComputerClause* "."?
    | objectComputer: 'OBJECT-COMPUTER' "." Id? ComputerClause* "."?
    | specialNames: 'SPECIAL-NAMES' "." SpecialNamesParagraphPhrase* SpecialNamesParagraphClause* "."?
    | inputOutputSection: 'INPUT-OUTPUT' 'SECTION' "."
    | fileControl: 'FILE-CONTROL' "."
    // the clauses may come in any order, also before ASSIGN (as in `SELECT SQ-FS4 RESERVE 1 ASSIGN "SEQ1.DAT"`)
    | select: 'SELECT' 'OPTIONAL'? Id FileControlClause* 'ASSIGN' 'TO'? AltAssignmentNameLiteral+ FileControlClause* "."
    | ioControl: 'I-O-CONTROL' "."
    | ioControlEntries: IoControlEntry+ "."
    // the rest of a paragraph, of the division, or even of the program can come from a copybook
    | copy: CopyStatement
    ;
