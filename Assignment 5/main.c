//  Author name: Darren Vu
//  Author email: vuchampion@csu.fullerton.edu
//  Date of last update: October 19, 2019

#include "stdio.h"

extern long control();

int main(int argc, char* argv[]) {
//double return_code seemed to be nonzero which is good while long
//return_code was just many zeroes
  double return_code = 100;

  printf("This is Assignment 5 by Darren Vu\n");
  printf("The main.c module has begun executing\n");
  printf("Prepare to enter the assembly module named control.\n");
  return_code = control(); // Call control.asm module

  printf("You are back in the main.c module\n");
  printf("The module has recieved %lf\n", return_code);
  printf("This module will return 0 to the OS. Goodbye.\n");
  return 0;
}
