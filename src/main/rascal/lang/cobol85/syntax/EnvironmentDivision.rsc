 module lang::cobol85::\syntax::EnvironmentDivision  extend lang::cobol85::\syntax::ConfigurationSection;
extend lang::cobol85::\syntax::InputOutputSection;

// the reserved words of this module
keyword CobwordKeywords
  = 'CONFIGURATION'
  | 'DIVISION'
  | 'ENVIRONMENT'
  | 'FILE-CONTROL'
  | 'I-O-CONTROL'
  | 'INPUT-OUTPUT'
  | 'ON'
  | 'RERUN'
  | 'SECTION'
  ;


syntax Environment_division =
   environmentDivision: 'ENVIRONMENT' 'DIVISION' "."
 // the rest of the environment division, and possibly the data and procedure divisions, can come from a copybook
 |  environmentDivision: 'ENVIRONMENT' 'DIVISION' "." Copy_statement
 |  environmentDivision: 'ENVIRONMENT' 'DIVISION' "." 'INPUT-OUTPUT' 'SECTION' "."
 |  environmentDivision: 'ENVIRONMENT' 'DIVISION' "." 'INPUT-OUTPUT' 'SECTION' "." 'I-O-CONTROL' "."
 |  environmentDivision: 'ENVIRONMENT' 'DIVISION' "." 'INPUT-OUTPUT' 'SECTION' "." 'I-O-CONTROL' "." Copy_statement
 |  environmentDivision: 'ENVIRONMENT' 'DIVISION' "." 'INPUT-OUTPUT' 'SECTION' "." 'I-O-CONTROL' "." 'RERUN' 'ON' Id  Same_area+  "."
 |  environmentDivision: 'ENVIRONMENT' 'DIVISION' "." 'INPUT-OUTPUT' 'SECTION' "." 'I-O-CONTROL' "." Qsam_or_sam_or_vsam_i_o_control_entries+ "."
 |  environmentDivision: 'ENVIRONMENT' 'DIVISION' "." 'INPUT-OUTPUT' 'SECTION' "." 'I-O-CONTROL' "." Qsam_or_sam_or_vsam_i_o_control_entries+ "." Same_area+  "."
 |  environmentDivision: 'ENVIRONMENT' 'DIVISION' "." 'INPUT-OUTPUT' 'SECTION' "." 'I-O-CONTROL' "." Qsam_or_sam_or_vsam_i_o_control_entries+ "." 'RERUN' 'ON' Id  Same_area+  "."
 |  environmentDivision: 'ENVIRONMENT' 'DIVISION' "." 'INPUT-OUTPUT' 'SECTION' "." 'FILE-CONTROL' "." File_control_entry*
 |  environmentDivision: 'ENVIRONMENT' 'DIVISION' "." 'INPUT-OUTPUT' 'SECTION' "." 'FILE-CONTROL' "." File_control_entry* 'I-O-CONTROL' "."
 |  environmentDivision: 'ENVIRONMENT' 'DIVISION' "." 'INPUT-OUTPUT' 'SECTION' "." 'FILE-CONTROL' "." File_control_entry* 'I-O-CONTROL' "." Copy_statement
 |  environmentDivision: 'ENVIRONMENT' 'DIVISION' "." 'INPUT-OUTPUT' 'SECTION' "." 'FILE-CONTROL' "." File_control_entry* 'I-O-CONTROL' "." 'RERUN' 'ON' Id  Same_area+  "."
 |  environmentDivision: 'ENVIRONMENT' 'DIVISION' "." 'INPUT-OUTPUT' 'SECTION' "." 'FILE-CONTROL' "." File_control_entry* 'I-O-CONTROL' "." Qsam_or_sam_or_vsam_i_o_control_entries+ "."
 |  environmentDivision: 'ENVIRONMENT' 'DIVISION' "." 'INPUT-OUTPUT' 'SECTION' "." 'FILE-CONTROL' "." File_control_entry* 'I-O-CONTROL' "." Qsam_or_sam_or_vsam_i_o_control_entries+ "." Same_area+  "."
 |  environmentDivision: 'ENVIRONMENT' 'DIVISION' "." 'INPUT-OUTPUT' 'SECTION' "." 'FILE-CONTROL' "." File_control_entry* 'I-O-CONTROL' "." Qsam_or_sam_or_vsam_i_o_control_entries+ "." 'RERUN' 'ON' Id  Same_area+  "."
 |  environmentDivision: 'ENVIRONMENT' 'DIVISION' "." 'CONFIGURATION' 'SECTION' "." Configuration_section_paragraph*
 |  environmentDivision: 'ENVIRONMENT' 'DIVISION' "." 'CONFIGURATION' 'SECTION' "." Configuration_section_paragraph* 'INPUT-OUTPUT' 'SECTION' "."
 |  environmentDivision: 'ENVIRONMENT' 'DIVISION' "." 'CONFIGURATION' 'SECTION' "." Configuration_section_paragraph* 'INPUT-OUTPUT' 'SECTION' "." 'I-O-CONTROL' "."
 |  environmentDivision: 'ENVIRONMENT' 'DIVISION' "." 'CONFIGURATION' 'SECTION' "." Configuration_section_paragraph* 'INPUT-OUTPUT' 'SECTION' "." 'I-O-CONTROL' "." Copy_statement
 |  environmentDivision: 'ENVIRONMENT' 'DIVISION' "." 'CONFIGURATION' 'SECTION' "." Configuration_section_paragraph* 'INPUT-OUTPUT' 'SECTION' "." 'I-O-CONTROL' "." 'RERUN' 'ON' Id  Same_area+  "."
 |  environmentDivision: 'ENVIRONMENT' 'DIVISION' "." 'CONFIGURATION' 'SECTION' "." Configuration_section_paragraph* 'INPUT-OUTPUT' 'SECTION' "." 'I-O-CONTROL' "." Qsam_or_sam_or_vsam_i_o_control_entries+ "."
 |  environmentDivision: 'ENVIRONMENT' 'DIVISION' "." 'CONFIGURATION' 'SECTION' "." Configuration_section_paragraph* 'INPUT-OUTPUT' 'SECTION' "." 'I-O-CONTROL' "." Qsam_or_sam_or_vsam_i_o_control_entries+ "." Same_area+  "."
 |  environmentDivision: 'ENVIRONMENT' 'DIVISION' "." 'CONFIGURATION' 'SECTION' "." Configuration_section_paragraph* 'INPUT-OUTPUT' 'SECTION' "." 'I-O-CONTROL' "." Qsam_or_sam_or_vsam_i_o_control_entries+ "." 'RERUN' 'ON' Id  Same_area+  "."
 |  environmentDivision: 'ENVIRONMENT' 'DIVISION' "." 'CONFIGURATION' 'SECTION' "." Configuration_section_paragraph* 'INPUT-OUTPUT' 'SECTION' "." 'FILE-CONTROL' "." File_control_entry*
 |  environmentDivision: 'ENVIRONMENT' 'DIVISION' "." 'CONFIGURATION' 'SECTION' "." Configuration_section_paragraph* 'INPUT-OUTPUT' 'SECTION' "." 'FILE-CONTROL' "." File_control_entry* 'I-O-CONTROL' "."
 |  environmentDivision: 'ENVIRONMENT' 'DIVISION' "." 'CONFIGURATION' 'SECTION' "." Configuration_section_paragraph* 'INPUT-OUTPUT' 'SECTION' "." 'FILE-CONTROL' "." File_control_entry* 'I-O-CONTROL' "." Copy_statement
 |  environmentDivision: 'ENVIRONMENT' 'DIVISION' "." 'CONFIGURATION' 'SECTION' "." Configuration_section_paragraph* 'INPUT-OUTPUT' 'SECTION' "." 'FILE-CONTROL' "." File_control_entry* 'I-O-CONTROL' "." 'RERUN' 'ON' Id  Same_area+  "."
 |  environmentDivision: 'ENVIRONMENT' 'DIVISION' "." 'CONFIGURATION' 'SECTION' "." Configuration_section_paragraph* 'INPUT-OUTPUT' 'SECTION' "." 'FILE-CONTROL' "." File_control_entry* 'I-O-CONTROL' "." Qsam_or_sam_or_vsam_i_o_control_entries+ "."
 |  environmentDivision: 'ENVIRONMENT' 'DIVISION' "." 'CONFIGURATION' 'SECTION' "." Configuration_section_paragraph* 'INPUT-OUTPUT' 'SECTION' "." 'FILE-CONTROL' "." File_control_entry* 'I-O-CONTROL' "." Qsam_or_sam_or_vsam_i_o_control_entries+ "." Same_area+  "."
 |  environmentDivision: 'ENVIRONMENT' 'DIVISION' "." 'CONFIGURATION' 'SECTION' "." Configuration_section_paragraph* 'INPUT-OUTPUT' 'SECTION' "." 'FILE-CONTROL' "." File_control_entry* 'I-O-CONTROL' "." Qsam_or_sam_or_vsam_i_o_control_entries+ "." 'RERUN' 'ON' Id  Same_area+  "." 
  ;

