.PHONY: all

all: x86httpserver

x86httpserver.o: x86httpserver.s
	as x86httpserver.s -o x86httpserver.o

x86httpserver: x86httpserver.o
	ld x86httpserver.o -o x86httpserver
