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
  = \label-records-clause-tail-c1: 'STANDARD'
  | \label-records-clause-tail-c2: 'OMITTED'
  | \label-records-clause-tail-c3: Data_name+
  ;
syntax Alt_fd_sd
  = \alt-fd-sd-c1: 'FD'
  | \alt-fd-sd-c2: 'SD'
  ;
syntax Record_clause_tail
  = \record-clause-tail-c1: 'CONTAINS'? Integer 'TO' Integer 'CHARACTERS'?
  | \record-clause-tail-c2: 'CONTAINS'? Integer 'CHARACTERS'?
  | \record-clause-tail-c3: 'IS'? 'VARYING' 'IN'? 'SIZE'? 'CHARACTERS'?
  | \record-clause-tail-c3: 'IS'? 'VARYING' 'IN'? 'SIZE'? 'CHARACTERS'? 'DEPENDING' 'ON'? Data_name
  | \record-clause-tail-c3: 'IS'? 'VARYING' 'IN'? 'SIZE'? 'TO' Integer 'CHARACTERS'?
  | \record-clause-tail-c3: 'IS'? 'VARYING' 'IN'? 'SIZE'? 'TO' Integer 'CHARACTERS'? 'DEPENDING' 'ON'? Data_name
  | \record-clause-tail-c3: 'IS'? 'VARYING' 'IN'? 'SIZE'? 'FROM'? Integer 'CHARACTERS'?
  | \record-clause-tail-c3: 'IS'? 'VARYING' 'IN'? 'SIZE'? 'FROM'? Integer 'CHARACTERS'? 'DEPENDING' 'ON'? Data_name
  | \record-clause-tail-c3: 'IS'? 'VARYING' 'IN'? 'SIZE'? 'FROM'? Integer 'TO' Integer 'CHARACTERS'?
  | \record-clause-tail-c3: 'IS'? 'VARYING' 'IN'? 'SIZE'? 'FROM'? Integer 'TO' Integer 'CHARACTERS'? 'DEPENDING' 'ON'? Data_name
  ;
syntax Alt_characters_records
  = \alt-characters-records-c1: 'CHARACTERS'
  | \alt-characters-records-c2: 'RECORDS'
  | \alt-characters-records-c3: 'RECORD'
  ;
syntax File_and_sort_description_entry_clause
  = \file-and-sort-description-entry-clause-c5: 'LABEL' Records_are Label_records_clause_tail
  | \file-and-sort-description-entry-clause-c3: 'BLOCK' 'CONTAINS'? Integer_to? Integer Alt_characters_records?
  | \file-and-sort-description-entry-clause-c8: 'LINAGE' 'IS'? Alt_data_name_integer 'LINES'?
  | \file-and-sort-description-entry-clause-c8: 'LINAGE' 'IS'? Alt_data_name_integer 'LINES'? 'AT'? 'BOTTOM' Alt_data_name_integer
  | \file-and-sort-description-entry-clause-c8: 'LINAGE' 'IS'? Alt_data_name_integer 'LINES'? 'AT'? 'TOP' Alt_data_name_integer
  | \file-and-sort-description-entry-clause-c8: 'LINAGE' 'IS'? Alt_data_name_integer 'LINES'? 'AT'? 'TOP' Alt_data_name_integer 'LINES'? 'AT'? 'BOTTOM' Alt_data_name_integer
  | \file-and-sort-description-entry-clause-c8: 'LINAGE' 'IS'? Alt_data_name_integer 'LINES'? 'WITH'? 'FOOTING' 'AT'? Alt_data_name_integer
  | \file-and-sort-description-entry-clause-c8: 'LINAGE' 'IS'? Alt_data_name_integer 'LINES'? 'WITH'? 'FOOTING' 'AT'? Alt_data_name_integer 'LINES'? 'AT'? 'BOTTOM' Alt_data_name_integer
  | \file-and-sort-description-entry-clause-c8: 'LINAGE' 'IS'? Alt_data_name_integer 'LINES'? 'WITH'? 'FOOTING' 'AT'? Alt_data_name_integer 'LINES'? 'AT'? 'TOP' Alt_data_name_integer
  | \file-and-sort-description-entry-clause-c8: 'LINAGE' 'IS'? Alt_data_name_integer 'LINES'? 'WITH'? 'FOOTING' 'AT'? Alt_data_name_integer 'LINES'? 'AT'? 'TOP' Alt_data_name_integer 'LINES'? 'AT'? 'BOTTOM' Alt_data_name_integer
  | \file-and-sort-description-entry-clause-c9: 'RECORDING' 'MODE'? 'IS'? Cobword \ CobwordKeywords
  | \file-and-sort-description-entry-clause-c2: Global_clause
  | \file-and-sort-description-entry-clause-c4: 'RECORD' Record_clause_tail
  | \file-and-sort-description-entry-clause-c7: 'DATA' Records_are Data_name+
  | \file-and-sort-description-entry-clause-c6: 'VALUE' 'OF' Value_of_clause_tail+
  | \file-and-sort-description-entry-clause-c10: 'CODE-SET' 'IS'? Alphabet_name
  | \file-and-sort-description-entry-clause-c1: External_clause
  ;
syntax Records_are = \records-are: Records Are?;

syntax Alt_qualified_data_name_literal
  = \alt-qualified-data-name-literal-c2: Literal
  | \alt-qualified-data-name-literal-c1: Qualified_data_name
  ;
syntax Alt_data_name_integer
  = \alt-data-name-integer-c1: Data_name
  | \alt-data-name-integer-c2: Integer
  ;

syntax Value_of_clause_tail = \value-of-clause-tail: System_name 'IS'? Alt_qualified_data_name_literal;