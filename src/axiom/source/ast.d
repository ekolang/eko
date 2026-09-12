module ast;
import std.stdio;

struct OpratorSt {
	static int equal = 1;
}

public interface Node {
	//void execute();
}


class DefineKeyWord : Node {
	string gen;
	string type;
	string name;
	string value;
	this(string gen, string type, string name, string value)
	{
		this.gen = gen;
		this.name = name;
		this.type = type;
		this.value = value;
	}
}
class TypeEx : Node {
	string type;
	this(string type)
	{
		this.type = type;
	}
}

class OperatorEx : Node {
	int typeofoprator;
	this(int typeofoprator)
	{
		this.typeofoprator = typeofoprator;
	}
}

class StringEx : Node {
	string value;
	this(string value){
		this.value = value;
	}
}

class FuncCall : Node {
	string name;
	string arguments;
	this(string name, string arguments)
	{
		this.name = name;
		this.arguments = arguments;
	}
}

class DefineKeyWordFunc : Node {
	string keyword;
	string type;
	string name;
	FuncCall func;
	this(string keyword, string type, string name, FuncCall func)
	{
		this.name = name;
		this.type = type;
		this.name = name;
		this.func = func;
	}
}


class IfState : Node {
	Node[] bodya;
	this(Node[] bodya)
	{
		this.bodya = bodya;
	}
}

class DefineDelegate : Node {
	string event_name;
	Node[] _body;
	this(string event_name, Node[] _body)
	{
		this.event_name = event_name;
		this._body = _body;
	}
}