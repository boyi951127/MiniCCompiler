%{
/****************************************************************************
token.lex
ParserWizard generated Lex file.

Date: 2017Äê8ÔÂ13ÈÕ
****************************************************************************/
#pragma warning (disable: 4005)
#pragma warning (disable: 4996)
#include <iostream>
#include <string>
#include "util.h"
#include "define.h"
#include "errormsg.h"

using namespace std;

int charPos = 1;
string tran = "";
int yywrap(void)
{
	charPos = 1;
	string tran = "";
	return 1;
}

void adjust(void)
{
	EM_tokPos = charPos;
	charPos += yyleng;
}
%}

%state STRING
%state COMMENT1
%state COMMENT2


%%
<INITIAL>{
	/* operator */
	" "						{ cout << "SPACE" << endl; adjust(); continue; }
	[\t]*					{ cout << "TAB" << endl; adjust(); continue; }
	[\n\r]+					{ cout << "NEWLINE" << endl; adjust(); continue; }
	","						{ cout << "COMMA" << endl; adjust(); return COMMA; }
	";"						{ cout << "SEMICOLON" << endl; adjust(); return SEMICOLON; }
	"("  					{ cout << "LPAREN" << endl; adjust(); return LPAREN; }
	")"  					{ cout << "RPAREN" << endl; adjust(); return RPAREN; }
	"["  					{ cout << "LBRACK" << endl; adjust(); return LBRACK; }
	"]"  					{ cout << "RBRACK" << endl; adjust(); return RBRACK; }
	"{"  					{ cout << "LBRACE" << endl; adjust(); return LBRACE; }
	"}"  					{ cout << "RBRACE" << endl; adjust(); return RBRACE; }
	"."  					{ cout << "DOT" << endl; adjust(); return DOT; }
	"+"  					{ cout << "PLUS" << endl; adjust(); return PLUS; }
	"-"  					{ cout << "MINUS" << endl; adjust(); return MINUS; }
	"*"  					{ cout << "TIMES" << endl; adjust(); return TIMES; }
	"/"  					{ cout << "DIVIDE" << endl; adjust(); return DIVIDE; }
	"=="  					{ cout << "EQ" << endl; adjust(); return EQ; }
	"!=" 					{ cout << "NEQ" << endl; adjust(); return NEQ; }
	"<"  					{ cout << "LT" << endl; adjust(); return LT; }
	"<=" 					{ cout << "LE" << endl; adjust(); return LE; }
	">"  					{ cout << "GT" << endl; adjust(); return GT; }
	">=" 					{ cout << "GE" << endl; adjust(); return GE; }
	"&"  					{ cout << "AND" << endl; adjust(); return AND; }
	"|"  					{ cout << "OR" << endl; adjust(); return OR; }
	"=" 					{ cout << "ASSIGN" << endl; adjust(); return ASSIGN; }
	/* key word */
	if						{ cout << "IF" << endl; adjust(); return IF; }
	else					{ cout << "ELSE" << endl; adjust(); return ELSE; }
	for						{ cout << "FOR" << endl; adjust(); return FOR; }
	while					{ cout << "WHILE" << endl; adjust(); return WHILE; }
	break					{ cout << "BREAK" << endl; adjust(); return BREAK;}
	int						{ cout << "INT" << endl; adjust(); return INT; }
	string					{ cout << "STRING" << endl; adjust(); return STRING; }
	printf					{ cout << "PRINTF" << endl; adjust(); return PRINTF; }
	scanf					{ cout << "SCANF" << endl; adjust(); return SCANF; }
	/* number */
	[0-9]+					{ cout << "INT NUM" << endl; adjust(); yylval.ival = atoi(yytext); return INTNUM; }
	/* ID */
	[a-zA-Z]+[a-zA-Z0-9_]*  { cout << "ID" << endl; adjust(); yylval.sval = string(yytext); return ID; }
	/* comment & string begin */
	"/*"					{ cout << "COMMENT1 BEGIN" << endl; adjust(); BEGIN(COMMENT1); continue; }
	"//"					{ cout << "COMMENT2 BEGIN" << endl; adjust(); BEGIN(COMMENT2); continue; }
	\"						{ cout << "STRING BEGIN" << endl; adjust(); BEGIN(STRING); continue; }
	/* error */
	.						{ cout << "ERROR" << endl; adjust(); EM_error(EM_tokPos,"illegal token"); continue; }
}

<STRING>{
	\"						{ adjust(); cout << "STRING END" << endl; yylval.sval = tran+'\0'; tran = ""; return STRINGVAL; }
	\\n						{ adjust(); tran += "\n"; continue; }
	\\t						{ adjust(); tran += "\t"; continue; }
	.						{ adjust(); tran += yytext[0]; continue; }
}

<COMMENT1>{
	"*/"					{ cout << "COMMENT1 END" << endl; adjust(); BEGIN(INITIAL); }
	"[\n\t]"				{ adjust(); continue; }
	.						{ adjust(); continue; }
}

<COMMENT2>{
	"[\n\t]"				{ cout << "COMMENT2 END" << endl; adjust(); BEGIN(INITIAL); }
	.						{ adjust(); continue; }
}
%%










int main(void)
{
	FILE *file;
	char *filename = (char*)malloc(sizeof(char)*20);
	int state = 1;
	while(state)
	{
		printf("Enter the file you want to test: ");
		scanf("%s", filename);
		printf("***********************************\n");
		if(!(file =  fopen(filename, "r")))
		{
			printf("Sorry the file is not existed!\n");
		}
		else
		{
			yyin = file;
		}
		yylex();
	}
	
	return 0;
}

