module lang::vscobolii::\test::AmbiguityRegressionTest

import analysis::grammars::dramb::Regression;
import lang::vscobolii::Main;

test bool runRegressionTests() = testForParsingRegressions(#VSCobolII, model) when {loc model} := findResources(|relative:///lang/vscobolii/test/regression.dra|);
