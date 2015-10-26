EXEC_NAME = litecomp

INCLUDE_DIR =includes

CPP_FLAGS =	\
-std=gnu++11	\
-I$(INCLUDE_DIR)

OBJ_FILES =	\
parser.o 	\
tokens.o 	\
main.o		\

GEN_FILES_CLEANUP = 	\
tokens.cpp 		\
parser.cpp		\
parser.hpp

ifeq ($(OS), Windows_NT)
	LEX_PRG := flex
	EXEC_EXTENSION := .exe
else
	LEX_PRG := lex
endif

all: $(OBJ_FILES)
	g++ $(OBJ_FILES) -o $(EXEC_NAME) $(CPP_FLAGS)

%.o:%.cpp
	g++ -c $< -o $@ $(CPP_FLAGS)

parser.cpp: parser.y
	bison -d -o $@ $< -v

parser.hpp: parser.cpp

tokens.cpp: tokens.l parser.hpp
	$(LEX_PRG) -o $@ $<

clean_tmp:
	rm -rf $(OBJ_FILES) $(GEN_FILES_CLEANUP) parser.output 

clean: clean_tmp
	rm -rf $(EXEC_NAME)$(EXEC_EXTENSION) 
