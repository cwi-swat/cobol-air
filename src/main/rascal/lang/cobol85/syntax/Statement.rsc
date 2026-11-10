@license{
Copyright (c) 2026, CWI - Software Analysis and Transformation

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this
   list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice,
   this list of conditions and the following disclaimer in the documentation
   and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
}
@synopsis{All procedure division statements, from ACCEPT to WRITE, with their phrases and scope terminators.}
@description{
This module defines the statements of the procedure division as one `Statement` nonterminal with one rule per
statement kind, including the arithmetic statements, MOVE, IF and EVALUATE, PERFORM in all its forms, the
input-output statements OPEN, READ, WRITE, REWRITE, START, DELETE and CLOSE, CALL, STRING, UNSTRING, INSPECT,
SEARCH, SET, SORT and MERGE, the communication statements and the old ALTER, GO TO DEPENDING and ENTRY. Optional
trailing phrases are lists in any order per statement family (`ArithmeticPhrase`, `IoPhrase`, `OverflowPhrase`,
`SortPhrase`), followed by the conditional phrases such as ON SIZE ERROR, AT END and INVALID KEY. This replaces
the many rules that encoded every permitted subset and order; a checker rejects the combinations COBOL does not
allow. The statements of a conditional phrase are imperative, so a nested statement with a conditional phrase of
its own needs its scope terminator, and an IF without END-IF ends at the period or at an enclosing ELSE or WHEN.
Statement lists extend up to the end of the sentence, a scope terminator or the next phrase of the enclosing
statement.
}
module lang::cobol85::\syntax::Statement

extend lang::cobol85::\syntax::Condition;
extend lang::cobol85::\syntax::Lexical;
extend lang::cobol85::\syntax::Expression;

