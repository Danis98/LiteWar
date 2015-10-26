%{
	#include <cstdlib>
	#include <cstdio>
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
%token <token> TMACRO TENDMACRO
%token <token> TDAT TMOV TJMP TJZ TJNZ TSPL TCMP TNOP TADD TSUB TDIV TMUL TMOD
%token <token> TOPPLUS TOPMINUS TOPMUL TOPDIV TOPMOD TLPAREN TRPAREN
%token <token> TLSQUARE TRSQUARE
%token <token> TIMMEDIATE

%type <ident> ident
%type <expr> numeric expr add_expr mult_expr unary_expr primary_expr
%type <block> program stmts
%type <stmt> stmt macro label instr
%type <token> op

%start program

%%

//The program itself
program: stmts {programBlock=$1;}
	;

//List of statements
stmts	: stmt {$$=new NBlock(); $$->stmts.push_back($<stmt>1);}
	| stmts stmt {$1->stmts.push_back($<stmt>2);}
	;

//Single statement
stmt	: label
	| instr
	| macro
	;

//Instruction, can have from 0 to 2 arguments
instr	: op {$$=new NInstr($1);}
	| op expr {$$=new NInstr($1, $2);}
	| op expr expr {$$=new NInstr($1, $2, $3);}
	;

//Define a macro, sintax is:
//macro macro_name
// <list of statements>
//endmacro
macro	: TMACRO ident stmts TENDMACRO {$$=new NMacro(*$2, *$3); delete $2;}
	;

//Label, sintax is [label_name]
label	: TLSQUARE ident TRSQUARE {$$=new NLabel(*$2); delete $2;}
	;

//Expressions with various levels of precedence
expr : add_expr
	;

add_expr : mult_expr
	| add_expr TOPPLUS mult_expr {$$=new NBinaryOp($2, *$1, *$3);}
	| add_expr TOPMINUS mult_expr {$$=new NBinaryOp($2, *$1, *$3);}
	;

mult_expr : unary_expr
	| mult_expr TOPMUL unary_expr {$$=new NBinaryOp($2, *$1, *$3);}
	| mult_expr TOPDIV unary_expr {$$=new NBinaryOp($2, *$1, *$3);}
	| mult_expr TOPMOD unary_expr {$$=new NBinaryOp($2, *$1, *$3);}
	;

unary_expr : primary_expr
	| TOPMINUS primary_expr {$$=new NUnaryOp($1, *$2);}
	;

primary_expr : numeric
	| ident {$<ident>$=$1;}
	| TLPAREN expr TRPAREN {$$=$2;}
	;

//Identifier, can have letters, numbers and underscores
ident	: TIDENTIFIER {$$=new NIdent(*$1); delete $1;}
	;

//Integer numbers, can be in direct mode (no prefix)
//or immediate mode (# prefix)
numeric : TNUM {$$=new NNum(ADDR_DIRECT, atoi($1->c_str())); delete $1;}
	| TIMMEDIATE TNUM {$$=new NNum(ADDR_IMMEDIATE,
					atoi($2->c_str())); delete $2;}
	;

//Possible instructions
op	: TDAT|TMOV|TJMP|TJZ|TJNZ|TSPL|TCMP|TNOP|TADD|TSUB|TMUL|TDIV|TMOD
	;

%%
