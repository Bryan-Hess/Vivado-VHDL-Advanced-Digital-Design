/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                         */
/*  \   \        Copyright (c) 2003-2013 Xilinx, Inc.                 */
/*  /   /        All Right Reserved.                                  */
/* /---/   /\                                                         */
/* \   \  /  \                                                        */
/*  \___\/\___\                                                       */
/**********************************************************************/


#include "iki.h"
#include <string.h>
#include <math.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                         */
/*  \   \        Copyright (c) 2003-2013 Xilinx, Inc.                 */
/*  /   /        All Right Reserved.                                  */
/* /---/   /\                                                         */
/* \   \  /  \                                                        */
/*  \___\/\___\                                                       */
/**********************************************************************/


#include "iki.h"
#include <string.h>
#include <math.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
typedef void (*funcp)(char *, char *);
extern int main(int, char**);
extern void execute_339(char*, char *);
extern void execute_340(char*, char *);
extern void execute_12(char*, char *);
extern void execute_332(char*, char *);
extern void execute_17(char*, char *);
extern void execute_22(char*, char *);
extern void execute_27(char*, char *);
extern void execute_32(char*, char *);
extern void execute_37(char*, char *);
extern void execute_42(char*, char *);
extern void execute_47(char*, char *);
extern void execute_52(char*, char *);
extern void execute_57(char*, char *);
extern void execute_62(char*, char *);
extern void execute_67(char*, char *);
extern void execute_72(char*, char *);
extern void execute_77(char*, char *);
extern void execute_82(char*, char *);
extern void execute_87(char*, char *);
extern void execute_92(char*, char *);
extern void execute_97(char*, char *);
extern void execute_102(char*, char *);
extern void execute_107(char*, char *);
extern void execute_112(char*, char *);
extern void execute_117(char*, char *);
extern void execute_122(char*, char *);
extern void execute_127(char*, char *);
extern void execute_132(char*, char *);
extern void execute_137(char*, char *);
extern void execute_142(char*, char *);
extern void execute_147(char*, char *);
extern void execute_152(char*, char *);
extern void execute_157(char*, char *);
extern void execute_162(char*, char *);
extern void execute_167(char*, char *);
extern void execute_172(char*, char *);
extern void execute_177(char*, char *);
extern void execute_182(char*, char *);
extern void execute_187(char*, char *);
extern void execute_192(char*, char *);
extern void execute_197(char*, char *);
extern void execute_202(char*, char *);
extern void execute_207(char*, char *);
extern void execute_212(char*, char *);
extern void execute_217(char*, char *);
extern void execute_222(char*, char *);
extern void execute_227(char*, char *);
extern void execute_232(char*, char *);
extern void execute_237(char*, char *);
extern void execute_242(char*, char *);
extern void execute_247(char*, char *);
extern void execute_252(char*, char *);
extern void execute_257(char*, char *);
extern void execute_262(char*, char *);
extern void execute_267(char*, char *);
extern void execute_272(char*, char *);
extern void execute_277(char*, char *);
extern void execute_282(char*, char *);
extern void execute_287(char*, char *);
extern void execute_292(char*, char *);
extern void execute_297(char*, char *);
extern void execute_302(char*, char *);
extern void execute_307(char*, char *);
extern void execute_312(char*, char *);
extern void execute_317(char*, char *);
extern void execute_322(char*, char *);
extern void execute_327(char*, char *);
extern void execute_14(char*, char *);
extern void execute_15(char*, char *);
extern void execute_334(char*, char *);
extern void execute_336(char*, char *);
extern void execute_338(char*, char *);
extern void transaction_0(char*, char*, unsigned, unsigned, unsigned);
extern void vhdl_transfunc_eventcallback(char*, char*, unsigned, unsigned, unsigned, char *);
extern void transaction_2(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_18(char*, char*, unsigned, unsigned, unsigned);
funcp funcTab[76] = {(funcp)execute_339, (funcp)execute_340, (funcp)execute_12, (funcp)execute_332, (funcp)execute_17, (funcp)execute_22, (funcp)execute_27, (funcp)execute_32, (funcp)execute_37, (funcp)execute_42, (funcp)execute_47, (funcp)execute_52, (funcp)execute_57, (funcp)execute_62, (funcp)execute_67, (funcp)execute_72, (funcp)execute_77, (funcp)execute_82, (funcp)execute_87, (funcp)execute_92, (funcp)execute_97, (funcp)execute_102, (funcp)execute_107, (funcp)execute_112, (funcp)execute_117, (funcp)execute_122, (funcp)execute_127, (funcp)execute_132, (funcp)execute_137, (funcp)execute_142, (funcp)execute_147, (funcp)execute_152, (funcp)execute_157, (funcp)execute_162, (funcp)execute_167, (funcp)execute_172, (funcp)execute_177, (funcp)execute_182, (funcp)execute_187, (funcp)execute_192, (funcp)execute_197, (funcp)execute_202, (funcp)execute_207, (funcp)execute_212, (funcp)execute_217, (funcp)execute_222, (funcp)execute_227, (funcp)execute_232, (funcp)execute_237, (funcp)execute_242, (funcp)execute_247, (funcp)execute_252, (funcp)execute_257, (funcp)execute_262, (funcp)execute_267, (funcp)execute_272, (funcp)execute_277, (funcp)execute_282, (funcp)execute_287, (funcp)execute_292, (funcp)execute_297, (funcp)execute_302, (funcp)execute_307, (funcp)execute_312, (funcp)execute_317, (funcp)execute_322, (funcp)execute_327, (funcp)execute_14, (funcp)execute_15, (funcp)execute_334, (funcp)execute_336, (funcp)execute_338, (funcp)transaction_0, (funcp)vhdl_transfunc_eventcallback, (funcp)transaction_2, (funcp)transaction_18};
const int NumRelocateId= 76;

void relocate(char *dp)
{
	iki_relocate(dp, "xsim.dir/Multiplier_behav/xsim.reloc",  (void **)funcTab, 76);
	iki_vhdl_file_variable_register(dp + 16072);
	iki_vhdl_file_variable_register(dp + 16128);


	/*Populate the transaction function pointer field in the whole net structure */
}

void sensitize(char *dp)
{
	iki_sensitize(dp, "xsim.dir/Multiplier_behav/xsim.reloc");
}

void simulate(char *dp)
{
		iki_schedule_processes_at_time_zero(dp, "xsim.dir/Multiplier_behav/xsim.reloc");
	// Initialize Verilog nets in mixed simulation, for the cases when the value at time 0 should be propagated from the mixed language Vhdl net
	iki_execute_processes();

	// Schedule resolution functions for the multiply driven Verilog nets that have strength
	// Schedule transaction functions for the singly driven Verilog nets that have strength

}
#include "iki_bridge.h"
void relocate(char *);

void sensitize(char *);

void simulate(char *);

extern SYSTEMCLIB_IMP_DLLSPEC void local_register_implicit_channel(int, char*);
extern void implicit_HDL_SCinstatiate();

extern SYSTEMCLIB_IMP_DLLSPEC int xsim_argc_copy ;
extern SYSTEMCLIB_IMP_DLLSPEC char** xsim_argv_copy ;

int main(int argc, char **argv)
{
    iki_heap_initialize("ms", "isimmm", 0, 2147483648) ;
    iki_set_sv_type_file_path_name("xsim.dir/Multiplier_behav/xsim.svtype");
    iki_set_crvs_dump_file_path_name("xsim.dir/Multiplier_behav/xsim.crvsdump");
    void* design_handle = iki_create_design("xsim.dir/Multiplier_behav/xsim.mem", (void *)relocate, (void *)sensitize, (void *)simulate, 0, isimBridge_getWdbWriter(), 0, argc, argv);
     iki_set_rc_trial_count(100);
    (void) design_handle;
    return iki_simulate_design();
}
