module lang::vscobolii::\test::Parse

import Exception;
import IO;
import ParseTree;
import Set;
import lang::vscobolii::Main;
import lang::vscobolii::Preprocess;
import util::FileSystem;
import util::Monitor;

private bool debug = true;

start[VSCobolII] parseVSCobolII(loc org, bool allowAmbiguity=false, bool allowRecovery=false, bool pre=true) {
    str src = readFile(org);
    return parse(#start[VSCobolII], pre ? preprocess(src) : src, org, allowAmbiguity=allowAmbiguity, allowRecovery=allowRecovery);
}

public set[loc] needsReplace = {
    |project://cobol-air/examples/NIST/SM/SM208A.CBL|
};

public set[loc] havingFUNCTION = {
|project://cobol-air/examples/NIST/OB/OBIC1A.CBL|,
|project://cobol-air/examples/NIST/OB/OBNC1M.CBL|,
|project://cobol-air/examples/NIST/IF/IF107A.CBL|,
|project://cobol-air/examples/NIST/IF/IF111A.CBL|,
|project://cobol-air/examples/NIST/IF/IF131A.CBL|,
|project://cobol-air/examples/NIST/IF/IF127A.CBL|,
|project://cobol-air/examples/NIST/IF/IF126A.CBL|,
|project://cobol-air/examples/NIST/IF/IF130A.CBL|,
|project://cobol-air/examples/NIST/IF/IF110A.CBL|,
|project://cobol-air/examples/NIST/IF/IF106A.CBL|,
|project://cobol-air/examples/NIST/IF/IF137A.CBL|,
|project://cobol-air/examples/NIST/IF/IF121A.CBL|,
|project://cobol-air/examples/NIST/IF/IF101A.CBL|,
|project://cobol-air/examples/NIST/IF/IF401M.CBL|,
|project://cobol-air/examples/NIST/IF/IF117A.CBL|,
|project://cobol-air/examples/NIST/IF/IF140A.CBL|,
|project://cobol-air/examples/NIST/IF/IF141A.CBL|,
|project://cobol-air/examples/NIST/IF/IF116A.CBL|,
|project://cobol-air/examples/NIST/IF/IF120A.CBL|,
|project://cobol-air/examples/NIST/IF/IF136A.CBL|,
|project://cobol-air/examples/NIST/IF/IF123A.CBL|,
|project://cobol-air/examples/NIST/IF/IF135A.CBL|,
|project://cobol-air/examples/NIST/IF/IF119A.CBL|,
|project://cobol-air/examples/NIST/IF/IF139A.CBL|,
|project://cobol-air/examples/NIST/IF/IF142A.CBL|,
|project://cobol-air/examples/NIST/IF/IF115A.CBL|,
|project://cobol-air/examples/NIST/IF/IF403M.CBL|,
|project://cobol-air/examples/NIST/IF/IF103A.CBL|,
|project://cobol-air/examples/NIST/IF/IF102A.CBL|,
|project://cobol-air/examples/NIST/IF/IF114A.CBL|,
|project://cobol-air/examples/NIST/IF/IF402M.CBL|,
|project://cobol-air/examples/NIST/IF/IF138A.CBL|,
|project://cobol-air/examples/NIST/IF/IF118A.CBL|,
|project://cobol-air/examples/NIST/IF/IF134A.CBL|,
|project://cobol-air/examples/NIST/IF/IF122A.CBL|,
|project://cobol-air/examples/NIST/IF/IF129A.CBL|,
|project://cobol-air/examples/NIST/IF/IF113A.CBL|,
|project://cobol-air/examples/NIST/IF/IF105A.CBL|,
|project://cobol-air/examples/NIST/IF/IF125A.CBL|,
|project://cobol-air/examples/NIST/IF/IF133A.CBL|,
|project://cobol-air/examples/NIST/IF/IF109A.CBL|,
|project://cobol-air/examples/NIST/IF/IF108A.CBL|,
|project://cobol-air/examples/NIST/IF/IF132A.CBL|,
|project://cobol-air/examples/NIST/IF/IF124A.CBL|,
|project://cobol-air/examples/NIST/IF/IF104A.CBL|,
|project://cobol-air/examples/NIST/IF/IF112A.CBL|,
|project://cobol-air/examples/NIST/IF/IF128A.CBL|,
|project://cobol-air/examples/NIST/ST/ST133A.CBL|,
|project://cobol-air/examples/NIST/NC/NC140A.CBL|,
|project://cobol-air/examples/NIST/DB/DB105A.CBL|,
|project://cobol-air/examples/NIST/DB/DB203A.CBL|,
|project://cobol-air/examples/NIST/DB/DB202A.CBL|,
|project://cobol-air/examples/NIST/IC/IC237A.CBL|,
|project://cobol-air/examples/NIST/IC/IC227A.CBL|,
|project://cobol-air/examples/NIST/IC/IC222A.CBL|,
|project://cobol-air/examples/NIST/IX/IX205A.CBL|,
|project://cobol-air/examples/NIST/IX/IX101A.CBL|,
|project://cobol-air/examples/NIST/IX/IX208A.CBL|,
|project://cobol-air/examples/NIST/IX/IX218A.CBL|,
|project://cobol-air/examples/NIST/IX/IX201A.CBL|,
|project://cobol-air/examples/NIST/IX/IX217A.CBL|,
|project://cobol-air/examples/NIST/IX/IX105A.CBL|,
|project://cobol-air/examples/NIST/IX/IX207A.CBL|,
|project://cobol-air/examples/NIST/IX/IX206A.CBL|,
|project://cobol-air/examples/NIST/RL/RL211A.CBL|,
|project://cobol-air/examples/NIST/RL/RL206A.CBL|,
|project://cobol-air/examples/NIST/RL/RL210A.CBL|,
|project://cobol-air/examples/NIST/RL/RL108A.CBL|,
|project://cobol-air/examples/NIST/RL/RL201A.CBL|,
|project://cobol-air/examples/NIST/RL/RL105A.CBL|,
|project://cobol-air/examples/NIST/RL/RL106A.CBL|,
|project://cobol-air/examples/NIST/RL/RL107A.CBL|,
|project://cobol-air/examples/NIST/RL/RL205A.CBL|,
|project://cobol-air/examples/NIST/RL/RL209A.CBL|,
|project://cobol-air/examples/NIST/RL/RL212A.CBL|,
|project://cobol-air/examples/NIST/RW/RW101A.CBL|,
|project://cobol-air/examples/NIST/RW/RW102A.CBL|,
|project://cobol-air/examples/NIST/RW/RW103A.CBL|,
|project://cobol-air/examples/NIST/RW/RW104A.CBL|,
|project://cobol-air/examples/NIST/IX/IX203A.SUBPRG|,
|project://cobol-air/examples/NIST/IX/IX202A.SUBPRG|,
|project://cobol-air/examples/NIST/IX/IX103A.SUBPRG|,
|project://cobol-air/examples/NIST/IX/IX102A.SUBPRG|,
|project://cobol-air/examples/NIST/RL/RL109A.SUBPRG|,
|project://cobol-air/examples/NIST/RL/RL110A.SUBPRG|,
|project://cobol-air/examples/NIST/RL/RL102A.SUBPRG|,
|project://cobol-air/examples/NIST/RL/RL103A.SUBPRG|,
|project://cobol-air/examples/NIST/RL/RL207A.SUBPRG|,
|project://cobol-air/examples/NIST/RL/RL202A.SUBPRG|,
|project://cobol-air/examples/NIST/RL/RL203A.SUBPRG|,
|project://cobol-air/examples/NIST/RL/RL213A.SUBPRG|,
|project://cobol-air/examples/NIST/RL/RL208A.SUBPRG|
};

test bool smokeTest() {
    cbls = [ f | loc f <- files(|project://cobol-air/examples/NIST/|), f.extension in {"CBL", "SUBPRG", "SUBRTN"}];

    set[loc] bugTriggering = {} ;
    //  {|project://cobol-air/examples/NIST/IX/IX109A.CBL|, |project://cobol-air/examples/NIST/IX/IX108A.CBL|,
    //                 |project://cobol-air/examples/NIST/IX/IX105A.CBL|, |project://cobol-air/examples/NIST/NC/NC201A.CBL|,
    //                 |project://cobol-air/examples/NIST/IX/IX113A.CBL|, |project://cobol-air/examples/NIST/RL/RL210A.CBL|,
    //                 |project://cobol-air/examples/NIST/NC/NC210A.CBL|, |project://cobol-air/examples/NIST/IX/IX118A.SUBPRG|,
    //                 |project://cobol-air/examples/NIST/IX/IX119A.SUBPRG|, |project://cobol-air/examples/NIST/IX/IX120A.SUBPRG|,
    //                 |project://cobol-air/examples/NIST/IX/IX114A.SUBPRG|, |project://cobol-air/examples/NIST/IX/IX115A.SUBPRG|,
    //                 |project://cobol-air/examples/NIST/IX/IX116A.SUBPRG|, |project://cobol-air/examples/NIST/IX/IX117A.SUBPRG|,
    //                 |project://cobol-air/examples/NIST/NC/NC211A.CBL|};
    
    int success = 0;
    int errors = 0;
    int ambs = 0;
    jobStart("parsing test files", totalWork=size(cbls));

    for (loc src <- cbls, src notin bugTriggering,  src notin needsReplace) {
        jobStep("parsing test files", "<src>");
        try {
            println("parsing <src>");
            pt = parseVSCobolII(src, allowAmbiguity=false);
            success += 1;
            println("success!");
            // int numOfAmbs = ( 0 | it + 1 | /amb(_) := pt );
            // println("ambs: <numOfAmbs>");
        }
        catch Ambiguity(loc l, str sym, str txt): {
            println("ambiguity: <l>");
            println("symbol: <sym>");
            println("source: `<txt>`");
            //return ;
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

    println("#succes: <success>");
    println("#errors: <errors>");
    println("#ambs: <ambs>");
    println("#bugtriggering: <size(bugTriggering)>");

    // we always return true because we are not ready yet
    return true;
}