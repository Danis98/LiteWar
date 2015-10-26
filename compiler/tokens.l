%{
#include <string>
#include <node.h>
#include "parser.hpp"

#define SAVE_TOKEN yylval.string=new std::string(yytext, yyleng)
#define TOKEN(t) (yylval.token=t)
extern "C" int yywrap(){}
%}

%%

[ \t\n]		;

"dat"		return TOKEN(TDAT);
"mov"		return TOKEN(TMOV);

"jmp"		return TOKEN(TJMP);
"jz"		return TOKEN(TJZ);
"jnz"		return TOKEN(TJNZ);
"cmp"		return TOKEN(TCMP);

"add"		return TOKEN(TADD);
"sub"		return TOKEN(TSUB);
"mul"		return TOKEN(TMUL);
"div"		return TOKEN(TDIV);
"mod"		return TOKEN(TMOD);

"spl"		return TOKEN(TSPL);

"nop"		return TOKEN(TNOP);

"macro"		return TOKEN(TMACRO);
"endmacro"	return TOKEN(TENDMACRO);

"-"		return TOKEN(TOPMINUS);
"+"		return TOKEN(TOPPLUS);
"*"		return TOKEN(TOPMUL);
"/"		return TOKEN(TOPDIV);
"%"		return TOKEN(TOPMOD);
"("		return TOKEN(TLPAREN);
")"		return TOKEN(TRPAREN);

"["		return TOKEN(TLSQUARE);
"]"		return TOKEN(TRSQUARE);

"#"		return TOKEN(TIMMEDIATE);

[0-9]+		SAVE_TOKEN; return TNUM;
[a-zA-Z0-9_]+	SAVE_TOKEN; return TIDENTIFIER;

.		printf("Unknown token: %s\n",yytext); yyterminate();

%%
