module infss;
public import axiom;
import std.stdio;
import std.file;
import std.conv;
import std.algorithm;
import std.string;
import std.regex;
import token_string, ultracex, ssm;
import core.stdc.stdlib: exit, malloc;
import csl.preprs.define, func;
import math_manager;
import lbrk, ast;
import cslm.proc, cslm.randomnameforvalue, cshort, intfunc_fs;
//header managment tool imported here
import header.ast, header.parser;
//box plus imports
import box_p.header.ast, box_p.header.parser;
public import marschiert; //runtime
import ast;
enum TokanType {
    Keyword,
    Name,
    Value,
    Oprator,
    Br1,
    Br2,
    funcname,
    undr,
    Sm_m,
    Sm_f,
    Gen,
    AstNeeded
}

int isMain = 0;

struct Tokan
{
    TokanType token;
    string value;
}


// dic-value

Tokan[] tks;
ubyte[string] ubytesave;
int graphicalMode = 0;
int shortmode = 0;
//fi
int read_file_call = 0;
string read_file_save_result_string;
const string _requestedversion = "0.0.1";

import astsupport;

void infs(string filepath, string mode, string la, int addmode)
{
    init("0.0.1");
    string hah = "";
    string ccfinal = "";
    int ssog = 0;
    //auto fha = File(filepath, "r");
    auto fha = readText(filepath);
    auto kp = define_(fha, mode);
    int head_flag = 0;
    foreach(ga; kp.splitLines()){
        if (mode == "debug") writeln("LINE = <", ga, ">");
        string haa = ga.idup;
        string[] words = tkstring(haa, mode);
        int a = 0;
        if (ga.startsWith("//")) continue;
        foreach(hh; words){
            if (mode == "debug") writeln(hh);
            a++;
            TokanType type;
            if (hh == "int" || hh == "string" || hh == "void*" || hh == "if") //keywords in here
            {
                type = TokanType.Keyword;
            } else if(hh == "unsigned" || hh == "signed" || hh == "auto") {
                type = TokanType.undr;
            } else if (hh == "="){
                type = TokanType.Oprator;
            } else if (hh.startsWith("--value:") || hh.startsWith("-v:") || hh == "header" || hh.startsWith("main()")){
                type = TokanType.Name;
            } else if (hh.startsWith("//")){
                continue;
            } else if (hh.startsWith("{")){ 
                type = TokanType.Br1;
            } else if (hh.startsWith("}")){
                type = TokanType.Br2;
            } else if (hh == ("~")) {
                type = TokanType.Sm_m;
            } else if (hh == "?" || hh.startsWith("@") || hh.startsWith("%")){
                type = TokanType.Sm_f;
            } else if (hh.startsWith("fgets") && hh.startsWith("readFile")){
                type = TokanType.funcname;
            } else if (hh.indexOf("(") != -1){
                type = TokanType.Value;
            } else if (hh == "generate" || hh == "gen"){
                type = TokanType.Gen;
            } else if (hh == "long" || hh == "short" || hh == "float" || hh == "double"){
                type = TokanType.AstNeeded;
            } else {
                if (hh.startsWith("\"") && hh.endsWith("\"")){
                    //writeln(hh);
                    if (shortmode == 1)
                    {
                        type = TokanType.Sm_f;
                    } else {
                    type = TokanType.Value;

                    tks ~= Tokan(type, hh);
                    continue;
                    }
                }
                try {
                    if (hh.startsWith("//"))
                    {
                        tks = null;
                        continue;
                    }
                    if (tks.length > 0 && tks[0].value != "int" && tks[0].value == "string" && tks[0].value == "#_SBOX")
                    {
                            

                    } else {
                        if (hh == ";") { continue; }
                    int s = to!int(hh);
                    type = TokanType.Value;
                        
                    }
                    
                } catch(Exception e){
                    continue;
                    //prinPanic("The entered value does not match the received type of the variable.");
                }
                
            }
            tks ~= Tokan(type, hh);
            if (mode == "debug") writeln(tks);
        }
        
        try {
            if (tks.length > 0 && tks[0].token == TokanType.Gen && tks[1].token == TokanType.AstNeeded)
            {
                astSupportLine(ga, addmode);
                continue;
            }
            // ============== function manager ========
            //writeln(count_to_find_end);
            handle_(tks, mode, ga);
            if (count_to_find_end == 1)
            {
            
                continue;
            }
            // ============== Plus Box Manager ========  
               if(counter_of_box == 1)
                {
                    sbox_nparser(ga, counter_of_box);
                    if(mode == "debug") writeln("BOX MODE: ", counter_of_box);
                    tks =  null;
                    continue;
                }
            // ============== Header Manager ==========
            
                if (tks.length > 1 && (tks[0].value == "generate" || tks[0].value == "gen") && tks[1].value == "header") {
                    Tokan cs = Tokan(TokanType.Br1, "{");
                    if (canFind(tks, cs))
                    {
                        //writeln("TTTKKKSSSS:" ~ to!string(tks));
                        par9ser(tks, ga, head_flag);
                    }
                    head_flag = 1;
                    generatesaw = 1;
                    headersaw = 1;
                    tks = null;
                    //
                    continue;
                }

            if(head_flag == 1){
                par9ser(tks, ga, head_flag);
                //tks = null;
                
            }

            if (tks.length > 0 && (tks[0].token == TokanType.Sm_m || shortmode == 1)){
                shortmode = 1;
                shortmode_run(tks);
                continue;
            }
            if (mode == "debug"){
                foreach(t, v; tks){
                    writeln(to!string(t) ~ ": " ~ to!string(v));
                }
                writeln("isMain: " ~ to!string(isMain));
            }
            if (mode == "debug"){
                        writeln("MainInsideCode: " ~ hah);
                    }
            if (isMain == 1){
                int aja = to!int(tks.length);
                int hhp = lpp(tks);
                if (hhp != -1 && tks[hhp].token == TokanType.Br2){
                    if (mode == "cc") {
                        ccfinal = ccfinal ~ "\nreturn(0E);\n}";
                        auto k = File(filepath.replace(".csl", "") ~ ".csc", "w");
                        k.write(ccfinal);
                        k.close();
                        proce(readText(filepath.replace(".csl", "") ~".csc"),  filepath.replace(".csl", ".csc"), "n", la);
                    } else {
                    es(hah, mode, addmode);
                    }
                    isMain = 0;
                    continue;
                } else {
                    if (mode == "cc")
                    {
                        if (hah.indexOf("write") != -1)
                        {
                            auto jk = regex(`write\((\S+)\)\;`);
                            auto aa = match(hah, jk);
                            if (!aa.empty)
                            {
                                
                                string kk = aa.captures[1].replace(" ", "\\s");
                                hah = hah.replace("printf(" ~ aa.captures[1] ~ ")", "pr(" ~ kk ~ ")");
                                ccfinal = ccfinal ~ "\n" ~ hah;
                                //hah = to!string(hah) ~ "\n" ~ to!string(ga);
                            }
                            
                        } else if (hah.indexOf("return") != -1)
                        {
                            //hah = to!string(hah) ~ "\n";
                            continue;
                        } else if (hah.indexOf("if") != -1)
                        {

                        } else if (ssog == 1)
                        {
                            foreach(l, ka; int_s)
                            {
                                ccfinal = ccfinal ~ "\n\t__int(" ~ l ~"," ~ to!string(ka) ~");";
                            }
                        }
                    }
                    if (mode == "cc") hah = "";
                    hah = to!string(hah) ~ "\n" ~ to!string(ga);
                    continue;
                }
            } else {
                int unsi = 0;
                
            if (tks.length > 0 && (tks[0].token == TokanType.Keyword || tks[0].token == TokanType.undr || tks[0].value == "generate" || tks[0].value == "gen")){
                if (tks[0].value == "int" || tks[0].value == "string" || tks[0].value == "double" || tks[0].value == "float" || tks[0].value == "double" || tks[0].value == "long" || tks[0].value == "short" || tks[0].value == "signed" || tks[0].value == "unsigned" || tks[0].value == "void*" || tks[0].value == "generate" || tks[0].value == "gen"){
                    if (mode == "debug")
                    {
                        writeln(tks[0].value);
                    }
                    if (tks[0].token == TokanType.undr && tks[0].value != "auto" && tks[0].value != "signed")
                    {
                        if (mode == "debug")
                        {
                            writeln("(Global Unsigned curser (GUC) - setting to enable...)");
                        }
                        unsi = 1;
                        if (tks[2].token == TokanType.Name)
                        {
                            
                            if (tks[0].value == "string"){
                                if (true){
                                    if (tks[2].value == "=")
                                    {
                                        if (tks[3].value.startsWith("\"") && tks[3].value.endsWith("\"")){
                                            auto kao = tks[3].value.replace("\"", "");
                                            if (mode == "debug"){
                                                writeln(kao);
                                            }
                                         
                                            auto ak = tks[1].value.replace("[]", "");
                                            ak = ak.replace("--value", "");
                                            ak = ak.replace("-v:", "");
                                            if (mode == "cc")
                                            {
                                                if (ccfinal.length > 0)
                                                {
                                                    //ccfinal = ccfinal ~ "\n" ~ 
                                                }
                                            } else {
                                                
                                            str[ak] = kao;
                                            }
                                            tks = null;
                                            unsi--;
                                            continue;
                                        } else {
                                            if (tks[3].value in str)
                                            {
                                                str[tks[1].value.replace("[]","")] = str[tks[3].value];
                                            } else if (tks[3].value in int_s){
                                                str[tks[1].value.replace("[]", "")] = to!string(int_s[tks[3].value]);
                                            }
                                        }
                                    } else {
                                        writeln("str2");
                                        tks = null;
                                        unsi--;
                                        continue;
                                    }
                                } else {
                                    writeln("strfuckup.");
                                    tks = null;
                                    unsi--;
                                    continue;
                                }
                            }
                        unint[tks[2].value] = 0;
                        unsi--;
                        if (tks[3].token == TokanType.Oprator){
                            if (tks[3].value == "="){
                                
                                    unint[tks[2].value] = to!int(tks[4].value);
                                    unsi--;

                                    if (mode == "debug"){
                                        writeln(unint[tks[2].value]);
                                        writeln("Setting (tks) to null for new lines...");
                                    }
                                    
                            } else {
                                writeln("p5");
                            }
                        } else {
                            writeln("p4");
                        }
                        }
                    } else {
                        if(mode == "debug") writeln("REACHED GENERATE CHECK");
                        if (tks[0].value == "auto" || tks[0].value == "signed")
                        {
                            tks = tks.remove(0);
                        }
                        if (mode == "debug")
                        {
                            writeln("P!: " ~ tks[0].value);
                            writeln(tks);
                            writeln(tks[1]);
                        }
                        if (mode == "debug") writeln(tks[0].value == "generate");
                        if(mode == "debug") writeln(tks[1].value.startsWith("main()"));
                        if(mode == "debug") writeln(tks.length > 2);
                        if(mode == "debug")writeln(tks.length > 2 && tks[2].value == "{");
                        if(mode == "debug") writeln(tks[1].value.indexOf("main(){"));
                    if (tks[0].value == "generate" || tks[0].value == "gen"){
                        if (tks[1].value.startsWith("main()") && (tks.length > 1 && tks[2].value == "{") || tks[1].value.indexOf("main(){") != -1){
                            if (mode == "debug"){
                                writeln("Main defined for (this main program)...");
                            }
                            isMain = 1;
                            int kakl = 0;
                            if (tks[1].value.indexOf("{") != -1) kakl = 1;
                            if (tks.length > 2 && (tks[2].token == TokanType.Br1)){
                                if (mode == "cc")
                                {
                                    if (ccfinal.length > 0)
                                    {
                                        ccfinal = ccfinal ~ "\n" ~ "(s, code) _main\n{";
                                    } else {
                                        ccfinal = "(s, code) _main\n{";
                                    }
                                }
                                tks = null;
                                continue;
                                //tks = null;
                            } else if (kakl == 1) {
                                tks = null;
                                continue;
                            }
                        } else {
                            tks = tks.remove(0);
                            if (tks[0].value == "string"){
                                if (true){
                                    if (tks[2].value == "=")
                                    {
                                        if(mode == "debug") writeln(tks[3]);
                                        if (tks[3].value.startsWith("\"") && tks[3].value.endsWith("\"")){
                                            auto kao = tks[3].value.replace("\"", "");
                                            if (mode == "debug"){
                                                writeln(kao);
                                            }
                                         
                                            auto ak = tks[1].value.replace("[]", "");
                                            str[ak] = kao;
                                            tks = null;
                                            continue;
                                        } else if(tks[3].value.strip.startsWith("getInput(")){
                                            if (tks[3].value.strip.endsWith(").chomp"))
                                            {
                                                auto ak = tks[1].value.replace("[]", "");
                                                readit(ak, "");
                                                str[ak] = str[ak].replace("\n", "");
                                                tks = null;
                                                unsi--;
                                                continue;
                                            } else if (tks[3].value.strip.endsWith(")")){
                                                auto ak = tks[1].value.replace("[]", "");
                                                readit(ak, "");
                                                tks = null;
                                                unsi--;
                                                continue;
                                            } else prinPanic(kodes._syntex_faild, ga);
                                        } else if (tks[3].value.strip.startsWith("readFile(") && tks[3].value.strip.endsWith(")")) {
                                            read_file_call = 1;
                                            str[tks[1].value.replace("[]", "")] = "";
                                            read_file_save_result_string = tks[1].value.replace("[]", "");
                                        } else {
                                            if (tks[3].value in str)
                                            {
                                                str[tks[1].value.replace("[]","")] = str[tks[3].value];
                                                read_file_save_result_string = tks[1].value.replace("[]", "");
                                            } else if (tks[3].value in int_s){
                                                str[tks[1].value.replace("[]", "")] = to!string(int_s[tks[3].value]);
                                                read_file_save_result_string = tks[1].value.replace("[]", "");
                                            }
                                        }
                                    } else {
                                        writeln("str2");
                                        tks = null;
                                        continue;
                                    }
                                } else if (tks[1].value == "-v:readFile.filename"){
                                    if (read_file_call == 1)
                                    {
                                        if (tks[3].value.startsWith("\"") && tks[3].value.endsWith("\"")){
                                            str[read_file_save_result_string] = readText(tks[3].value.replace("\"", ""));
                                        } else {
                                            if (tks[3].value in str)
                                            {
                                                str[tks[1].value.replace("[]","")] = str[tks[3].value];
                                            } else if (tks[3].value in int_s){
                                                str[tks[1].value.replace("[]", "")] = to!string(int_s[tks[3].value]);
                                            }
                                        }
                                    }
                                } else {
                                    writeln("strfuckup.");
                                    tks = null;
                                    continue;
                                }
                            } else if(tks[0].value == "void*"){
                                voidp[tks[1].value] = malloc(1);
                                if (mode == "debug")
                                {
                                    writeln("size of: 1B in D");
                                }
                                tks = null;
                                continue;
                            } else if(tks[0].value == "int"){
                                int_s[tks[1].value] = 0;
                                //writeln(tks);
                                if(tks[2].token == TokanType.Oprator)
                                {
                                    if (tks[2].value == "="){
                                    if (mode == "cc")
                                    {
                                        ssog = 1;
                                        int_s[tks[1].value] = math_man(tks[3].value);
                                    } else {
                                    int_s[tks[1].value] = math_man(tks[3].value);
                                    }
                                    if (mode == "debug"){
                                        writeln(int_s[tks[1].value]);
                                        writeln("Setting (tks) to null for new lines...");
                                    }
                                    
                            } else {
                                writeln("p5");
                            }
                                } else if(tks.length == 1){
                                    tks = null;
                                    continue;
                                }
                            }
                        }
                        /*Dead code: if (tks.length > 2 && tks[2].token == TokanType.Oprator){
                            if (tks[2].value == "="){
                                    if (mode == "cc")
                                    {
                                        ssog = 1;
                                        int_s[tks[1].value] = math_man(tks[3].value);
                                    } else {
                                    int_s[tks[1].value] = math_man(tks[3].value);
                                    }
                                    if (mode == "debug"){
                                        writeln(int_s[tks[1].value]);
                                        writeln("Setting (tks) to null for new lines...");
                                    }
                                    
                            } else {
                                writeln("p5");
                            }
                        } else {
                            writeln("p4");
                        } */
                    } else {
                        writeln("p3");
                    }
                    }
                } else {
                    writeln("p2");
                }
                
            } else {
                tks = null;
                //writeln("p1");
            }
        }
        } catch(Exception e){
            prinPanic(kodes._eerror, ga);
            writeln(to!string(e.msg));
        }
        tks = null;
    }

}

