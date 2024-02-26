module lang::vscobolii::\test::AmbiguityRegressionTest

import analysis::grammars::dramb::Regression;
import lang::vscobolii::Main;
import IO;

@synopsis{Run the stored examples in regressions.dra against the current grammar}
@description{
If the tests fail, then run `drAmbiguity(|project://cobol-air/src/main/rascal/lang/vscobolii/test/regressions.dra|)` to diagnose and fix the errors.
Add more tests by "stashing" more examples in the model and press "file->save" in DrAmbiguity.
}
test bool runRegressionTests() = testForParsingRegressions(#VSCobolII, model) when {loc model} := findResources(|relative:///lang/vscobolii/test/regressions.dra|);
