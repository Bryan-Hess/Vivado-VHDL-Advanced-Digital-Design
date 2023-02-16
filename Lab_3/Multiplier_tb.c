
/*#include <stdio.h>
int main(void)
{
	// base address of axi_regmap as set in the Vivado address editor
	uint32_t *regmap= (uint32_t *) 0x70000000;

	uint32_t Ain = 0;
	uint32_t Bin = 0;
    size_t reset = 0;
    uint32_t Aout = 0;
    uint32_t Bout = 0;
	size_t done = 0;
	uint64_t R = 0;

	////////////////////////////////////////Test 1//////////////////////////////////////////////

	//Bitwise AND
	Ain = 4294967295, Bin = 4294967295, reset = 0;
	regmap[0] = Ain, regmap[1] = Bin, regmap[2] = reset;
	Aout = regmap[0], Bout = regmap[1], done = regmap[2];

	regmap[2] = 1;
	regmap[2] = 0;

	while (done == 0);
	R=(((uint64_t) Aout) << 32) + ((uint64_t) Bout);
	printf("%2zu * %2zu = %3zu (%s)\n", Ain, Bin, R, (R == (uint64_t) Ain * (uint64_t) Bin) ? "COR" : "ERR");

	return 0;
}
*/

#include <stdio.h>
#include <stdlib.h>

int main(void)
{
	uint32_t *regmap = (uint32_t *) 0x70000000; // base address of axi_regmap as set in the Vivado address editor

	uint64_t  res = 0, reg; // 64-bit register to hold the value of the multiplication and the result from the multiplier
	uint32_t  A, B;	// 32-bit random numbers

	printf("start\n");

	A = 0x01010101;
	B = 0x01010101;
	res = (uint64_t) A * (uint64_t) B; // you have to do type casting before multiplying, otherwise, you will end up having incorrect result.

	// Assign A, B to your multiplier
	regmap[0] = A;
	regmap[1] = B;

	// give the reset signal
	regmap[2] = 1;
	regmap[2] = 0;

	// poll for done signal
	while (regmap[2] == 0);

	// assuming your result is stored in R_high = regmap[0] and R_low = regmap[1]
	// you have to do type casting first, othersie you will end up with a wrong answer.
	reg = (((uint64_t) regmap[0]) << 32) + ((uint64_t) regmap[1]);

	// %8lx will print uint32_t in hex in 8 digits, %16llx will print uint64_t in hex in 16 digits.
	printf("%8lx * %8lx = %8lx%8lx (%16llx) (%s) \n\n", A, B, regmap[0], regmap[1], res, (reg == res ? "correct" : "wrong"));


	A = 0xF58E6f32;
	B = 0xF9B6C821;
	res = (uint64_t) A * (uint64_t) B; // you have to do type casting before multiplying, otherwise, you will end up having incorrect result.

	// Assign A, B to your multiplier
	regmap[0] = A;
	regmap[1] = B;

	// give the reset signal
	regmap[2] = 1;
	regmap[2] = 0;

	// poll for done signal
	while (regmap[2] == 0);

	// assuming your result is stored in R_high = regmap[0] and R_low = regmap[1]
	// you have to do type casting first, othersie you will end up with a wrong answer.
	reg = (((uint64_t) regmap[0]) << 32) + ((uint64_t) regmap[1]);

	// %8lx will print uint32_t in hex in 8 digits, %16llx will print uint64_t in hex in 16 digits.
	printf("%8lx * %8lx = %8lx%8lx (%16llx) (%s) \n\n", A, B, regmap[0], regmap[1], res, (reg == res ? "correct" : "wrong"));


	A = 0x00000000;
	B = 0x00000000;
	res = (uint64_t) A * (uint64_t) B; // you have to do type casting before multiplying, otherwise, you will end up having incorrect result.

	// Assign A, B to your multiplier
	regmap[0] = A;
	regmap[1] = B;

	// give the reset signal
	regmap[2] = 1;
	regmap[2] = 0;

	// poll for done signal
	while (regmap[2] == 0);

	// assuming your result is stored in R_high = regmap[0] and R_low = regmap[1]
	// you have to do type casting first, othersie you will end up with a wrong answer.
	reg = (((uint64_t) regmap[0]) << 32) + ((uint64_t) regmap[1]);

	// %8lx will print uint32_t in hex in 8 digits, %16llx will print uint64_t in hex in 16 digits.
	printf("%8lx * %8lx = %8lx%8lx (%16llx) (%s) \n\n", A, B, regmap[0], regmap[1], res, (reg == res ? "correct" : "wrong"));


	A = 0XFFFFFFFF;
	B = 0xFFFFFFFF;
	res = (uint64_t) A * (uint64_t) B; // you have to do type casting before multiplying, otherwise, you will end up having incorrect result.

	// Assign A, B to your multiplier
	regmap[0] = A;
	regmap[1] = B;

	// give the reset signal
	regmap[2] = 1;
	regmap[2] = 0;

	// poll for done signal
	while (regmap[2] == 0);

	// assuming your result is stored in R_high = regmap[0] and R_low = regmap[1]
	// you have to do type casting first, othersie you will end up with a wrong answer.
	reg = (((uint64_t) regmap[0]) << 32) + ((uint64_t) regmap[1]);

	// %8lx will print uint32_t in hex in 8 digits, %16llx will print uint64_t in hex in 16 digits.
	printf("%8lx * %8lx = %8lx%8lx (%16llx) (%s) \n\n", A, B, regmap[0], regmap[1], res, (reg == res ? "correct" : "wrong"));


	A = rand();
	B = rand();
	res = (uint64_t) A * (uint64_t) B; // you have to do type casting before multiplying, otherwise, you will end up having incorrect result.

	// Assign A, B to your multiplier
	regmap[0] = A;
	regmap[1] = B;

	// give the reset signal
	regmap[2] = 1;
	regmap[2] = 0;

	// poll for done signal
	while (regmap[2] == 0);

	// assuming your result is stored in R_high = regmap[0] and R_low = regmap[1]
	// you have to do type casting first, othersie you will end up with a wrong answer.
	reg = (((uint64_t) regmap[0]) << 32) + ((uint64_t) regmap[1]);

	// %8lx will print uint32_t in hex in 8 digits, %16llx will print uint64_t in hex in 16 digits.
	printf("%8lx * %8lx = %8lx%8lx (%16llx) (%s) \n\n", A, B, regmap[0], regmap[1], res, (reg == res ? "correct" : "wrong"));




	return 0;
}
