module lang::cobol85::\syntax::Statement

extend lang::cobol85::\syntax::Condition;
extend lang::cobol85::\syntax::Lexical;
extend lang::cobol85::\syntax::Expression;

// the reserved words of this module
keyword CobwordKeywords
    = 'ACCEPT'
    | 'ADD'
    | 'ADVANCING'
    | 'AFTER'
    | 'ALL'
    | 'ALPHABETIC'
    | 'ALPHANUMERIC'
    | 'ALPHANUMERIC-EDITED'
    | 'ALSO'
    | 'ALTER'
    | 'AND'
    | 'ANY'
    | 'AT'
    | 'BEFORE'
    | 'BEGINNING'
    | 'BY'
    | 'CALL'
    | 'CANCEL'
    | 'CHARACTERS'
    | 'CLOSE'
    | 'COLLATING'
    | 'COMPUTE'
    | 'CONTENT'
    | 'CONTINUE'
    | 'CONVERTING'
    | 'COPY'
    | 'CORR'
    | 'CORRESPONDING'
    | 'COUNT'
    | 'DATA'
    | 'DATE'
    | 'DAY'
    | 'DAY-OF-WEEK'
    | 'DBCS'
    | 'DEBUGGING'
    | 'DELETE'
    | 'DELIMITED'
    | 'DELIMITER'
    | 'DEPENDING'
    | 'DISABLE'
    | 'DISPLAY'
    | 'DIVIDE'
    | 'DOWN'
    | 'DUPLICATES'
    | 'EGCS'
    | 'EGI'
    | 'ELSE'
    | 'EMI'
    | 'ENABLE'
    | 'END'
    | 'END-ADD'
    | 'END-CALL'
    | 'END-COMPUTE'
    | 'END-DELETE'
    | 'END-DIVIDE'
    | 'END-EVALUATE'
    | 'END-IF'
    | 'END-MULTIPLY'
    | 'END-OF-PAGE'
    | 'END-PERFORM'
    | 'END-READ'
    | 'END-RETURN'
    | 'END-REWRITE'
    | 'END-SEARCH'
    | 'END-START'
    | 'END-STRING'
    | 'END-SUBTRACT'
    | 'END-UNSTRING'
    | 'END-WRITE'
    | 'ENDING'
    | 'ENTRY'
    | 'EOP'
    | 'EQUAL'
    | 'ERROR'
    | 'ESI'
    | 'EVALUATE'
    | 'EXCEPTION'
    | 'EXIT'
    | 'EXTEND'
    | 'FALSE'
    | 'FILE'
    | 'FIRST'
    | 'FOR'
    | 'FROM'
    | 'GIVING'
    | 'GLOBAL'
    | 'GO'
    | 'GOBACK'
    | 'I-O'
    | 'IF'
    | 'IN'
    | 'INITIAL'
    | 'INITIALIZE'
    | 'INPUT'
    | 'INSPECT'
    | 'INTO'
    | 'INVALID'
    | 'IS'
    | 'KEY'
    | 'LABEL'
    | 'LEADING'
    | 'LINE'
    | 'LINES'
    | 'LOCK'
    | 'MERGE'
    | 'MESSAGE'
    | 'MORE-LABELS'
    | 'MOVE'
    | 'MULTIPLY'
    | 'NEXT'
    | 'NO'
    | 'NOT'
    | 'NUMERIC'
    | 'NUMERIC-EDITED'
    | 'OF'
    | 'OFF'
    | 'ON'
    | 'OPEN'
    | 'OR'
    | 'ORDER'
    | 'OTHER'
    | 'OUTPUT'
    | 'OVERFLOW'
    | 'PAGE'
    | 'PERFORM'
    | 'POINTER'
    | 'PROCEDURE'
    | 'PROCEDURES'
    | 'PROCEED'
    | 'PROGRAM'
    | 'PURGE'
    | 'READ'
    | 'RECEIVE'
    | 'RECORD'
    | 'REEL'
    | 'REFERENCE'
    | 'RELEASE'
    | 'REMAINDER'
    | 'REMOVAL'
    | 'REPLACING'
    | 'RETURN'
    | 'REVERSED'
    | 'REWIND'
    | 'REWRITE'
    | 'ROUNDED'
    | 'RUN'
    | 'SEARCH'
    | 'SEND'
    | 'SENTENCE'
    | 'SEQUENCE'
    | 'SET'
    | 'SIZE'
    | 'SORT'
    | 'STANDARD'
    | 'START'
    | 'STOP'
    | 'STRING'
    | 'SUBTRACT'
    | 'TALLYING'
    | 'TEST'
    | 'THEN'
    | 'TIME'
    | 'TIMES'
    | 'TO'
    | 'TRUE'
    | 'UNIT'
    | 'UNSTRING'
    | 'UNTIL'
    | 'UP'
    | 'UPON'
    | 'USE'
    | 'USING'
    | 'VARYING'
    | 'WHEN'
    | 'WITH'
    | 'WRITE'
    ;

