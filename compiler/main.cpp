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
	if(argc<2){
		std::cout<<"[USAGE]: "<<argv[0]<<"[ -f ] <source file>, "
		<<argc-1<<" arguments inputted instead\n";
		return 0;
	}
	
	for(int i=1;i<argc;i++){
		if(file_exists(argv[i]))
			yyin=std::fopen(argv[i],"r");
		else{
			std::cout<<"Invalid argument/s\n";
			return 0;
		}
	}
	
	std::cout<<"Starting parsing...\n";
	yyparse();
}
