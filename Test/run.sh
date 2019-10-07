#/bin/bash
#Author: Darren Vu
#Program name: Assembly Programming Assignment 1: Playing With Integers

rm *.o
rm *.out
#echo "Assemble .asm"
nasm -f elf64 -l fp-io.lis -o fp-io.o assembly.asm

#echo "Compile C file"
g++ -c -m64 -Wall -l fp-io-driver.lis -o fp-io-driver.o driver.c -fno-pie -no-pie

#echo "Link .asm and .c"
g++ -m64 -o fpio.out fp-io-driver.o fp-io.o -fno-pie -no-pie

#echo "Running .out file"
./fpio.out

#echo "Closing"
