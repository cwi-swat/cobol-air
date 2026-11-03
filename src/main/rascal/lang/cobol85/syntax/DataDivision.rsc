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
// the sections of the data division, in any order; a checker rejects the orders COBOL does not allow
syntax Data_division = dataDivision: 'DATA' 'DIVISION' "." Data_section*;

syntax Data_section
  = file: 'FILE' 'SECTION' "." File_section_entry*
  | workingStorage: 'WORKING-STORAGE' 'SECTION' "." Data_description_entry*
  | linkage: 'LINKAGE' 'SECTION' "." Data_description_entry*
  | communication: Communication_section
  ;