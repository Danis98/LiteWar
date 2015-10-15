%{
	#include <iostream>
	#include <string>

	#include "parser.hpp"
	
	#include <node.h>

	block *program_block;

	extern int yylex();
	void yyerror(const char *s){std::printf("[COMPILATION FAILED] %s\n", s); std::exit(1);}
%}

%union{
	stmt* stmt;
	block* block;
	label* label;
	instr* instr;
	ident* ident;
	stmt_list* block;
	std::string *string;
	int token;
}

%token <string> TNUM TIDENTIFIER
%token <token> COLON
%token <token> TMACRO TENDMACRO
%token <token> TDAT TMOV TADD TSUB TMUL TDIV TMOD TJMP TJZ TJNZ TSPL TCMP TNOP

%type <ident> ident
%type <block> program stmts
%type <macro> macro
%type <label> label
%type <stmt> stmt
%type <token> op

%start program

%%

program: stmts{std::cout<<"Starting program parsing...\n";
		program_block=$1;}
	;

stmts	: stmt{}
	| stmt stmts{}
	;

stmt	: instr
	| macro
	| label
	;

instr	: op{}
	| op TNUM{}
	| op TNUM TNUM{}
	;

macro	: TMACRO ident stmts TENDMACRO
	;

label	: ident COLON
	;

ident	: TIDENTIFIER
	;

op	: TDAT|TMOV|TADD|TSUB|TMUL|TDIV|TMOD|TJMP|TJZ|TJNZ|TSPL|TCMP|TNOP
	;

%%