syntax Statement
    = exitProgram: 'EXIT' 'PROGRAM'
    | receive: 'RECEIVE' Id IoPhrase*
    | enable: 'ENABLE' CommunicationIoMode Id CommunicationKeyPhrase?
    | disable: 'DISABLE' CommunicationIoMode Id CommunicationKeyPhrase?
    | send: 'SEND' Id IoPhrase*
    | purge: 'PURGE' Id
    | merge: 'MERGE' Id SortPhrase*
    | searchAll: 'SEARCH' 'ALL' Identifier IoPhrase* IoConditionalPhrase* WhenConditionStats EndSearch
    | search: 'SEARCH' Identifier IoPhrase* IoConditionalPhrase* WhenConditionStats+ EndSearch
    | compute: 'COMPUTE' CobwordRounded+ Equal Expression ArithmeticPhrase* ArithmeticConditionalPhrase* 'END-COMPUTE'
    | compute: 'COMPUTE' CobwordRounded+ Equal Expression ArithmeticPhrase* () !>> 'END-COMPUTE'
    | computeConditional: 'COMPUTE' CobwordRounded+ Equal Expression ArithmeticPhrase* ArithmeticConditionalPhrase+ () !>> 'END-COMPUTE'
    | exit: 'EXIT'
    | alter: 'ALTER' ProcedureToProcedure+
    | call: 'CALL' Expression OverflowPhrase* OverflowConditionalPhrase* 'END-CALL'
    | call: 'CALL' Expression OverflowPhrase* () !>> 'END-CALL'
    | callConditional: 'CALL' Expression OverflowPhrase* OverflowConditionalPhrase+ () !>> 'END-CALL'
    | \set: 'SET' SetStatementPhrase+
    | stop: 'STOP' AltRunLiteral
    | divide: 'DIVIDE' Expression ArithmeticPhrase* ArithmeticConditionalPhrase* 'END-DIVIDE'
    | divide: 'DIVIDE' Expression ArithmeticPhrase* () !>> 'END-DIVIDE'
    | divideConditional: 'DIVIDE' Expression ArithmeticPhrase* ArithmeticConditionalPhrase+ () !>> 'END-DIVIDE'
    | display: 'DISPLAY' Operand+ ('UPON' Id)? ('WITH'? 'NO' 'ADVANCING')?
    | read: 'READ' Id 'NEXT'? 'RECORD'? IoPhrase* IoConditionalPhrase* 'END-READ'
    | read: 'READ' Id 'NEXT'? 'RECORD'? IoPhrase* () !>> 'END-READ'
    | readConditional: 'READ' Id 'NEXT'? 'RECORD'? IoPhrase* IoConditionalPhrase+ () !>> 'END-READ'
    | string: 'STRING' DelimitedByPhrase+ OverflowPhrase* OverflowConditionalPhrase* 'END-STRING'
    | string: 'STRING' DelimitedByPhrase+ OverflowPhrase* () !>> 'END-STRING'
    | stringConditional: 'STRING' DelimitedByPhrase+ OverflowPhrase* OverflowConditionalPhrase+ () !>> 'END-STRING'
    | subtract: 'SUBTRACT' Corresponding? Operand+ ArithmeticPhrase* ArithmeticConditionalPhrase* 'END-SUBTRACT'
    | subtract: 'SUBTRACT' Corresponding? Operand+ ArithmeticPhrase* () !>> 'END-SUBTRACT'
    | subtractConditional: 'SUBTRACT' Corresponding? Operand+ ArithmeticPhrase* ArithmeticConditionalPhrase+ () !>> 'END-SUBTRACT'
    | move: 'MOVE' Corresponding? Expression 'TO' Identifier+
    | goMoreLabels: 'GO' 'TO'? 'MORE-LABELS'
    | goTo: 'GO' 'TO'? ProcedureName+ ('DEPENDING' 'ON'? Identifier)?
    | goback: 'GOBACK'
    | add: 'ADD' Corresponding? Operand+ ArithmeticPhrase* ArithmeticConditionalPhrase* 'END-ADD'
    | add: 'ADD' Corresponding? Operand+ ArithmeticPhrase* () !>> 'END-ADD'
    | addConditional: 'ADD' Corresponding? Operand+ ArithmeticPhrase* ArithmeticConditionalPhrase+ () !>> 'END-ADD'
    | accept: 'ACCEPT' Identifier ('FROM' Date)?
    | acceptMessage: 'ACCEPT' Id 'MESSAGE' 'COUNT'
    | acceptCount: 'ACCEPT' Id 'COUNT'
    | delete: 'DELETE' Id 'RECORD'? IoPhrase* IoConditionalPhrase* 'END-DELETE'
    | delete: 'DELETE' Id 'RECORD'? IoPhrase* () !>> 'END-DELETE'
    | deleteConditional: 'DELETE' Id 'RECORD'? IoPhrase* IoConditionalPhrase+ () !>> 'END-DELETE'
    | initialize: 'INITIALIZE' Identifier+ ('REPLACING' InitializeReplacingArgument+)?
    | \continue: 'CONTINUE'
    | release: 'RELEASE' RecordName IoPhrase*
    | unstring: 'UNSTRING' Identifier OverflowPhrase* OverflowConditionalPhrase* 'END-UNSTRING'
    | unstring: 'UNSTRING' Identifier OverflowPhrase* () !>> 'END-UNSTRING'
    | unstringConditional: 'UNSTRING' Identifier OverflowPhrase* OverflowConditionalPhrase+ () !>> 'END-UNSTRING'
    | close: 'CLOSE' CloseStatementFileName+
    | \if: 'IF' Expression 'THEN'? AltStatementListNextSentence () !>> 'ELSE' EndIf
    | ifElse: 'IF' Expression 'THEN'? AltStatementListNextSentence 'ELSE' AltStatementListNextSentence EndIf
    | inspect: 'INSPECT' Identifier InspectPhrase+
    | sort: 'SORT' Id SortPhrase*
    | write: 'WRITE' RecordName IoPhrase* IoConditionalPhrase* 'END-WRITE'
    | write: 'WRITE' RecordName IoPhrase* () !>> 'END-WRITE'
    | writeConditional: 'WRITE' RecordName IoPhrase* IoConditionalPhrase+ () !>> 'END-WRITE'
    | evaluate: 'EVALUATE' {EvaluateCondition 'ALSO'}+ WhenPhrases+ EndEvaluate
    | \start: 'START' Id IoPhrase* IoConditionalPhrase* 'END-START'
    | \start: 'START' Id IoPhrase* () !>> 'END-START'
    | startConditional: 'START' Id IoPhrase* IoConditionalPhrase+ () !>> 'END-START'
    | \return: 'RETURN' Id 'RECORD'? IoPhrase* IoConditionalPhrase* EndReturn
    | perform: 'PERFORM' ProcedureName (Through ProcedureName)? PerformPhrase?
    | endPerform: 'PERFORM' PerformPhrase? StatementList 'END-PERFORM'
    | entry: 'ENTRY' Literal UsingDataNamePluslist?
    | cancel: 'CANCEL' Operand+
    | open: 'OPEN' OpenStatementPhrase+
    | multiply: 'MULTIPLY' Expression ArithmeticPhrase* ArithmeticConditionalPhrase* 'END-MULTIPLY'
    | multiply: 'MULTIPLY' Expression ArithmeticPhrase* () !>> 'END-MULTIPLY'
    | multiplyConditional: 'MULTIPLY' Expression ArithmeticPhrase* ArithmeticConditionalPhrase+ () !>> 'END-MULTIPLY'
    | rewrite: 'REWRITE' RecordName IoPhrase* IoConditionalPhrase* 'END-REWRITE'
    | rewrite: 'REWRITE' RecordName IoPhrase* () !>> 'END-REWRITE'
    | rewriteConditional: 'REWRITE' RecordName IoPhrase* IoConditionalPhrase+ () !>> 'END-REWRITE'
    ;

