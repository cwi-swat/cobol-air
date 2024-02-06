module lang::vscobolii::\VSC-env-div 

extend lang::vscobolii::\VSC-conf-sec;
extend lang::vscobolii::\VSC-io-sec;


syntax Environment_division =
   \environment-division: 'ENVIRONMENT' 'DIVISION' "."
 |  \environment-division: 'ENVIRONMENT' 'DIVISION' "." 'INPUT-OUTPUT' 'SECTION' "."
 |  \environment-division: 'ENVIRONMENT' 'DIVISION' "." 'INPUT-OUTPUT' 'SECTION' "." 'I-O-CONTROL' "."
 |  \environment-division: 'ENVIRONMENT' 'DIVISION' "." 'INPUT-OUTPUT' 'SECTION' "." 'I-O-CONTROL' "." Same_area+  "."
 |  \environment-division: 'ENVIRONMENT' 'DIVISION' "." 'INPUT-OUTPUT' 'SECTION' "." 'I-O-CONTROL' "." 'RERUN' 'ON' Assignment_name  Same_area+  "."
 |  \environment-division: 'ENVIRONMENT' 'DIVISION' "." 'INPUT-OUTPUT' 'SECTION' "." 'I-O-CONTROL' "." Qsam_or_sam_or_vsam_i_o_control_entries+ "."
 |  \environment-division: 'ENVIRONMENT' 'DIVISION' "." 'INPUT-OUTPUT' 'SECTION' "." 'I-O-CONTROL' "." Qsam_or_sam_or_vsam_i_o_control_entries+ "." Same_area+  "."
 |  \environment-division: 'ENVIRONMENT' 'DIVISION' "." 'INPUT-OUTPUT' 'SECTION' "." 'I-O-CONTROL' "." Qsam_or_sam_or_vsam_i_o_control_entries+ "." 'RERUN' 'ON' Assignment_name  Same_area+  "."
 |  \environment-division: 'ENVIRONMENT' 'DIVISION' "." 'INPUT-OUTPUT' 'SECTION' "." 'FILE-CONTROL' "." File_control_entry*
 |  \environment-division: 'ENVIRONMENT' 'DIVISION' "." 'INPUT-OUTPUT' 'SECTION' "." 'FILE-CONTROL' "." File_control_entry* 'I-O-CONTROL' "."
 |  \environment-division: 'ENVIRONMENT' 'DIVISION' "." 'INPUT-OUTPUT' 'SECTION' "." 'FILE-CONTROL' "." File_control_entry* 'I-O-CONTROL' "." Same_area+  "."
 |  \environment-division: 'ENVIRONMENT' 'DIVISION' "." 'INPUT-OUTPUT' 'SECTION' "." 'FILE-CONTROL' "." File_control_entry* 'I-O-CONTROL' "." 'RERUN' 'ON' Assignment_name  Same_area+  "."
 |  \environment-division: 'ENVIRONMENT' 'DIVISION' "." 'INPUT-OUTPUT' 'SECTION' "." 'FILE-CONTROL' "." File_control_entry* 'I-O-CONTROL' "." Qsam_or_sam_or_vsam_i_o_control_entries+ "."
 |  \environment-division: 'ENVIRONMENT' 'DIVISION' "." 'INPUT-OUTPUT' 'SECTION' "." 'FILE-CONTROL' "." File_control_entry* 'I-O-CONTROL' "." Qsam_or_sam_or_vsam_i_o_control_entries+ "." Same_area+  "."
 |  \environment-division: 'ENVIRONMENT' 'DIVISION' "." 'INPUT-OUTPUT' 'SECTION' "." 'FILE-CONTROL' "." File_control_entry* 'I-O-CONTROL' "." Qsam_or_sam_or_vsam_i_o_control_entries+ "." 'RERUN' 'ON' Assignment_name  Same_area+  "."
 |  \environment-division: 'ENVIRONMENT' 'DIVISION' "." 'CONFIGURATION' 'SECTION' "." Configuration_section_paragraph*
 |  \environment-division: 'ENVIRONMENT' 'DIVISION' "." 'CONFIGURATION' 'SECTION' "." Configuration_section_paragraph* 'INPUT-OUTPUT' 'SECTION' "."
 |  \environment-division: 'ENVIRONMENT' 'DIVISION' "." 'CONFIGURATION' 'SECTION' "." Configuration_section_paragraph* 'INPUT-OUTPUT' 'SECTION' "." 'I-O-CONTROL' "."
 |  \environment-division: 'ENVIRONMENT' 'DIVISION' "." 'CONFIGURATION' 'SECTION' "." Configuration_section_paragraph* 'INPUT-OUTPUT' 'SECTION' "." 'I-O-CONTROL' "." Same_area+  "."
 |  \environment-division: 'ENVIRONMENT' 'DIVISION' "." 'CONFIGURATION' 'SECTION' "." Configuration_section_paragraph* 'INPUT-OUTPUT' 'SECTION' "." 'I-O-CONTROL' "." 'RERUN' 'ON' Assignment_name  Same_area+  "."
 |  \environment-division: 'ENVIRONMENT' 'DIVISION' "." 'CONFIGURATION' 'SECTION' "." Configuration_section_paragraph* 'INPUT-OUTPUT' 'SECTION' "." 'I-O-CONTROL' "." Qsam_or_sam_or_vsam_i_o_control_entries+ "."
 |  \environment-division: 'ENVIRONMENT' 'DIVISION' "." 'CONFIGURATION' 'SECTION' "." Configuration_section_paragraph* 'INPUT-OUTPUT' 'SECTION' "." 'I-O-CONTROL' "." Qsam_or_sam_or_vsam_i_o_control_entries+ "." Same_area+  "."
 |  \environment-division: 'ENVIRONMENT' 'DIVISION' "." 'CONFIGURATION' 'SECTION' "." Configuration_section_paragraph* 'INPUT-OUTPUT' 'SECTION' "." 'I-O-CONTROL' "." Qsam_or_sam_or_vsam_i_o_control_entries+ "." 'RERUN' 'ON' Assignment_name  Same_area+  "."
 |  \environment-division: 'ENVIRONMENT' 'DIVISION' "." 'CONFIGURATION' 'SECTION' "." Configuration_section_paragraph* 'INPUT-OUTPUT' 'SECTION' "." 'FILE-CONTROL' "." File_control_entry*
 |  \environment-division: 'ENVIRONMENT' 'DIVISION' "." 'CONFIGURATION' 'SECTION' "." Configuration_section_paragraph* 'INPUT-OUTPUT' 'SECTION' "." 'FILE-CONTROL' "." File_control_entry* 'I-O-CONTROL' "."
 |  \environment-division: 'ENVIRONMENT' 'DIVISION' "." 'CONFIGURATION' 'SECTION' "." Configuration_section_paragraph* 'INPUT-OUTPUT' 'SECTION' "." 'FILE-CONTROL' "." File_control_entry* 'I-O-CONTROL' "." Same_area+  "."
 |  \environment-division: 'ENVIRONMENT' 'DIVISION' "." 'CONFIGURATION' 'SECTION' "." Configuration_section_paragraph* 'INPUT-OUTPUT' 'SECTION' "." 'FILE-CONTROL' "." File_control_entry* 'I-O-CONTROL' "." 'RERUN' 'ON' Assignment_name  Same_area+  "."
 |  \environment-division: 'ENVIRONMENT' 'DIVISION' "." 'CONFIGURATION' 'SECTION' "." Configuration_section_paragraph* 'INPUT-OUTPUT' 'SECTION' "." 'FILE-CONTROL' "." File_control_entry* 'I-O-CONTROL' "." Qsam_or_sam_or_vsam_i_o_control_entries+ "."
 |  \environment-division: 'ENVIRONMENT' 'DIVISION' "." 'CONFIGURATION' 'SECTION' "." Configuration_section_paragraph* 'INPUT-OUTPUT' 'SECTION' "." 'FILE-CONTROL' "." File_control_entry* 'I-O-CONTROL' "." Qsam_or_sam_or_vsam_i_o_control_entries+ "." Same_area+  "."
 |  \environment-division: 'ENVIRONMENT' 'DIVISION' "." 'CONFIGURATION' 'SECTION' "." Configuration_section_paragraph* 'INPUT-OUTPUT' 'SECTION' "." 'FILE-CONTROL' "." File_control_entry* 'I-O-CONTROL' "." Qsam_or_sam_or_vsam_i_o_control_entries+ "." 'RERUN' 'ON' Assignment_name  Same_area+  "." 
  ;