syntax EndSearch
    = 'END-SEARCH'
    | () >> "."
    ;

syntax ProcedureToProcedure
    = to: ProcedureName 'TO' ProcedureName
    | to: ProcedureName 'TO' 'PROCEED' 'TO' ProcedureName
    ;

syntax DelimitedByPhrase = delimited: Operand+ 'DELIMITED' 'BY'? OperandOrSize;

syntax PerformAfterPhrase = after: 'AFTER' Identifier 'FROM' Expression 'BY' Expression 'UNTIL' Expression;

syntax InitializeReplacingArgument = by: InitializeReplacingType 'DATA'? 'BY' Expression;

syntax BeforeAfterPhrase = beforeAfter: AltBeforeAfter 'INITIAL'? Operand;

syntax TallyingForArgument
    = characters: 'CHARACTERS' BeforeAfterPhrase*
    | allLeading: AltAllLeading TallyingOperand+
    ;

syntax AltFileReelUnit
    = unit: 'UNIT'
    | reel: 'REEL'
    | file: 'FILE'
    ;

syntax Lines
    = lines: 'LINES'
    | line: 'LINE'
    ;

syntax EvaluatePhrase
    = through: 'NOT'? Expression ! negation Through Expression
    | \true: 'TRUE'
    | condition: Expression
    // also covers [NOT] value; the EVALUATE subject decides which it is
    | \false: 'FALSE'
    | \any: 'ANY'
    | other: 'OTHER'
    ;

syntax AltBeginningEnding
    = beginning: 'BEGINNING'
    | ending: 'ENDING'
    ;

syntax WhenPhrase = \when: 'WHEN' {EvaluatePhrase 'ALSO'}+;

syntax OpenStatementPhrase
    = io: 'I-O' Id+
    | input: 'INPUT' OpenStatementInputFileName+
    | output: 'OUTPUT' OpenStatementOutputFileName+
    | \extend: 'EXTEND' Id+
    ;

syntax EndAdd = 'END-ADD'?;

syntax AltRemovalNoRewind
    = withNoRewind: WithNoRewind
    | removal: 'FOR'? 'REMOVAL'
    ;

syntax AltUpDown
    = down: 'DOWN'
    | up: 'UP'
    ;

syntax Corresponding
    = corr: 'CORR'
    | corresponding: 'CORRESPONDING'
    ;

syntax EndOfPage
    = endOfPage: 'END-OF-PAGE'
    | eop: 'EOP'
    ;

syntax InspectReplacingPhrase
    = characters: 'CHARACTERS' 'BY' Expression BeforeAfterPhrase*
    | allLeadingFirst: AltAllLeadingFirst InspectReplacingArgument+
    ;

syntax AltBeforeAfter
    = before: 'BEFORE'
    | after: 'AFTER'
    ;

syntax AltAllLeading
    = \all: 'ALL'
    | leading: 'LEADING'
    ;

syntax UsingDataNamePluslist = using: 'USING' Id+;

syntax AltFileNamesIO
    = fileName: Id+
    | output: 'OUTPUT'
    | input: 'INPUT'
    | io: 'I-O'
    | \extend: 'EXTEND'
    ;

