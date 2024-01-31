module lang::vscobolii::\VSC-fd-entry 

extend lang::vscobolii::\VSC-dd-entry;
extend lang::vscobolii::\VSC-conf-sec;
extend lang::vscobolii::\VSC-lex;
extend lang::vscobolii::\VSC-expr;


syntax File_and_sort_description_entry =
  \file-and-sort-description-entry: Alt_fd_sd File_name File_and_sort_description_entry_clauses "." 
  ;

syntax Label_records_clause_tail =
  \label-records-clause-tail-c1: "STANDARD" 
  | \label-records-clause-tail-c2: "OMITTED" 
  | \label-records-clause-tail-c3: Data_names 
  ;

syntax To_integer =
  \to-integer: "TO" Integer 
  ;

syntax Alt_fd_sd =
  \alt-fd-sd-c1: "FD" 
  | \alt-fd-sd-c2: "SD" 
  ;

syntax Data_names =
  \data-names: Data_name+ 
  ;

syntax Record_clause_tail =
  \record-clause-tail-c1: Record_clause_tail_2 
  | \record-clause-tail-c2: Record_clause_tail_1 
  | \record-clause-tail-c3: Record_clause_tail_3 
  ;

syntax Footing =
  footing: "WITH"? "FOOTING" "AT"? Alt_data_name_integer 
  ;

syntax Record_varying_phrase =
  \record-varying-phrase: "IS"? "VARYING" "IN"? "SIZE"? From_integer? To_integer? "CHARACTERS"? 
  ;

syntax Depending_on =
  \depending-on: "DEPENDING" "ON"? Data_name 
  ;

syntax Lines_bottom =
  \lines-bottom: "LINES"? "AT"? "BOTTOM" Alt_data_name_integer 
  ;

syntax Data_records_clause =
  \data-records-clause: "DATA" Records_are Data_name+ 
  ;

syntax Linage_clause =
  \linage-clause: "LINAGE" "IS"? Alt_data_name_integer "LINES"? Linage_footing_phrase 
  ;

syntax Alt_characters_records =
  \alt-characters-records-c1: "CHARACTERS" 
  | \alt-characters-records-c2: "RECORDS" 
  | \alt-characters-records-c3: "RECORD" 
  ;

syntax Record_clause_tail_2 =
  \record-clause-tail-2: "CONTAINS"? Integer "TO" Integer "CHARACTERS"? 
  ;

syntax Record_clause_tail_1 =
  \record-clause-tail-1: "CONTAINS"? Integer "CHARACTERS"? 
  ;

syntax Block_contains_clause =
  \block-contains-clause: "BLOCK" "CONTAINS"? Integer_to? Integer Alt_characters_records? 
  ;

syntax Recording_mode_clause =
  \recording-mode-clause: "RECORDING" "MODE"? "IS"? Cobword \ CobwordKeywords 
  ;

syntax Record_clause =
  \record-clause: "RECORD" Record_clause_tail 
  ;

syntax Code_set_clause =
  \code-set-clause: "CODE-SET" "IS"? Alphabet_name 
  ;

syntax File_and_sort_description_entry_clauses =
  \file-and-sort-description-entry-clauses: File_and_sort_description_entry_clause* 
  ;

syntax Lines_top =
  \lines-top: "LINES"? "AT"? "TOP" Alt_data_name_integer 
  ;

syntax File_and_sort_description_entry_clause =
  \file-and-sort-description-entry-clause-c5: Label_records_clause 
  | \file-and-sort-description-entry-clause-c3: Block_contains_clause 
  | \file-and-sort-description-entry-clause-c8: Linage_clause 
  | \file-and-sort-description-entry-clause-c9: Recording_mode_clause 
  | \file-and-sort-description-entry-clause-c2: Global_clause 
  | \file-and-sort-description-entry-clause-c4: Record_clause 
  | \file-and-sort-description-entry-clause-c7: Data_records_clause 
  | \file-and-sort-description-entry-clause-c6: Value_of_clause 
  | \file-and-sort-description-entry-clause-c10: Code_set_clause 
  | \file-and-sort-description-entry-clause-c1: External_clause 
  ;

syntax Linage_footing_phrase =
  \linage-footing-phrase: Footing? Lines_top? Lines_bottom? 
  ;

syntax Records_are =
  \records-are: Records Are? 
  ;

syntax Alt_qualified_data_name_literal =
  \alt-qualified-data-name-literal-c2: Literal 
  | \alt-qualified-data-name-literal-c1: Qualified_data_name 
  ;

syntax Label_records_clause =
  \label-records-clause: "LABEL" Records_are Label_records_clause_tail 
  ;

syntax Value_of_clause =
  \value-of-clause: "VALUE" "OF" Value_of_clause_tail+ 
  ;

syntax From_integer =
  \from-integer: "FROM"? Integer 
  ;

syntax Alt_data_name_integer =
  \alt-data-name-integer-c1: Data_name 
  | \alt-data-name-integer-c2: Integer 
  ;

syntax Value_of_clause_tail =
  \value-of-clause-tail: System_name "IS"? Alt_qualified_data_name_literal 
  ;

syntax Record_clause_tail_3 =
  \record-clause-tail-3: Record_varying_phrase Depending_on? 
  ;
