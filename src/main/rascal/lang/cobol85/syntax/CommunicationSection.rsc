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
@synopsis{The COMMUNICATION SECTION: CD entries for message input and output.}
@description{
This module defines the communication description (CD) entries of the COMMUNICATION SECTION, for programs that
exchange messages with a message control system. A CD entry is FOR INPUT, FOR INITIAL INPUT or FOR OUTPUT, and names the data
items of its communication area: for input the symbolic queue and sub-queues, message date and time, source, text
length, end key, status key and message count, and for output the destination count, text length, status key,
destination table and error key. The input form can also list its eleven data names by position, without the
clause keywords. Record descriptions may follow each CD entry. The statements that use these areas, such as SEND,
RECEIVE, ENABLE and DISABLE, are in the Statement module.
}
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