syntax EvaluateCondition
    = \false: 'FALSE'
    | condition: Expression
    | \true: 'TRUE'
    ;

syntax WhenPhrases = whenPhrase: WhenPhrase+ StatementList;

syntax OpenStatementOutputFileName = fileName: Id WithNoRewind?;

syntax Equal
    = equalSign: "="
    | equal: 'EQUAL'
    ;

syntax EndMultiply = 'END-MULTIPLY'?;

syntax AltStatementListNextSentence
    = statementList: StatementList
    | nextSentence: 'NEXT' 'SENTENCE'
    ;

syntax OpenStatementInputFileName = fileName: Id AltReversedWithNoRewind?;

syntax CloseStatementFileName = fileName: Id CloseStatementOptions?;

syntax InitializeReplacingType
    = alphabetic: 'ALPHABETIC'
    | numericEdited: 'NUMERIC-EDITED'
    | numeric: 'NUMERIC'
    | alphanumericEdited: 'ALPHANUMERIC-EDITED'
    | alphanumeric: 'ALPHANUMERIC'
    | dbcs: 'DBCS'
    | egcs: 'EGCS'
    ;

syntax UseStatement
    = useAfterProcedure: 'USE' 'GLOBAL'? 'AFTER' 'STANDARD'? AltExceptionError 'PROCEDURE' 'ON'? AltFileNamesIO
    | useAfterLabel: 'USE' 'GLOBAL'? 'AFTER' 'STANDARD'? AltBeginningEnding? AltFileReelUnit? 'LABEL' 'PROCEDURE' 'ON'? AltFileNamesIO
    | useDebugging: 'USE' 'FOR'? 'DEBUGGING' 'ON'? AltProceduresAllProcedures
    ;

syntax WhenConditionStats = \when: 'WHEN' Expression AltStatementListNextSentence;

syntax InspectReplacingArgument = by: NotAll Operand 'BY' Operand BeforeAfterPhrase*;

// a BY CONTENT or BY REFERENCE phrase applies to all the parameters that follow it, up to the next BY phrase;
// parameters before the first BY phrase are passed by reference
syntax UsingParameters
    = identifier: Identifier+ ParameterGroup*
    | identifier: ParameterGroup+
    ;

syntax ParameterGroup
    = content: 'BY'? 'CONTENT' Operand+
    | reference: 'BY'? 'REFERENCE' Identifier+
    ;

syntax PagePhrase
    = page: 'PAGE'
    // also ZERO LINES, a figurative constant
    | lines: Expression Lines?
    ;

syntax EndDivide = 'END-DIVIDE'?;

syntax WithTest = \test: 'WITH'? 'TEST' AltBeforeAfter;

syntax SetOper
    = by: AltUpDown 'BY'
    | to: 'TO'
    ;

// an IF without END-IF ends at the period, or at the ELSE or WHEN of an enclosing IF or EVALUATE
syntax EndIf
    = 'END-IF'
    | () >> "."
    | () >> 'ELSE'
    | () >> 'WHEN'
    ;

syntax EndCompute = 'END-COMPUTE'?;

syntax EndCall = 'END-CALL'?;

syntax EndString = 'END-STRING'?;

syntax EndDelete = 'END-DELETE'?;

syntax EndUnString = 'END-UNSTRING'?;

syntax EndWrite = 'END-WRITE'?;

syntax EndEvaluate = 'END-EVALUATE'?;

syntax EndReturn
    = 'END-RETURN'
    | () >> "."
    ;

syntax EndStart = 'END-START'?;

syntax EndRewrite = 'END-REWRITE'?;

syntax EndRead = 'END-READ'?;

// the phrases of the arithmetic statements, in any order; a checker rejects the combinations COBOL does not allow
syntax ArithmeticPhrase
    = to: 'TO' CobwordRounded+
    | from: 'FROM' CobwordRounded+
    | by: 'BY' CobwordRounded+
    | into: 'INTO' CobwordRounded+
    | giving: 'GIVING' CobwordRounded+
    | remainder: 'REMAINDER' Identifier
    | sizeError: 'ON'? 'SIZE' 'ERROR' StatementList
    | notSizeError: 'NOT' 'ON'? 'SIZE' 'ERROR' StatementList
    ;

