#include "cbased.h"
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>

void* _calloc(size_t num, size_t size)
{
    int al = (int*)calloc(num, size);
    if (al == NULL)
    {
        return 0;
    } else {
        retunr al;
    }
}


void *_realloc(void *ptr, unsigned size)
{

}