//Student Name: Hoanh Vo
//Assignment 6: The Harmonic Sum
//language: C
//Purpose: this program is a driver for hamonic_sum calculation 
#include<stdio.h>

extern double hamonic_sum();

int main()
{
	double x;
	printf("%s\n","Welcome to fast number crunching by Hoanh Vo");
	x = hamonic_sum();
	printf("%s%10.10lf\n","The driver has received the number",x);
	printf("%s","Have a nice day");

	return 0;
}


