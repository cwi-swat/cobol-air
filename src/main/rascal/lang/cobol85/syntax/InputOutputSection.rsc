module lang::cobol85::\syntax::InputOutputSection

extend lang::cobol85::\syntax::FileDescriptionEntry;
extend lang::cobol85::\syntax::Expression;

// the reserved words of this module
keyword CobwordKeywords
  = 'ACCESS'
  | 'ALTERNATE'
  | 'APPLY'
  | 'AREA'
  | 'AREAS'
  | 'ASSIGN'
  | 'CHARACTER'
  | 'CONTAINS'
  | 'DELIMITER'
  | 'DUPLICATES'
  | 'DYNAMIC'
  | 'END'
  | 'EVERY'
  | 'FILE'
  | 'FOR'
  | 'INDEXED'
  | 'IS'
  | 'KEY'
  | 'MODE'
  | 'MULTIPLE'
  | 'OF'
  | 'ON'
  | 'OPTIONAL'
  | 'ORGANIZATION'
  | 'PADDING'
  | 'PASSWORD'
  | 'POSITION'
  | 'RANDOM'
  | 'RECORD'
  | 'RECORDS'
  | 'RELATIVE'
  | 'RERUN'
  | 'RESERVE'
  | 'SAME'
  | 'SELECT'
  | 'SEQUENTIAL'
  | 'SORT'
  | 'SORT-MERGE'
  | 'STANDARD-1'
  | 'STATUS'
  | 'TAPE'
  | 'TO'
  | 'WITH'
  | 'WRITE-ONLY'
  ;

syntax File_name_position
  = fileName: File_name
  | fileName: File_name 'POSITION' Integer
  ;
syntax Record_delimiter_name
  = assignmentName: Assignment_name
  | standard1: 'STANDARD-1'
  ;
syntax Record_sort
  = sort: 'SORT'
  | record: 'RECORD'
  | sortMerge: 'SORT-MERGE'
  ;
syntax Alt_indexed_relative_sequential
  = relative: 'RELATIVE'
  | indexed: 'INDEXED'
  | sequential: 'SEQUENTIAL'
  ;
syntax Qsam_or_sam_or_vsam_i_o_control_entries
  = rerun: 'RERUN' 'ON' Alt_assignment_name_file_name 'EVERY'? Every_phrase 'OF'? File_name
  // SAME SORT AREA FOR SQ-FS1 ST-FS1,
  | same: 'SAME' Record_sort? 'AREA'? 'FOR'? File_name File_name+
  | apply: 'APPLY' 'WRITE-ONLY' 'ON'? File_name+
  | multiple: 'MULTIPLE' 'FILE' 'TAPE'? 'CONTAINS'? File_name_position+
  ;
syntax Every_phrase
  = end: 'END' 'OF'? Alt_reel_unit
  | records: Integer 'RECORDS'
  ;
syntax Fce_phrase
  = record: 'RECORD' 'KEY'? 'IS'? Qualified_data_name
  | access: 'ACCESS' 'MODE'? 'IS'? Alt_sequential_random_dynamic
  | access: 'ACCESS' 'MODE'? 'IS'? Alt_sequential_random_dynamic 'RELATIVE' 'KEY'? 'IS'? Qualified_data_name
  | recordDelimiter: 'RECORD' 'DELIMITER' 'IS'? Record_delimiter_name
  | status: 'FILE'? 'STATUS' 'IS'? Qualified_data_name Qualified_data_name?
  | padding: 'PADDING' 'CHARACTER'? 'IS'? Alt_qualified_data_name_literal
  | organization: Alt_indexed_relative_sequential
  | organization: 'ORGANIZATION' 'IS'? Alt_indexed_relative_sequential
  | passwordClause: Password_clause
  | alternate: 'ALTERNATE' 'RECORD'? 'KEY'? 'IS'? Qualified_data_name Password_clause?
  | alternate: 'ALTERNATE' 'RECORD'? 'KEY'? 'IS'? Qualified_data_name Password_clause? 'WITH'? 'DUPLICATES'
  | reserve: 'RESERVE' Integer Areas?
  ;
syntax Password_clause = password: 'PASSWORD' 'IS'? Data_name;
syntax Alt_assignment_name_literal
  = literal: Literal
  | assignmentName: Assignment_name
  ;
syntax Alt_assignment_name_file_name
  = assignmentName: Assignment_name
  | fileName: File_name
  ;
syntax File_control_entry
  // the clauses may come in any order, also before ASSIGN (as in `SELECT SQ-FS4 RESERVE 1 ASSIGN "SEQ1.DAT"`)
  = select: 'SELECT' 'OPTIONAL'? File_name Fce_phrase* 'ASSIGN' 'TO'? Alt_assignment_name_literal+ Fce_phrase* "."
  | copy: Copy_statement
  ;

syntax Alt_sequential_random_dynamic
  = random: 'RANDOM'
  | \dynamic: 'DYNAMIC'
  | sequential: 'SEQUENTIAL'
  ;

syntax Areas
  = areas: 'AREAS'
  | area: 'AREA'
  ;
  
syntax Same_area = same: 'SAME' Record_sort 'AREA'? 'FOR'? File_name File_name+;