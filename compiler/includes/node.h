#ifndef __NODE_H
#define __NODE_H

#include <iostream>
#include <vector>
#include <string>

class NStmt;
class NInstr;

typedef std::vector<NStmt*> stmtList;

class NStmt{
public:
	virtual ~NStmt(){}
};

class NExpr{
public:
	virtual ~NExpr(){}
};

class NIdent : public NExpr{
public:
	std::string id;
	NIdent(std::string& id) : id(id){}
};

class NNum : public NExpr{
public:
	int num;
	NNum(int num) : num(num){std::cout<<"Fliflozio\n";}
};

class NLabel : public NStmt{
public:
	NIdent name;
	NLabel(NIdent& name) : name(name){}
};

class NInstr : public NStmt{
public:
	int id;
	NExpr *a, *b;
	NInstr(int id) : id(id){}
	NInstr(int id, NExpr *a) : id(id), a(a){}
	NInstr(int id, NExpr *a, NExpr *b) : id(id), a(a), b(b){}
};

class NBlock : public NStmt{
public:
	stmtList stmts;
	NBlock(){}
};

class NMacro : public NStmt{
public:
	NIdent id;
	NBlock block;
	NMacro(NIdent& id, NBlock& block) : id(id), block(block){}
};

#endif
