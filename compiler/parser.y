%{
	#include <cstdlib>
	#include <iostream>
	#include <string>
	
	#include <node.h>

	NBlock *programBlock;

	extern int yylex();
	void yyerror(const char *s){std::printf("[COMPILATION FAILED] %s\n", s); std::exit(1);}
%}

%union {
	NStmt *stmt;
	NBlock *block;
	NIdent *ident;
	NExpr *expr;
	std::string *string;
	int token;
}

%token <string> TNUM TIDENTIFIER
%token <token> COLON
%token <token> TMACRO TENDMACRO
%token <token> TDAT TMOV TADD TSUB TMUL TDIV TMOD TJMP TJZ TJNZ TSPL TCMP TNOP

%type <ident> ident
%type <expr> numeric expr
%type <block> program stmts
%type <stmt> stmt macro label instr
%type <token> op

%start program

%%

program: stmts {programBlock=$1;}
	;

stmts	: stmt {$$=new NBlock(); $$->stmts.push_back($<stmt>1);}
	| stmts stmt {$1->stmts.push_back($<stmt>2);}
	;

stmt	: instr
	| macro
	| label
	;

instr	: op {$$=new NInstr($1);}
	| op expr {$$=new NInstr($1, $2);}
	| op expr expr {}
	;

macro	: TMACRO ident stmts TENDMACRO{}
	;

label	: ident COLON{}
	;

expr	: numeric
	;

ident	: TIDENTIFIER {$$=new NIdent(*$1); delete $1;}
	;

numeric : TNUM {$$=new NNum(atoi($1->c_str())); delete $1;}
	;

op	: TDAT|TMOV|TADD|TSUB|TMUL|TDIV|TMOD|TJMP|TJZ|TJNZ|TSPL|TCMP|TNOP
	;

%%