// the phrases of the input-output statements, in any order; a checker rejects the combinations COBOL does not allow
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
    | noData: 'NO' 'DATA' Statement
    ;

// the conditional phrases of the input-output statements, which follow the other phrases
syntax IoConditionalPhrase
    = atEnd: 'AT'? 'END' ImperativeStatementList
    | notAtEnd: 'NOT' 'AT'? 'END' ImperativeStatementList
    | invalidKey: 'INVALID' 'KEY'? ImperativeStatementList
    | notInvalidKey: 'NOT' 'INVALID' 'KEY'? ImperativeStatementList
    | endOfPage: 'AT'? EndOfPage ImperativeStatementList
    | notEndOfPage: 'NOT' 'AT'? EndOfPage ImperativeStatementList
    ;

// the statements of a conditional phrase are imperative (COBOL-85): a statement with a conditional phrase of its own
// needs its scope terminator there. So in `ADD A TO B ON SIZE ERROR ADD C TO D NOT ON SIZE ERROR ...` the NOT ON SIZE
// ERROR phrase belongs to the first ADD.
syntax ImperativeStatementList
    = statement: Statement ! addConditional ! subtractConditional ! multiplyConditional ! divideConditional ! computeConditional ! readConditional ! writeConditional ! rewriteConditional ! deleteConditional ! startConditional ! callConditional ! stringConditional ! unstringConditional+ EndStatementList;

syntax WhenConditionStats = \when: 'WHEN' Expression AltStatementListNextSentence;

syntax AltStatementListNextSentence
    = statementList: StatementList
    | nextSentence: 'NEXT' 'SENTENCE'
    ;

syntax StatementList = statement: Statement+ EndStatementList;

// the conditional phrases of the arithmetic statements, which follow the other phrases
syntax ArithmeticConditionalPhrase
    = sizeError: 'ON'? 'SIZE' 'ERROR' ImperativeStatementList
    | notSizeError: 'NOT' 'ON'? 'SIZE' 'ERROR' ImperativeStatementList
    ;

// the conditional phrases of CALL, STRING and UNSTRING, which follow the other phrases
syntax OverflowConditionalPhrase
    = overflow: 'ON'? 'OVERFLOW' ImperativeStatementList
    | notOverflow: 'NOT' 'ON'? 'OVERFLOW' ImperativeStatementList
    | exception: 'ON'? 'EXCEPTION' ImperativeStatementList
    | notException: 'NOT' 'ON'? 'EXCEPTION' ImperativeStatementList
    ;

syntax WhenPhrases = whenPhrase: WhenPhrase+ StatementList;

syntax CommunicationIoMode
    = input: 'INPUT' 'TERMINAL'?
    | output: 'OUTPUT'
    ;

syntax CommunicationKeyPhrase = key: 'WITH'? 'KEY' Expression;

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

syntax EndSearch
    = 'END-SEARCH'
    | () >> "."
    ;

syntax Equal
    = equalSign: "="
    | equal: 'EQUAL'
    ;

// the phrases of the arithmetic statements, in any order; a checker rejects the combinations COBOL does not allow
syntax ArithmeticPhrase
    = to: 'TO' CobwordRounded+
    | from: 'FROM' CobwordRounded+
    | by: 'BY' CobwordRounded+
    | into: 'INTO' CobwordRounded+
    | giving: 'GIVING' CobwordRounded+
    | remainder: 'REMAINDER' Identifier
    ;

