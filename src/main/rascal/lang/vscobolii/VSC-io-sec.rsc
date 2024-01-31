module lang::vscobolii::\VSC-io-sec 

extend lang::vscobolii::\VSC-fd-entry;
extend lang::vscobolii::\VSC-expr;


syntax File_name_position =
  \file-name-position: File_name Position? 
  ;

syntax Input_output_section =
  \input-output-section: "INPUT-OUTPUT" "SECTION" "." File_control_paragraph? I_o_control_paragraph? 
  ;

syntax Assign_clause =
  \assign-clause: "ASSIGN" "TO"? Alt_assignment_name_literal+ 
  ;

syntax Record_delimiter_name =
  \record-delimiter-name-c2: Assignment_name 
  | \record-delimiter-name-c1: "STANDARD-1" 
  ;

syntax Fce_organization =
  \fce-organization: Organization_is? Alt_indexed_relative_sequential 
  ;

syntax Record_sort =
  \record-sort-c2: "SORT" 
  | \record-sort-c1: "RECORD" 
  | \record-sort-c3: "SORT-MERGE" 
  ;

syntax Every_phrase_1 =
  \every-phrase-1: Integer "RECORDS" 
  ;

syntax Alt_indexed_relative_sequential =
  \alt-indexed-relative-sequential-c2: "RELATIVE" 
  | \alt-indexed-relative-sequential-c1: "INDEXED" 
  | \alt-indexed-relative-sequential-c3: "SEQUENTIAL" 
  ;

syntax With_duplicates =
  \with-duplicates: "WITH"? "DUPLICATES" 
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
  \relative-key-clause: "RELATIVE" "KEY"? "IS"? Qualified_data_name 
  ;

syntax Fce_access_mode =
  \fce-access-mode: "ACCESS" "MODE"? "IS"? Alt_sequential_random_dynamic Relative_key_clause? 
  ;

syntax File_status_clause =
  \file-status-clause: "FILE"? "STATUS" "IS"? Qualified_data_name Qualified_data_name? 
  ;

syntax I_o_sam =
  \i-o-sam: Qsam_or_sam_or_vsam_i_o_control_entries+ "." 
  ;

syntax Alternate_record_key_clause =
  \alternate-record-key-clause: "ALTERNATE" "RECORD"? "KEY"? "IS"? Qualified_data_name Password_clause? With_duplicates? 
  ;

syntax Qsam_or_sam_or_vsam_i_o_control_entries_4 =
  \qsam-or-sam-or-vsam-i-o-control-entries-4: "APPLY" "WRITE-ONLY" "ON"? File_name+ 
  ;

syntax Record_key_clause =
  \record-key-clause: "RECORD" "KEY"? "IS"? Qualified_data_name 
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
  \every-phrase-2: "END" "OF"? Alt_reel_unit 
  ;

syntax Password_clause =
  \password-clause: "PASSWORD" "IS"? Data_name 
  ;

syntax Padding_character_clause =
  \padding-character-clause: "PADDING" "CHARACTER"? "IS"? Alt_qualified_data_name_literal 
  ;

syntax Reserve_clause =
  \reserve-clause: "RESERVE" Integer Areas? 
  ;

syntax Select_clause =
  \select-clause: "SELECT" "OPTIONAL"? File_name 
  ;

syntax Qsam_or_sam_or_vsam_i_o_control_entries_1 =
  \qsam-or-sam-or-vsam-i-o-control-entries-1: "RERUN" "ON" Alt_assignment_name_file_name "EVERY"? Every_phrase "OF"? File_name 
  ;

syntax Record_delimiter_clause =
  \record-delimiter-clause: "RECORD" "DELIMITER" "IS"? Record_delimiter_name 
  ;

syntax Alt_assignment_name_literal =
  \alt-assignment-name-literal-c2: Literal 
  | \alt-assignment-name-literal-c1: Assignment_name 
  ;

syntax Qsam_or_sam_or_vsam_i_o_control_entries_3 =
  \qsam-or-sam-or-vsam-i-o-control-entries-3: "MULTIPLE" "FILE" "TAPE"? "CONTAINS"? File_name_position+ 
  ;

syntax Alt_assignment_name_file_name =
  \alt-assignment-name-file-name-c1: Assignment_name 
  | \alt-assignment-name-file-name-c2: File_name 
  ;

syntax Organization_is =
  \organization-is: "ORGANIZATION" "IS"? 
  ;

syntax Qsam_or_sam_or_vsam_i_o_control_entries_2 =
  \qsam-or-sam-or-vsam-i-o-control-entries-2: "SAME" "RECORD"? "AREA"? "FOR"? File_name File_name+ 
  ;

syntax Position =
  position: "POSITION" Integer 
  ;

syntax File_control_paragraph =
  \file-control-paragraph: "FILE-CONTROL" "." File_control_entry* 
  ;

syntax File_control_entry =
  \file-control-entry: Select_clause Assign_clause Fce_phrase* "." 
  ;

syntax Alt_sequential_random_dynamic =
  \alt-sequential-random-dynamic-c2: "RANDOM" 
  | \alt-sequential-random-dynamic-c3: "DYNAMIC" 
  | \alt-sequential-random-dynamic-c1: "SEQUENTIAL" 
  ;

syntax Areas =
  \areas-c2: "AREAS" 
  | \areas-c1: "AREA" 
  ;

syntax I_o_control_paragraph =
  \i-o-control-paragraph: "I-O-CONTROL" "." I_o_sam? I_o_sort_merge? 
  ;

syntax Rerun_on =
  \rerun-on: "RERUN" "ON" Assignment_name 
  ;

syntax Same_area =
  \same-area: "SAME" Record_sort "AREA"? "FOR"? File_name File_name+ 
  ;
