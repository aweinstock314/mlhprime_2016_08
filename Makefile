.PHONY: all

all: x86httpserver helloworld bindsend

x86httpserver.o: x86httpserver.s
	as x86httpserver.s -o x86httpserver.o
x86httpserver: x86httpserver.o
	ld x86httpserver.o -o x86httpserver

helloworld.o: helloworld.s
	as helloworld.s -o helloworld.o
helloworld: helloworld.o
	ld helloworld.o -o helloworld

bindsend: bindsend.c
	gcc bindsend.c -o bindsend
