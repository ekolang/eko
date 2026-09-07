module structer;
import lex, ast;
//tokens
enum Token {
	KeyWord,
	Value,
	Name,
	Type,
	Oprators,
	Func,
	BrNeedFunc,
	Br1,
	Br2
}
struct Tokens {
	Token type;
	string valu;
}
struct BlockType
{
	string funcname;
	string argumnets;
}
public int[string] intmap;
public float[string] floatmap;
public bool[string] boolmap;
public char[string] charmap;
public short[string] shortmap;
public long[string] longmap;
public double[string] doublemap;
public string[string] map_str;
public string[string] func_table; 
