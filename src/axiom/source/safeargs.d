module safeargs;

import std.stdio, std.string, error, structer;
string[] safe_args(ref string[string] map, string[] current)
{
    string[] res;
    foreach(ol; current)
    {
        if (ol == "") continue;
        ol = ol.strip();
        //writeln("map_str contents: ", map);
        //writeln("ol: " ~ ol);
		if (ol.startsWith("@") && ol in map){
			res ~= map[ol.replace("\"", "")];
            continue;
		} else {
            if (ol.startsWith("@")) 
            {
                _error("\"\033[32m\033[1m" ~ ol.replace("@", "") ~ "\033[0m\"" ~ " does not exist in any of the data types or is undefined.");
            }
            res ~= ol;
        }
    }
    return res;
}
