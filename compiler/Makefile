EXEC_NAME = litecomp

INCLUDE_DIR =includes

OBJ_FILES =	\
parser.o 	\
tokens.o 	\
main.o		\

GEN_FILES_CLEANUP = 	\
tokens.cpp 		\
parser.cpp		\
parser.hpp

all: $(OBJ_FILES)
	g++ $(OBJ_FILES) -o $(EXEC_NAME) -std=c++11 -I$(INCLUDE_DIR)

%.o:%.cpp
	g++ -c $< -o $@ -std=c++11 -I$(INCLUDE_DIR)

parser.cpp: parser.y
	bison -d -o $@ $< -v

parser.hpp: parser.cpp

tokens.cpp: tokens.l parser.hpp
	lex -o $@ $<

clean:
	rm -f $(OBJ_FILES) $(GEN_FILES_CLEANUP) parser.output