syntax Environment_division_content =
   \environment-division-content: 
 |  \environment-division-content: 'CONFIGURATION' 'SECTION' "." Configuration_section_paragraph*
 |  \environment-division-content: 'INPUT-OUTPUT' 'SECTION' "."
 |  \environment-division-content: 'CONFIGURATION' 'SECTION' "." Configuration_section_paragraph*  'INPUT-OUTPUT' 'SECTION' "."
 |  \environment-division-content: 'INPUT-OUTPUT' 'SECTION' "." 'I-O-CONTROL' "."
 |  \environment-division-content: 'CONFIGURATION' 'SECTION' "." Configuration_section_paragraph*  'INPUT-OUTPUT' 'SECTION' "." 'I-O-CONTROL' "."
 |  \environment-division-content: 'INPUT-OUTPUT' 'SECTION' "." 'I-O-CONTROL' "." Same_area+  "."
 |  \environment-division-content: 'CONFIGURATION' 'SECTION' "." Configuration_section_paragraph*  'INPUT-OUTPUT' 'SECTION' "." 'I-O-CONTROL' "." Same_area+  "."
 |  \environment-division-content: 'INPUT-OUTPUT' 'SECTION' "." 'I-O-CONTROL' "." 'RERUN' 'ON' Assignment_name  Same_area+  "."
 |  \environment-division-content: 'CONFIGURATION' 'SECTION' "." Configuration_section_paragraph*  'INPUT-OUTPUT' 'SECTION' "." 'I-O-CONTROL' "." 'RERUN' 'ON' Assignment_name  Same_area+  "."
 |  \environment-division-content: 'INPUT-OUTPUT' 'SECTION' "." 'I-O-CONTROL' "." Qsam_or_sam_or_vsam_i_o_control_entries+ "."
 |  \environment-division-content: 'CONFIGURATION' 'SECTION' "." Configuration_section_paragraph*  'INPUT-OUTPUT' 'SECTION' "." 'I-O-CONTROL' "." Qsam_or_sam_or_vsam_i_o_control_entries+ "."
 |  \environment-division-content: 'INPUT-OUTPUT' 'SECTION' "." 'I-O-CONTROL' "." Qsam_or_sam_or_vsam_i_o_control_entries+ "." Same_area+  "."
 |  \environment-division-content: 'CONFIGURATION' 'SECTION' "." Configuration_section_paragraph*  'INPUT-OUTPUT' 'SECTION' "." 'I-O-CONTROL' "." Qsam_or_sam_or_vsam_i_o_control_entries+ "." Same_area+  "."
 |  \environment-division-content: 'INPUT-OUTPUT' 'SECTION' "." 'I-O-CONTROL' "." Qsam_or_sam_or_vsam_i_o_control_entries+ "." 'RERUN' 'ON' Assignment_name  Same_area+  "."
 |  \environment-division-content: 'CONFIGURATION' 'SECTION' "." Configuration_section_paragraph*  'INPUT-OUTPUT' 'SECTION' "." 'I-O-CONTROL' "." Qsam_or_sam_or_vsam_i_o_control_entries+ "." 'RERUN' 'ON' Assignment_name  Same_area+  "."
 |  \environment-division-content: 'INPUT-OUTPUT' 'SECTION' "." 'FILE-CONTROL' "." File_control_entry*
 |  \environment-division-content: 'CONFIGURATION' 'SECTION' "." Configuration_section_paragraph*  'INPUT-OUTPUT' 'SECTION' "." 'FILE-CONTROL' "." File_control_entry*
 |  \environment-division-content: 'INPUT-OUTPUT' 'SECTION' "." 'FILE-CONTROL' "." File_control_entry* 'I-O-CONTROL' "."
 |  \environment-division-content: 'CONFIGURATION' 'SECTION' "." Configuration_section_paragraph*  'INPUT-OUTPUT' 'SECTION' "." 'FILE-CONTROL' "." File_control_entry* 'I-O-CONTROL' "."
 |  \environment-division-content: 'INPUT-OUTPUT' 'SECTION' "." 'FILE-CONTROL' "." File_control_entry* 'I-O-CONTROL' "." Same_area+  "."
 |  \environment-division-content: 'CONFIGURATION' 'SECTION' "." Configuration_section_paragraph*  'INPUT-OUTPUT' 'SECTION' "." 'FILE-CONTROL' "." File_control_entry* 'I-O-CONTROL' "." Same_area+  "."
 |  \environment-division-content: 'INPUT-OUTPUT' 'SECTION' "." 'FILE-CONTROL' "." File_control_entry* 'I-O-CONTROL' "." 'RERUN' 'ON' Assignment_name  Same_area+  "."
 |  \environment-division-content: 'CONFIGURATION' 'SECTION' "." Configuration_section_paragraph*  'INPUT-OUTPUT' 'SECTION' "." 'FILE-CONTROL' "." File_control_entry* 'I-O-CONTROL' "." 'RERUN' 'ON' Assignment_name  Same_area+  "."
 |  \environment-division-content: 'INPUT-OUTPUT' 'SECTION' "." 'FILE-CONTROL' "." File_control_entry* 'I-O-CONTROL' "." Qsam_or_sam_or_vsam_i_o_control_entries+ "."
 |  \environment-division-content: 'CONFIGURATION' 'SECTION' "." Configuration_section_paragraph*  'INPUT-OUTPUT' 'SECTION' "." 'FILE-CONTROL' "." File_control_entry* 'I-O-CONTROL' "." Qsam_or_sam_or_vsam_i_o_control_entries+ "."
 |  \environment-division-content: 'INPUT-OUTPUT' 'SECTION' "." 'FILE-CONTROL' "." File_control_entry* 'I-O-CONTROL' "." Qsam_or_sam_or_vsam_i_o_control_entries+ "." Same_area+  "."
 |  \environment-division-content: 'CONFIGURATION' 'SECTION' "." Configuration_section_paragraph*  'INPUT-OUTPUT' 'SECTION' "." 'FILE-CONTROL' "." File_control_entry* 'I-O-CONTROL' "." Qsam_or_sam_or_vsam_i_o_control_entries+ "." Same_area+  "."
 |  \environment-division-content: 'INPUT-OUTPUT' 'SECTION' "." 'FILE-CONTROL' "." File_control_entry* 'I-O-CONTROL' "." Qsam_or_sam_or_vsam_i_o_control_entries+ "." 'RERUN' 'ON' Assignment_name  Same_area+  "."
 |  \environment-division-content: 'CONFIGURATION' 'SECTION' "." Configuration_section_paragraph*  'INPUT-OUTPUT' 'SECTION' "." 'FILE-CONTROL' "." File_control_entry* 'I-O-CONTROL' "." Qsam_or_sam_or_vsam_i_o_control_entries+ "." 'RERUN' 'ON' Assignment_name  Same_area+  "." 
  ;
