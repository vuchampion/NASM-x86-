#!/bin/bash
#Author: Darren Vu

rm *.out
rm *.o

echo "Compile main.c"
gcc -c -g -Wall -m64 -std=c99 -fno-pie -no-pie -o main.o main.c

echo "Compile control.asm"
nasm -g -f elf64 -l control.lis -o control.o control.asm

echo "Linking all object files..."
g++ -g -m64 -std=c++14 -fno-pie -no-pie -o executable.out main.o control.o

echo "Executing ./out\n"
./executable.out

echo "Exiting Bash..."
