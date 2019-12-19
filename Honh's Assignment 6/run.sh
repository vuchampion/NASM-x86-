#!bin/bash
#Author: Hoanh Vo
#Assignment: 6
#Purpose: This program compiles files, links objects and create executable file.

rm*.out
rm*.o

echo "Compiling the driver module -----------------------"
gcc -c -m64 -g -Wall -o cMain.o serie_sum.c -fno-pie -no-pie
echo "assembling the asm file--------------------------- "
nasm -f elf64 -g -l asm_calculation.lis -o asmCalculation.o Calculation.asm
echo "Linking objects file-------------------------------"
gcc -Wall -m64 -g -o final.out cMain.o asmCalculation.o -fno-pie -no-pie


echo "Run the executable file----------------------------"
./final.out

