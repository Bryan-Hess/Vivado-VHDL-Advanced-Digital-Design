#include <stdio.h>

int main(void)
{
	// base address of axi_regmap as set in the Vivado address editor
	uint32_t *regmap= (uint32_t *) 0x70000000;

	size_t A = 0;
    size_t B = 0;
    size_t ALUOp = 0;
    size_t SHAMT = 0;
	size_t Result = 0;
	int C = 0, D = 0;
	unsigned int E = 0, F = 0;

	////////////////////////////////////////Logic//////////////////////////////////////////////

	//Bitwise AND
	A = 65535, B = 252645135, SHAMT = 0, ALUOp = 0;
	regmap[0] = A, regmap[1] = B, regmap[2] = ALUOp, regmap[3] = SHAMT;
	Result = regmap[0];
	printf("%2zu AND %2zu = %3zu (%s)\n", A, B, Result, (Result == (A&B)) ? "COR" : "ERR");

	//Bitwise OR
	A = 65535, B = 252645135, SHAMT = 0, ALUOp = 1;
	regmap[0] = A, regmap[1] = B, regmap[2] = ALUOp, regmap[3] = SHAMT;
	Result = regmap[0];
	printf("%2zu OR %2zu = %3zu (%s)\n", A, B, Result, (Result == (A|B)) ? "COR" : "ERR");

	//Bitwise XOR
	A = 65535, B = 252645135, SHAMT = 0, ALUOp = 2;
	regmap[0] = A, regmap[1] = B, regmap[2] = ALUOp, regmap[3] = SHAMT;
	Result = regmap[0];
	printf("%2zu XOR %2zu = %3zu (%s)\n", A, B, Result, (Result == (A^B)) ? "COR" : "ERR");

	//Bitwise NOR
	A = 65535, B = 252645135, SHAMT = 0, ALUOp = 3;
	regmap[0] = A, regmap[1] = B, regmap[2] = ALUOp, regmap[3] = SHAMT;
	Result = regmap[0];
	printf("%2zu NOR %2zu = %3zu (%s)\n", A, B, Result, (Result == 4042260480) ? "COR" : "ERR");

	/////////////////////////////////////Arithmetic////////////////////////////////////////////

	//Add Signed
	C = 70, D = -1, SHAMT = 0, ALUOp = 4;
	regmap[0] = C, regmap[1] = D, regmap[2] = ALUOp, regmap[3] = SHAMT;
	Result = regmap[0];
	printf("%d ADD %d = %3zu (%s)\n", C, D, Result, (Result == C+D) ? "COR" : "ERR");

	//Add Unsigned
	E = 400, F = 20, SHAMT = 0, ALUOp = 5;
	regmap[0] = E, regmap[1] = F, regmap[2] = ALUOp, regmap[3] = SHAMT;
	Result = regmap[0];
	printf("%u ADDU %u = %3zu (%s)\n", E, F, Result, (Result == E+F) ? "COR" : "ERR");

	//Subtract Signed
	C = 400, D = -20, SHAMT = 0, ALUOp = 6;
	regmap[0] = C, regmap[1] = D, regmap[2] = ALUOp, regmap[3] = SHAMT;
	Result = regmap[0];
	printf("%d SUB %d = %3zu (%s)\n", C, D, Result, (Result == C-D) ? "COR" : "ERR");

	//Subtract Unsigned
	E = 1000, F = 999, SHAMT = 0, ALUOp = 7;
	regmap[0] = E, regmap[1] = F, regmap[2] = ALUOp, regmap[3] = SHAMT;
	Result = regmap[0];
	printf("%u SUBU %u = %3zu (%s)\n", E, F, Result, (Result == E-F) ? "COR" : "ERR");

	/////////////////////////////////////Comparison////////////////////////////////////////////

	//Set on Less Than
	C = -500, D = -100, SHAMT = 0, ALUOp = 10;
	regmap[0] = C, regmap[1] = D, regmap[2] = ALUOp, regmap[3] = SHAMT;
	Result = regmap[0];
	printf("%d SLT %d = %3zu (%s)\n", C, D, Result, (Result == 1) ? "COR" : "ERR");

	//Set on Less Than Unsigned
	E = 500, F = 100, SHAMT = 0, ALUOp = 11;
	regmap[0] = E, regmap[1] = F, regmap[2] = ALUOp, regmap[3] = SHAMT;
	Result = regmap[0];
	printf("%u SLTU %u = %3zu (%s)\n", E, F, Result, (Result == 0) ? "COR" : "ERR");

	////////////////////////////////////////Shift//////////////////////////////////////////////

	//Shift Left Logical
	A = 42758785, B = 0, SHAMT = 10, ALUOp = 12;
	regmap[0] = A, regmap[1] = B, regmap[2] = ALUOp, regmap[3] = SHAMT;
	Result = regmap[0];
	printf("%2zu SLL %2zu = %3zu (%s)\n", A, SHAMT, Result, (Result == (A<<SHAMT)) ? "COR" : "ERR");

	//Shift Right Logical
	A = 2128394904, B = 0, SHAMT = 7, ALUOp = 14;
	regmap[0] = A, regmap[1] = B, regmap[2] = ALUOp, regmap[3] = SHAMT;
	Result = regmap[0];
	printf("%2zu SRL %2zu = %3zu (%s)\n", A, SHAMT, Result, (Result == (A>>SHAMT)) ? "COR" : "ERR");

	//Shift Right Arithmetic
	C = -2128394904, B = 0, SHAMT = 7, ALUOp = 15;
	regmap[0] = C, regmap[1] = B, regmap[2] = ALUOp, regmap[3] = SHAMT;
	Result = regmap[0];
	printf("%2zu SRA %2zu = %3zu (%s)\n", C, SHAMT, Result, (Result == (C>>SHAMT)) ? "COR" : "ERR");

	return 0;
}
