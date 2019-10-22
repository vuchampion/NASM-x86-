//  Author name: Darren Vu
//  Author email: vuchampion@csu.fullerton.edu
//  Date of last update: October 19, 2019

#include "stdio.h"

extern long control();

int main(int argc, char* argv[]) {
  long return_code = 100;

  printf("This is Assignment 4 by Darren Vu\n");
  printf("The main.c module has begun executing\n");
  printf("Prepare to enter the assembly module named control.\n");
  return_code = control(); // Call control.asm module

  printf("You are back in the main.c module\n");
  printf("%s%ld\n","\n\nThe driver received return code ",return_code);
  printf("Thank you for the nice number!\n");
  printf("%s%08lx%s", "This is the returned value in 8-byte Hexcadecimal: ", return_code, "\n");
  printf("This module will return 0 to the OS. Goodbye.\n");
  return 0;
}
