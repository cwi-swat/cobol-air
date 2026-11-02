module lang::cobol85::\test::AmbiguityRegressionTest

import analysis::grammars::dramb::Regression;
import lang::cobol85::\syntax::Main;
import IO;

@synopsis{Run the stored examples in regressions.dra against the current grammar}
@description{
If the tests fail, then run `drAmbiguity(|project://cobol-air/src/main/rascal/lang/cobol85/test/regressions.dra|)` to diagnose and fix the errors.
Add more tests by "stashing" more examples in the model and press "file->save" in DrAmbiguity.
}
test bool runRegressionTests() = testForParsingRegressions(#Cobol85, model) when {loc model} := findResources(|relative:///lang/cobol85/test/regressions.dra|);
