module ttoken;
import std.stdio, structer, std.conv;

T checktypeDefined(T)(T a)
{
	if (a in charmap)
	{
		return to!T(charmap[a]);
	} else if (a in map_str)
	{
		return to!T(map_str[a]);
	} else if (a in longmap){
		return to!T(longmap[a]);
	} else if (a in intmap)
	{
		return to!T(intmap[a]);
	} else if (a in shortmap)
	{
		return to!T(shortmap[a]);
	} else if (a in doublemap)
	{
		return to!T(doublemap[a]);
	} else if (a in floatmap)
	{
		return to!T(floatmap[a]);
	} else if (a in boolmap)
	{
		return to!T(boolmap[a]);
	} else {
		return null;
	}
}