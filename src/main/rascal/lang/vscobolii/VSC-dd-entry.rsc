module lang::vscobolii::\VSC-dd-entry

extend lang::vscobolii::\VSC-conf-sec;
extend lang::vscobolii::\VSC-lex;
extend lang::vscobolii::\VSC-expr;

syntax Integer_to = \integer-to: Integer 'TO';

syntax Picture
  = \picture-c2: 'PIC'
  | \picture-c1: 'PICTURE'
  ;
syntax Zeroes
  = \zeroes-c2: 'ZEROS'
  | \zeroes-c1: 'ZERO'
  | \zeroes-c3: 'ZEROES'
  ;
syntax External_clause = \external-clause: 'IS'? 'EXTERNAL';
syntax Data_description_entry
  = // the follow restriction ensures that digits are eaten up by picture strings.
   \data-description-entry-c1: Nat !>> [.,] Alt_data_name_filler? Data_description_entry_clause* "."?
  | \data-description-entry-c2: Copy_statement
  | \data-description-entry-c3: Replace_directive
  ;
syntax Alt_left_right
  = \alt-left-right-c1: 'LEFT'
  | \alt-left-right-c2: 'RIGHT'
  ;

syntax Justified
  = \justified-c1: 'JUSTIFIED'
  | \justified-c2: 'JUST'
  ;
syntax Synchronized
  = \synchronized-c1: 'SYNCHRONIZED'
  | \synchronized-c2: 'SYNC'
  ;

syntax Data_description_entry_clause
  = \data-description-entry-clause-c4: External_clause
  | \data-description-entry-clause-c5: Global_clause
  | \data-description-entry-clause-c9: Synchronized Alt_left_right?
  | \data-description-entry-clause-c3: 'BLANK' 'WHEN'? Zeroes
  | \data-description-entry-clause-c8: Alt_leading_trailing
  | \data-description-entry-clause-c8: 'SIGN' 'IS'? Alt_leading_trailing
  | \data-description-entry-clause-c8: Alt_leading_trailing 'SEPARATE' 'CHARACTER'?
  | \data-description-entry-clause-c8: 'SIGN' 'IS'? Alt_leading_trailing 'SEPARATE' 'CHARACTER'?
  | \data-description-entry-clause-c12: Values Are? Literal_through_literal+
  | \data-description-entry-clause-c1: Picture 'IS'? Picture_string
  | \data-description-entry-clause-c2: 'REDEFINES' Data_name
  | \data-description-entry-clause-c10: Usage
  | \data-description-entry-clause-c10: 'USAGE' 'IS'? Usage
  | \data-description-entry-clause-c11: 'RENAMES' Qualified_data_name
  | \data-description-entry-clause-c11: 'RENAMES' Qualified_data_name Through Qualified_data_name
  | \data-description-entry-clause-c6: Justified 'RIGHT'?
  | \data-description-entry-clause-c7: Occurs_clause
  ;

syntax Global_clause = \global-clause: 'IS'? 'GLOBAL';

syntax Alt_leading_trailing
  = \alt-leading-trailing-c2: 'TRAILING'
  | \alt-leading-trailing-c1: 'LEADING'
  ;
syntax Usage
  = \usage-c3: "COMP-1"
  | \usage-c12: 'DISPLAY'
  | \usage-c14: 'INDEX'
  | \usage-c5: "COMP-3"
  | \usage-c4: "COMP-2"
  | \usage-c16: 'POINTER'
  | \usage-c11: "COMPUTATIONAL-4"
  | \usage-c8: "COMPUTATIONAL-1"
  | \usage-c9: "COMPUTATIONAL-2"
  | \usage-c1: 'BINARY'
  | \usage-c15: 'PACKED-DECIMAL'
  | \usage-c2: 'COMP'
  | \usage-c7: 'COMPUTATIONAL'
  | \usage-c6: "COMP-4"
  | \usage-c13: "DISPLAY-1"
  | \usage-c10: "COMPUTATIONAL-3"
  ;
syntax Indexed_by = \indexed-by: 'INDEXED' 'BY'? Index_name+;

syntax Alt_data_name_filler
  = \alt-data-name-filler-c2: 'FILLER'
  | \alt-data-name-filler-c1: Data_name
  ;

syntax Occurs_clause
  = \occurs-clause-c1: 'OCCURS' Integer_to? Integer 'TIMES'? 'DEPENDING' 'ON'? Qualified_data_name Occurs_clause_key* Indexed_by?
  | \occurs-clause-c2: 'OCCURS' Integer 'TIMES'? Occurs_clause_key* Indexed_by?
  ;

syntax Occurs_clause_key = \occurs-clause-key: Alt_ascending_descending 'KEY'? 'IS'? Qualified_data_name+;