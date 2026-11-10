module lang::cobol85::ide::LanguageServer

import ParseTree;
import util::LanguageServer;
import util::Reflective;
import lang::cobol85::\syntax::Main;
import lang::cobol85::Parser;

set[LanguageService] contributions() = {
    parsing(Tree (str input, loc origin) { 
        return parseCobol85(input, origin, doPreprocess=true, allowRecovery=true); 
    })
};

set[LanguageService] copyBookContributions() = {
    parsing(Tree (str input, loc origin) { 
        return parseCobol85Copybook(input, origin, doPreprocess=true, allowRecovery=true); 
    })
};

void main() {
    registerLanguage(
        language(
            getProjectPathConfig(|project://cobol-air|, mode=interpreter()),
            "COBOL85",
            {"CBL"},
            "lang::cobol85::ide::LanguageServer",
            "contributions"
        )
    );
    registerLanguage(
        language(
            getProjectPathConfig(|project://cobol-air|, mode=interpreter()),
            "COBOL85 Copybooks",
            {"CPY"},
            "lang::cobol85::ide::LanguageServer",
            "copyBookContributions"
        )
    );
}
