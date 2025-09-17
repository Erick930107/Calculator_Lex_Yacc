%{
	void yyerror(char*);
	#include "calc.tab.h"
    #include <stdlib.h>
%}

%%

"abs" { return ABS; }

"sin" { return SIN; }

"cos" { return COS; }

"log" { return LOG; }

"neg" { return NEG; }

"++" { return INC; }

"--" { return DEC; }

[a-zA-Z_][a-zA-Z0-9_]* {
    if (yyleng < 256) strcpy(yylval.varName, yytext);
    else printf("too long");
    return VARIABLE;
}

\.?[0-9]+|[0-9]+\.[0-9]*	{
    yylval.value = atof(yytext);
    return NUM;
}

[-+()=/*%^\n]	{return *yytext;}

[ \t] ;

. {
    fprintf(stderr, "syntax error at line %d: Invalid character '%c'\n", yylineno, *yytext);
    exit(0);
}

%%
int yywrap()
{
    return 1;
}

// bison -d calc.y     # 生成 calc.tab.c 和 calc.tab.h
// flex calc.l          # 生成 lex.yy.c
// g++ -std=c++17  -o calc lex.yy.c calc.tab.c -lfl -lm