module lang::vscobolii::\VSC-io-sec 

extend lang::vscobolii::\VSC-fd-entry;
extend lang::vscobolii::\VSC-expr;


syntax File_name_position =
  \file-name-position: File_name Position? 
  ;

syntax Input_output_section =
  \input-output-section: "INPUT-OUTPUT" !>> [\- 0-9 A-Z _ a-z] "SECTION" !>> [\- 0-9 A-Z _ a-z] "." File_control_paragraph? I_o_control_paragraph? 
  ;

syntax Assign_clause =
  \assign-clause: "ASSIGN" !>> [\- 0-9 A-Z _ a-z] "TO"? Alt_assignment_name_literal+ 
  ;

syntax Record_delimiter_name =
  \record-delimiter-name-c2: Assignment_name 
  | \record-delimiter-name-c1: "STANDARD-1" !>> [\- 0-9 A-Z _ a-z] 
  ;

syntax Fce_organization =
  \fce-organization: Organization_is? Alt_indexed_relative_sequential 
  ;

syntax Record_sort =
  \record-sort-c2: "SORT" !>> [\- 0-9 A-Z _ a-z] 
  | \record-sort-c1: "RECORD" !>> [\- 0-9 A-Z _ a-z] 
  | \record-sort-c3: "SORT-MERGE" !>> [\- 0-9 A-Z _ a-z] 
  ;

syntax Every_phrase_1 =
  \every-phrase-1: Integer "RECORDS" !>> [\- 0-9 A-Z _ a-z] 
  ;

syntax Alt_indexed_relative_sequential =
  \alt-indexed-relative-sequential-c2: "RELATIVE" !>> [\- 0-9 A-Z _ a-z] 
  | \alt-indexed-relative-sequential-c1: "INDEXED" !>> [\- 0-9 A-Z _ a-z] 
  | \alt-indexed-relative-sequential-c3: "SEQUENTIAL" !>> [\- 0-9 A-Z _ a-z] 
  ;

syntax With_duplicates =
  \with-duplicates: "WITH"? "DUPLICATES" !>> [\- 0-9 A-Z _ a-z] 
  ;

syntax Sort_merge_i_o_control_entries =
  \sort-merge-i-o-control-entries: Rerun_on? Same_area+ 
  ;

syntax Qsam_or_sam_or_vsam_i_o_control_entries =
  \qsam-or-sam-or-vsam-i-o-control-entries-c1: Qsam_or_sam_or_vsam_i_o_control_entries_1 
  | \qsam-or-sam-or-vsam-i-o-control-entries-c2: Qsam_or_sam_or_vsam_i_o_control_entries_2 
  | \qsam-or-sam-or-vsam-i-o-control-entries-c4: Qsam_or_sam_or_vsam_i_o_control_entries_4 
  | \qsam-or-sam-or-vsam-i-o-control-entries-c3: Qsam_or_sam_or_vsam_i_o_control_entries_3 
  ;

syntax Relative_key_clause =
  \relative-key-clause: "RELATIVE" !>> [\- 0-9 A-Z _ a-z] "KEY"? "IS"? Qualified_data_name 
  ;

syntax Fce_access_mode =
  \fce-access-mode: "ACCESS" !>> [\- 0-9 A-Z _ a-z] "MODE"? "IS"? Alt_sequential_random_dynamic Relative_key_clause? 
  ;

syntax File_status_clause =
  \file-status-clause: "FILE"? "STATUS" !>> [\- 0-9 A-Z _ a-z] "IS"? Qualified_data_name Qualified_data_name? 
  ;

syntax I_o_sam =
  \i-o-sam: Qsam_or_sam_or_vsam_i_o_control_entries+ "." 
  ;

syntax Alternate_record_key_clause =
  \alternate-record-key-clause: "ALTERNATE" !>> [\- 0-9 A-Z _ a-z] "RECORD"? "KEY"? "IS"? Qualified_data_name Password_clause? With_duplicates? 
  ;

syntax Qsam_or_sam_or_vsam_i_o_control_entries_4 =
  \qsam-or-sam-or-vsam-i-o-control-entries-4: "APPLY" !>> [\- 0-9 A-Z _ a-z] "WRITE-ONLY" !>> [\- 0-9 A-Z _ a-z] "ON"? File_name+ 
  ;

syntax Record_key_clause =
  \record-key-clause: "RECORD" !>> [\- 0-9 A-Z _ a-z] "KEY"? "IS"? Qualified_data_name 
  ;

syntax Every_phrase =
  \every-phrase-c2: Every_phrase_2 
  | \every-phrase-c1: Every_phrase_1 
  ;

syntax I_o_sort_merge =
  \i-o-sort-merge: Sort_merge_i_o_control_entries "." 
  ;

