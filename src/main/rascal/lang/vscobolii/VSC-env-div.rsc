module lang::vscobolii::\VSC-env-div 

extend lang::vscobolii::\VSC-conf-sec;
extend lang::vscobolii::\VSC-io-sec;


syntax Environment_division =
  \environment-division: "ENVIRONMENT" !>> [\- 0-9 A-Z _ a-z] "DIVISION" !>> [\- 0-9 A-Z _ a-z] "." Environment_division_content 
  ;

syntax Environment_division_content =
  \environment-division-content: Configuration_section? Input_output_section? 
  ;
