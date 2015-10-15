#ifndef __NODE_H
#define __NODE_H

#include <vector>
#include <string>

class stmt;
class instr;

std::vector<stmt*> stmt_list;

class stmt{
public:
	virtual ~stmt(){}
};

class ident{
public:
	std::string id;
	ident(std::string& id) : id(id){}
};

class label : public stmt{
public:
	ident name;
	label(ident& name) : name(name){}
};

class instr : public stmt{
public:
	int id;
	int *a, *b;
	instr(int id) : id(id){}
	instr(int id, int *a) : id(id), a(a){}
	instr(int id, int *a, int *b) : id(id), a(a), b(b){}
};

class block : public stmt{
	stmt_list stmts;
	block(){}
};

class macro : public stmt{
	ident id;
	stmt_list stmts;
	macro(ident& id) : id(id){}
};

#endif
