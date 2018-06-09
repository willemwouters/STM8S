;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.4.0 #8981 (Jul  5 2014) (Linux)
; This file was generated Mon Jun 22 23:29:59 2015
;--------------------------------------------------------
	.module uart
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _SetupSerialPort
	.globl _uart_write
	.globl _UART1_SendData8
	.globl _strlen
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area DATA
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area INITIALIZED
;--------------------------------------------------------
; Stack segment in internal ram 
;--------------------------------------------------------
	.area	SSEG
__start__stack:
	.ds	1

;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area DABS (ABS)
;--------------------------------------------------------
; interrupt vector 
;--------------------------------------------------------
	.area HOME
__interrupt_vect:
	int s_GSINIT ;reset
	int 0x0000 ;trap
	int 0x0000 ;int0
	int 0x0000 ;int1
	int 0x0000 ;int2
	int 0x0000 ;int3
	int 0x0000 ;int4
	int 0x0000 ;int5
	int 0x0000 ;int6
	int 0x0000 ;int7
	int 0x0000 ;int8
	int 0x0000 ;int9
	int 0x0000 ;int10
	int 0x0000 ;int11
	int 0x0000 ;int12
	int 0x0000 ;int13
	int 0x0000 ;int14
	int 0x0000 ;int15
	int 0x0000 ;int16
	int 0x0000 ;int17
	int 0x0000 ;int18
	int 0x0000 ;int19
	int 0x0000 ;int20
	int 0x0000 ;int21
	int 0x0000 ;int22
	int 0x0000 ;int23
	int 0x0000 ;int24
	int 0x0000 ;int25
	int 0x0000 ;int26
	int 0x0000 ;int27
	int 0x0000 ;int28
	int 0x0000 ;int29
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area HOME
	.area GSINIT
	.area GSFINAL
	.area GSINIT
__sdcc_gs_init_startup:
__sdcc_init_data:
; stm8_genXINIT() start
	ldw x, #l_DATA
	jreq	00002$
00001$:
	clr (s_DATA - 1, x)
	decw x
	jrne	00001$
00002$:
	ldw	x, #l_INITIALIZER
	jreq	00004$
00003$:
	ld	a, (s_INITIALIZER - 1, x)
	ld	(s_INITIALIZED - 1, x), a
	decw	x
	jrne	00003$
00004$:
; stm8_genXINIT() end
	.area GSFINAL
	jp	__sdcc_program_startup
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area HOME
	.area HOME
__sdcc_program_startup:
	jp	_main
