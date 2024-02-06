  module lang::vscobolii::\VSC-fd-entry  extend lang::vscobolii::\VSC-dd-entry;
extend lang::vscobolii::\VSC-conf-sec;
extend lang::vscobolii::\VSC-lex;
extend lang::vscobolii::\VSC-expr; 
syntax Label_records_clause_tail =
  \label-records-clause-tail-c1: 'STANDARD' 
  | \label-records-clause-tail-c2: 'OMITTED' 
  |  \label-records-clause-tail-c3: Data_name+ 
  ;

syntax To_integer =
  \to-integer: 'TO' Integer 
  ;

syntax Alt_fd_sd =
  \alt-fd-sd-c1: 'FD' 
  | \alt-fd-sd-c2: 'SD' 
  ; 
syntax Record_clause_tail =
   \record-clause-tail-c1: 'CONTAINS'? Integer 'TO' Integer 'CHARACTERS'? 
  |  \record-clause-tail-c2: 'CONTAINS'? Integer 'CHARACTERS'? 
  |   \record-clause-tail-c3: Record_varying_phrase
 |  \record-clause-tail-c3: Record_varying_phrase 'DEPENDING' 'ON'? Data_name 
  ; 
syntax Lines_bottom =
  \lines-bottom: 'LINES'? 'AT'? 'BOTTOM' Alt_data_name_integer 
  ; 
syntax Alt_characters_records =
  \alt-characters-records-c1: 'CHARACTERS' 
  | \alt-characters-records-c2: 'RECORDS' 
  | \alt-characters-records-c3: 'RECORD' 
  ; 
syntax Lines_top =
  \lines-top: 'LINES'? 'AT'? 'TOP' Alt_data_name_integer 
  ;

syntax File_and_sort_description_entry_clause =
    \file-and-sort-description-entry-clause-c5: 'LABEL' Records Are?  Label_records_clause_tail 
  |  \file-and-sort-description-entry-clause-c3: 'BLOCK' 'CONTAINS'? Integer_to? Integer Alt_characters_records? 
  |  \file-and-sort-description-entry-clause-c8: 'LINAGE' 'IS'? Alt_data_name_integer 'LINES'? Linage_footing_phrase 
  |  \file-and-sort-description-entry-clause-c9: 'RECORDING' 'MODE'? 'IS'? Cobword \ CobwordKeywords 
  | \file-and-sort-description-entry-clause-c2: Global_clause 
  |  \file-and-sort-description-entry-clause-c4: 'RECORD' Record_clause_tail 
  |   \file-and-sort-description-entry-clause-c7: 'DATA' Records Are?  Data_name+ 
  |  \file-and-sort-description-entry-clause-c6: 'VALUE' 'OF' Value_of_clause_tail+ 
  |  \file-and-sort-description-entry-clause-c10: 'CODE-SET' 'IS'? Alphabet_name 
  | \file-and-sort-description-entry-clause-c1: External_clause 
  ; 
syntax Alt_qualified_data_name_literal =
  \alt-qualified-data-name-literal-c2: Literal 
  | \alt-qualified-data-name-literal-c1: Qualified_data_name 
  ; 
syntax Alt_data_name_integer =
  \alt-data-name-integer-c1: Data_name 
  | \alt-data-name-integer-c2: Integer 
  ;

syntax Value_of_clause_tail =
  \value-of-clause-tail: System_name 'IS'? Alt_qualified_data_name_literal 
  ;
