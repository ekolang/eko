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
	int oprator;
	string value;
	this(string gen, string type, string name, int oprator, string value)
	{
		this.gen = gen;
		this.name = name;
		this.type = type;
		this.oprator = oprator;
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
	int oprator;
	FuncCall func;
	this(string keyword, string type, string name, int oprator, FuncCall func)
	{
		this.name = name;
		this.type = type;
		this.name = name;
		this.oprator = oprator;
		this.func = func;
	}
}


class IfState : Node {
	Node left;
	string opr;
	Node right;
	Node boday;
	this(Node left, string opr, Node right, Node boday)
	{
		this.left = left;
		this.opr = opr;
		this.right = right;
		this.boday = boday;
	}
}