syntax CobwordRounded = operand: Operand 'ROUNDED'?;

syntax ProcedureToProcedure
    = to: ProcedureName 'TO' ProcedureName
    | to: ProcedureName 'TO' 'PROCEED' 'TO' ProcedureName
    ;

// the phrases of CALL, STRING and UNSTRING, in any order; a checker rejects the combinations COBOL does not allow
syntax OverflowPhrase
    = delimitedBy: 'DELIMITED' 'BY'? {AllOperand 'OR'}+
    | into: 'INTO' UnstringStatementDst+
    | pointer: 'WITH'? 'POINTER' Identifier
    | tallying: 'TALLYING' 'IN'? Identifier
    | using: 'USING' UsingParameters
    ;

syntax AllOperand = operand: 'ALL'? NotAll Operand;

syntax UnstringStatementDst
    = identifier: Identifier
    | identifier: Identifier 'COUNT' 'IN'? Identifier
    | identifier: Identifier 'DELIMITER' 'IN'? Identifier
    | identifier: Identifier 'DELIMITER' 'IN'? Identifier 'COUNT' 'IN'? Identifier
    ;

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

syntax SetStatementPhrase = identifier: Identifier+ SetOper SetSrc;

syntax SetOper
    = by: AltUpDown 'BY'
    | to: 'TO'
    ;

syntax AltUpDown
    = down: 'DOWN'
    | up: 'UP'
    ;

syntax SetSrc
    = \off: 'OFF'
    | operand: Operand
    | \on: 'ON'
    | \true: 'TRUE'
    ;

syntax AltRunLiteral
    = run: 'RUN'
    | literal: Literal
    ;

syntax DelimitedByPhrase = delimited: Operand+ 'DELIMITED' 'BY'? OperandOrSize;

syntax OperandOrSize
    = size: 'SIZE'
    | operand: Operand
    ;

syntax Corresponding
    = corr: 'CORR'
    | corresponding: 'CORRESPONDING'
    ;

syntax Date
    = time: 'TIME'
    | day: 'DAY'
    | date: 'DATE'
    | dayOfWeek: 'DAY-OF-WEEK'
    | mnemonicName: Id
    ;

syntax InitializeReplacingArgument = by: InitializeReplacingType 'DATA'? 'BY' Expression;

syntax InitializeReplacingType
    = alphabetic: 'ALPHABETIC'
    | numericEdited: 'NUMERIC-EDITED'
    | numeric: 'NUMERIC'
    | alphanumericEdited: 'ALPHANUMERIC-EDITED'
    | alphanumeric: 'ALPHANUMERIC'
    | dbcs: 'DBCS'
    | egcs: 'EGCS'
    ;

syntax CloseStatementFileName = fileName: Id CloseStatementOptions?;

syntax CloseStatementOptions
    = noRewindLock: 'WITH'? AltNoRewindLock
    | reelUnit: AltReelUnit AltRemovalNoRewind?
    ;

syntax AltNoRewindLock
    = no: 'NO' 'REWIND'
    | lock: 'LOCK'
    ;

syntax AltRemovalNoRewind
    = withNoRewind: WithNoRewind
    | removal: 'FOR'? 'REMOVAL'
    ;

// an IF without END-IF ends at the period, or at the ELSE or WHEN of an enclosing IF or EVALUATE
syntax EndIf
    = 'END-IF'
    | () >> "."
    | () >> 'ELSE'
    | () >> 'WHEN'
    ;

syntax InspectPhrase
    = tallying: 'TALLYING' TallyingArgument+
    | replacing: 'REPLACING' InspectReplacingPhrase+
    | converting: 'CONVERTING' Expression 'TO' Expression BeforeAfterPhrase*
    ;

syntax TallyingArgument = \for: Identifier 'FOR' TallyingForArgument+;

syntax TallyingForArgument
    = characters: 'CHARACTERS' BeforeAfterPhrase*
    | allLeading: AltAllLeading TallyingOperand+
    ;

syntax AltAllLeading
    = \all: 'ALL'
    | leading: 'LEADING'
    ;

syntax TallyingOperand = operand: NotAll Operand BeforeAfterPhrase*;

syntax InspectReplacingPhrase
    = characters: 'CHARACTERS' 'BY' Expression BeforeAfterPhrase*
    | allLeadingFirst: AltAllLeadingFirst InspectReplacingArgument+
    ;

