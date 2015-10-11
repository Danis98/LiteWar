EXEC_NAME = litecomp

OBJ_FILES =	\
main.o		\
parser.o 	\
tokens.o 	\

GEN_FILES_CLEANUP = 	\
tokens.cpp 		\
parser.cpp		\
parser.hpp

all: $(OBJ_FILES)
	g++ $< $(EXEC_NAME) -std=c++11

parser.cpp: parser.y
	bison -d -o $@ $< -v

parser.hpp: parser.cpp

tokens.cpp: tokens.l parser.hpp
	lex -o $@ $<

clean:
	rm -f $(OBJ_FILES) $(GEN_FILES_CLEANUP) parser.output
