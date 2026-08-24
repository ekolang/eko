module ekograp.infssfunctions;

import std.stdio;
import error;
import std.file;
import std.conv;
import std.algorithm;
import std.string;
import std.regex;
import token_string, ultracex, ssm;
import core.stdc.stdlib: exit, malloc, system;
import cslg.ultracgraphic.sgfu;
import csl.mempack.freec;
import csl.mempack.mallc;
import csl.preprs.define, infss, ekograp.functions, arsd.simpledisplay;

void graphicFucntionsManager(string lio)
{
    if (lio.startsWith("GraphicalCircle"))
    {
        writeln("INK");
        auto ll = regex(`^GraphicalCircle\((.*)\);$`);
        auto ll2 = match(lio, ll);
        if (!ll2.empty)
        {
            if (ll2.captures[1].indexOf(",") != -1)
            {
                string[] aja = ll2.captures[1].split(",");
                string[] s_aja;
                foreach(jk; aja)
                {
                    s_aja ~= jk.strip();
                    writeln(s_aja);
                }
                aa.drawCircle(psave[s_aja[0]], to!int(s_aja[1]));
            }
        }
    } else if (lio.startsWith("fillGraphicalScreen"))
    {
        writeln("INK()");
        auto ll = regex(`^fillGraphicalScreen\((.*)\);$`);
        auto ll2 = match(lio, ll);
        if (!ll2.empty)
        {
            if (ll2.captures[1].indexOf(",") != -1)
            {
                string[] aja = ll2.captures[1].split(",");
                string[] s_aja;
                foreach(jk; aja)
                {
                    s_aja ~= jk.strip();
                    writeln(s_aja);
                }
                clearscreen(windows[s_aja[0]], s_aja[1], s_aja[2]);
            }
            //graphic_commends ~= "circle " ~ ll2.captures[1] ~ ll2.captures[2];
        }
    } else if (lio.startsWith("initGraphicMode"))
    {
        writeln("INK(1)");
        auto ll = regex(`^initGraphicMode\((.*)\);$`);
        auto ll2 = match(lio, ll);
        if (!ll2.empty)
        {
            if (ll2.captures[1].indexOf(",") != -1)
            {
                string[] aja = ll2.captures[1].split(",");
                string[] s_aja;
                foreach(jk; aja)
                {
                    s_aja ~= jk.strip();
                    writeln(s_aja);
                }
                windows[s_aja[0]] = initscreen(s_aja[1], to!int(s_aja[2]), to!int(s_aja[3])); 
                aa = windows[s_aja[0]].draw();
            }
        }
    } else if (lio.startsWith("runGraphicMode"))
    {
        writeln("IsNK");
        auto ll = regex(`^runGraphicMode\((.*)\);$`);
        auto ll2 = match(lio, ll);
        if (!ll2.empty)
        {
            
                windowshow(windows[ll2.captures[1]]); 
            
        } else writeln("N");
    } else if (lio.startsWith("Point"))
    {
        writeln("IaK");
        auto ll = regex(`Point\((.*)\);$`);
        auto ll2 = match(lio, ll);
        if (!ll2.empty)
        {
            if (ll2.captures[1].indexOf(",") != -1)
            {
                string[] aja = ll2.captures[1].split(",");
                string[] s_aja;
                foreach(jk; aja)
                {
                    s_aja ~= jk.strip();
                }
                toLocation(s_aja[0], to!int(s_aja[1]), to!int(s_aja[2]));
            }
            
        }
    } else writeln("No functionw with this name.");
}