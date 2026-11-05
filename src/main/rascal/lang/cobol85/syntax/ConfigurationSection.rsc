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
module lang::cobol85::\syntax::ConfigurationSection

extend lang::cobol85::\syntax::Condition;
extend lang::cobol85::\syntax::Expression;

keyword CobwordKeywords
    = 'ALPHABET'
    | 'ALSO'
    | 'ARE'
    | 'CHARACTERS'
    | 'CLASS'
    | 'COLLATING'
    | 'COMMA'
    | 'CURRENCY'
    | 'DEBUGGING'
    | 'DECIMAL-POINT'
    | 'EBCDIC'
    | 'IN'
    | 'IS'
    | 'MEMORY'
    | 'MODE'
    | 'MODULES'
    | 'NATIVE'
    | 'OFF'
    | 'ON'
    | 'PROGRAM'
    | 'SEGMENT-LIMIT'
    | 'SEQUENCE'
    | 'SIGN'
    | 'SIZE'
    | 'STANDARD-1'
    | 'STANDARD-2'
    | 'STATUS'
    | 'SYMBOLIC'
    | 'WITH'
    | 'WORDS'
    ;

syntax MemorySizeType
    = characters: 'CHARACTERS'
    | modules: 'MODULES'
    | words: 'WORDS'
    ;

syntax Are
    = \is: 'IS'
    | are: 'ARE'
    ;

syntax SpecialNamesParagraphPhrase
    = systemName: Id 'IS'? Id SpecialNamesParagraphStatusPhrase?
    | status: Id SpecialNamesParagraphStatusPhrase
    ;

syntax SpecialNamesParagraphStatusPhrase
    = \on: 'ON' 'STATUS'? 'IS'? Expression ('OFF' 'STATUS'? 'IS'? Expression)?
    | \off: 'OFF' 'STATUS'? 'IS'? Expression ('ON' 'STATUS'? 'IS'? Expression)?
    ;

syntax SpecialNamesParagraphClause
    = decimalPoint: 'DECIMAL-POINT' 'IS'? 'COMMA'
    | class: 'CLASS' Id 'IS'? LiteralThroughLiteral+
    | symbolic: 'SYMBOLIC' 'CHARACTERS'? SymbolicCharacterMapping+ ('IN' Id)?
    | currency: 'CURRENCY' 'SIGN'? 'IS'? Literal
    | alphabet: 'ALPHABET' Id 'IS'? AlphabetType
    ;

// a single character, a range, or characters of the same position in the collating sequence
syntax AlphabetTypeOther
    = also: {Literal 'ALSO'}+
    | through: Literal Through Literal
    ;

syntax SymbolicCharacterMapping = symbolicCharacter: Id+ Are? Integer+;

// the clauses of SOURCE-COMPUTER and OBJECT-COMPUTER, in any order; a checker rejects the combinations COBOL does not allow
syntax ComputerClause
    = memory: 'MEMORY' 'SIZE'? Integer MemorySizeType
    | sequence: 'PROGRAM'? 'COLLATING'? 'SEQUENCE' 'IS'? Id
    | segmentLimit: 'SEGMENT-LIMIT' 'IS'? PriorityNumber
    | debugging: 'WITH'? 'DEBUGGING' 'MODE'
    ;

syntax AlphabetType
    = native: 'NATIVE'
    | ebcdic: 'EBCDIC'
    | standard2: 'STANDARD-2'
    | standard1: 'STANDARD-1'
    | alphabetTypeOther: AlphabetTypeOther+
    ;
