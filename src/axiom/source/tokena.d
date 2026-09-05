module tokena;
import std.stdio;

string[] Tokenlz(string line)
{
	string[] result;
	string curent;
	bool inString = false;
	bool inParan = false;
	foreach(char a; line)
	{
		if (a == '"')
		{
			inString = !inString;
			curent ~= a; 
		} else if (inString == false && a == '(')
		{
			inParan = true;
			curent ~= a;
		} else if (inString == false && inParan == true && a == ')')
		{
			inParan = false;
			curent ~= a;
			result ~= curent;
			curent = "";
			continue;
		} else if(a == ' ' && !inParan){
			if (inString == true)
			{
				curent ~= a;
			} else if (curent.length > 0)
			{
				result ~= curent;
				curent = "";
			}
		} else {
			curent ~= a;
		}
	}
	if (curent.length > 0) result ~= curent;
	return result;
}