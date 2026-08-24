module lbrk;

import std.stdio, std.string, infss;


int lpp(Tokan[] tt)
{
    int re = -1;
    for(int i = (cast(int)tt.length) -1; i >=0; i--)
    {
        if (tt[i].value == "}")
        {
            re = i;
            break;
        }
    }
    return re;
}