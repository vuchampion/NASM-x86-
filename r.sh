#!/bin/bash
#Author: Darren Vu

rm *.out
rm *.o

echo "Compile main.c"
gcc -c -g -Wall -m64 -std=c99 -fno-pie -no-pie -o main.o main.c

echo "Compile control.asm"
nasm -g -f elf64 -l control.lis -o control.o control.asm

echo "Compile fill.cpp"
g++ -c -g -Wall -m64 -std=c++14 -fno-pie -no-pie -o fill.o fill.cpp

echo "Compile display.c"
gcc -c -g -Wall -m64 -std=c11 -fno-pie -no-pie -o display.o display.c

echo "Compile sum.asm"
nasm -g -f elf64 -l control.lis -o sum.o sum.asm

echo "Linking all object files..."
g++ -g -m64 -std=c++14 -fno-pie -no-pie -o executable.out main.o control.o fill.o display.o sum.o

echo "Executing ./out\n"
./executable.out

echo "Exiting Bash..."
