%{
#include <string>
#include "parser.hpp"
#define SAVE_TOKEN yylval.string=new std::string(yytext, yyleng)
#define TOKEN(t) (yylval.token=t)
%}

%option noyywrap

%%

[ \t\n]		;

[0-9]+		SAVE_TOKEN; return TOKEN(TNUM);

"dat"		return TOKEN(TDAT);
"mov"		return TOKEN(TMOV);

"add"		return TOKEN(TADD);
"sub"		return TOKEN(TSUB);
"mul"		return TOKEN(TMUL);
"div"		return TOKEN(TDIV);
"mod"		return TOKEN(TMOD);

"jmp"		return TOKEN(TJMP);
"jz"		return TOKEN(TJZ);
"jnz"		return TOKEN(TJNZ);

"spl"		return TOKEN(TSPL);

"cmp"		return TOKEN(TCMP);

"nop"		return TOKEN(TNOP);

.		printf("Unknown token: %s\n",yytext); yyterminate();

%%