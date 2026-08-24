module marschiert;

import std.stdio;
public import csl.mempack.freec, csl.mempack.mallc;
public import cslg.ultracgraphic.sgfu;
public import error;
public import intfunc;
public import value;
import core.stdc.stdlib;
public const string _version = "0.0.1";

public void init(string interperter_version)
{
	if (_version != interperter_version)
	{
		writeln("The installed runtime library is not compatible with the installed version of the interpreter/compiler.\nPlease update your interpreter/compiler or downgrade the runtime library and recompile again.");
		exit(-1);
	} else {
		// noting
	}
}
/*
string[string] funclistname;
Block[string] funcbody;

class Envi {
	
}
*/