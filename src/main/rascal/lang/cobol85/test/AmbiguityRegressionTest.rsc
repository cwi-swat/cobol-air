module lang::cobol85::\test::AmbiguityRegressionTest

import analysis::grammars::dramb::Model;
import analysis::grammars::dramb::Regression;
import lang::cobol85::\syntax::Main;
import IO;
import ValueIO;
// readTextValueFile builds the constructors it reads (type, prod, just, ...) from the definitions in scope here
import ParseTree;
import util::Maybe;

@synopsis{Run the stored examples in regressions.dra against the current grammar}
@description{
If the tests fail, then run `drAmbiguity(|project://cobol-air/src/main/rascal/lang/cobol85/test/regressions.dra|)` to diagnose and fix the errors.
Add more tests by "stashing" more examples in the model and press "file->save" in DrAmbiguity.
The model is stored as a textual value, the format that `drAmbiguity(loc)` reads.
}
test bool runRegressionTests() = runRegressionTests(#Cobol85, readTextValueFile(#Model, model)) == []
  when {loc model} := findResources(|relative:///lang/cobol85/test/regressions.dra|);
