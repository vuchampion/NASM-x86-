#include <stdio.h>

extern "C" long adding_two_integers();

int main() {

	long return_code = -9;
	return_code = adding_two_integers();
	printf("Hello\n");
	printf("%s%ld%s\n","The driver received return code ",return_code, ".  The driver will now return 0 to the OS.  Bye.");

	return 0;
}	

