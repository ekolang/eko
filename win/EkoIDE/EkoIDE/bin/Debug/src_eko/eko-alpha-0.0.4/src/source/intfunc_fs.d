module intfunc_fs;

import std.stdio;
import std.string, infss;

void readit(string jak, string prif) {
    if (prif != "")
    {
        write(prif);
        str[jak] = readln();
    } else {
        str[jak] = readln();
    }
}