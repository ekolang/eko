module ekoc.ekomain;
import std.stdio, ekoc.ekocast, ekoc.ekoclexer, ekoc.ekocparser, ekoc.ekoctoken, ekoc.ekostatic;
import axiom;

string[string] str_map;

void ekocmain_run(string[] lines)
{
    foreach(o; lines)
    {
        string[] opa = ekoc_token(o);
        writeln(opa);
        EkocToken[] eko_res = ekoclex(opa);
        writeln(eko_res);
        ASTNode[] node_res = ekocparsera(eko_res);
        writeln(node_res);
        ekoc_interperter(node_res);
    }
}

void ekoc_interperter(ASTNode[] asd)
{
    foreach(ast; asd)
    {
        if (auto key = cast(DefineKeyWord)ast)
        {
            if (key.type == "S")
            {
                if (auto key2 = cast(BineryOp)key.value)
                {
                    if (auto key3 = cast(StringDefine)key2.right)
                    {
                        if (auto key4 = cast(IdeNode)key2.left)
                        {
                            str_map[key4.name] = key3.value;
                        }
                    }
                }
                //str_map[ajja.value] = jaka;
                writeln(str_map); //for test
            }
        }
    }
}