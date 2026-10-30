module lang::vscobolii::\VSC-data-div

extend lang::vscobolii::\VSC-fd-entry;
extend lang::vscobolii::\VSC-dd-entry;
extend lang::vscobolii::\VSC-comm-sec;

syntax File_section_entry = \file-section-entry: Alt_fd_sd File_name File_and_sort_description_entry_clause* "." Data_description_entry+;
syntax Data_division
  = \data-division: 'DATA' 'DIVISION' "."
  | \data-division: 'DATA' 'DIVISION' "." Communication_section
  | \data-division: 'DATA' 'DIVISION' "." 'LINKAGE' 'SECTION' "." Data_description_entry*
  | \data-division: 'DATA' 'DIVISION' "." 'WORKING-STORAGE' 'SECTION' "." Data_description_entry*
  | \data-division: 'DATA' 'DIVISION' "." 'WORKING-STORAGE' 'SECTION' "." Data_description_entry* 'LINKAGE' 'SECTION' "." Data_description_entry*
  | \data-division: 'DATA' 'DIVISION' "." 'WORKING-STORAGE' 'SECTION' "." Data_description_entry* Communication_section
  | \data-division: 'DATA' 'DIVISION' "." 'FILE' 'SECTION' "." File_section_entry*
  | \data-division: 'DATA' 'DIVISION' "." 'FILE' 'SECTION' "." File_section_entry* Communication_section
  | \data-division: 'DATA' 'DIVISION' "." 'FILE' 'SECTION' "." File_section_entry* 'LINKAGE' 'SECTION' "." Data_description_entry*
  | \data-division: 'DATA' 'DIVISION' "." 'FILE' 'SECTION' "." File_section_entry* 'LINKAGE' 'SECTION' "." Data_description_entry* Communication_section
  | \data-division: 'DATA' 'DIVISION' "." 'FILE' 'SECTION' "." File_section_entry* 'WORKING-STORAGE' 'SECTION' "." Data_description_entry*
  | \data-division: 'DATA' 'DIVISION' "." 'FILE' 'SECTION' "." File_section_entry* 'WORKING-STORAGE' 'SECTION' "." Data_description_entry* Communication_section
  | \data-division: 'DATA' 'DIVISION' "." 'FILE' 'SECTION' "." File_section_entry* Communication_section 'WORKING-STORAGE' 'SECTION' "." Data_description_entry*
  | \data-division: 'DATA' 'DIVISION' "." 'FILE' 'SECTION' "." File_section_entry* 'WORKING-STORAGE' 'SECTION' "." Data_description_entry* 'LINKAGE' 'SECTION' "." Data_description_entry*
  | \data-division: 'DATA' 'DIVISION' "." 'FILE' 'SECTION' "." File_section_entry* 'WORKING-STORAGE' 'SECTION' "." Data_description_entry* 'LINKAGE' 'SECTION' "." Data_description_entry* Communication_section
  | \data-division: 'DATA' 'DIVISION' "." 'FILE' 'SECTION' "." File_section_entry* Communication_section 'WORKING-STORAGE' 'SECTION' "." Data_description_entry* 'LINKAGE' 'SECTION' "." Data_description_entry*
  ;