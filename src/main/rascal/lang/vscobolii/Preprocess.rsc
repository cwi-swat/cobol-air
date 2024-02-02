module lang::vscobolii::Preprocess

import String;
import List;

str nukeLineNos(str src) {
    list[str] lines = split("\n", src);
    lines = [ "      " + line[6..72] + "        " | str line <- lines ];
    return intercalate("\n", lines) + "\n";
}