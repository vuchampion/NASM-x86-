#include<iostream>
using namespace std;

extern "C" void swap(long *, long *);

void swap(long * first_address, long * second_address)
{cout << "FYI: the function swap, written in C++, has begun execution" << endl;
 long temp;
 temp = *first_address;
 *first_address = *second_address;
 *second_address = temp;
}
