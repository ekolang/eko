module error;

import std.stdio;
import cbased;

void _error(string errortxt)
{
    writeln("\033[1m\033[31mError: \033[0m" ~ errortxt);
    _abort();
}