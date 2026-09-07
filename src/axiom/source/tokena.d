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
		write(a);
		if (a == '"')
		{
			inString = !inString;
			if (inString == false){
				result ~= curent;
				curent ~= a;
			}
			curent ~= a;
			continue;
		} else if (inString == false && a == '(')
		{
			inParan = true;
			continue;
		} else if (inString == false && inParan == true && a == ')')
		{
			inParan = false;
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
				continue;
			}
		} else {
			curent ~= a;
			continue;
		}
	}
	if (curent.length > 0) result ~= curent;
	return result;
}