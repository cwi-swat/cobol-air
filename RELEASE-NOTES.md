
#### 0.2 - maintenance

* Moved ambiguity regression tests out of the DrAmbiguity model to a standard rsc-test module file.

#### 0.1.1 - maintenance

* API documentation in order; ready for inclusion in http://www.rascal-mpl.org

#### 0.1.0 - the leap to COBOL 85

* added context-free grammar rules for all COBOL 85 constructs found in the NIST examples which are not also in VS COBOL II
* added rules for accepting COPY statements in several common locations in the grammar; at least those required to parse the NIST examples
* added syntax rules for COPY books themselves, for as long as they represent "proper" sub-non-terminals of the grammar. This excludes one test CPY file in the NIST set.
* large-scale simplifications and refactorings, and accepts more sentences without becoming ambiguous. Some syntactical constructs which were illegal before are legal now to make the tree shape simpler and easier to disambiguate:
   - collapsed mutually recursive expression operators into a single non-terminal `Expression`; added priority, associativity, exclude and follow restrictions to filter the new ambiguity caused by this collapse
   - shared common prefixes, targeting a single rule for every language construct for non-terminals such as Statement
   - let go of fixed order of optional tail clauses, these are now lists (which also helps with sharing prefixes)
   - renamed all non-terminals to use "CamelCase"
   - renamed all constructor names to use "camelCase"
   - renamed all constructor names to reflect the literals of the rule itself (like `ifThenElse` and `perform` instead of `non-terminal-4` and `non-terminal-5`)
   - fixed all ambiguity caused by "LR shift/reduce conflicts" which can be resolved by a "shift before reduce" heuristic, using follow restrictions and precede restrictions
   - distributed the keyword reservation non-terminal acros the modules where the respective keywords are introduced
* activated regression tests for the NIST examples (both .COB and .CPY) files
* registered a regression tests for every sub-ambiguity found in regressions.dra and let the tests run these regression tests

The current grammar has 218 non-terminals where the original had 271 (excluding keyword sorts), and 796 rules where the original had 708 rules. 
The fewer non-terminal are due to over-approximations (simplifications) such as letting go of the fixed order of optional tail clauses and creating idiomatic expression grammars. The additional rules are due to supporting large language extensions that come with COBOL 85 and spreading the possibility of REPLACE and COPY commands over the grammar. Due to sharing optional tail clauses between different language constructs and the `!` exclude operator, also many rules could be removed.

#### 0.0.1 (unreleased) - the beginning with VS COBOL II

* initial grammar extracted from VS COBOL II grammar via Jan Kort's https://gdk.sourceforge.net/vscobolii.html
* extracted grammar to SDF2 and converted to Rascal semi-automatically
* included all COBOL 85 test cases from NIST
* initial simplification/rewrites to make grammar idiomatic
