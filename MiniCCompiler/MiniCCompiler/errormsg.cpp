#include <iostream>
#include <stdarg.h>
#include "util.h"
#include "errormsg.h"
using namespace std;

bool anyErrors = FALSE;
static string fileName = "";

typedef struct intList{
	int i; 
	struct intList *rest; 
} *IntList;

static IntList intList(int i, IntList rest)
{
	IntList l = (IntList)checked_malloc(sizeof *l);
	l->i = i; l->rest = rest;
	return l;
}

int EM_tokPos = 0;
static int lineNum = 0;
static IntList linePos = NULL;

void EM_newline(void)
{
	lineNum++;
	linePos = intList(EM_tokPos, linePos);
}

void EM_error(int pos, char *message, ...)
{
	va_list ap;
	IntList lines = linePos;
	int num = lineNum;


	anyErrors = TRUE;
	while (lines && lines->i >= pos)
	{
		lines = lines->rest; num--;
	}

	if (fileName != "")
	{
		fprintf(stderr, "%s:", fileName.c_str());
	}
		
	if (lines)
	{
		fprintf(stderr, "%d.%d: ", num, pos - lines->i);
	}
		
	va_start(ap, message);
	vfprintf(stderr, message, ap);
	va_end(ap);
	fprintf(stderr, "\n");

}