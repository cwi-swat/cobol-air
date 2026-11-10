module lang::cobol85::\test::AmbiguityRegressionTest

import analysis::grammars::ParserTesting;
import util::Reflective;

@synopsis{Run the regression tests in cobol85-regressions.rsc-tests against the current grammar}
@description{
Every test in `cobol85-regressions.rsc-tests` is an ambiguity that was fixed: an example that must parse without
ambiguity as the nonterminal in its header. Failing tests are reported with their location in the test file.
Diagnose a failing example with `firstAmbiguity` and `diagnose` from `analysis::grammars::Ambiguity`.
}
test bool runRegressionTests()
    = reportParserTestModule(|project://cobol-air/src/main/rascal/lang/cobol85/test/cobol85-regressions.rsc-tests|, pcfg=getProjectPathConfig(|project://cobol-air|));
