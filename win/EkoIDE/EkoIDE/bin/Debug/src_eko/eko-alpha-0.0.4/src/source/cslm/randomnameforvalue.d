module cslm.randomnameforvalue;

import std.stdio;
import std.random;
import std.ascii;
import std.conv;
import std.string;

string randa()
{
    string chars = "abcdefghijklmnopqrstuvwxyz";
    int length = 6;
    
    char[] buffer = new char[length];
    auto rng = Random(unpredictableSeed);
    
    for (int i = 0; i < length; i++) {
        buffer[i] = chars[uniform(0, chars.length, rng)];
    }
    
    return to!string(buffer);
}