//  Author name: Darren Vu
//  Author email: vuchampion@csu.fullerton.edu
//  Date of last update: October 19, 2019

#include "stdio.h"

void display(long int [], int size);

void display(long int myarray[], int size) {
  printf("\nThe display.c module has begun executing.\n");
  for (int i = 0; i < size; i++) {
    printf("%ld\n", myarray[i]);
  }
}
