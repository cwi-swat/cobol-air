module lang::cobol85::\syntax::DataDivision

extend lang::cobol85::\syntax::FileDescriptionEntry;
extend lang::cobol85::\syntax::DataDescriptionEntry;
extend lang::cobol85::\syntax::CommunicationSection;

// the reserved words of this module
keyword CobwordKeywords
  = 'DATA'
  | 'DIVISION'
  | 'FILE'
  | 'LINKAGE'
  | 'SECTION'
  | 'WORKING-STORAGE'
  ;

syntax File_section_entry
  = fd: Alt_fd_sd File_name File_and_sort_description_entry_clause* "." Data_description_entry+
  | fd: Alt_fd_sd File_name Copy_statement Data_description_entry* // the clauses come from a copybook
  ;
syntax Data_division
  = dataDivision: 'DATA' 'DIVISION' "."
  | dataDivision: 'DATA' 'DIVISION' "." Communication_section
  | dataDivision: 'DATA' 'DIVISION' "." 'LINKAGE' 'SECTION' "." Data_description_entry*
  | dataDivision: 'DATA' 'DIVISION' "." 'WORKING-STORAGE' 'SECTION' "." Data_description_entry*
  | dataDivision: 'DATA' 'DIVISION' "." 'WORKING-STORAGE' 'SECTION' "." Data_description_entry* 'LINKAGE' 'SECTION' "." Data_description_entry*
  | dataDivision: 'DATA' 'DIVISION' "." 'WORKING-STORAGE' 'SECTION' "." Data_description_entry* Communication_section
  | dataDivision: 'DATA' 'DIVISION' "." 'FILE' 'SECTION' "." File_section_entry*
  | dataDivision: 'DATA' 'DIVISION' "." 'FILE' 'SECTION' "." File_section_entry* Communication_section
  | dataDivision: 'DATA' 'DIVISION' "." 'FILE' 'SECTION' "." File_section_entry* 'LINKAGE' 'SECTION' "." Data_description_entry*
  | dataDivision: 'DATA' 'DIVISION' "." 'FILE' 'SECTION' "." File_section_entry* 'LINKAGE' 'SECTION' "." Data_description_entry* Communication_section
  | dataDivision: 'DATA' 'DIVISION' "." 'FILE' 'SECTION' "." File_section_entry* 'WORKING-STORAGE' 'SECTION' "." Data_description_entry*
  | dataDivision: 'DATA' 'DIVISION' "." 'FILE' 'SECTION' "." File_section_entry* 'WORKING-STORAGE' 'SECTION' "." Data_description_entry* Communication_section
  | dataDivision: 'DATA' 'DIVISION' "." 'FILE' 'SECTION' "." File_section_entry* Communication_section 'WORKING-STORAGE' 'SECTION' "." Data_description_entry*
  | dataDivision: 'DATA' 'DIVISION' "." 'FILE' 'SECTION' "." File_section_entry* 'WORKING-STORAGE' 'SECTION' "." Data_description_entry* 'LINKAGE' 'SECTION' "." Data_description_entry*
  | dataDivision: 'DATA' 'DIVISION' "." 'FILE' 'SECTION' "." File_section_entry* 'WORKING-STORAGE' 'SECTION' "." Data_description_entry* 'LINKAGE' 'SECTION' "." Data_description_entry* Communication_section
  | dataDivision: 'DATA' 'DIVISION' "." 'FILE' 'SECTION' "." File_section_entry* Communication_section 'WORKING-STORAGE' 'SECTION' "." Data_description_entry* 'LINKAGE' 'SECTION' "." Data_description_entry*
  ;