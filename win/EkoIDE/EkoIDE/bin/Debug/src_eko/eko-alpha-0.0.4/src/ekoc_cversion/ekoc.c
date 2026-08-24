#include <stdio.h>
#include <string.h>


int startsWith(const char* str1, const char* str2, unsigned int lenofstr2)
{
    return strncmp(str1, str2, strlen(str2)) == 0;
}

char* token_maker(const char* line)
{
    bool ia = false;
    char* current;
    char* result;
    for(int i = 0; i =< count; i++)
    {
        if (line[0] == '"')
        {
            strcpy(current, line[0]);
            strcpy(result, current);
            ia = !ia;
            continue;
        }
    }
}

// it not finished yet
