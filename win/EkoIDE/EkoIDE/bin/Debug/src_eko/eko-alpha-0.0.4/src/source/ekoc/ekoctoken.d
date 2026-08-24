module ekoc.ekoctoken;

import std.stdio;

string[] ekoc_token(string line)
{
    bool inp = false;
    string current = "";
    string[] result;
    foreach(char a; line)
    {
        if (a == '"')
        {
            inp = !inp;
            current ~= a;
            continue;
        } else if (inp)
        {
            current ~= a;
            continue;
        } else if (a == ' ')
        {
            result ~= current;
            current = "";
            continue;
        } else if (a == ';'){
            result ~= current;
            current = "";
            continue;
        } else {
            current ~= a;
            continue;
        }
    }
    return result;
}