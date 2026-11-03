module lang::cobol85::ide::LanguageServer

import ParseTree;
import util::LanguageServer;
import util::Reflective;
import lang::cobol85::\syntax::Main;
import lang::cobol85::\syntax::Preprocess;

private start[Cobol85] (value, loc) cobolParser = parser(#start[Cobol85], allowRecovery=true, allowAmbiguity=false);

set[LanguageService] contributions() = {
    parsing(Tree (str input, loc origin) { 
        return cobolParser(preprocess(input), origin); 
    })
};

void main() {
    registerLanguage(
        language(
            getProjectPathConfig(|project://cobol-air|, mode=interpreter_external()),
            "COBOL85",
            {"CBL"},
            "lang::cobol85::ide::LanguageServer",
            "contributions"
        )
    );
}
