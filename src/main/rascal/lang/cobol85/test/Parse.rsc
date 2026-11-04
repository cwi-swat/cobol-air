module lang::cobol85::\test::Parse

import Exception;
import IO;
import ParseTree;
import Set;
import lang::cobol85::Parser;
import util::FileSystem;
import util::Monitor;

private bool debug = false;

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

// copybooks that are no complete construct on their own: the end or the middle of a data description entry, an IF
// without its body, a single operand or word, or text that is only COBOL after COPY REPLACING (KP004). They only
// parse after expanding them into the program that copies them.
public set[loc] incompleteCopyBooks = {
    |project://cobol-air/examples/NIST/copybooks/K101A.CPY|,
    |project://cobol-air/examples/NIST/copybooks/K1P01.CPY|,
    |project://cobol-air/examples/NIST/copybooks/K1PRC.CPY|,
    |project://cobol-air/examples/NIST/copybooks/K1W01.CPY|,
    |project://cobol-air/examples/NIST/copybooks/K1W02.CPY|,
    |project://cobol-air/examples/NIST/copybooks/K1W03.CPY|,
    |project://cobol-air/examples/NIST/copybooks/KP004.CPY|,
    |project://cobol-air/examples/NIST/copybooks/KP009.CPY|,
    |project://cobol-air/examples/NIST/copybooks/KP010.CPY|
};

// uses the Report Writer clauses and statements that the NIST test set does not use; fails on a parse error or ambiguity
test bool reportWriterTest() {
    parseCobol85(|project://cobol-air/examples/ReportWriter/RWFULL.CBL|);
    return true;
}

test bool cobol85ParseNIST() {
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

// parses every copybook with the Copybook start nonterminal; a copybook that fits several of its alternatives counts
// as a success, with a forest at the top
test bool cobol85ParseNistCopybooks() {
    cpys = [ f | loc f <- files(|project://cobol-air/examples/NIST/|), f.extension == "CPY"];

    int success = 0;
    int errors = 0;
    int ambs = 0;
    jobStart("parsing copybooks", totalWork=size(cpys));

    for (loc src <- cpys, src notin incompleteCopyBooks) {
        jobStep("parsing copybooks", "<src>");
        try {
            parseCobol85Copybook(src);
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
    jobEnd("parsing copybooks");

    println("#success: <success>");
    println("#errors : <errors>");
    println("#ambs   : <ambs>");

    return errors == 0 && ambs == 0;
}
