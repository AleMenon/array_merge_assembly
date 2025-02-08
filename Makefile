#Makefile for C#

#CC - Compiler used
CC=gcc

#ifeq - Recognizes the system and proceds to set the variables:

#REMOVE - Used to clean the directory after running the program
#EXE - Used to execute the program, based on the OS of the machine
ifeq ($(OS),Windows_NT)
    REMOVE=del
	 EXE=./main.exe
else
    REMOVE=rm -f
	 EXE=./main
endif

#Compile and run the code (default when calling 'make')
all:compile run

#Compile, run and clean after the end of the program
allc:compile run clean

compile: merge_array.c
	@$(CC) -o main merge_array.c

run:
	@$(EXE)
	@echo " "
	

clean:
	@$(REMOVE) $(EXE)

.PHONY: clean