// the phrases of the input-output statements, in any order; a checker rejects the combinations COBOL does not allow.
// READ, RETURN, SEARCH and RECEIVE exclude END-OF-PAGE and the others exclude AT END, so that a statement nested in
// an AT END or END-OF-PAGE phrase can not take the NOT AT END or NOT END-OF-PAGE of its parent
syntax IoPhrase
    = into: 'INTO' Identifier
    | from: 'FROM' Identifier
    | key: 'KEY' 'IS'? QualifiedDataName
    | keyRelation: 'KEY' 'IS'? RelOp QualifiedDataName
    | varying: 'VARYING' Identifier
    | advancing: AltBeforeAfter 'ADVANCING'? PagePhrase
    | message: 'MESSAGE'
    | segment: 'SEGMENT'
    | withEsi: 'WITH' 'ESI'
    | withEmi: 'WITH' 'EMI'
    | withEgi: 'WITH' 'EGI'
    | with: 'WITH' Identifier
    | replacing: 'REPLACING' 'LINE'
    | atEnd: 'AT'? 'END' StatementList
    | notAtEnd: 'NOT' 'AT'? 'END' StatementList
    | invalidKey: 'INVALID' 'KEY'? StatementList
    | notInvalidKey: 'NOT' 'INVALID' 'KEY'? StatementList
    | endOfPage: 'AT'? EndOfPage StatementList
    | notEndOfPage: 'NOT' 'AT'? EndOfPage StatementList
    | noData: 'NO' 'DATA' Statement
    ;

// the phrases of CALL, STRING and UNSTRING, in any order; a checker rejects the combinations COBOL does not allow
syntax OverflowPhrase
    = delimitedBy: 'DELIMITED' 'BY'? {AllOperand 'OR'}+
    | into: 'INTO' UnstringStatementDst+
    | pointer: 'WITH'? 'POINTER' Identifier
    | tallying: 'TALLYING' 'IN'? Identifier
    | using: 'USING' UsingParameters
    | overflow: 'ON'? 'OVERFLOW' StatementList
    | notOverflow: 'NOT' 'ON'? 'OVERFLOW' StatementList
    | exception: 'ON'? 'EXCEPTION' StatementList
    | notException: 'NOT' 'ON'? 'EXCEPTION' StatementList
    ;

// the phrases of SORT and MERGE, in any order; a checker rejects the combinations COBOL does not allow
syntax SortPhrase
    = key: 'ON'? AltAscendingDescending 'KEY'? 'IS'? QualifiedDataName+
    | duplicates: 'WITH'? 'DUPLICATES' 'IN'? 'ORDER'?
    | sequence: 'COLLATING'? 'SEQUENCE' 'IS'? Id
    | using: 'USING' Id+
    | input: 'INPUT' 'PROCEDURE' 'IS'? ProcedureName (Through ProcedureName)?
    | output: 'OUTPUT' 'PROCEDURE' 'IS'? ProcedureName (Through ProcedureName)?
    | giving: 'GIVING' Id+
    ;

syntax InspectPhrase
    = tallying: 'TALLYING' TallyingArgument+
    | replacing: 'REPLACING' InspectReplacingPhrase+
    | converting: 'CONVERTING' Expression 'TO' Expression BeforeAfterPhrase*
    ;

syntax PerformPhrase
    = times: Expression 'TIMES'
    | until: WithTest? 'UNTIL' Expression
    | varying: WithTest? 'VARYING' Identifier 'FROM' Expression 'BY' Expression 'UNTIL' Expression PerformAfterPhrase*
    ;

