module structer;

//tokens
enum Token {
	KeyWord,
	Value,
	Name,
	Type,
	Oprators,
	Func
}
struct Tokens {
	Token type;
	string valu;
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