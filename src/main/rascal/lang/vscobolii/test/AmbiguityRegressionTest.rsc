module lang::vscobolii::\test::AmbiguityRegressionTest

import analysis::grammars::dramb::Regression;
import lang::vscobolii::Main;
import IO;

test bool runRegressionTests() = testForParsingRegressions(#VSCobolII, model) when {loc model} := findResources(|relative:///lang/vscobolii/test/regressions.dra|);
