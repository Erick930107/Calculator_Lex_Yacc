%{
#include <stdio.h>   
#include <stdlib.h>
#include <math.h>
#include <bits/stdc++.h>
#include <unordered_map>


extern char *yytext;
std::unordered_map <std::string, double> variables;
int line=1;

void yyerror(const char* s) {
    printf("Line %d: ", line);
    fprintf(stderr, "%s with token %s\n", s, yytext);
}
int yylex(void);

%}

%union {
    double value;
    char varName[256];
}

%token NUM NEG ABS SIN COS LOG INC DEC
%token <varName> VARIABLE
%type <value> expr
%left '+' '-' 
%left '*' '/' '^' '%'
%right UMINUS


%%

program:
    program statement '\n'
    |
    ;
statement:
    expr { printf("%lf\n", $1); }
    | VARIABLE '=' expr    {
        std::string varName($1);
        variables[varName] = $3;
        printf("%lf\n", variables[varName]);
        line++;
    }
     ;
expr:
    NUM 
    | VARIABLE{
        std::string varName($1); 
        if (variables.find(varName) != variables.end()) 
        {
            $$ = variables[varName]; // 變數已定義
        } 
        else 
        {
            printf("Line %d: %s is undefined\n", line, varName.c_str()); // 輸出未定義
            exit(1); 
        } 
    }
    | '-' expr %prec UMINUS { $$ = -$2; }
    | expr '+' expr    { $$ = $1 + $3; }
    | expr '-' expr    { $$ = $1 - $3; }
    | expr '*' expr    { $$ = $1 * $3; }
    | expr '/' expr    { $$ = $1 / $3; }
    | expr '%' expr    { $$ = (int)$1 % (int)$3; }
    | expr '^' expr    { $$ = pow($1,$3); }
    | NEG '(' expr ')' { $$ = -$3; }
    | ABS '(' expr ')' { $$ = abs($3); }
    | SIN '(' expr ')' { $$ = sin($3); }
    | COS '(' expr ')' { $$ = cos($3); }
    | LOG '(' expr ')' { $$ = log10($3); }
    | VARIABLE INC { 
        std::string varName($1);
        $$ = variables[varName];
        variables[varName]++;
    }
    | VARIABLE DEC { 
        std::string varName($1);
        $$ = variables[varName];
        variables[varName]--;
    }
    | INC VARIABLE { 
        std::string varName($2);
        ++variables[varName];
        $$ = variables[varName];
    }
    | DEC VARIABLE { 
        std::string varName($2);
        --variables[varName];
        $$ = variables[varName];
    }
    |'('expr')'       {$$ = $2;}
    ;
	
%%

int main(void)
{
    yyparse();
    return 0;
}