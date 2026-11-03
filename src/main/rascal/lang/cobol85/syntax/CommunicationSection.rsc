module lang::cobol85::\syntax::CommunicationSection

extend lang::cobol85::\syntax::Expression;

// the reserved words of this module
keyword CobwordKeywords
  = 'CD'
  | 'COMMUNICATION'
  | 'COUNT'
  | 'DATE'
  | 'END'
  | 'ERROR'
  | 'FOR'
  | 'INITIAL'
  | 'INPUT'
  | 'IS'
  | 'KEY'
  | 'LENGTH'
  | 'MESSAGE'
  | 'OCCURS'
  | 'OUTPUT'
  | 'QUEUE'
  | 'SECTION'
  | 'SOURCE'
  | 'STATUS'
  | 'SUB-QUEUE-1'
  | 'SUB-QUEUE-2'
  | 'SUB-QUEUE-3'
  | 'SYMBOLIC'
  | 'TEXT'
  | 'TIME'
  | 'TIMES'
  ;

syntax Communication_section = communicationSection: 'COMMUNICATION' 'SECTION' "." Communication_description_entry+;

// a CD entry is followed by the record descriptions of its message area
syntax Communication_description_entry
  = cd: 'CD' Data_name Communication_direction Communication_description_clause* "." Data_description_entry*
  // the input form can also list its eleven data names by position, without the clause keywords
  | cdInput: 'CD' Data_name Communication_input Alt_data_name_filler+ "." Data_description_entry*
  ;

syntax Communication_direction
  = initialInput: 'FOR'? 'INITIAL' 'INPUT'
  | input: 'FOR'? 'INPUT'
  | output: 'FOR'? 'OUTPUT'
  ;

syntax Communication_input
  = initialInput: 'FOR'? 'INITIAL' 'INPUT'
  | input: 'FOR'? 'INPUT'
  ;

syntax Communication_description_clause
  // input clauses
  = queue: 'SYMBOLIC'? 'QUEUE' 'IS'? Data_name
  | subQueue1: 'SYMBOLIC'? 'SUB-QUEUE-1' 'IS'? Data_name
  | subQueue2: 'SYMBOLIC'? 'SUB-QUEUE-2' 'IS'? Data_name
  | subQueue3: 'SYMBOLIC'? 'SUB-QUEUE-3' 'IS'? Data_name
  | date: 'MESSAGE'? 'DATE' 'IS'? Data_name
  | time: 'MESSAGE'? 'TIME' 'IS'? Data_name
  | source: 'SYMBOLIC'? 'SOURCE' 'IS'? Data_name
  | text: 'TEXT' 'LENGTH' 'IS'? Data_name
  | end: 'END' 'KEY' 'IS'? Data_name
  | status: 'STATUS' 'KEY' 'IS'? Data_name
  | count: 'MESSAGE'? 'COUNT' 'IS'? Data_name
  // output clauses
  | destinationCount: 'DESTINATION' 'COUNT' 'IS'? Data_name
  | destinationTable: 'DESTINATION' 'TABLE' 'OCCURS' Integer 'TIMES' Indexed_by?
  | error: 'ERROR' 'KEY' 'IS'? Data_name
  | destination: 'SYMBOLIC'? 'DESTINATION' 'IS'? Data_name
  ;
