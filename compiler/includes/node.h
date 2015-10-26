#ifndef __NODE_H
#define __NODE_H

#include <iostream>
#include <vector>
#include <string>

#define ADDR_DIRECT	0
#define ADDR_IMMEDIATE	1

class NStmt;
class NInstr;

typedef std::vector<NStmt*> stmtList;

class Node{
public:
	virtual ~Node(){}
	virtual void dbg_print()=0;
};

class NStmt{
public:
	virtual ~NStmt(){}
	virtual void dbg_print()=0;
};

class NExpr{
public:
	virtual ~NExpr(){}
	virtual void dbg_print()=0;
};

class NIdent : public NExpr{
public:
	std::string id;
	NIdent(std::string& id) : id(id){}
	void dbg_print(){
		std::cout<<"<IDENT>: "<<id<<"\n";
	}
};

class NNum : public NExpr{
public:
	int mode;
	int num;
	NNum(int mode, int num) : mode(mode), num(num){}
	void dbg_print(){
		std::cout<<"<NUM>: "<<num<<(mode==ADDR_DIRECT?" (DIR)":" (IMMED)")<<"\n";
	}
};

class NBinaryOp : public NExpr{
public:
	int op;
	NExpr &a, &b;
	NBinaryOp(int op, NExpr& a, NExpr& b) : op(op), a(a), b(b){}
	void dbg_print(){
		std::cout<<"|BINARY OP|: "<<op<<"\n";
		a.dbg_print();
		b.dbg_print();
	}
};

class NUnaryOp : public NExpr{
public:
	int op;
	NExpr &a;
	NUnaryOp(int op, NExpr& a) : op(op), a(a){}
	void dbg_print(){
		std::cout<<"|UNARY OP|: "<<op<<"\n";
		a.dbg_print();
	}
};

class NLabel : public NStmt{
public:
	NIdent name;
	NLabel(NIdent& name) : name(name){}
	void dbg_print(){
		std::cout<<"[LABEL]: "<<name.id<<"\n";
	}
};

class NInstr : public NStmt{
public:
	int id;
	NExpr *a, *b;
	int args=0;
	NInstr(int id) : id(id){}
	NInstr(int id, NExpr *a) : id(id), a(a){args=1;}
	NInstr(int id, NExpr *a, NExpr *b) : id(id), a(a), b(b){args=2;}
	void dbg_print(){
		std::cout<<"[INSTR]: "<<id<<" ("<<args<<")\n";
		if(args>0)
			a->dbg_print();
		if(args>1)
			b->dbg_print();
	}
};

class NBlock : public NStmt{
public:
	stmtList stmts;
	NBlock(){}
	void dbg_print(){
		std::cout<<"{BLOCK}: "<<stmts.size()<<"\n";
		for(auto it=stmts.begin();it!=stmts.end();it++)
			(*it)->dbg_print();
		std::cout<<"{END OF BLOCK}\n";
	}
};

class NMacro : public NStmt{
public:
	NIdent id;
	NBlock block;
	NMacro(NIdent& id, NBlock& block) : id(id), block(block){}
	void dbg_print(){
		std::cout<<"[MACRO]: "<<id.id<<" ("<<block.stmts.size()<<")\n";
		block.dbg_print();
	}
};

#endif