public int if_flag;
int nbr = 0;
    int l = 0;
    string codes;
void es(string line, string mode, int addf){
    
    string[] lia = line.splitLines();
    foreach(lio; lia){
        lio = lio.idup;
        lio = lio.strip();
      if(lio == "" || lio.startsWith("//")){ continue; }
      if (lio.indexOf("&") != -1) 
      {
        string[] ak = lio.split("&");
        foreach(oo; ak)
        {
            oo = oo.strip();
            funcl(oo, mode, addf);
        }
      } else {
        if (mode == "debug") writeln(lio);
        if (mode == "debug") writeln(nbr);
                if(nbr == 3)
                {
                    if (mode == "debug") writeln(codes);
                    if (mode == "debug") writeln(lio);
                    if (lio.indexOf("return -999;") != -1 || (lio.strip() == "end;")){
                        if(mode == "debug") writeln("a:" ~ codes);
                        string[] liaa = codes.splitLines();
                        foreach (lo; liaa)
                        {
                            funcl(lo, mode, addf);
                        }
                        nbr = 0;
                        //if_flag = 0;
                        l = 0;
                        codes = "";
                        continue;
                    } else {
                        if (codes.length > 0){ codes = codes ~ "\n" ~ lio; } else { codes = lio; }
                        if(mode == "debug") writeln("codevalue:" ~ codes);
                        continue;
                    }
                } else if(nbr == 6)
                {
                    nbr = 9;
                    if_flag = 1;
                    l = 99;

                    continue;
                } else if (nbr == 9)
                {
                    if (lio.startsWith("return -999;") || (lio.strip() == ("end;"))) {
                        if (l != 99){
                        funcl(codes, mode, addf);
                        } else { 
                            nbr = 0;
                            l = 0;
                            continue;
                        }
                        continue;
                    } else {
                        codes = codes ~ "\n" ~ lio;
                        continue;
                    }
                }
                if (lio.startsWith("if"))
                {
                    //writeln(tks);
                    auto regexa = regex(r"if\s*\(((?:[^()]|\([^()]*\))*)\)");
                    auto lpl = match(lio, regexa);
                    if (lpl.empty)
                    {
                        writeln("RWE");
                        exit(0);
                    } else {
                    string ll = lpl.captures[1];
                    if (mode == "debug") writeln(ll);
                    /*if (ll.indexOf(",") != -1) string[] lopai = ll.strip(",");
                    foreach(osama; lopai)
                    {
                        osama = osama.split();
                         
                    } */
                    if(ll.startsWith("strcmp(") && ll.endsWith(")"))
                    {
                        string kk = ll.replace("strcmp(", "");
                        kk = kk.replace(")", "");
                        string[] rmm = kk.split(",");
                        foreach(o, llp; rmm){
                            rmm[o] = llp.strip();
                        }
                        if (mode == "debug") writeln("wr: " ~ rmm);
                        bool c1 = false;
                        int aa = 0;
                        string l1;
                        foreach(wtt; rmm)
                        {
                            if (c1 != true){
                                if (wtt.startsWith("-v:") || wtt.startsWith("--value:")) {
                                    l1 = str[wtt];
                                    if (mode == "debug") writeln(l1);
                                } else if (wtt.startsWith("\"") && wtt.endsWith("\""))
                                {
                                    string lt = wtt.replace("\"", "");
                                    l1 = lt;
                                    if (mode == "debug") writeln(l1);
                                } else {
                                    prinPanic(kodes._syntex_faild, line);
                                }
                                c1 = true;
                            } else {
                                //if (wtt.startsWith("-v:") || wtt.startsWith("--value:")) wtt = str[wtt];
                                if (wtt.startsWith("-v:") || wtt.startsWith("--value:")) {
                                    //writeln(wtt);
                                    //writeln(str);
                                    wtt = str[wtt];

                                } else if (wtt.startsWith("\"") && wtt.endsWith("\""))
                                {
                                    string lt = wtt.replace("\"", "");
                                    wtt = lt;
                                } else {
                                    prinPanic(kodes._syntex_faild, line);
                                }
                                if (l1 == wtt)
                                {
                                    aa = 1;
                                    if_flag = 0;
                                    c1 = true;
                                    l1 = wtt;
                                } else {
                                    aa = 0;
                                    if_flag = 1;
                                    c1 = true;
                                    l1 = wtt;
                                }
                            } 
                        }
                        if (mode == "debug") writeln(aa);
                        if (aa == 1)
                        {
                            if (lio.indexOf(":") != -1){
                                nbr = 3;
                                if(mode == "debug") writeln("!");
                                continue;
                            } else {
                                 writeln("EIF");
                                 exit(0);
                             }
                        } else {
                            if (lio.indexOf(":") != -1){
                                nbr = 6;
                                if(mode == "debug") writeln("!O");
                                continue;
                            } else {
                                 writeln("EIF");
                                 exit(0);
                             }
                        }
                    } else if(ll.indexOf(">") != -1)
                    {
                        string[] rmm = ll.split(">");
                        int[2] lenin;
                        foreach(la, mms; rmm)
                        {
                            rmm[la] = mms.strip();
                            
                        }
                        
                        if (rmm[0] in int_s)
                        {
                            lenin[0] = int_s[rmm[0]];
                            if (rmm[1] in int_s){
                                lenin[1] = int_s[rmm[1]];
                            } else lenin[1] = to!int(rmm[1]);
                        } else if (rmm[1] in int_s)
                        {
                            lenin[1] = int_s[rmm[1]];
                            lenin[0] = to!int(rmm[0]);
                        } else {
                            lenin[1] = to!int(rmm[1]);
                            lenin[0] = to!int(rmm[0]);
                        }
                        //writeln(lenin);
                        if (lenin[0] > lenin[1])
                        {
                            if (lio.indexOf(":") != -1){
                                nbr = 3;
                                if_flag = 0;
                                if(mode == "debug") writeln("!");
                                continue;
                            } else {
                                 writeln("EIF");
                                 exit(0);
                             }
                        } else {
                            if (lio.indexOf(":") != -1){
                                nbr = 6;
                                if_flag = 1;
                                if(mode == "debug") writeln("!O");
                                continue;
                            } else {
                                 writeln("EIF");
                                 exit(0);
                             }
                        }
                    } else if(ll.indexOf("<") != -1)
                    {
                        string[] rmm = ll.split("<");
                        int[2] lenin;
                        foreach(la, mms; rmm)
                        {
                            rmm[la] = mms.strip();
                        }
                        if (rmm[0] in int_s)
                        {
                            lenin[0] = int_s[rmm[0]];
                            if (rmm[1] in int_s){
                                lenin[1] = int_s[rmm[1]];
                            } else lenin[1] = to!int(rmm[1]);
                        } else if (rmm[1] in int_s)
                        {
                            lenin[1] = int_s[rmm[1]];
                            lenin[0] = to!int(rmm[0]);
                        } else {
                            lenin[1] = to!int(rmm[1]);
                            lenin[0] = to!int(rmm[0]);
                        }

                        if (lenin[0] < lenin[1])
                        {
                            if (lio.indexOf(":") != -1){
                                nbr = 3;
                                if_flag = 0;
                                if(mode == "debug") writeln("!");
                                continue;
                            } else {
                                 writeln("EIF");
                                 exit(0);
                             }
                        } else {
                            if (lio.indexOf(":") != -1){
                                nbr = 6;
                                if_flag = 1;
                                if(mode == "debug") writeln("!O");
                                continue;
                            } else {
                                 writeln("EIF");
                                 exit(0);
                             }
                        }
                    }
                    }
                } else {
                    if (nbr == 0) funcl(lio, mode, addf);
                }
      }
    
    }
}