#include <iostream>
#include <cstdio>
#include <sys/stat.h>

#include <node.h>

extern NBlock *programBlock;
extern int yyparse();

extern FILE *yyin;

inline bool file_exists(const char *name){
	struct stat buffer;
	return stat(name, &buffer)==0;
}

int main(int argc, char **argv){
	//Check arguments
	if(argc<2){
		std::cout<<"[USAGE]: "<<argv[0]<<"[ -f ] <source file>, "
		<<argc-1<<" arguments inputted instead\n";
		return 0;
	}
	
	//Open the source file
	if(file_exists(argv[1]))
		yyin=std::fopen(argv[1],"r");
	else{
		std::cout<<"Invalid argument/s\n";
		return 0;
	}
	
	//Parsing
	std::cout<<"Starting parsing...\n";
	yyparse();
	std::cout<<"Parsing succesful!\n";
}
