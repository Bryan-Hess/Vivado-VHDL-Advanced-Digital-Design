#include "xparameters.h"
#include "xil_cache.h"
#include "xtime_l.h"
#include <stdio.h>
#include "sleep.h"

#define BRAM_DEPTH 16
#define BRAM_CONTROLLER_ADDR 0x41000000
#define LAB_CPU_ADDR         0x40000000

// Test 0

// addi $7, $0, 17
// addi $11, $0, -3
// and $11, $7, $11
// sw $11, 15($7)

uint32_t program0[] = {
	0x20070011, 0x200BFFFD, 0x00EB5824, 0xACEB000F,
	0x00000000, 0x00000000, 0x00000000, 0x00000000,
	0x00000000, 0x00000000, 0x00000000, 0x00000000,
	0x00000000, 0x00000000, 0x00000000, 0x00000000
};

// Test 1

// addi $7, $0, 17
// addi $11, $0, -3
// sub $11, $7, $11
// sw $11, 15($7)

uint32_t program1[] = {
	0x20070011, 0x200BFFFD, 0x00EB5822, 0xACEB000F,
	0x00000000, 0x00000000, 0x00000000, 0x00000000,
	0x00000000, 0x00000000, 0x00000000, 0x00000000,
	0x00000000, 0x00000000, 0x00000000, 0x00000000
};
// function prototype to run the program

// Test 2

// addi $7, $0, 17
// addi $11, $0, -3
// addu $11, $7, $11
// sw $11, 15($7)

uint32_t program2[] = {
	0x20070011, 0x200BFFFD, 0x00EB5821, 0xACEB000F,
	0x00000000, 0x00000000, 0x00000000, 0x00000000,
	0x00000000, 0x00000000, 0x00000000, 0x00000000,
	0x00000000, 0x00000000, 0x00000000, 0x00000000
};

// Test 3

// addi $7, $0, 17
// addi $11, $0, -3
// sra $11, $7, 1
// sw $11, 15($7)

uint32_t program3[] = {
	0x20070011, 0x200BFFFD, 0x00075843, 0xACEB000F,
	0x00000000, 0x00000000, 0x00000000, 0x00000000,
	0x00000000, 0x00000000, 0x00000000, 0x00000000,
	0x00000000, 0x00000000, 0x00000000, 0x00000000
};

// Test 4

// addi $7, $0, 17
// addi $11, $0, -3
// sra $11, $7, 1
// sw $11, 15($7)

uint32_t program4[] = {
	0x20070011, 0x200BFFFD, 0x00E75804, 0xACEB000F,
	0x00000000, 0x00000000, 0x00000000, 0x00000000,
	0x00000000, 0x00000000, 0x00000000, 0x00000000,
	0x00000000, 0x00000000, 0x00000000, 0x00000000
};

// Test 5

// addi $7, $0, 17
// addi $11, $0, -3
// slti $11, $7, 63
// sw $11, 15($7)

uint32_t program5[] = {
	0x20070011, 0x200BFFFD, 0x28EB003F, 0xACEB000F,
	0x00000000, 0x00000000, 0x00000000, 0x00000000,
	0x00000000, 0x00000000, 0x00000000, 0x00000000,
	0x00000000, 0x00000000, 0x00000000, 0x00000000
};

// Test 6

// addi $7, $0, 17
// addi $11, $0, -3
// bne $11, $7, B_GO
// addi $1, $0, 2
// sll $0, $0, 0
// sll $0, $0, 0
// B_GO: addi $1, $0, 1
// sw $1, 15($7)

uint32_t program6[] = {
	0x20070011, 0x200BFFFD, 0x15670003, 0x20010002,
	0x00000000, 0x00000000, 0x20010001, 0xACE1000F,
	0x00000000, 0x00000000, 0x00000000, 0x00000000,
	0x00000000, 0x00000000, 0x00000000, 0x00000000
};

// Test 7

//lui $1, 0x00001001
//ori $13, $1,0x00000020
//lui $1, 0x00000123
//ori $9, $1,0x00004567
//sw $9, 0($13)
//lh $11, 2($13)
//sw $11, 16($13)

