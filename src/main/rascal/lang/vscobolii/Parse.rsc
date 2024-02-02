module lang::vscobolii::Parse

import lang::vscobolii::Main;
import lang::vscobolii::Preprocess;
import ParseTree;
import IO;


start[VSCobolII] parseVSCobolII(loc org, bool allowAmbiguity=false) {
    return parse(#start[VSCobolII], nukeLineNos(readFile(org)), org, allowAmbiguity=allowAmbiguity);
}