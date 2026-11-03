module lang::cobol85::\syntax::FileDescriptionEntry

extend lang::cobol85::\syntax::DataDescriptionEntry;
extend lang::cobol85::\syntax::ConfigurationSection;
extend lang::cobol85::\syntax::Lexical;
extend lang::cobol85::\syntax::Expression;

// the reserved words of this module
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
syntax LabelRecordsClauseTail
  = standard: 'STANDARD'
  | omitted: 'OMITTED'
  | dataName: Id+
  ;
syntax AltFdSd
  = fd: 'FD'
  | sd: 'SD'
  ;
syntax RecordClauseTail
  = to: 'CONTAINS'? Integer 'TO' Integer 'CHARACTERS'?
  | integer: 'CONTAINS'? Integer 'CHARACTERS'?
  | varying: 'IS'? 'VARYING' 'IN'? 'SIZE'? 'CHARACTERS'?
  | varying: 'IS'? 'VARYING' 'IN'? 'SIZE'? 'CHARACTERS'? 'DEPENDING' 'ON'? Id
  | varying: 'IS'? 'VARYING' 'IN'? 'SIZE'? 'TO' Integer 'CHARACTERS'?
  | varying: 'IS'? 'VARYING' 'IN'? 'SIZE'? 'TO' Integer 'CHARACTERS'? 'DEPENDING' 'ON'? Id
  | varying: 'IS'? 'VARYING' 'IN'? 'SIZE'? 'FROM'? Integer 'CHARACTERS'?
  | varying: 'IS'? 'VARYING' 'IN'? 'SIZE'? 'FROM'? Integer 'CHARACTERS'? 'DEPENDING' 'ON'? Id
  | varying: 'IS'? 'VARYING' 'IN'? 'SIZE'? 'FROM'? Integer 'TO' Integer 'CHARACTERS'?
  | varying: 'IS'? 'VARYING' 'IN'? 'SIZE'? 'FROM'? Integer 'TO' Integer 'CHARACTERS'? 'DEPENDING' 'ON'? Id
  ;
syntax AltCharactersRecords
  = characters: 'CHARACTERS'
  | records: 'RECORDS'
  | record: 'RECORD'
  ;
syntax FileAndSortDescriptionEntryClause
  = label: 'LABEL' RecordsAre LabelRecordsClauseTail
  | block: 'BLOCK' 'CONTAINS'? IntegerTo? Integer AltCharactersRecords?
  | linage: 'LINAGE' 'IS'? AltDataNameInteger 'LINES'?
  | linage: 'LINAGE' 'IS'? AltDataNameInteger 'LINES'? 'AT'? 'BOTTOM' AltDataNameInteger
  | linage: 'LINAGE' 'IS'? AltDataNameInteger 'LINES'? 'AT'? 'TOP' AltDataNameInteger
  | linage: 'LINAGE' 'IS'? AltDataNameInteger 'LINES'? 'AT'? 'TOP' AltDataNameInteger 'LINES'? 'AT'? 'BOTTOM' AltDataNameInteger
  | linage: 'LINAGE' 'IS'? AltDataNameInteger 'LINES'? 'WITH'? 'FOOTING' 'AT'? AltDataNameInteger
  | linage: 'LINAGE' 'IS'? AltDataNameInteger 'LINES'? 'WITH'? 'FOOTING' 'AT'? AltDataNameInteger 'LINES'? 'AT'? 'BOTTOM' AltDataNameInteger
  | linage: 'LINAGE' 'IS'? AltDataNameInteger 'LINES'? 'WITH'? 'FOOTING' 'AT'? AltDataNameInteger 'LINES'? 'AT'? 'TOP' AltDataNameInteger
  | linage: 'LINAGE' 'IS'? AltDataNameInteger 'LINES'? 'WITH'? 'FOOTING' 'AT'? AltDataNameInteger 'LINES'? 'AT'? 'TOP' AltDataNameInteger 'LINES'? 'AT'? 'BOTTOM' AltDataNameInteger
  | recording: 'RECORDING' 'MODE'? 'IS'? Id
  | globalClause: GlobalClause
  | record: 'RECORD' RecordClauseTail
  | \data: 'DATA' RecordsAre Id+
  | \value: 'VALUE' 'OF' ValueOfClauseTail+
  | codeSet: 'CODE-SET' 'IS'? Id
  | externalClause: ExternalClause
  ;
syntax RecordsAre = records: Records Are?;

syntax AltQualifiedDataNameLiteral
  = literal: Literal
  | qualifiedDataName: QualifiedDataName
  ;
syntax AltDataNameInteger
  = dataName: Id
  | integer: Integer
  ;

syntax ValueOfClauseTail = systemName: Id 'IS'? AltQualifiedDataNameLiteral;