syntax Statement
    = exitProgram: 'EXIT' 'PROGRAM'
    | receive: 'RECEIVE' Id IoPhrase ! endOfPage ! notEndOfPage*
    | enable: 'ENABLE' CommunicationIoMode Id CommunicationKeyPhrase?
    | disable: 'DISABLE' CommunicationIoMode Id CommunicationKeyPhrase?
    | send: 'SEND' Id IoPhrase ! atEnd ! notAtEnd*
    | purge: 'PURGE' Id
    | merge: 'MERGE' Id SortPhrase*
    | searchAll: 'SEARCH' 'ALL' Identifier IoPhrase ! endOfPage ! notEndOfPage* WhenConditionStats EndSearch
    | search: 'SEARCH' Identifier IoPhrase ! endOfPage ! notEndOfPage* WhenConditionStats+ EndSearch
    | compute: 'COMPUTE' CobwordRounded+ Equal Expression ArithmeticPhrase* EndCompute
    | exit: 'EXIT'
    | alter: 'ALTER' ProcedureToProcedure+
    | call: 'CALL' Expression OverflowPhrase* EndCall
    | \set: 'SET' SetStatementPhrase+
    | stop: 'STOP' AltRunLiteral
    | divide: 'DIVIDE' Expression ArithmeticPhrase* EndDivide
    | display: 'DISPLAY' Operand+ ('UPON' Id)? ('WITH'? 'NO' 'ADVANCING')?
    | read: 'READ' Id 'NEXT'? 'RECORD'? IoPhrase ! endOfPage ! notEndOfPage* EndRead
    | string: 'STRING' DelimitedByPhrase+ OverflowPhrase* EndString
    | subtract: 'SUBTRACT' Corresponding? Operand+ ArithmeticPhrase* EndSubtract
    | move: 'MOVE' Corresponding? Expression 'TO' Identifier+
    | goMoreLabels: 'GO' 'TO'? 'MORE-LABELS'
    | goTo: 'GO' 'TO'? ProcedureName+ ('DEPENDING' 'ON'? Identifier)?
    | goback: 'GOBACK'
    | add: 'ADD' Corresponding? Operand+ ArithmeticPhrase* EndAdd
    | accept: 'ACCEPT' Identifier ('FROM' Date)?
    | acceptMessage: 'ACCEPT' Id 'MESSAGE' 'COUNT'
    | acceptCount: 'ACCEPT' Id 'COUNT'
    | delete: 'DELETE' Id 'RECORD'? IoPhrase ! atEnd ! notAtEnd* EndDelete
    | initialize: 'INITIALIZE' Identifier+ ('REPLACING' InitializeReplacingArgument+)?
    | \continue: 'CONTINUE'
    | release: 'RELEASE' RecordName IoPhrase ! atEnd ! notAtEnd*
    | unstring: 'UNSTRING' Identifier OverflowPhrase* EndUnString
    | close: 'CLOSE' CloseStatementFileName+
    | \if: 'IF' Expression 'THEN'? AltStatementListNextSentence () !>> 'ELSE' EndIf
    | ifElse: 'IF' Expression 'THEN'? AltStatementListNextSentence 'ELSE' AltStatementListNextSentence EndIf
    | inspect: 'INSPECT' Identifier InspectPhrase+
    | sort: 'SORT' Id SortPhrase*
    | write: 'WRITE' RecordName IoPhrase ! atEnd ! notAtEnd* EndWrite
    | evaluate: 'EVALUATE' {EvaluateCondition 'ALSO'}+ WhenPhrases+ EndEvaluate
    | \start: 'START' Id IoPhrase ! atEnd ! notAtEnd* EndStart
    | \return: 'RETURN' Id 'RECORD'? IoPhrase ! endOfPage ! notEndOfPage* EndReturn
    | perform: 'PERFORM' ProcedureName (Through ProcedureName)? PerformPhrase?
    | endPerform: 'PERFORM' PerformPhrase? StatementList 'END-PERFORM'
    | entry: 'ENTRY' Literal UsingDataNamePluslist?
    | cancel: 'CANCEL' Operand+
    | open: 'OPEN' OpenStatementPhrase+
    | multiply: 'MULTIPLY' Expression ArithmeticPhrase* EndMultiply
    | rewrite: 'REWRITE' RecordName IoPhrase ! atEnd ! notAtEnd* EndRewrite
    ;

