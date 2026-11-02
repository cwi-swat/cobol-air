 module lang::cobol85::\syntax::Condition  extend lang::cobol85::\syntax::Expression; 

// the reserved words of this module
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

syntax Greater_than_or_equal_to =
   \greater-than-or-equal-to-c1: 'GREATER' 'THAN'? 'OR' 'EQUAL' 'TO'? 
  |  \greater-than-or-equal-to-c2: 'NOT' 'LESS' 'THAN'? 
  | \greater-than-or-equal-to-c4: "\>=" 
  |  \greater-than-or-equal-to-c3: 'NOT' "\<" 
  ; 
syntax Greater_than =
  \greater-than-c2: "\>" 
  |  \greater-than-c1: 'GREATER' 'THAN'? 
  ; 
// relations bind stronger than NOT, NOT stronger than AND, and AND stronger than OR (COBOL-85)
syntax Condition
  = bareExpression: Arithmetic_expression 
  // sign conditions
  | positive: Arithmetic_expression 'IS'? 'POSITIVE'
  | notPositive: Arithmetic_expression (('NOT' 'IS') | ('IS'? 'NOT')) 'POSITIVE'
  | negative: Arithmetic_expression 'IS'? 'NEGATIVE'
  | notNegative: Arithmetic_expression (('NOT' 'IS') | ('IS'? 'NOT')) 'NEGATIVE'
  | zero: Arithmetic_expression 'IS'? ('ZERO' | 'ZEROES' | 'ZEROS')
  | notZero: Arithmetic_expression (('NOT' 'IS') | ('IS'? 'NOT')) ('ZERO' | 'ZEROES' | 'ZEROS')
  // class conditions
  | numeric: Identifier 'IS'? 'NUMERIC'
  | notNumeric: Identifier (('NOT' 'IS') | ('IS'? 'NOT')) 'NUMERIC'
  | alphabetic: Identifier 'IS'? 'ALPHABETIC'
  | notAlphabetic: Identifier (('NOT' 'IS') | ('IS'? 'NOT')) 'ALPHABETIC'
  | alphabeticLower: Identifier 'IS'? 'ALPHABETIC-LOWER'
  | notAlphabeticLower: Identifier (('NOT' 'IS') | ('IS'? 'NOT')) 'ALPHABETIC-LOWER'
  | alphabeticUpper: Identifier 'IS'? 'ALPHABETIC-UPPER'
  | notAlphabeticUpper: Identifier (('NOT' 'IS') | ('IS'? 'NOT')) 'ALPHABETIC-UPPER'
  | dbcs: Identifier 'IS'? 'DBCS'
  | notDbcs: Identifier (('NOT' 'IS') | ('IS'? 'NOT')) 'DBCS'
  | kanji: Identifier 'IS'? 'KANJI'
  | notKanji: Identifier (('NOT' 'IS') | ('IS'? 'NOT')) 'KANJI'
  | inClass: Identifier 'IS'? Class_name
  | notInClass: Identifier (('NOT' 'IS') | ('IS'? 'NOT')) Class_name
  // condition brackets only around real conditions; brackets around a bare expression are expression brackets
  | brackets: "(" Condition!bareExpression ")"
  // GREATER and LESS end at a word boundary: `EQUAL TO ZEROS AND GREATERZERO` has the condition name GREATERZERO
  > right (
      greaterThan: Condition 'IS'? 'GREATER' !>> [A-Za-z0-9\-] ('THAN' | 'THEN')? Condition
    | greaterThan: Condition 'IS'? "\>" NotEqualSign Condition
    | notGreaterThan: Condition 'IS'? 'NOT' 'GREATER' !>> [A-Za-z0-9\-] ('THAN' | 'THEN')? Condition
    | notGreaterThan: Condition 'IS'? 'NOT' "\>" NotEqualSign Condition
    | lessThan: Condition 'IS'? 'LESS' !>> [A-Za-z0-9\-] ('THAN' | 'THEN')? Condition
    | lessThan: Condition 'IS'? "\<" NotEqualSign Condition
    | notLessThan: Condition 'IS'? 'NOT' 'LESS' !>> [A-Za-z0-9\-] ('THAN' | 'THEN')? Condition
    | notLessThan: Condition 'IS'? 'NOT' "\<" NotEqualSign Condition
    | equal: Condition 'IS'? 'EQUAL' 'TO'? Condition
    | equal: Condition 'IS'? "=" Condition
    | notEqual: Condition 'IS'? 'NOT' 'EQUAL' 'TO'? Condition
    | notEqual: Condition 'IS'? 'NOT' "=" Condition
    | greaterThanOrEqual: Condition 'IS'? 'GREATER' !>> [A-Za-z0-9\-] ('THAN' | 'THEN')? 'OR' 'EQUAL' 'TO'? Condition
    | greaterThanOrEqual: Condition 'IS'? "\>=" Condition
    | lessThanOrEqual: Condition 'IS'? 'LESS' !>> [A-Za-z0-9\-] ('THAN' | 'THEN')? 'OR' 'EQUAL' 'TO'? Condition
    | lessThanOrEqual: Condition 'IS'? "\<" "=" Condition
    )
  // abbreviated combined relation conditions leave out the subject: `A > B AND < C` means `A > B AND A < C`;
  // `AND NOT < C` is the negation of `< C`. Below the full relations, so `A >= B` is not `A > (= B)`
  > non-assoc (
      greaterThan: 'IS'? 'GREATER' !>> [A-Za-z0-9\-] ('THAN' | 'THEN')? Condition
    | greaterThan: 'IS'? "\>" NotEqualSign Condition
    | notGreaterThan: 'IS' 'NOT' 'GREATER' !>> [A-Za-z0-9\-] ('THAN' | 'THEN')? Condition
    | notGreaterThan: 'IS' 'NOT' "\>" NotEqualSign Condition
    | lessThan: 'IS'? 'LESS' !>> [A-Za-z0-9\-] ('THAN' | 'THEN')? Condition
    | lessThan: 'IS'? "\<" NotEqualSign Condition
    | notLessThan: 'IS' 'NOT' 'LESS' !>> [A-Za-z0-9\-] ('THAN' | 'THEN')? Condition
    | notLessThan: 'IS' 'NOT' "\<" NotEqualSign Condition
    | equal: 'IS'? 'EQUAL' 'TO'? Condition
    | equal: 'IS'? "=" Condition
    | notEqual: 'IS' 'NOT' 'EQUAL' 'TO'? Condition
    | notEqual: 'IS' 'NOT' "=" Condition
    | greaterThanOrEqual: 'IS'? 'GREATER' !>> [A-Za-z0-9\-] ('THAN' | 'THEN')? 'OR' 'EQUAL' 'TO'? Condition
    | greaterThanOrEqual: 'IS'? "\>=" Condition
    | lessThanOrEqual: 'IS'? 'LESS' !>> [A-Za-z0-9\-] ('THAN' | 'THEN')? 'OR' 'EQUAL' 'TO'? Condition
    | lessThanOrEqual: 'IS'? "\<" "=" Condition
    )
  > negation: 'NOT' Condition 
  > left conjunction: Condition 'AND' Condition 
  > left disjunction: Condition 'OR' Condition 
  ; 

// priorities do not keep the abbreviated `= B` out of `A < = B` and `A > = B`, so `<` and `>` exclude it here
syntax NotEqualSign = () !>> "=";
