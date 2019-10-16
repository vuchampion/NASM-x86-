#include <iostream>
using namespace std;

extern "C" void fill(long int []);

int number;

void fill(long int myarray[]) {
    std::cout << "The fill.cpp module has begun executing" << std::endl;
    for(int i = 0; i < 5; i++) {
      std::cout << "Enter a number into index " << i << " of the array" << std::endl;
      std::cin >> number;
      myarray[i] = number;
    }
}