syntax CommunicationIoMode
    = input: 'INPUT' 'TERMINAL'?
    | output: 'OUTPUT'
    ;

syntax CommunicationKeyPhrase = key: 'WITH'? 'KEY' Expression;

syntax Date
    = time: 'TIME'
    | day: 'DAY'
    | date: 'DATE'
    | dayOfWeek: 'DAY-OF-WEEK'
    | mnemonicName: Id
    ;

syntax CobwordRounded = operand: Operand 'ROUNDED'?;

syntax StatementList = statement: Statement+ EndStatementList;

// a statement list extends to the end of the sentence, a scope terminator, or the next phrase of its enclosing statement
syntax EndStatementList
    = () >> "."
    | () >> 'END'
    | () >> 'NOT'
    | () >> 'ELSE'
    | () >> 'WHEN'
    | () >> 'INVALID'
    | () >> 'AT'
    | () >> 'ON'
    | () >> 'OVERFLOW'
    | () >> 'COPY'
    ;

syntax OperandOrSize
    = size: 'SIZE'
    | operand: Operand
    ;

syntax UnstringStatementDst
    = identifier: Identifier
    | identifier: Identifier 'COUNT' 'IN'? Identifier
    | identifier: Identifier 'DELIMITER' 'IN'? Identifier
    | identifier: Identifier 'DELIMITER' 'IN'? Identifier 'COUNT' 'IN'? Identifier
    ;

syntax WithNoRewind = no: 'WITH'? 'NO' 'REWIND';

syntax TallyingOperand = operand: NotAll Operand BeforeAfterPhrase*;

// operands of INSPECT and UNSTRING can not be ALL literals; ALL is the keyword of the statement
syntax NotAll = () !>> 'ALL ' !>> 'ALL\"' !>> 'ALL\uE000';

syntax AltAllLeadingFirst
    = \all: 'ALL'
    | first: 'FIRST'
    | leading: 'LEADING'
    ;

syntax AltExceptionError
    = exception: 'EXCEPTION'
    | error: 'ERROR'
    ;

syntax AllOperand = operand: 'ALL'? NotAll Operand;

syntax AltRunLiteral
    = run: 'RUN'
    | literal: Literal
    ;

syntax EndSubtract = 'END-SUBTRACT'?;

syntax RelOp
    = equalTo: EqualTo
    | greaterThanOrEqualTo: GreaterThanOrEqualTo
    | greaterThan: GreaterThan
    ;

syntax AltNoRewindLock
    = no: 'NO' 'REWIND'
    | lock: 'LOCK'
    ;

syntax CloseStatementOptions
    = noRewindLock: 'WITH'? AltNoRewindLock
    | reelUnit: AltReelUnit AltRemovalNoRewind?
    ;

syntax SetSrc
    = \off: 'OFF'
    | operand: Operand
    | \on: 'ON'
    | \true: 'TRUE'
    ;

syntax AltProceduresAllProcedures
    = allProcedures: 'ALL' 'PROCEDURES'
    | procedureName: ProcedureName+
    // `USE FOR DEBUGGING ON ALL REFERENCES OF A B ALL C`; the names without ALL stay procedure names, as in c1
    | allReferences: ProcedureName* AllReferencesOf (AllReferencesOf | ProcedureName)*
    ;

syntax AllReferencesOf = \all: 'ALL' 'REFERENCES'? 'OF'? NotReferences Identifier;

// REFERENCES is the keyword, not a data name qualified by the identifier (`REFERENCES OF FREC`)
syntax NotReferences = () !>> 'REFERENCES ' !>> 'REFERENCES\n' !>> 'REFERENCES\uE000';

syntax AltReversedWithNoRewind
    = reversed: 'REVERSED'
    | withNoRewind: WithNoRewind
    ;

syntax SetStatementPhrase = identifier: Identifier+ SetOper SetSrc;

syntax TallyingArgument = \for: Identifier 'FOR' TallyingForArgument+;
