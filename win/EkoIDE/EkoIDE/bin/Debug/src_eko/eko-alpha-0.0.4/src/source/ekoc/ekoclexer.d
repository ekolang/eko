module ekoc.ekoclexer;
import ekoc.ekostatic;
string[] keywords = ["S"];
import std.stdio, std.string, std.algorithm;
EkocToken[] ekoclex(string[] toks)
{
    EkocToken[] tokens;
    foreach(i; toks)
    {
        bool k = false;
        foreach(o; keywords)
        {
            if (i == o)
            {
                tokens ~= EkocToken(i, Ekoctype.keyword);
                k = true;
            }
        }
        if (k)
        {
            k = false;
            continue;
        }
        if (i.startsWith("@"))
        {
            tokens ~= EkocToken(i, Ekoctype.name);
        } else if (i == "=") tokens ~= EkocToken(i, Ekoctype.op);
        else tokens ~= EkocToken(i, Ekoctype.valaue);
    }

    return tokens;
}