module header.ast;

import std.stdio, infss, std.conv, std.string;


interface Node {
    void execute();
}

class HeaderConfigManager : Node {
    int value;
    string nameofit;
    this(int value, string nameofit)
    {
        this.value = value;
        this.nameofit = nameofit;
    }
    override void execute()
    {
        if (nameofit == "GraphicEnable")
        {
            if (value == 1) graphicalMode = 1;
            else graphicalMode = 0;
            writeln("Draw to Graphic: " ~ to!string(graphicalMode));
        }
    }
}