uint32_t program7[] = {
	0x3C011001, 0x342D0020, 0x3C010123, 0x34294567,
	0xADA90000, 0x85AB0002, 0xADAB0010, 0x00000000,
	0x00000000, 0x00000000, 0x00000000, 0x00000000,
	0x00000000, 0x00000000, 0x00000000, 0x00000000
};

// Test 8

//lui $1, 0x00001001
//ori $13, $1,0x00000020
//addi $9, $0,-45
//clo, $10,$9
//sw $10, 0($13)

uint32_t program8[] = {
	0x3C011001, 0x342D0020, 0x2009FFD3, 0x71205021,
	0xADAA0000, 0x00000000, 0x00000000, 0x00000000,
	0x00000000, 0x00000000, 0x00000000, 0x00000000,
	0x00000000, 0x00000000, 0x00000000, 0x00000000
};

// Test 9

//lui $1, 0x00001001
//li $3,0xFF0F
//sw $3, 32($1)
//li $5,0xBBBB
//sll $0,$0,0
//lw $2, 32($1)
//and $4, $2,$5
//sw $4, 36($1)

uint32_t program9[] = {
	0x3C011001, 0x3403FF0F, 0xAC230020, 0x3405BBBB,
	0x00000000, 0x8C220020, 0x00452024, 0xAC240024,
	0x00000000, 0x00000000, 0x00000000, 0x00000000,
	0x00000000, 0x00000000, 0x00000000, 0x00000000
};

// Test 10

//addi $11, $0, -3
//bltzal $11,B_GO
//sll $0, $0, 0
//j EXIT
//sll $0, $0, 0
//B_GO: jr $31
//sll $0, $0, 0
//EXIT: sw $31, 32($zero)

uint32_t program10[] = {
	0x200BFFFD, 0x05700003, 0x00000000, 0x08000007,
	0x00000000, 0x03E00008, 0x00000000, 0xAC1F0020,
	0x00000000, 0x00000000, 0x00000000, 0x00000000,
	0x00000000, 0x00000000, 0x00000000, 0x00000000
};

void run_program(uint32_t *program);

int main(void) {
	printf("-------------------------------------\n");

	printf("\nRunning PROGRAM 0\n");
	run_program(program0);

	printf("\nRunning PROGRAM 1\n");
	run_program(program1);

	printf("\nRunning PROGRAM 2\n");
	run_program(program2);

	printf("\nRunning PROGRAM 3\n");
	run_program(program3);

	printf("\nRunning PROGRAM 4\n");
	run_program(program4);

	printf("\nRunning PROGRAM 5\n");
	run_program(program5);

	printf("\nRunning PROGRAM 6\n");
	run_program(program6);

	printf("\nRunning PROGRAM 7\n");
	run_program(program7);

	printf("\nRunning PROGRAM 8\n");
	run_program(program8);

	printf("\nRunning PROGRAM 9\n");
	run_program(program9);

	printf("\nRunning PROGRAM 10\n");
	run_program(program10);
}

void run_program(uint32_t *program) {

	//defining pointers for bram controller (bram_ptr) and the RegMap (cpu_ptr)
	uint32_t * bram_ptr = (uint32_t *)BRAM_CONTROLLER_ADDR;
	uint32_t * cpu_ptr  = (uint32_t *)LAB_CPU_ADDR;

	// assert cpu reset
	cpu_ptr[0] = 1;

	// initialize instruction memory
	for (int i = 0; i < BRAM_DEPTH; ++i) {
		bram_ptr[i] = program[i];
	}

	// print memory contents
	printf("Memory Contents (BEFORE)\n");
	for (int i = 0; i < BRAM_DEPTH; ++i) {
		printf("%2d : 0x%08X\n", i, (unsigned int)bram_ptr[i]);
	}

	// de-assert cpu reset
	cpu_ptr[0] = 0;

	// cpu execution will very likely finish faster than a read to bram_ptr through AXI-LITE
	// interface, but just in case you came up with a long program, you might wanna try one of
	// the following:
	//
	// 1. add a delay loop from some time, may be a second or so.
	// 2. poll a memory location that you will change by the end of your program execution.

	// print memory contents
	printf("\nMemory Contents (AFTER)\n");
	for (int i = 0; i < BRAM_DEPTH; ++i) {
		printf("%2d : 0x%08X\n", i, (unsigned int)bram_ptr[i]);
		sleep(.5);
	}
}
