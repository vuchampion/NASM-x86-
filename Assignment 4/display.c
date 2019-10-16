#include "stdio.h"

void display(long int []);

void display(long int myarray[]) {
  printf("\nThe display.c module has begun executing.\n");
  for (int i = 0; i < 5; i++) {
    printf("%ld\n", myarray[i]);
  }
}
