module lang::vscobolii::\VSC-dd-entry 

extend lang::vscobolii::\VSC-conf-sec;
extend lang::vscobolii::\VSC-lex;
extend lang::vscobolii::\VSC-expr;


syntax Integer_to =
  \integer-to: Integer 'TO' 
  ;

syntax Picture =
  \picture-c2: 'PIC' 
  | \picture-c1: 'PICTURE' 
  ;

syntax Sign_clause =
   \sign-clause: Alt_leading_trailing
 |  \sign-clause: 'SIGN' 'IS'?  Alt_leading_trailing
 |  \sign-clause: Alt_leading_trailing 'SEPARATE' 'CHARACTER'?
 |  \sign-clause: 'SIGN' 'IS'?  Alt_leading_trailing 'SEPARATE' 'CHARACTER'? 
  ;

syntax Picture_clause =
  \picture-clause: Picture 'IS'? Picture_string 
  ;

syntax Values_are =
  \values-are: Values Are? 
  ;

syntax Zeroes =
  \zeroes-c2: 'ZEROS' 
  | \zeroes-c1: 'ZERO' 
  | \zeroes-c3: 'ZEROES' 
  ;

syntax Redefines_clause =
  \redefines-clause: 'REDEFINES' Data_name 
  ;

syntax Usage_is =
  \usage-is: 'USAGE' 'IS'? 
  ;

syntax Justified_clause =
  \justified-clause: Justified 'RIGHT'? 
  ;

syntax External_clause =
  \external-clause: 'IS'? 'EXTERNAL' 
  ;

syntax Occurs_clause_1 =
  \occurs-clause-1: 'OCCURS' Integer 'TIMES'? Occurs_clause_key* Indexed_by? 
  ;

syntax Renames_clause =
   \renames-clause: 'RENAMES' Qualified_data_name
 |  \renames-clause: 'RENAMES' Qualified_data_name Through Qualified_data_name 
  ;

syntax Synchronized_clause =
  \synchronized-clause: Synchronized Alt_left_right? 
  ;

syntax Data_description_entry =
   \data-description-entry-c1: Num Alt_data_name_filler? Data_description_entry_clause*  "."? 
  | \data-description-entry-c2: Copy_statement 
  ;

syntax Occurs_clause_2 =
  \occurs-clause-2: 'OCCURS' Integer_to? Integer 'TIMES'? 'DEPENDING' 'ON'? Qualified_data_name Occurs_clause_key* Indexed_by? 
  ;

syntax Alt_left_right =
  \alt-left-right-c1: 'LEFT' 
  | \alt-left-right-c2: 'RIGHT' 
  ;

syntax Justified =
  \justified-c1: 'JUSTIFIED' 
  | \justified-c2: 'JUST' 
  ;

syntax Data_description_entry_clauses =
  \data-description-entry-clauses: Data_description_entry_clause* 
  ;

syntax Synchronized =
  \synchronized-c1: 'SYNCHRONIZED' 
  | \synchronized-c2: 'SYNC' 
  ;

syntax Data_description_entry_clause =
  \data-description-entry-clause-c4: External_clause 
  | \data-description-entry-clause-c5: Global_clause 
  |  \data-description-entry-clause-c9: Synchronized Alt_left_right? 
  |  \data-description-entry-clause-c3: 'BLANK' 'WHEN'? Zeroes 
  |  \data-description-entry-clause-c8: Alt_leading_trailing
 |  \data-description-entry-clause-c8: 'SIGN' 'IS'?  Alt_leading_trailing
 |  \data-description-entry-clause-c8: Alt_leading_trailing 'SEPARATE' 'CHARACTER'?
 |  \data-description-entry-clause-c8: 'SIGN' 'IS'?  Alt_leading_trailing 'SEPARATE' 'CHARACTER'? 
  |  \data-description-entry-clause-c12: Values Are? Literal_through_literal+ 
  |  \data-description-entry-clause-c1: Picture 'IS'? Picture_string 
  |  \data-description-entry-clause-c2: 'REDEFINES' Data_name 
  |  \data-description-entry-clause-c10: Usage
 |  \data-description-entry-clause-c10: 'USAGE' 'IS'?  Usage 
  |  \data-description-entry-clause-c11: 'RENAMES' Qualified_data_name
 |  \data-description-entry-clause-c11: 'RENAMES' Qualified_data_name Through Qualified_data_name 
  |  \data-description-entry-clause-c6: Justified 'RIGHT'? 
  | \data-description-entry-clause-c7: Occurs_clause 
  ;

syntax Global_clause =
  \global-clause: 'IS'? 'GLOBAL' 
  ;

syntax Alt_leading_trailing =
  \alt-leading-trailing-c2: 'TRAILING' 
  | \alt-leading-trailing-c1: 'LEADING' 
  ;

syntax Separate_character =
  \separate-character: 'SEPARATE' 'CHARACTER'? 
  ;

syntax Usage_clause =
   \usage-clause: Usage
 |  \usage-clause: 'USAGE' 'IS'?  Usage 
  ;

syntax Data_description_entry_1 =
   \data-description-entry-1: Num Alt_data_name_filler? Data_description_entry_clause*  "."? 
  ;

syntax Sign_is =
  \sign-is: 'SIGN' 'IS'? 
  ;

syntax Blank_when_zero_clause =
  \blank-when-zero-clause: 'BLANK' 'WHEN'? Zeroes 
  ;

syntax Usage =
  \usage-c3: "COMP-1" 
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

syntax Condition_value_clause =
   \condition-value-clause: Values Are? Literal_through_literal+ 
  ;

syntax Indexed_by =
  \indexed-by: 'INDEXED' 'BY'? Index_name+ 
  ;

syntax Alt_data_name_filler =
  \alt-data-name-filler-c2: 'FILLER' 
  | \alt-data-name-filler-c1: Data_name 
  ;

syntax Occurs_clause =
   \occurs-clause-c1: 'OCCURS' Integer_to? Integer 'TIMES'? 'DEPENDING' 'ON'? Qualified_data_name Occurs_clause_key* Indexed_by? 
  |  \occurs-clause-c2: 'OCCURS' Integer 'TIMES'? Occurs_clause_key* Indexed_by? 
  ;

syntax Occurs_clause_key =
  \occurs-clause-key: Alt_ascending_descending 'KEY'? 'IS'? Qualified_data_name+ 
  ;
