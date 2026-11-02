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
   \environment-division: 'ENVIRONMENT' 'DIVISION' "."
 // the rest of the environment division, and possibly the data and procedure divisions, can come from a copybook
 |  \environment-division: 'ENVIRONMENT' 'DIVISION' "." Copy_statement
 |  \environment-division: 'ENVIRONMENT' 'DIVISION' "." 'INPUT-OUTPUT' 'SECTION' "."
 |  \environment-division: 'ENVIRONMENT' 'DIVISION' "." 'INPUT-OUTPUT' 'SECTION' "." 'I-O-CONTROL' "."
 |  \environment-division: 'ENVIRONMENT' 'DIVISION' "." 'INPUT-OUTPUT' 'SECTION' "." 'I-O-CONTROL' "." Copy_statement
 |  \environment-division: 'ENVIRONMENT' 'DIVISION' "." 'INPUT-OUTPUT' 'SECTION' "." 'I-O-CONTROL' "." 'RERUN' 'ON' Assignment_name  Same_area+  "."
 |  \environment-division: 'ENVIRONMENT' 'DIVISION' "." 'INPUT-OUTPUT' 'SECTION' "." 'I-O-CONTROL' "." Qsam_or_sam_or_vsam_i_o_control_entries+ "."
 |  \environment-division: 'ENVIRONMENT' 'DIVISION' "." 'INPUT-OUTPUT' 'SECTION' "." 'I-O-CONTROL' "." Qsam_or_sam_or_vsam_i_o_control_entries+ "." Same_area+  "."
 |  \environment-division: 'ENVIRONMENT' 'DIVISION' "." 'INPUT-OUTPUT' 'SECTION' "." 'I-O-CONTROL' "." Qsam_or_sam_or_vsam_i_o_control_entries+ "." 'RERUN' 'ON' Assignment_name  Same_area+  "."
 |  \environment-division: 'ENVIRONMENT' 'DIVISION' "." 'INPUT-OUTPUT' 'SECTION' "." 'FILE-CONTROL' "." File_control_entry*
 |  \environment-division: 'ENVIRONMENT' 'DIVISION' "." 'INPUT-OUTPUT' 'SECTION' "." 'FILE-CONTROL' "." File_control_entry* 'I-O-CONTROL' "."
 |  \environment-division: 'ENVIRONMENT' 'DIVISION' "." 'INPUT-OUTPUT' 'SECTION' "." 'FILE-CONTROL' "." File_control_entry* 'I-O-CONTROL' "." Copy_statement
 |  \environment-division: 'ENVIRONMENT' 'DIVISION' "." 'INPUT-OUTPUT' 'SECTION' "." 'FILE-CONTROL' "." File_control_entry* 'I-O-CONTROL' "." 'RERUN' 'ON' Assignment_name  Same_area+  "."
 |  \environment-division: 'ENVIRONMENT' 'DIVISION' "." 'INPUT-OUTPUT' 'SECTION' "." 'FILE-CONTROL' "." File_control_entry* 'I-O-CONTROL' "." Qsam_or_sam_or_vsam_i_o_control_entries+ "."
 |  \environment-division: 'ENVIRONMENT' 'DIVISION' "." 'INPUT-OUTPUT' 'SECTION' "." 'FILE-CONTROL' "." File_control_entry* 'I-O-CONTROL' "." Qsam_or_sam_or_vsam_i_o_control_entries+ "." Same_area+  "."
 |  \environment-division: 'ENVIRONMENT' 'DIVISION' "." 'INPUT-OUTPUT' 'SECTION' "." 'FILE-CONTROL' "." File_control_entry* 'I-O-CONTROL' "." Qsam_or_sam_or_vsam_i_o_control_entries+ "." 'RERUN' 'ON' Assignment_name  Same_area+  "."
 |  \environment-division: 'ENVIRONMENT' 'DIVISION' "." 'CONFIGURATION' 'SECTION' "." Configuration_section_paragraph*
 |  \environment-division: 'ENVIRONMENT' 'DIVISION' "." 'CONFIGURATION' 'SECTION' "." Configuration_section_paragraph* 'INPUT-OUTPUT' 'SECTION' "."
 |  \environment-division: 'ENVIRONMENT' 'DIVISION' "." 'CONFIGURATION' 'SECTION' "." Configuration_section_paragraph* 'INPUT-OUTPUT' 'SECTION' "." 'I-O-CONTROL' "."
 |  \environment-division: 'ENVIRONMENT' 'DIVISION' "." 'CONFIGURATION' 'SECTION' "." Configuration_section_paragraph* 'INPUT-OUTPUT' 'SECTION' "." 'I-O-CONTROL' "." Copy_statement
 |  \environment-division: 'ENVIRONMENT' 'DIVISION' "." 'CONFIGURATION' 'SECTION' "." Configuration_section_paragraph* 'INPUT-OUTPUT' 'SECTION' "." 'I-O-CONTROL' "." 'RERUN' 'ON' Assignment_name  Same_area+  "."
 |  \environment-division: 'ENVIRONMENT' 'DIVISION' "." 'CONFIGURATION' 'SECTION' "." Configuration_section_paragraph* 'INPUT-OUTPUT' 'SECTION' "." 'I-O-CONTROL' "." Qsam_or_sam_or_vsam_i_o_control_entries+ "."
 |  \environment-division: 'ENVIRONMENT' 'DIVISION' "." 'CONFIGURATION' 'SECTION' "." Configuration_section_paragraph* 'INPUT-OUTPUT' 'SECTION' "." 'I-O-CONTROL' "." Qsam_or_sam_or_vsam_i_o_control_entries+ "." Same_area+  "."
 |  \environment-division: 'ENVIRONMENT' 'DIVISION' "." 'CONFIGURATION' 'SECTION' "." Configuration_section_paragraph* 'INPUT-OUTPUT' 'SECTION' "." 'I-O-CONTROL' "." Qsam_or_sam_or_vsam_i_o_control_entries+ "." 'RERUN' 'ON' Assignment_name  Same_area+  "."
 |  \environment-division: 'ENVIRONMENT' 'DIVISION' "." 'CONFIGURATION' 'SECTION' "." Configuration_section_paragraph* 'INPUT-OUTPUT' 'SECTION' "." 'FILE-CONTROL' "." File_control_entry*
 |  \environment-division: 'ENVIRONMENT' 'DIVISION' "." 'CONFIGURATION' 'SECTION' "." Configuration_section_paragraph* 'INPUT-OUTPUT' 'SECTION' "." 'FILE-CONTROL' "." File_control_entry* 'I-O-CONTROL' "."
 |  \environment-division: 'ENVIRONMENT' 'DIVISION' "." 'CONFIGURATION' 'SECTION' "." Configuration_section_paragraph* 'INPUT-OUTPUT' 'SECTION' "." 'FILE-CONTROL' "." File_control_entry* 'I-O-CONTROL' "." Copy_statement
 |  \environment-division: 'ENVIRONMENT' 'DIVISION' "." 'CONFIGURATION' 'SECTION' "." Configuration_section_paragraph* 'INPUT-OUTPUT' 'SECTION' "." 'FILE-CONTROL' "." File_control_entry* 'I-O-CONTROL' "." 'RERUN' 'ON' Assignment_name  Same_area+  "."
 |  \environment-division: 'ENVIRONMENT' 'DIVISION' "." 'CONFIGURATION' 'SECTION' "." Configuration_section_paragraph* 'INPUT-OUTPUT' 'SECTION' "." 'FILE-CONTROL' "." File_control_entry* 'I-O-CONTROL' "." Qsam_or_sam_or_vsam_i_o_control_entries+ "."
 |  \environment-division: 'ENVIRONMENT' 'DIVISION' "." 'CONFIGURATION' 'SECTION' "." Configuration_section_paragraph* 'INPUT-OUTPUT' 'SECTION' "." 'FILE-CONTROL' "." File_control_entry* 'I-O-CONTROL' "." Qsam_or_sam_or_vsam_i_o_control_entries+ "." Same_area+  "."
 |  \environment-division: 'ENVIRONMENT' 'DIVISION' "." 'CONFIGURATION' 'SECTION' "." Configuration_section_paragraph* 'INPUT-OUTPUT' 'SECTION' "." 'FILE-CONTROL' "." File_control_entry* 'I-O-CONTROL' "." Qsam_or_sam_or_vsam_i_o_control_entries+ "." 'RERUN' 'ON' Assignment_name  Same_area+  "." 
  ;

