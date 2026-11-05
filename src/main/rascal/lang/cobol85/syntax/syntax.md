---
title: COBOL 85 grammar
---

The top module of this syntax definition for COBOL 85 is ((API:lang/cobol85/syntax/Main)).

This is a grammar for COBOL 85, grown out of a grammar for VS COBOL II by increasing the
test coverage for the NIST test set. Also the grammar has been refactored to align with 
Rascal grammar idioms.

You can find out more about the origin of this grammar in the `doc/sources` folder of the current project.

* Claude Opus 5.5 (model ID claude-opus-5-5) was used for grammar analysis and refactoring
* Every change was regression tested against the NIST files (present in this project). 
* All ambiguity was analyzed using ((analysis::grammars::Ambiguity)) and its ((Ambiguity-diagnose)) function.
* Parse errors caused by the gap between VS COBOL II and COBOL 85 were resolved by turning Claude Opus 5.5 training data of COBOL 85 example files (self-reporting) into context-free grammar rules.
* The grammar was widened by the author such that:
  - only one recursive non-terminal for Expressions and Conditions, will allow more kinds of expressions in more places. The over-approximation must be resolved by a downstream (type)checker, if so required.
  - statement kinds equal language constructs: optimized one rule per construct
  - optional statement tail clauses are now an arbitrary order list instead of a subset of all possible permutations. This decimates the number of required rules (and downstream pattern matches)
* Naming conventions of Rascal adopted. So `camelCase` for labels, constructors and functions and `CamelCase` for types.
* Using regular expression (EBNF) Rascal idioms instead of non-terminal encoding
* Ambiguity caused by scannerless parsing resolved with follow restrictions (longest match)
* Ambiguity caused by "shift-before-reduce" heuristics in the grammar resolved by follow restrictions (with inner)
* Ambiguity caused by merging highly similar non-terminals, solved by excluding specific rules with `!` at usage locations
