module lang::cobol85::\syntax::CommunicationSection

extend lang::cobol85::\syntax::Expression;
extend lang::cobol85::\syntax::DataDescriptionEntry;
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

syntax CommunicationSection = communicationSection: 'COMMUNICATION' 'SECTION' "." CommunicationDescriptionEntry+;
syntax CommunicationDescriptionEntry
    = cd: 'CD' Id CommunicationDirection CommunicationDescriptionClause* "." DataDescriptionEntry*
    // the input form can also list its eleven data names by position, without the clause keywords
    | cdInput: 'CD' Id CommunicationInput AltDataNameFiller+ "." DataDescriptionEntry*
    ;

syntax CommunicationDirection
    = initialInput: 'FOR'? 'INITIAL' 'INPUT'
    | input: 'FOR'? 'INPUT'
    | output: 'FOR'? 'OUTPUT'
    ;

syntax CommunicationInput
    = initialInput: 'FOR'? 'INITIAL' 'INPUT'
    | input: 'FOR'? 'INPUT'
    ;

syntax CommunicationDescriptionClause
    // input clauses
    = queue: 'SYMBOLIC'? 'QUEUE' 'IS'? Id
    | subQueue1: 'SYMBOLIC'? 'SUB-QUEUE-1' 'IS'? Id
    | subQueue2: 'SYMBOLIC'? 'SUB-QUEUE-2' 'IS'? Id
    | subQueue3: 'SYMBOLIC'? 'SUB-QUEUE-3' 'IS'? Id
    | date: 'MESSAGE'? 'DATE' 'IS'? Id
    | time: 'MESSAGE'? 'TIME' 'IS'? Id
    | source: 'SYMBOLIC'? 'SOURCE' 'IS'? Id
    | text: 'TEXT' 'LENGTH' 'IS'? Id
    | end: 'END' 'KEY' 'IS'? Id
    | status: 'STATUS' 'KEY' 'IS'? Id
    | count: 'MESSAGE'? 'COUNT' 'IS'? Id
    // output clauses
    | destinationCount: 'DESTINATION' 'COUNT' 'IS'? Id
    | destinationTable: 'DESTINATION' 'TABLE' 'OCCURS' Integer 'TIMES' IndexedBy?
    | error: 'ERROR' 'KEY' 'IS'? Id
    | destination: 'SYMBOLIC'? 'DESTINATION' 'IS'? Id
    ;
