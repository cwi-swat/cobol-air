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
module lang::cobol85::\syntax::Condition

extend lang::cobol85::\syntax::Expression;

keyword CobwordKeywords
    = 'ALPHABETIC'
    | 'ALPHABETIC-LOWER'
    | 'ALPHABETIC-UPPER'
    | 'AND'
    | 'DBCS'
    | 'EQUAL'
    | 'GREATER'
    | 'IS'
    | 'KANJI'
    | 'LESS'
    | 'NEGATIVE'
    | 'NOT'
    | 'NUMERIC'
    | 'OR'
    | 'POSITIVE'
    | 'THAN'
    | 'THEN'
    | 'TO'
    | 'ZERO'
    | 'ZEROES'
    | 'ZEROS'
    ;

syntax GreaterThanOrEqualTo
    = greaterThan: 'GREATER' 'THAN'? 'OR' 'EQUAL' 'TO'?
    | notLessThan: 'NOT' 'LESS' 'THAN'?
    | greaterThanOrEqual: "\>="
    | notLessThanSign: 'NOT' "\<"
    ;

syntax GreaterThan
    = greaterThanSign: "\>"
    | greaterThan: 'GREATER' 'THAN'?
    ;

// conditions bind weaker than arithmetic; among the conditions (COBOL-85) sign and class conditions bind strongest,
// then relations, then NOT, then AND, and OR binds weakest
syntax Expression
    = :minus
    > non-assoc ( // sign conditions
                 positive: Expression 'IS'? 'POSITIVE' NotArithmetic
                | notPositive: Expression 'IS'? 'NOT' 'POSITIVE' NotArithmetic
                | notPositive: Expression 'NOT' 'IS' 'POSITIVE' NotArithmetic
                | negative: Expression 'IS'? 'NEGATIVE' NotArithmetic
                | notNegative: Expression 'IS'? 'NOT' 'NEGATIVE' NotArithmetic
                | notNegative: Expression 'NOT' 'IS' 'NEGATIVE' NotArithmetic
                | zero: Expression 'IS'? ('ZERO' | 'ZEROES' | 'ZEROS') NotArithmetic
                | notZero: Expression 'IS'? 'NOT' ('ZERO' | 'ZEROES' | 'ZEROS') NotArithmetic
                | notZero: Expression 'NOT' 'IS' ('ZERO' | 'ZEROES' | 'ZEROS') NotArithmetic
                // class conditions
                | numeric: Expression 'IS'? 'NUMERIC' NotArithmetic
                | notNumeric: Expression 'IS'? 'NOT' 'NUMERIC' NotArithmetic
                | notNumeric: Expression 'NOT' 'IS' 'NUMERIC' NotArithmetic
                | alphabetic: Expression 'IS'? 'ALPHABETIC' NotArithmetic
                | notAlphabetic: Expression 'IS'? 'NOT' 'ALPHABETIC' NotArithmetic
                | notAlphabetic: Expression 'NOT' 'IS' 'ALPHABETIC' NotArithmetic
                | alphabeticLower: Expression 'IS'? 'ALPHABETIC-LOWER' NotArithmetic
                | notAlphabeticLower: Expression 'IS'? 'NOT' 'ALPHABETIC-LOWER' NotArithmetic
                | notAlphabeticLower: Expression 'NOT' 'IS' 'ALPHABETIC-LOWER' NotArithmetic
                | alphabeticUpper: Expression 'IS'? 'ALPHABETIC-UPPER' NotArithmetic
                | notAlphabeticUpper: Expression 'IS'? 'NOT' 'ALPHABETIC-UPPER' NotArithmetic
                | notAlphabeticUpper: Expression 'NOT' 'IS' 'ALPHABETIC-UPPER' NotArithmetic
                | dbcs: Expression 'IS'? 'DBCS' NotArithmetic
                | notDbcs: Expression 'IS'? 'NOT' 'DBCS' NotArithmetic
                | notDbcs: Expression 'NOT' 'IS' 'DBCS' NotArithmetic
                | kanji: Expression 'IS'? 'KANJI' NotArithmetic
                | notKanji: Expression 'IS'? 'NOT' 'KANJI' NotArithmetic
                | notKanji: Expression 'NOT' 'IS' 'KANJI' NotArithmetic
                | inClass: Expression 'IS'? Id NotArithmetic
                | notInClass: Expression 'IS'? 'NOT' Id NotArithmetic
                | notInClass: Expression 'NOT' 'IS' Id NotArithmetic
                )
    // GREATER and LESS end at a word boundary: `EQUAL TO ZEROS AND GREATERZERO` has the condition name GREATERZERO
    > right ( greaterThan: Expression 'IS'? 'GREATER' !>> [A-Za-z0-9\-] ('THAN' | 'THEN')? Expression
            | greaterThan: Expression 'IS'? "\>" NotEqualSign Expression
            | notGreaterThan: Expression 'IS'? 'NOT' 'GREATER' !>> [A-Za-z0-9\-] ('THAN' | 'THEN')? Expression
            | notGreaterThan: Expression 'IS'? 'NOT' "\>" NotEqualSign Expression
            | lessThan: Expression 'IS'? 'LESS' !>> [A-Za-z0-9\-] ('THAN' | 'THEN')? Expression
            | lessThan: Expression 'IS'? "\<" NotEqualSign Expression
            | notLessThan: Expression 'IS'? 'NOT' 'LESS' !>> [A-Za-z0-9\-] ('THAN' | 'THEN')? Expression
            | notLessThan: Expression 'IS'? 'NOT' "\<" NotEqualSign Expression
            | equal: Expression 'IS'? 'EQUAL' 'TO'? Expression
            | equal: Expression 'IS'? "=" Expression
            | notEqual: Expression 'IS'? 'NOT' 'EQUAL' 'TO'? Expression
            | notEqual: Expression 'IS'? 'NOT' "=" Expression
            | greaterThanOrEqual: Expression 'IS'? 'GREATER' !>> [A-Za-z0-9\-] ('THAN' | 'THEN')? 'OR' 'EQUAL' 'TO'? Expression
            | greaterThanOrEqual: Expression 'IS'? "\>=" Expression
            | lessThanOrEqual: Expression 'IS'? 'LESS' !>> [A-Za-z0-9\-] ('THAN' | 'THEN')? 'OR' 'EQUAL' 'TO'? Expression
            | lessThanOrEqual: Expression 'IS'? "\<" "=" Expression
            )
    // abbreviated combined relation conditions leave out the subject: `A > B AND < C` means `A > B AND A < C`;
    // `AND NOT < C` is the negation of `< C`. Below the full relations, so `A >= B` is not `A > (= B)`
    > non-assoc ( greaterThan: 'IS'? 'GREATER' !>> [A-Za-z0-9\-] ('THAN' | 'THEN')? Expression
                | greaterThan: 'IS'? "\>" NotEqualSign Expression
                | notGreaterThan: 'IS' 'NOT' 'GREATER' !>> [A-Za-z0-9\-] ('THAN' | 'THEN')? Expression
                | notGreaterThan: 'IS' 'NOT' "\>" NotEqualSign Expression
                | lessThan: 'IS'? 'LESS' !>> [A-Za-z0-9\-] ('THAN' | 'THEN')? Expression
                | lessThan: 'IS'? "\<" NotEqualSign Expression
                | notLessThan: 'IS' 'NOT' 'LESS' !>> [A-Za-z0-9\-] ('THAN' | 'THEN')? Expression
                | notLessThan: 'IS' 'NOT' "\<" NotEqualSign Expression
                | equal: 'IS'? 'EQUAL' 'TO'? Expression
                | equal: 'IS'? "=" Expression
                | notEqual: 'IS' 'NOT' 'EQUAL' 'TO'? Expression
                | notEqual: 'IS' 'NOT' "=" Expression
                | greaterThanOrEqual: 'IS'? 'GREATER' !>> [A-Za-z0-9\-] ('THAN' | 'THEN')? 'OR' 'EQUAL' 'TO'? Expression
                | greaterThanOrEqual: 'IS'? "\>=" Expression
                | lessThanOrEqual: 'IS'? 'LESS' !>> [A-Za-z0-9\-] ('THAN' | 'THEN')? 'OR' 'EQUAL' 'TO'? Expression
                | lessThanOrEqual: 'IS'? "\<" "=" Expression
                )
    > negation: 'NOT' Expression
    > left conjunction: Expression 'AND' Expression
    > left disjunction: Expression 'OR' Expression
    ;

// a sign or class condition is no operand of arithmetic; without this guard `MAX(E + 4, H * 2)` would also read as
// `(E + 4 H) * 2`, an IS-less class condition, because priorities do not filter a postfix rule in a leftmost position
syntax NotArithmetic = () !>> [*/+\-];

// priorities do not keep the abbreviated `= B` out of `A < = B` and `A > = B`, so `<` and `>` exclude it here
syntax NotEqualSign = () !>> "=";
