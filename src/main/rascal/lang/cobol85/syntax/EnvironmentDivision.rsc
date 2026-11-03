 module lang::cobol85::\syntax::EnvironmentDivision  extend lang::cobol85::\syntax::ConfigurationSection;
extend lang::cobol85::\syntax::InputOutputSection;

// the reserved words of this module
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
syntax Environment_division = environmentDivision: 'ENVIRONMENT' 'DIVISION' "." Environment_entry*;

syntax Environment_entry
  = configurationSection: 'CONFIGURATION' 'SECTION' "."
  // not `(Id Computer_clause* ".")?`: rascal 0.43.1-RC1 fails on that group when the list in it is empty
  | sourceComputer: 'SOURCE-COMPUTER' "." Id? Computer_clause* "."?
  | objectComputer: 'OBJECT-COMPUTER' "." Id? Computer_clause* "."?
  | specialNames: 'SPECIAL-NAMES' "." Special_names_paragraph_phrase* Special_names_paragraph_clause* "."?
  | inputOutputSection: 'INPUT-OUTPUT' 'SECTION' "."
  | fileControl: 'FILE-CONTROL' "."
  // the clauses may come in any order, also before ASSIGN (as in `SELECT SQ-FS4 RESERVE 1 ASSIGN "SEQ1.DAT"`)
  | select: 'SELECT' 'OPTIONAL'? Id Fce_phrase* 'ASSIGN' 'TO'? Alt_assignment_name_literal+ Fce_phrase* "."
  | ioControl: 'I-O-CONTROL' "."
  | ioControlEntries: Io_control_entry+ "."
  // the rest of a paragraph, of the division, or even of the program can come from a copybook
  | copy: Copy_statement
  ;

