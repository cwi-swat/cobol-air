 module lang::vscobolii::\VSC-env-div  extend lang::vscobolii::\VSC-conf-sec;
extend lang::vscobolii::\VSC-io-sec;


syntax Environment_division =
    \environment-division: 'ENVIRONMENT' 'DIVISION' "." Input_output_section?
|  \environment-division: 'ENVIRONMENT' 'DIVISION' "." 'CONFIGURATION' 'SECTION' "." Configuration_section_paragraph* Input_output_section? 
  ;
