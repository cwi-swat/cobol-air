  module lang::vscobolii::\VSC-data-div  extend lang::vscobolii::\VSC-fd-entry;
extend lang::vscobolii::\VSC-dd-entry; 
syntax File_section_entry =
   \file-section-entry: Alt_fd_sd File_name File_and_sort_description_entry_clauses "."Data_description_entry+ 
  ;
