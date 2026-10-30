module lang::vscobolii::\VSC-comm-sec

extend lang::vscobolii::\VSC-expr;

syntax Communication_section = \communication-section: 'COMMUNICATION' 'SECTION' "." Communication_description_entry+;

// a CD entry is followed by the record descriptions of its message area
syntax Communication_description_entry
  = \communication-description-entry: 'CD' Data_name Communication_direction Communication_description_clause* "." Data_description_entry*
  // the input form can also list its eleven data names by position, without the clause keywords
  | \communication-description-entry-positional: 'CD' Data_name Communication_input Alt_data_name_filler+ "." Data_description_entry*
  ;

syntax Communication_direction
  = \communication-direction-initial-input: 'FOR'? 'INITIAL' 'INPUT'
  | \communication-direction-input: 'FOR'? 'INPUT'
  | \communication-direction-output: 'FOR'? 'OUTPUT'
  ;

syntax Communication_input
  = \communication-direction-initial-input: 'FOR'? 'INITIAL' 'INPUT'
  | \communication-direction-input: 'FOR'? 'INPUT'
  ;

syntax Communication_description_clause
  // input clauses
  = \communication-description-clause-symbolic-queue: 'SYMBOLIC'? 'QUEUE' 'IS'? Data_name
  | \communication-description-clause-symbolic-sub-queue-1: 'SYMBOLIC'? 'SUB-QUEUE-1' 'IS'? Data_name
  | \communication-description-clause-symbolic-sub-queue-2: 'SYMBOLIC'? 'SUB-QUEUE-2' 'IS'? Data_name
  | \communication-description-clause-symbolic-sub-queue-3: 'SYMBOLIC'? 'SUB-QUEUE-3' 'IS'? Data_name
  | \communication-description-clause-message-date: 'MESSAGE'? 'DATE' 'IS'? Data_name
  | \communication-description-clause-message-time: 'MESSAGE'? 'TIME' 'IS'? Data_name
  | \communication-description-clause-symbolic-source: 'SYMBOLIC'? 'SOURCE' 'IS'? Data_name
  | \communication-description-clause-text-length: 'TEXT' 'LENGTH' 'IS'? Data_name
  | \communication-description-clause-end-key: 'END' 'KEY' 'IS'? Data_name
  | \communication-description-clause-status-key: 'STATUS' 'KEY' 'IS'? Data_name
  | \communication-description-clause-message-count: 'MESSAGE'? 'COUNT' 'IS'? Data_name
  // output clauses
  | \communication-description-clause-destination-count: 'DESTINATION' 'COUNT' 'IS'? Data_name
  | \communication-description-clause-destination-table: 'DESTINATION' 'TABLE' 'OCCURS' Integer 'TIMES' Indexed_by?
  | \communication-description-clause-error-key: 'ERROR' 'KEY' 'IS'? Data_name
  | \communication-description-clause-symbolic-destination: 'SYMBOLIC'? 'DESTINATION' 'IS'? Data_name
  ;
