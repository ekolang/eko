module ekoc.ekocparser;

import std.stdio;
import std.string, ekoc.ekocast, ekoc.ekostatic;

ASTNode[] ekocparsera(EkocToken[] tokens)
{
    ASTNode[] result;
    if (tokens[0].type == Ekoctype.keyword && tokens[1].type == Ekoctype.name && tokens[2].type == Ekoctype.op && tokens[3].type == Ekoctype.valaue)
    {
        result ~= new DefineKeyWord(
            tokens[0].value,
            new BineryOp(
                tokens[2].value,
                new IdeNode(tokens[1].value),
                new StringDefine(tokens[3].value)
            )
        );
    }
    return result;
}