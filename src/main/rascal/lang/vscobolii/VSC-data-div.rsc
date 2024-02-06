module lang::vscobolii::\VSC-data-div 

extend lang::vscobolii::\VSC-fd-entry;
extend lang::vscobolii::\VSC-dd-entry;


syntax Data_division_content =
  \data-division-content: File_section? Working_storage_section? Linkage_section? 
  ;

syntax Working_storage_section =
  \working-storage-section: 'WORKING-STORAGE' 'SECTION' "." Data_description_entry* 
  ;

syntax File_section_entry =
  \file-section-entry: File_and_sort_description_entry Data_description_entry+ 
  ;

syntax Linkage_section =
  \linkage-section: 'LINKAGE' 'SECTION' "." Data_description_entry* 
  ;

syntax File_section =
  \file-section: 'FILE' 'SECTION' "." File_section_entry* 
  ;

syntax Data_division =
  \data-division: 'DATA' 'DIVISION' "." Data_division_content 
  ;
