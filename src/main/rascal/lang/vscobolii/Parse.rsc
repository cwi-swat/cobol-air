module lang::vscobolii::Parse

import lang::vscobolii::Main;
import lang::vscobolii::Preprocess;
import ParseTree;
import IO;
import util::FileSystem;
import Set;
import Exception;

start[VSCobolII] parseVSCobolII(loc org, bool allowAmbiguity=false) {
    return parse(#start[VSCobolII], preprocess(readFile(org)), org, allowAmbiguity=allowAmbiguity);
}


void smokeTest() {
    cbls = [ f | loc f <- files(|project://cobol-air/examples/NIST/|), f.extension in {"CBL", "SUBPRG", "SUBRTN"}];

    set[loc] bugTriggering = {|project://cobol-air/examples/NIST/IX/IX109A.CBL|, |project://cobol-air/examples/NIST/IX/IX108A.CBL|,
                    |project://cobol-air/examples/NIST/IX/IX105A.CBL|, |project://cobol-air/examples/NIST/NC/NC201A.CBL|,
                    |project://cobol-air/examples/NIST/IX/IX113A.CBL|, |project://cobol-air/examples/NIST/RL/RL210A.CBL|,
                    |project://cobol-air/examples/NIST/NC/NC210A.CBL|, |project://cobol-air/examples/NIST/IX/IX118A.SUBPRG|,
                    |project://cobol-air/examples/NIST/IX/IX119A.SUBPRG|, |project://cobol-air/examples/NIST/IX/IX120A.SUBPRG|,
                    |project://cobol-air/examples/NIST/IX/IX114A.SUBPRG|, |project://cobol-air/examples/NIST/IX/IX115A.SUBPRG|,
                    |project://cobol-air/examples/NIST/IX/IX116A.SUBPRG|, |project://cobol-air/examples/NIST/IX/IX117A.SUBPRG|,
                    |project://cobol-air/examples/NIST/NC/NC211A.CBL|};
    
    int success = 0;
    int errors = 0;
    int ambs = 0;
    for (loc src <- cbls, src notin bugTriggering) {
        try {
            println("parsing <src>");
            pt = parseVSCobolII(src, allowAmbiguity=true);
            success += 1;
            println("success!");
        }
        catch Ambiguity(loc l, str sym, str txt): {
            println("ambiguity: <l>");
            println("symbol: <sym>");
            println("source: `<txt>`");
            ambs += 1;
        }
        catch ParseError(loc l): {
            println("parse error: <l>");
            errors += 1;
        }
    }

    println("#succes: <success>");
    println("#errors: <errors>");
    println("#ambs: <ambs>");
    println("#bugtriggering: <size(bugTriggering)>");
}