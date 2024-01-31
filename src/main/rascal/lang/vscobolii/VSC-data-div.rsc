module lang::vscobolii::\VSC-data-div 

extend lang::vscobolii::\VSC-fd-entry;
extend lang::vscobolii::\VSC-dd-entry;


syntax Data_division_content =
  \data-division-content: File_section? Working_storage_section? Linkage_section? 
  ;

syntax Working_storage_section =
  \working-storage-section: "WORKING-STORAGE" !>> [\- 0-9 A-Z _ a-z] "SECTION" !>> [\- 0-9 A-Z _ a-z] "." Data_description_entry* 
  ;

syntax File_section_entry =
  \file-section-entry: File_and_sort_description_entry Data_description_entry+ 
  ;

syntax Linkage_section =
  \linkage-section: "LINKAGE" !>> [\- 0-9 A-Z _ a-z] "SECTION" !>> [\- 0-9 A-Z _ a-z] "." Data_description_entry* 
  ;

syntax File_section =
  \file-section: "FILE" !>> [\- 0-9 A-Z _ a-z] "SECTION" !>> [\- 0-9 A-Z _ a-z] "." File_section_entry* 
  ;

syntax Data_division =
  \data-division: "DATA" !>> [\- 0-9 A-Z _ a-z] "DIVISION" !>> [\- 0-9 A-Z _ a-z] "." Data_division_content 
  ;
