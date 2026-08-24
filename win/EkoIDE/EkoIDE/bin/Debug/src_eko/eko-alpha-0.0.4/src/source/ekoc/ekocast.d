module ekoc.ekocast;

import std.stdio;

interface ASTNode {
    //noting
}
class StringDefine: ASTNode {
    string value;
    this(string value)
    {
        this.value = value;
    }
}

class BineryOp: ASTNode {
    string op;
    ASTNode left;
    ASTNode right;
    this(string op, ASTNode left, ASTNode right)
    {
        this.op = op;
        this.left = left;
        this.right = right;
    }
}

class IdeNode: ASTNode {
    string name;
    this(string name)
    {
        this.name = name;
    }
}

class DefineKeyWord: ASTNode {
    string type;
    BineryOp value;
    this(string type, BineryOp value)
    {
        this.type = type;
        this.value = value;
    }
}


class FunctionDefine: ASTNode {
    string name;
    StringDefine value;
    this(string name, StringDefine value)
    {
        this.name = name;
        this.value = value;
    }
}