#include "stm8l.h"

int main() {
	int d;
	// Configure pins
	PB_DDR = 0xFF;
	PB_CR1 = 0xFF;
	// Loop
	do {
		PB_ODR ^= 0b00100000;
		for(d = 0; d < 10000; d++) { }
	} while(1);
}
