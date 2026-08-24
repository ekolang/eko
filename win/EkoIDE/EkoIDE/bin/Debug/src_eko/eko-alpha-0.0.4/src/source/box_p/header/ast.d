module box_p.header.ast;

import std.stdio, infss, std.conv, std.string, csl.preprs._sbox;


interface Node {
    void execute();
}

class BoxManager : Node {
    string value;
    this(string value)
    {
        this.value = value;
    }
    override void execute()
    {
        sbox(value, "normal", 0);
    }
}


