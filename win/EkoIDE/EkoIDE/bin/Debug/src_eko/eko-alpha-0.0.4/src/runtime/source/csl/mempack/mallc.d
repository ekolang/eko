module csl.mempack.mallc;

import std.stdio, std.conv, error, value;
import core.stdc.stdlib: malloc;
import intfunc;

void*[string] voidp;
void _malloc(string line, string mode)
{
    if (mode == "debug"){
    writeln("YOU CALLED MALLOC SOMEWHERE IN YOUR PROG");
    }
    string[] args = init_func(line);
    if (args[0] == "int")
    {
        voidp[args[1]] = malloc(int.sizeof);
    } else if (args[0] == "string")
    {
        voidp[args[1]] = malloc(char.sizeof);
    } else
    {
        try {
            if (args[0] in int_s)
            {
                voidp[args[1]] = malloc(to!size_t(int_s[args[0]]));
            } else {
                voidp[args[1]] = malloc(to!size_t(args[0]));
            }
        
        } catch(Exception e)
        {
            //writeln("fi0");
            prinPanic(kodes._file_faild, line);
        }
    }
}