syntax AltAllLeadingFirst
    = \all: 'ALL'
    | first: 'FIRST'
    | leading: 'LEADING'
    ;

syntax InspectReplacingArgument = by: NotAll Operand 'BY' Operand BeforeAfterPhrase*;

// operands of INSPECT and UNSTRING can not be ALL literals; ALL is the keyword of the statement
syntax NotAll = () !>> 'ALL ' !>> 'ALL\"' !>> 'ALL\uE000';

syntax BeforeAfterPhrase = beforeAfter: AltBeforeAfter 'INITIAL'? Operand;

syntax EvaluateCondition
    = \false: 'FALSE'
    | condition: Expression
    | \true: 'TRUE'
    ;

syntax EndEvaluate = 'END-EVALUATE'?;

syntax EndReturn
    = 'END-RETURN'
    | () >> "."
    ;

syntax PerformPhrase
    = times: Expression 'TIMES'
    | until: WithTest? 'UNTIL' Expression
    | varying: WithTest? 'VARYING' Identifier 'FROM' Expression 'BY' Expression 'UNTIL' Expression PerformAfterPhrase*
    ;

syntax WithTest = \test: 'WITH'? 'TEST' AltBeforeAfter;

syntax AltBeforeAfter
    = before: 'BEFORE'
    | after: 'AFTER'
    ;

syntax PerformAfterPhrase = after: 'AFTER' Identifier 'FROM' Expression 'BY' Expression 'UNTIL' Expression;

syntax UsingDataNamePluslist = using: 'USING' Id+;

syntax OpenStatementPhrase
    = io: 'I-O' Id+
    | input: 'INPUT' OpenStatementInputFileName+
    | output: 'OUTPUT' OpenStatementOutputFileName+
    | \extend: 'EXTEND' Id+
    ;

syntax OpenStatementInputFileName = fileName: Id AltReversedWithNoRewind?;

syntax AltReversedWithNoRewind
    = reversed: 'REVERSED'
    | withNoRewind: WithNoRewind
    ;

syntax OpenStatementOutputFileName = fileName: Id WithNoRewind?;

syntax WithNoRewind = no: 'WITH'? 'NO' 'REWIND';

syntax RelOp
    = equalTo: EqualTo
    | greaterThanOrEqualTo: GreaterThanOrEqualTo
    | greaterThan: GreaterThan
    ;

syntax PagePhrase
    = page: 'PAGE'
    // also ZERO LINES, a figurative constant
    | lines: Expression Lines?
    ;

syntax Lines
    = lines: 'LINES'
    | line: 'LINE'
    ;

syntax EndOfPage
    = endOfPage: 'END-OF-PAGE'
    | eop: 'EOP'
    ;

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

syntax WhenPhrase = \when: 'WHEN' {EvaluatePhrase 'ALSO'}+;

syntax EvaluatePhrase
    = through: 'NOT'? Expression ! negation Through Expression
    | \true: 'TRUE'
    | condition: Expression
    // also covers [NOT] value; the EVALUATE subject decides which it is
    | \false: 'FALSE'
    | \any: 'ANY'
    | other: 'OTHER'
    ;

syntax UseStatement
    = useAfterProcedure: 'USE' 'GLOBAL'? 'AFTER' 'STANDARD'? AltExceptionError 'PROCEDURE' 'ON'? AltFileNamesIO
    | useAfterLabel: 'USE' 'GLOBAL'? 'AFTER' 'STANDARD'? AltBeginningEnding? AltFileReelUnit? 'LABEL' 'PROCEDURE' 'ON'? AltFileNamesIO
    | useDebugging: 'USE' 'FOR'? 'DEBUGGING' 'ON'? AltProceduresAllProcedures
    ;

syntax AltExceptionError
    = exception: 'EXCEPTION'
    | error: 'ERROR'
    ;

syntax AltFileNamesIO
    = fileName: Id+
    | output: 'OUTPUT'
    | input: 'INPUT'
    | io: 'I-O'
    | \extend: 'EXTEND'
    ;

syntax AltBeginningEnding
    = beginning: 'BEGINNING'
    | ending: 'ENDING'
    ;

syntax AltFileReelUnit
    = unit: 'UNIT'
    | reel: 'REEL'
    | file: 'FILE'
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
