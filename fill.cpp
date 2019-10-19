//  Author name: Darren Vu
//  Author email: vuchampion@csu.fullerton.edu
//  Date of last update: October 19, 2019

#include <iostream>
using namespace std;

extern "C" int long fill(long int [], int max_size);

int long fill(long int myarray[], int max_size) {
    std::cin.clear();
    int number;
    int actual_size = 0;
    std::cout << "\n\nThe fill.cpp module has begun executing" << std::endl;
    std::cout << "The max size of the array is 10." << std::endl;
    std::cout << "Input 10 numbers into the array." << std::endl;
    std::cout << "Alternatively, feel free to press CTRL-D to stop inputting numbers" << std::endl;

    for(int i = 0; i < max_size; i++) {
        std::cout << "Enter a number into index " << i << " of the array" << std::endl;
        std::cin >> number;
        if (std::cin.eof()) {
            std::cout << "CTRL-D Interrupt Detected" << std::endl;
            myarray[i] = 0; //control module will STILL record a value into the array
                            //it is best to set it to zero so we don't encounter
                            //any garbage values
            break;
        }
        else {
            myarray[i] = number;
            actual_size++;
        }
    }
    return actual_size;
}