syntax Fce_phrase =
  \fce-phrase-c4: Record_key_clause 
  | \fce-phrase-c3: Fce_access_mode 
  | \fce-phrase-c9: Record_delimiter_clause 
  | \fce-phrase-c7: File_status_clause 
  | \fce-phrase-c8: Padding_character_clause 
  | \fce-phrase-c2: Fce_organization 
  | \fce-phrase-c5: Password_clause 
  | \fce-phrase-c6: Alternate_record_key_clause 
  | \fce-phrase-c1: Reserve_clause 
  ;

syntax Every_phrase_2 =
  \every-phrase-2: "END" !>> [\- 0-9 A-Z _ a-z] "OF"? Alt_reel_unit 
  ;

syntax Password_clause =
  \password-clause: "PASSWORD" !>> [\- 0-9 A-Z _ a-z] "IS"? Data_name 
  ;

syntax Padding_character_clause =
  \padding-character-clause: "PADDING" !>> [\- 0-9 A-Z _ a-z] "CHARACTER"? "IS"? Alt_qualified_data_name_literal 
  ;

syntax Reserve_clause =
  \reserve-clause: "RESERVE" !>> [\- 0-9 A-Z _ a-z] Integer Areas? 
  ;

syntax Select_clause =
  \select-clause: "SELECT" !>> [\- 0-9 A-Z _ a-z] "OPTIONAL"? File_name 
  ;

syntax Qsam_or_sam_or_vsam_i_o_control_entries_1 =
  \qsam-or-sam-or-vsam-i-o-control-entries-1: "RERUN" !>> [\- 0-9 A-Z _ a-z] "ON" !>> [\- 0-9 A-Z _ a-z] Alt_assignment_name_file_name "EVERY"? Every_phrase "OF"? File_name 
  ;

syntax Record_delimiter_clause =
  \record-delimiter-clause: "RECORD" !>> [\- 0-9 A-Z _ a-z] "DELIMITER" !>> [\- 0-9 A-Z _ a-z] "IS"? Record_delimiter_name 
  ;

syntax Alt_assignment_name_literal =
  \alt-assignment-name-literal-c2: Literal 
  | \alt-assignment-name-literal-c1: Assignment_name 
  ;

syntax Qsam_or_sam_or_vsam_i_o_control_entries_3 =
  \qsam-or-sam-or-vsam-i-o-control-entries-3: "MULTIPLE" !>> [\- 0-9 A-Z _ a-z] "FILE" !>> [\- 0-9 A-Z _ a-z] "TAPE"? "CONTAINS"? File_name_position+ 
  ;

syntax Alt_assignment_name_file_name =
  \alt-assignment-name-file-name-c1: Assignment_name 
  | \alt-assignment-name-file-name-c2: File_name 
  ;

syntax Organization_is =
  \organization-is: "ORGANIZATION" !>> [\- 0-9 A-Z _ a-z] "IS"? 
  ;

syntax Qsam_or_sam_or_vsam_i_o_control_entries_2 =
  \qsam-or-sam-or-vsam-i-o-control-entries-2: "SAME" !>> [\- 0-9 A-Z _ a-z] "RECORD"? "AREA"? "FOR"? File_name File_name+ 
  ;

syntax Position =
  position: "POSITION" !>> [\- 0-9 A-Z _ a-z] Integer 
  ;

syntax File_control_paragraph =
  \file-control-paragraph: "FILE-CONTROL" !>> [\- 0-9 A-Z _ a-z] "." File_control_entry* 
  ;

syntax File_control_entry =
  \file-control-entry: Select_clause Assign_clause Fce_phrase* "." 
  ;

syntax Alt_sequential_random_dynamic =
  \alt-sequential-random-dynamic-c2: "RANDOM" !>> [\- 0-9 A-Z _ a-z] 
  | \alt-sequential-random-dynamic-c3: "DYNAMIC" !>> [\- 0-9 A-Z _ a-z] 
  | \alt-sequential-random-dynamic-c1: "SEQUENTIAL" !>> [\- 0-9 A-Z _ a-z] 
  ;

syntax Areas =
  \areas-c2: "AREAS" !>> [\- 0-9 A-Z _ a-z] 
  | \areas-c1: "AREA" !>> [\- 0-9 A-Z _ a-z] 
  ;

syntax I_o_control_paragraph =
  \i-o-control-paragraph: "I-O-CONTROL" !>> [\- 0-9 A-Z _ a-z] "." I_o_sam? I_o_sort_merge? 
  ;

syntax Rerun_on =
  \rerun-on: "RERUN" !>> [\- 0-9 A-Z _ a-z] "ON" !>> [\- 0-9 A-Z _ a-z] Assignment_name 
  ;

syntax Same_area =
  \same-area: "SAME" !>> [\- 0-9 A-Z _ a-z] Record_sort "AREA"? "FOR"? File_name File_name+ 
  ;
