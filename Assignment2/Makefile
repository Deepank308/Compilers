a.out: main.o libass2_17CS30011.a
				gcc main.o -L. -lass2_17CS30011
main.o: main.c myl.h
				gcc -Wall -c main.c
libass2_17CS30011.a: ass2_17CS30011.o
				ar -rcs libass2_17CS30011.a ass2_17CS30011.o
ass2_17CS30011.o: ass2_17CS30011.c myl.h
				gcc -Wall -c ass2_17CS30011.c
clean:
				rm a.out main.o libass2_17CS30011.a ass2_17CS30011.o
