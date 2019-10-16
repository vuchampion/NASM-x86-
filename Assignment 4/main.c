#include "stdio.h"

extern long control();

int main(int argc, char* argv[]) {
  long return_code = 99;

  printf("This is Assignment 4 by Darren Vu\n");
  printf("The main.c module has begun executing\n");
  return_code = control(); // Call control.asm module

  printf("%s%ld%s\n","\n\nThe driver received return code ",return_code, ".  The driver will now return 0 to the OS.  Bye.");
  return 0;
}