;	return from main will return to caller
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area CODE
;	uart.c: 5: int uart_write(const char *str) {
;	-----------------------------------------
;	 function uart_write
;	-----------------------------------------
_uart_write:
	sub	sp, #3
;	uart.c: 7: for(i = 0; i < strlen(str); i++) {
	clr	(0x01, sp)
00103$:
	ldw	x, (0x06, sp)
	pushw	x
	call	_strlen
	addw	sp, #2
	ldw	(0x02, sp), x
	ld	a, (0x01, sp)
	ld	xl, a
	rlc	a
	clr	a
	sbc	a, #0x00
	ld	xh, a
	cpw	x, (0x02, sp)
	jrnc	00101$
;	uart.c: 8: UART1_SendData8(str[i]);
	clrw	x
	ld	a, (0x01, sp)
	ld	xl, a
	addw	x, (0x06, sp)
	ld	a, (x)
	push	a
	call	_UART1_SendData8
	pop	a
;	uart.c: 7: for(i = 0; i < strlen(str); i++) {
	inc	(0x01, sp)
	jra	00103$
00101$:
;	uart.c: 10: return(i); // Bytes sent
	ld	a, (0x01, sp)
	ld	xl, a
	rlc	a
	clr	a
	sbc	a, #0x00
	ld	xh, a
	addw	sp, #3
	ret
;	uart.c: 13: void SetupSerialPort()
;	-----------------------------------------
;	 function SetupSerialPort
;	-----------------------------------------
_SetupSerialPort:
;	uart.c: 19: (void) UART1->SR;
	ldw	x, #0x5230
	ld	a, (x)
;	uart.c: 20: (void) UART1->DR;
	ldw	x, #0x5231
	ld	a, (x)
;	uart.c: 22: UART1->CR2 = UART1_CR2_RESET_VALUE;
	ldw	x, #0x5235
	clr	(x)
;	uart.c: 23: UART1->CR4 = UART1_CR4_RESET_VALUE;
	ldw	x, #0x5237
	clr	(x)
;	uart.c: 24: UART1->CR5 = UART1_CR5_RESET_VALUE;
	ldw	x, #0x5238
	clr	(x)
;	uart.c: 25: UART1->GTR = UART1_GTR_RESET_VALUE;
	ldw	x, #0x5239
	clr	(x)
;	uart.c: 26: UART1->PSCR = UART1_PSCR_RESET_VALUE;
	ldw	x, #0x523a
	clr	(x)
;	uart.c: 30: UART1->CR1 = (u8) UART1_WORDLENGTH_8D | (u8) UART1_PARITY_NO;   // Word length = 8, no parity.
	ldw	x, #0x5234
	clr	(x)
;	uart.c: 31: UART1->CR3 = (u8) UART1_STOPBITS_1;                             // 1 stop bit.
	ldw	x, #0x5236
	clr	(x)
;	uart.c: 33: UART1->BRR1 &= (uint8_t) (~UART1_BRR1_DIVM);
	ldw	x, #0x5232
	ld	a, (x)
	ldw	x, #0x5232
	clr	(x)
;	uart.c: 34: UART1->BRR2 &= (uint8_t) (~UART1_BRR2_DIVM);
	ldw	x, #0x5233
	ld	a, (x)
	and	a, #0x0f
	ld	(x), a
;	uart.c: 35: UART1->BRR2 &= (uint8_t) (~UART1_BRR2_DIVF);
	ldw	x, #0x5233
	ld	a, (x)
	and	a, #0xf0
	ld	(x), a
;	uart.c: 39: UART1->BRR2 = 0x0b;
	ldw	x, #0x5233
	ld	a, #0x0b
	ld	(x), a
;	uart.c: 40: UART1->BRR1 = 0x08;
	ldw	x, #0x5232
	ld	a, #0x08
	ld	(x), a
;	uart.c: 44: UART1->CR2 &= (u8) ~(UART1_CR2_TEN | UART1_CR2_REN);
	ldw	x, #0x5235
	ld	a, (x)
	and	a, #0xf3
	ld	(x), a
;	uart.c: 48: UART1->CR3 &= (u8)~(UART1_CR3_CPOL | UART1_CR3_CPHA | UART1_CR3_LBCL);
	ldw	x, #0x5236
	ld	a, (x)
	and	a, #0xf8
	ld	(x), a
;	uart.c: 52: UART1->CR3 |= (u8)((u8) UART1_SYNCMODE_CLOCK_ENABLE &
	ldw	x, #0x5236
	ld	a, (x)
	ldw	x, #0x5236
	ld	(x), a
;	uart.c: 57: UART1->CR2 |= (u8) ((u8) UART1_CR2_TEN | (u8) UART1_CR2_REN);
	ldw	x, #0x5235
	ld	a, (x)
	or	a, #0x0c
	ld	(x), a
;	uart.c: 58: UART1->CR3 &= (u8) (~UART1_CR3_CKEN);
	ldw	x, #0x5236
	ld	a, (x)
	and	a, #0xf7
	ld	(x), a
	ret
;	uart.c: 61: int main() {
;	-----------------------------------------
;	 function main
;	-----------------------------------------
_main:
;	uart.c: 64: CLK_DIVR = 0x00; // Set the frequency to 16 MHz
	ldw	x, #0x50c0
	clr	(x)
;	uart.c: 65: CLK_PCKENR1 = 0xFF; // Enable peripherals
	ldw	x, #0x50c3
	ld	a, #0xff
	ld	(x), a
;	uart.c: 67: PB_DDR = 0xFF;
	ldw	x, #0x5007
	ld	a, #0xff
	ld	(x), a
;	uart.c: 68: PB_CR1 = 0xFF;
	ldw	x, #0x5008
	ld	a, #0xff
	ld	(x), a
;	uart.c: 72: SetupSerialPort();
	call	_SetupSerialPort
;	uart.c: 74: do {
00102$:
;	uart.c: 75: uart_write("Hello World!\n");
	ldw	x, #___str_0+0
	pushw	x
	call	_uart_write
	addw	sp, #2
;	uart.c: 76: for(i = 0; i < 147456; i++) { } // Sleep
	ldw	y, #0x4000
	ldw	x, #0x0002
00107$:
	subw	y, #0x0001
	ld	a, xl
	sbc	a, #0x00
	ld	xl, a
	ld	a, xh
	sbc	a, #0x00
	ld	xh, a
	tnzw	y
	jrne	00107$
	tnzw	x
	jreq	00102$
;	uart.c: 77: } while(1);
	jra	00107$
	ret
	.area CODE
___str_0:
	.ascii "Hello World!"
	.db 0x0A
	.db 0x00
	.area INITIALIZER
	.area CABS (ABS)
