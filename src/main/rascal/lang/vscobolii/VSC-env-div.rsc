 module lang::vscobolii::\VSC-env-div  extend lang::vscobolii::\VSC-conf-sec;
extend lang::vscobolii::\VSC-io-sec;


syntax Environment_division =
   \environment-division: 'ENVIRONMENT' 'DIVISION' "." Configuration_section? Input_output_section? 
  ;
