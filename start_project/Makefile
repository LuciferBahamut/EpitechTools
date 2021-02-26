##
## EPITECH PROJECT, 2021
## Makefile
## File description:
## Makefile
##

## Var def ##
SHELL		=	/bin/sh
CC			=	gcc
CPP			=	g++
RM			=	rm -f
#############

## Sources ##
MAIN		=	main.c

BIN_SRC		=	

TEST_SRC	=

INC			=	-I./include/
#############

##	Obj	   ##
MAIN_OBJ	=	$(MAIN:.c=.o)
SRC_OBJ		=	$(BIN_SRC:.C=.o)
TEST_OBJ	=	$(TEST_SRC:.c=.o)
#############

##	Flags  ##
CFLAGS		=	-Wall -Wextra -Werror
CPPFLAGS	=	$(INC)
LDFLAGS		=	
#############

##	Names  ##
BIN			=
TEST_BIN	=	unit_tests
#############

##	Rules  ##
all:	$(BIN)
$(BIN): $(MAIN_OBJ) $(SRC_OBJ)
	$(CC) -o $(BIN) $(MAIN_OBJ) $(SRC_OBJ) $(CFLAGS) $(CPPFLAGS)
	clean

# Debug
debug:	fclean
debug:	CFLAGS += -g3 -DDEBUG
debug:	$(BIN)

# Unit Test
tests_run:	fclean
tests_run:	CFLAGS += --coverage
tests_run:	LDFLAGS += -lcriterion -DUNIT_TEST
tests_run:	$(SRC_OBJ) $(TEST_OBJ)
	$(CC) -o $(TEST_BIN) $(SRC_OBJ) $(TEST_OBJ) $(LDFLAGS) $(CFLAGS) $(CPPFLAGS)
	./$(TEST_BIN)
	clean

# Coverage
coverage:
	gcovr -b --exclude-directories tests
	gcovr -r . --exclude-directories tests

# Clear
clean:
	@$(RM) $(MAIN_OBJ)
	@$(RM) $(SRC_OBJ)
	@$(RM) $(TEST_OBJ)

fclean: clean
	@$(RM) $(BIN)
	@$(RM) $(TEST_BIN)
	@$(RM) **/*.gc*

# re
re : fclean all clean

# PHONY
.PHONY: all debug tests_run coverage clean fclean re