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
  | 'SEQUENTIAL'
  | 'SORT'
  | 'SORT-MERGE'
  | 'STANDARD-1'
  | 'STATUS'
  | 'TAPE'
  | 'WITH'
  | 'WRITE-ONLY'
  ;

syntax File_name_position = fileName: Id ('POSITION' Integer)?;
syntax Record_delimiter_name
  = assignmentName: Id
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
// the entries of the I-O-CONTROL paragraph
syntax Io_control_entry
  = rerun: 'RERUN' 'ON' Id ('EVERY'? Every_phrase 'OF'? Id)?
  // SAME SORT AREA FOR SQ-FS1 ST-FS1,
  | same: 'SAME' Record_sort? 'AREA'? 'FOR'? Id Id+
  | apply: 'APPLY' 'WRITE-ONLY' 'ON'? Id+
  | multiple: 'MULTIPLE' 'FILE' 'TAPE'? 'CONTAINS'? File_name_position+
  ;
syntax Every_phrase
  = end: 'END' 'OF'? Alt_reel_unit
  | records: Integer 'RECORDS'
  ;
syntax Fce_phrase
  = record: 'RECORD' 'KEY'? 'IS'? Qualified_data_name
  | access: 'ACCESS' 'MODE'? 'IS'? Alt_sequential_random_dynamic
  | relativeKey: 'RELATIVE' 'KEY'? 'IS'? Qualified_data_name
  | recordDelimiter: 'RECORD' 'DELIMITER' 'IS'? Record_delimiter_name
  | status: 'FILE'? 'STATUS' 'IS'? Qualified_data_name Qualified_data_name?
  | padding: 'PADDING' 'CHARACTER'? 'IS'? Alt_qualified_data_name_literal
  | organization: 'ORGANIZATION'? 'IS'? Alt_indexed_relative_sequential
  | passwordClause: Password_clause
  | alternate: 'ALTERNATE' 'RECORD'? 'KEY'? 'IS'? Qualified_data_name Password_clause?
  | duplicates: 'WITH'? 'DUPLICATES'
  | reserve: 'RESERVE' Integer Areas?
  ;
syntax Password_clause = password: 'PASSWORD' 'IS'? Id;
syntax Alt_assignment_name_literal
  = literal: Literal
  | assignmentName: Id
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
  
