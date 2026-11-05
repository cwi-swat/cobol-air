module lang::cobol85::\syntax::FileDescriptionEntry

extend lang::cobol85::\syntax::DataDescriptionEntry;
extend lang::cobol85::\syntax::ConfigurationSection;
extend lang::cobol85::\syntax::Lexical;
extend lang::cobol85::\syntax::Expression;

keyword CobwordKeywords
    = 'AT'
    | 'BLOCK'
    | 'BOTTOM'
    | 'CHARACTERS'
    | 'CODE-SET'
    | 'CONTAINS'
    | 'DATA'
    | 'DEPENDING'
    | 'FD'
    | 'FOOTING'
    | 'FROM'
    | 'IN'
    | 'IS'
    | 'LABEL'
    | 'LINAGE'
    | 'LINES'
    | 'MODE'
    | 'OF'
    | 'OMITTED'
    | 'ON'
    | 'RECORD'
    | 'RECORDING'
    | 'RECORDS'
    | 'SD'
    | 'SIZE'
    | 'STANDARD'
    | 'TO'
    | 'TOP'
    | 'VALUE'
    | 'VARYING'
    | 'WITH'
    ;

syntax AltFdSd
    = fd: 'FD'
    | sd: 'SD'
    ;

syntax AltCharactersRecords
    = characters: 'CHARACTERS'
    | records: 'RECORDS'
    | record: 'RECORD'
    ;

syntax FileAndSortDescriptionEntryClause
    = standard: 'LABEL' Records Are? 'STANDARD'
    | omitted: 'LABEL' Records Are? 'OMITTED'
    | label: 'LABEL' Records Are? Id+
    | block: 'BLOCK' 'CONTAINS'? Integer ('TO' Integer)? AltCharactersRecords?
    | linage: 'LINAGE' 'IS'? AltDataNameInteger 'LINES'? LinagePhrase*
    | recording: 'RECORDING' 'MODE'? 'IS'? Id
    | globalClause: GlobalClause
    | record: 'RECORD' 'CONTAINS'? Integer ('TO' Integer)? 'CHARACTERS'?
    // not ('FROM'? Integer)?: rascal 0.43.1-RC1 mishandles some sequence groups, see EnvironmentDivision.rsc
    | varying: 'RECORD' 'IS'? 'VARYING' 'IN'? 'SIZE'? 'FROM'? Integer? ('TO' Integer)? 'CHARACTERS'? ('DEPENDING' 'ON'? Id)?
    | \data: 'DATA' Records Are? Id+
    | \value: 'VALUE' 'OF' ValueOfPhrase+
    | codeSet: 'CODE-SET' 'IS'? Id
    | externalClause: ExternalClause
    ;

// the phrases of LINAGE, in any order; LINES belongs to the number before it
syntax LinagePhrase
    = footing: 'WITH'? 'FOOTING' 'AT'? AltDataNameInteger 'LINES'?
    | top: 'AT'? 'TOP' AltDataNameInteger 'LINES'?
    | bottom: 'AT'? 'BOTTOM' AltDataNameInteger 'LINES'?
    ;

syntax AltQualifiedDataNameLiteral
    = literal: Literal
    | qualifiedDataName: QualifiedDataName
    ;

syntax AltDataNameInteger
    = dataName: Id
    | integer: Integer
    ;

syntax ValueOfPhrase = systemName: Id 'IS'? AltQualifiedDataNameLiteral;
