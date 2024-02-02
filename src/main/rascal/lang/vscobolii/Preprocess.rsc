module lang::vscobolii::Preprocess

import String;
import List;

str preprocess(str src) {
    list[str] lines = split("\n", src);
    str prespace = "      ";
    lines = [ prespace + line[6..72] + "        " | str line <- lines ];

    lines = for (str line <- lines) {
        if (line[7] == "-") { // continuation 
            line = line[0..7] + " " + line[8..];
        }
        append line;
    }
    return intercalate("\n", lines) + "\n";
}
