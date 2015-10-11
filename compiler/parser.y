%{
#include <iostream>
#include <string>

void yyerror(const char *str){
	std::cout<<"[FATAL ERROR] "<<str<<"\n";
}
%}

%token <string> TNUM
%token <token> TDAT TMOV TADD TSUB TMUL TDIV TMOD TJMP TJZ TJNZ TSPL TCMP TNOP

%start program

%%

program: stmts
	;

stmts:	stmt stmts
	;

stmt:	instr{}
	| instr TNUM{}
	| instr TNUM TNUM{}
	;

instr: TDAT|TMOV|TADD|TSUB|TMUL|TDIV|TMOD|TJMP|TJZ|TJNZ|TSPL|TCMP|TNOP
	;

%%
