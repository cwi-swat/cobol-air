module lang::vscobolii::\VSC-io-sec

extend lang::vscobolii::\VSC-fd-entry;
extend lang::vscobolii::\VSC-expr;

syntax File_name_position
  = \file-name-position: File_name
  | \file-name-position: File_name 'POSITION' Integer
  ;
syntax Record_delimiter_name
  = \record-delimiter-name-c2: Assignment_name
  | \record-delimiter-name-c1: "STANDARD-1"
  ;
syntax Record_sort
  = \record-sort-c2: 'SORT'
  | \record-sort-c1: 'RECORD'
  | \record-sort-c3: 'SORT-MERGE'
  ;
syntax Alt_indexed_relative_sequential
  = \alt-indexed-relative-sequential-c2: 'RELATIVE'
  | \alt-indexed-relative-sequential-c1: 'INDEXED'
  | \alt-indexed-relative-sequential-c3: 'SEQUENTIAL'
  ;
syntax Qsam_or_sam_or_vsam_i_o_control_entries
  = \qsam-or-sam-or-vsam-i-o-control-entries-c1: 'RERUN' 'ON' Alt_assignment_name_file_name 'EVERY'? Every_phrase 'OF'? File_name
  | \qsam-or-sam-or-vsam-i-o-control-entries-c2: 'SAME' 'RECORD'? 'AREA'? 'FOR'? File_name File_name+
  | \qsam-or-sam-or-vsam-i-o-control-entries-c4: 'APPLY' 'WRITE-ONLY' 'ON'? File_name+
  | \qsam-or-sam-or-vsam-i-o-control-entries-c3: 'MULTIPLE' 'FILE' 'TAPE'? 'CONTAINS'? File_name_position+
  ;
syntax Every_phrase
  = \every-phrase-c2: 'END' 'OF'? Alt_reel_unit
  | \every-phrase-c1: Integer 'RECORDS'
  ;
syntax Fce_phrase
  = \fce-phrase-c4: 'RECORD' 'KEY'? 'IS'? Qualified_data_name
  | \fce-phrase-c3: 'ACCESS' 'MODE'? 'IS'? Alt_sequential_random_dynamic
  | \fce-phrase-c3: 'ACCESS' 'MODE'? 'IS'? Alt_sequential_random_dynamic 'RELATIVE' 'KEY'? 'IS'? Qualified_data_name
  | \fce-phrase-c9: 'RECORD' 'DELIMITER' 'IS'? Record_delimiter_name
  | \fce-phrase-c7: 'FILE'? 'STATUS' 'IS'? Qualified_data_name Qualified_data_name?
  | \fce-phrase-c8: 'PADDING' 'CHARACTER'? 'IS'? Alt_qualified_data_name_literal
  | \fce-phrase-c2: Alt_indexed_relative_sequential
  | \fce-phrase-c2: 'ORGANIZATION' 'IS'? Alt_indexed_relative_sequential
  | \fce-phrase-c5: Password_clause
  | \fce-phrase-c6: 'ALTERNATE' 'RECORD'? 'KEY'? 'IS'? Qualified_data_name Password_clause?
  | \fce-phrase-c6: 'ALTERNATE' 'RECORD'? 'KEY'? 'IS'? Qualified_data_name Password_clause? 'WITH'? 'DUPLICATES'
  | \fce-phrase-c1: 'RESERVE' Integer Areas?
  ;
syntax Password_clause = \password-clause: 'PASSWORD' 'IS'? Data_name;
syntax Alt_assignment_name_literal
  = \alt-assignment-name-literal-c2: Literal
  | \alt-assignment-name-literal-c1: Assignment_name
  ;
syntax Alt_assignment_name_file_name
  = \alt-assignment-name-file-name-c1: Assignment_name
  | \alt-assignment-name-file-name-c2: File_name
  ;
syntax File_control_entry = \file-control-entry: 'SELECT' 'OPTIONAL'? File_name 'ASSIGN' 'TO'? Alt_assignment_name_literal+ Fce_phrase* ".";

syntax Alt_sequential_random_dynamic
  = \alt-sequential-random-dynamic-c2: 'RANDOM'
  | \alt-sequential-random-dynamic-c3: 'DYNAMIC'
  | \alt-sequential-random-dynamic-c1: 'SEQUENTIAL'
  ;

syntax Areas
  = \areas-c2: 'AREAS'
  | \areas-c1: 'AREA'
  ;
  
syntax Same_area = \same-area: 'SAME' Record_sort 'AREA'? 'FOR'? File_name File_name+;