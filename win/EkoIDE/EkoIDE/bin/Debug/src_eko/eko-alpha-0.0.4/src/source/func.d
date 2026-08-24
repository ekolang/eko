module func;
import std.stdio,  ast, std.array;
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
import csl.preprs.define, infss, ekograp.functions, arsd.simpledisplay, ekograp.infssfunctions;
import axiom, astsupport;
string[] allowedflags = ["_IfFlag"];
void funcl(string lio, string mode, int addm)
{
    {
            if(mode == "debug") {
        writeln("0K1-- function line, called: " ~ lio);
        writeln("Checking if starts with: ", funcname);
        writeln("Result: ", lio.startsWith(funcname));
        writeln(ka);
    }
    
    }
    if(mode == "debug") writeln("0K1-- function line, called: " ~ lio);
    //writeln(ka);
    //riteln("S*&8g: " ~ to!string(globalf));
    if (lio.startsWith("_"))
    {
        if (mode == "debug") writeln("Ast called.");
        astSupportLine(lio, addm);
    } else if(lio.startsWith("DebugPrintFlag(") && lio.endsWith(");")){
        auto uai = regex(`DebugPrintFlag\((.+)\);`);
        auto la = match(lio, uai);
        if (!la.empty){
            foreach (value; allowedflags)
            {
                if (la.captures[1] == value && value == "_IfFlag"){
                    writeln(if_flag);
                } else prinPanic(kodes._syntex_faild, lio);
            }
        } else prinPanic(kodes._syntex_faild, lio);
     } else if (lio.startsWith("else:")){
        //writeln(if_flag);
        if (if_flag == 1)
        {
            auto iai = lio.split(":");
            funcl(iai[1].strip(), mode, addm);
            if_flag = 0;
        }

        if_flag = 0;
    } else if (lio in ka)
    {
        if(mode == "debug") writeln("HHHHHHHH");
        foreach(la; globalf){
            //writeln("bb:" ~ la.name);
            int oppa;
            if (lio.startsWith(la.name)){
                string[] pala;
                    if (la.arg.length > 0)
                    {
                        writeln("js");
                        bool first = true;
                        foreach(opa; la.arg)
                        {
                            string regexpattern;
                           
                            for(int i = cast(int)la.arg.length - 1; i < 0; i--)
                            {
                                if (first){
                                    regexpattern = "(\\S+)";
                                    first = false;
                                } else {
                                    regexpattern = regexpattern ~ ", (\\S+)";
                                }
                            }
                            writeln(regexpattern);
                            auto ja = regex(regexpattern);
                            auto eko = match(lio, ja);
                            if (!eko.empty){
                                pala = eko.map!(to!string).array();
                            } else prinPanic(kodes._syntex_faild, lio);
                        }
                        foreach (o, sga; la.code)
                        {
                            foreach (oal; pala)
                            {
                                foreach (plaa; la.arg) {
                                    la.code[o] = sga.replace(plaa, oal);
                                    writeln(la.code);
                                }
                            }
                        }
                    }
                    foreach(klka; la.code){
                        if (klka.strip().startsWith("if")){
                            oppa = 1;
                        
                        es(klka.strip(), mode, addm);
                        
                        } else {
                            if (oppa == 1) {
                                es(klka.strip(), mode, addm);
                            } else funcl(klka.strip(), mode, addm);   
                }
                }
            }
        }
    } else if(lio.indexOf("=") != -1){ 
        auto aga = regex(`(\S+) = (.*)$`);
        auto jkak = match(lio, aga);
        if (jkak.empty) {
            //other functions.
        } else {
            string ga = jkak.captures[1];
            if (ga in str)
            {
                // if it string
                if (jkak.captures[2].startsWith("\"") & jkak.captures[2].endsWith("\""))
                {
                    str[ga] = jkak.captures[2].replace("\\n", "\n");
                    str[ga] = jkak.captures[2].replace("\"", "");
                    str[ga] = jkak.captures[2].replace("\\u", "\"");
                    str[ga] = jkak.captures[2].replace("\\s0", " ");
                }
            } else if (ga in int_s)
            {
                // if it num
                
                try {
                    int ia;
                    //writeln(jkak.captures[2]);
                    if (jkak.captures[2].endsWith("++")){
                        ia = to!int(jkak.captures[2].replace("++", ""));
                        ia = ia + 1;
                    } else ia = to!int(jkak.captures[2]);
                    //writeln(ia);
                    int_s[ga] = ia;
                } catch (Exception e)
                {
                    //writeln(jkak.captures[2]);
                    auto rega = regex(`^(-?)([a-zA-Z]+)(:)([a-zA-Z]+)(\+\+)$`);
                    auto lal = match(jkak.captures[2], rega);
                    if (!lal.empty)
                    {
                        auto la = lal.captures[1] ~ lal.captures[2] ~ lal.captures[3] ~ lal.captures[4];
                        if (la in int_s){
                        if (lal.captures[5] == "++")
                        {
                            int_s[ga] = int_s[la] + 1;
                        } else if (lal.captures[5] == "--")
                        {
                            int_s[ga] = int_s[la] - 1;
                        } else prinPanic(kodes._syntex_faild, lio);
                        }
                    } else if (jkak.captures[2] in int_s){
                        int_s[ga] = int_s[jkak.captures[2]];
                    }
                    //prinPanic(kodes._syntex_faild, lio);
                }
            } else writeln("NF");
        }
     } else if (lio.startsWith("write")){
        auto aj = regex(`write\("([^"]+)"\);`);
        auto aj2 = match(lio, aj);
        if (!aj2.empty)
        {

            if (aj2.captures[1] in int_s)
            {
                write(int_s[aj2.captures[1]]);
            } else {
                string kaaa = aj2.captures[1].replace("\"", "");
                kaaa = kaaa.replace("\\n", "\n");
                write(kaaa);
            }
        } else {
            auto kaj = regex(`write\((.+)\);`);
            auto kaj2 = match(lio, kaj);
            if(!kaj2.empty){
                if (kaj2.captures[1].indexOf("+") != -1){
                    string[] kp = kaj2.captures[1].split('+');
                    if (mode == "debug"){
                        writeln(kp);
                    }
                    foreach (kal; kp){
                        kal = kal.replace(" ", "");
                        if (kal in str)
                        {
                            write(str[kal]);
                        } else if(kal.startsWith("\"") && kal.endsWith("\"")){
                            auto lll = kal.replace("\"", "");
                            lll = lll.replace("\\s0", " ");
                            lll = lll.replace("\\n", "\n");
                            write(lll);
                        } else if(kal in int_s) {
                            write(int_s[kal]);
                        } else if(kal in unint){
                            write(unint[kal]);
                        } else {
                            writeln("pw2");
                        }
                    }
                } else {
                if (kaj2.captures[1] in int_s)
            {
                write(int_s[kaj2.captures[1]]);
            } else if (kaj2.captures[1] in str){
                write(str[kaj2.captures[1]]);
            } else if (kaj2.captures[1] in unint){
                write(unint[kaj2.captures[1]]);
            } else {
                prinPanic(kodes._no_value, lio);
            }
                }
        } else {
            writeln("e2");
        }
        }
    } else if(lio.startsWith("return")){
            auto reg = regex(`return (\S+);`);
            auto ja = match(lio, reg);
            if (!ja.empty)
            {
                if (ja.captures[1] in int_s){
                    
                        fiappwitherror(int_s[ja.captures[1]]); 
                    
                } else {
                    fiappwitherror(to!int(ja.captures[1]));
                }
            } else {
                writeln("r1");
            }
    } else if (lio == "_exitWDT;"){
        throw new UltraCExp("Program ended with");
    } else if (lio.startsWith("malloc"))
    {
        auto ll = regex(`malloc\((.+)\);`);
        auto ll2 = match(lio, ll);
        if (!ll2.empty)
        {
            if (mode == "debug")
            {
                writeln(ll2);
            }

            _malloc(ll2.captures[1], mode);
        }
    } else if(lio.startsWith("free")){
        auto ll = regex(`free\((.+)\);`);
        auto ll2 = match(lio, ll);
        if (!ll2.empty)
        {
            if (mode == "debug")
            {
                writeln(ll2);
            }

            _free(ll2.captures[1]);
        }
    } else if (lio.startsWith("sys") != -1)
    {
        auto ll = regex(`sys\((.+)\);`);
        auto ll2 = match(lio, ll);
        if (!ll2.empty)
        {
            string final_commend = "".dup;
            if (mode == "debug")
            {
                writeln(ll2);
            }

            if (ll2.captures[1].indexOf("+") != -1){
                    string[] kp = ll2.captures[1].split('+');
                    if (mode == "debug"){
                        writeln(kp);
                    }
                    foreach (kal; kp){
                        kal = kal.strip();
                    
                        if (kal in str)
                        {
                            final_commend = final_commend ~ kal;
                        } else if(kal.startsWith("\"") && kal.endsWith("\"")){
                            //auto lll = kal.replace("\"", "");
                            //string la = kal.dup.remove(0);
                            //la = la.dup.remove(kal.length);
                            string la = kal[1 .. $ - 1];
                            la = la.replace("\\x", "&");
                            final_commend = final_commend ~ la;
                        } else {
                            prinPanic(kodes._syntex_faild, lio);
                            //final_commend = final_commend ~ kal;
                        }
                    }
                } else {
                if (ll2.captures[1] in str){
                    //write(str[kaj2.captures[1]]);
                    final_commend = final_commend ~ ll2.captures[1];
                }
            //system(toStringz(ll2.captures[1]));
            //_free(ll2.captures[1]);
                }


                if (final_commend != "")
                {
                    system(toStringz(final_commend));
                } else {
                    system(toStringz(ll2.captures[1]));
                }
        }
     } else {
        //f
     }
}
