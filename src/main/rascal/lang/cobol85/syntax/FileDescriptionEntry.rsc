module lang::cobol85::\syntax::FileDescriptionEntry

extend lang::cobol85::\syntax::DataDescriptionEntry;
extend lang::cobol85::\syntax::ConfigurationSection;
extend lang::cobol85::\syntax::Lexical;
extend lang::cobol85::\syntax::Expression;

// the reserved words of this module
keyword CobwordKeywords
  = 'AT'
  | 'BLOCK'
  | 'BOTTOM'
  | 'CHARACTERS'
  | 'CODE-SET'
  | 'CONTAINS'
  | 'DATA'
  | 'DEPENDING'
  | 'FD'
  | 'FOOTING'
  | 'FROM'
  | 'IN'
  | 'IS'
  | 'LABEL'
  | 'LINAGE'
  | 'LINES'
  | 'MODE'
  | 'OF'
  | 'OMITTED'
  | 'ON'
  | 'RECORD'
  | 'RECORDING'
  | 'RECORDS'
  | 'SD'
  | 'SIZE'
  | 'STANDARD'
  | 'TO'
  | 'TOP'
  | 'VALUE'
  | 'VARYING'
  | 'WITH'
  ;
syntax Label_records_clause_tail
  = standard: 'STANDARD'
  | omitted: 'OMITTED'
  | dataName: Id+
  ;
syntax Alt_fd_sd
  = fd: 'FD'
  | sd: 'SD'
  ;
syntax Record_clause_tail
  = to: 'CONTAINS'? Integer 'TO' Integer 'CHARACTERS'?
  | integer: 'CONTAINS'? Integer 'CHARACTERS'?
  | varying: 'IS'? 'VARYING' 'IN'? 'SIZE'? 'CHARACTERS'?
  | varying: 'IS'? 'VARYING' 'IN'? 'SIZE'? 'CHARACTERS'? 'DEPENDING' 'ON'? Id
  | varying: 'IS'? 'VARYING' 'IN'? 'SIZE'? 'TO' Integer 'CHARACTERS'?
  | varying: 'IS'? 'VARYING' 'IN'? 'SIZE'? 'TO' Integer 'CHARACTERS'? 'DEPENDING' 'ON'? Id
  | varying: 'IS'? 'VARYING' 'IN'? 'SIZE'? 'FROM'? Integer 'CHARACTERS'?
  | varying: 'IS'? 'VARYING' 'IN'? 'SIZE'? 'FROM'? Integer 'CHARACTERS'? 'DEPENDING' 'ON'? Id
  | varying: 'IS'? 'VARYING' 'IN'? 'SIZE'? 'FROM'? Integer 'TO' Integer 'CHARACTERS'?
  | varying: 'IS'? 'VARYING' 'IN'? 'SIZE'? 'FROM'? Integer 'TO' Integer 'CHARACTERS'? 'DEPENDING' 'ON'? Id
  ;
syntax Alt_characters_records
  = characters: 'CHARACTERS'
  | records: 'RECORDS'
  | record: 'RECORD'
  ;
syntax File_and_sort_description_entry_clause
  = label: 'LABEL' Records_are Label_records_clause_tail
  | block: 'BLOCK' 'CONTAINS'? Integer_to? Integer Alt_characters_records?
  | linage: 'LINAGE' 'IS'? Alt_data_name_integer 'LINES'?
  | linage: 'LINAGE' 'IS'? Alt_data_name_integer 'LINES'? 'AT'? 'BOTTOM' Alt_data_name_integer
  | linage: 'LINAGE' 'IS'? Alt_data_name_integer 'LINES'? 'AT'? 'TOP' Alt_data_name_integer
  | linage: 'LINAGE' 'IS'? Alt_data_name_integer 'LINES'? 'AT'? 'TOP' Alt_data_name_integer 'LINES'? 'AT'? 'BOTTOM' Alt_data_name_integer
  | linage: 'LINAGE' 'IS'? Alt_data_name_integer 'LINES'? 'WITH'? 'FOOTING' 'AT'? Alt_data_name_integer
  | linage: 'LINAGE' 'IS'? Alt_data_name_integer 'LINES'? 'WITH'? 'FOOTING' 'AT'? Alt_data_name_integer 'LINES'? 'AT'? 'BOTTOM' Alt_data_name_integer
  | linage: 'LINAGE' 'IS'? Alt_data_name_integer 'LINES'? 'WITH'? 'FOOTING' 'AT'? Alt_data_name_integer 'LINES'? 'AT'? 'TOP' Alt_data_name_integer
  | linage: 'LINAGE' 'IS'? Alt_data_name_integer 'LINES'? 'WITH'? 'FOOTING' 'AT'? Alt_data_name_integer 'LINES'? 'AT'? 'TOP' Alt_data_name_integer 'LINES'? 'AT'? 'BOTTOM' Alt_data_name_integer
  | recording: 'RECORDING' 'MODE'? 'IS'? Id
  | globalClause: Global_clause
  | record: 'RECORD' Record_clause_tail
  | \data: 'DATA' Records_are Id+
  | \value: 'VALUE' 'OF' Value_of_clause_tail+
  | codeSet: 'CODE-SET' 'IS'? Id
  | externalClause: External_clause
  ;
syntax Records_are = records: Records Are?;

syntax Alt_qualified_data_name_literal
  = literal: Literal
  | qualifiedDataName: Qualified_data_name
  ;
syntax Alt_data_name_integer
  = dataName: Id
  | integer: Integer
  ;

syntax Value_of_clause_tail = systemName: Id 'IS'? Alt_qualified_data_name_literal;