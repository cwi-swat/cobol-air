module lang::cobol85::\test::Parse

import Exception;
import IO;
import ParseTree;
import Set;
import lang::cobol85::\syntax::Main;
import lang::cobol85::\syntax::Preprocess;
import util::FileSystem;
import util::Monitor;

private bool debug = false;

start[Cobol85] parseCobol85(loc org, bool allowAmbiguity=false, bool allowRecovery=false, bool pre=true) {
    str src = readFile(org);
    return parse(#start[Cobol85], pre ? preprocess(src) : src, org, allowAmbiguity=allowAmbiguity, allowRecovery=allowRecovery);
}

public set[loc] needsReplace = {
    |project://cobol-air/examples/NIST/SM/SM208A.CBL|
};

// COPY in the middle of an entry or a statement (`77 COPY K1W02.` followed by `14003.`, `IF X = COPY K3SML.`);
// these only parse after expanding the copybooks, which we do not do (yet)
public set[loc] needsCopyExpansion = {
    |project://cobol-air/examples/NIST/SM/SM101A.CBL|,
    |project://cobol-air/examples/NIST/SM/SM103A.CBL|,
    |project://cobol-air/examples/NIST/SM/SM206A.CBL|
};

// uses the Report Writer clauses and statements that the NIST test set does not use; fails on a parse error or ambiguity
test bool reportWriterTest() {
    parseCobol85(|project://cobol-air/examples/ReportWriter/RWFULL.CBL|);
    return true;
}

test bool smokeTest() {
    cbls = [ f | loc f <- files(|project://cobol-air/examples/NIST/|), f.extension in {"CBL", "SUBPRG", "SUBRTN"}];
    
    int success = 0;
    int errors = 0;
    int ambs = 0;
    ignored = needsCopyExpansion + needsReplace;
    jobStart("parsing test files", totalWork=size(cbls));

    for (loc src <- cbls, src notin ignored) {
        jobStep("parsing test files", "<src>");
        try {
            pt = parseCobol85(src, allowAmbiguity=false);
            success += 1;
        }
        catch Ambiguity(loc l, str sym, str txt): {
            println("ambiguity: <l>");
            println("symbol: <sym>");
            println("source: `<txt>`");
            
            ambs += 1;
            if (debug) {
                return false;
            }
        }
        catch ParseError(loc l): {
            println("parse error: <l>");
            errors += 1;
            if (debug) {
                return false;
            }
        }
    }
    jobEnd("parsing test files");

    println("#success: <success>");
    println("#errors : <errors>");
    println("#ambs   : <ambs>");

    return errors == 0 && ambs == 0;
}