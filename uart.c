#include <string.h>
#include "stm8l.h"
#include "stm8s_uart1.h"

int uart_write(const char *str) {
	char i;
	for(i = 0; i < strlen(str); i++) {
		UART1_SendData8(str[i]);
	}
	return(i); // Bytes sent
}

void SetupSerialPort()
{
    //
    //  Clear the Idle Line Detected bit in the status register by a read
    //  to the UART1_SR register followed by a Read to the UART1_DR register.
    //
    (void) UART1->SR;
    (void) UART1->DR;

    UART1->CR2 = UART1_CR2_RESET_VALUE;
    UART1->CR4 = UART1_CR4_RESET_VALUE;
    UART1->CR5 = UART1_CR5_RESET_VALUE;
    UART1->GTR = UART1_GTR_RESET_VALUE;
    UART1->PSCR = UART1_PSCR_RESET_VALUE;
    //
    //  Setup the port.
    //
    UART1->CR1 = (u8) UART1_WORDLENGTH_8D | (u8) UART1_PARITY_NO;   // Word length = 8, no parity.
    UART1->CR3 = (u8) UART1_STOPBITS_1;                             // 1 stop bit.

    UART1->BRR1 &= (uint8_t) (~UART1_BRR1_DIVM);
    UART1->BRR2 &= (uint8_t) (~UART1_BRR2_DIVM);
    UART1->BRR2 &= (uint8_t) (~UART1_BRR2_DIVF);
    //
    //  Set the clock prescaler for 11520 baud.  This assumes a 16 MHz clock speed.
    //
    UART1->BRR2 = 0x0b;
    UART1->BRR1 = 0x08;
    //
    //  Disable the Transmitter and Receiver before seting the LBCL, CPOL and CPHA bits
    //
    UART1->CR2 &= (u8) ~(UART1_CR2_TEN | UART1_CR2_REN);
    //
    //  Clear the Clock Polarity, lock Phase, Last Bit Clock pulse
    //
    UART1->CR3 &= (u8)~(UART1_CR3_CPOL | UART1_CR3_CPHA | UART1_CR3_LBCL);
    //
    //  Set the Clock Polarity, lock Phase, Last Bit Clock pulse
    //
    UART1->CR3 |= (u8)((u8) UART1_SYNCMODE_CLOCK_ENABLE &
                       (u8) (UART1_CR3_CPOL | UART1_CR3_CPHA | UART1_CR3_LBCL));
    //
    //  Set the Tx and Rx state
    //
    UART1->CR2 |= (u8) ((u8) UART1_CR2_TEN | (u8) UART1_CR2_REN);
    UART1->CR3 &= (u8) (~UART1_CR3_CKEN);
}

int main() {
	unsigned long i = 0;

	CLK_DIVR = 0x00; // Set the frequency to 16 MHz
	CLK_PCKENR1 = 0xFF; // Enable peripherals

	PB_DDR = 0xFF;
	PB_CR1 = 0xFF;

	PB_ODR != 0b00100000;

	SetupSerialPort();

	do {
		uart_write("Hello World!\n");
		for(i = 0; i < 147456; i++) { } // Sleep
	} while(1);
}
