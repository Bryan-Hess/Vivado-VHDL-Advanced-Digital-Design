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
extern void execute_186(char*, char *);
extern void execute_25(char*, char *);
extern void execute_185(char*, char *);
extern void execute_30(char*, char *);
extern void execute_35(char*, char *);
extern void execute_40(char*, char *);
extern void execute_45(char*, char *);
extern void execute_50(char*, char *);
extern void execute_55(char*, char *);
extern void execute_60(char*, char *);
extern void execute_65(char*, char *);
extern void execute_70(char*, char *);
extern void execute_75(char*, char *);
extern void execute_80(char*, char *);
extern void execute_85(char*, char *);
extern void execute_90(char*, char *);
extern void execute_95(char*, char *);
extern void execute_100(char*, char *);
extern void execute_105(char*, char *);
extern void execute_110(char*, char *);
extern void execute_115(char*, char *);
extern void execute_120(char*, char *);
extern void execute_125(char*, char *);
extern void execute_130(char*, char *);
extern void execute_135(char*, char *);
extern void execute_140(char*, char *);
extern void execute_145(char*, char *);
extern void execute_150(char*, char *);
extern void execute_155(char*, char *);
extern void execute_160(char*, char *);
extern void execute_165(char*, char *);
extern void execute_170(char*, char *);
extern void execute_175(char*, char *);
extern void execute_180(char*, char *);
extern void execute_27(char*, char *);
extern void execute_28(char*, char *);
extern void vhdl_transfunc_eventcallback(char*, char*, unsigned, unsigned, unsigned, char *);
funcp funcTab[37] = {(funcp)execute_186, (funcp)execute_25, (funcp)execute_185, (funcp)execute_30, (funcp)execute_35, (funcp)execute_40, (funcp)execute_45, (funcp)execute_50, (funcp)execute_55, (funcp)execute_60, (funcp)execute_65, (funcp)execute_70, (funcp)execute_75, (funcp)execute_80, (funcp)execute_85, (funcp)execute_90, (funcp)execute_95, (funcp)execute_100, (funcp)execute_105, (funcp)execute_110, (funcp)execute_115, (funcp)execute_120, (funcp)execute_125, (funcp)execute_130, (funcp)execute_135, (funcp)execute_140, (funcp)execute_145, (funcp)execute_150, (funcp)execute_155, (funcp)execute_160, (funcp)execute_165, (funcp)execute_170, (funcp)execute_175, (funcp)execute_180, (funcp)execute_27, (funcp)execute_28, (funcp)vhdl_transfunc_eventcallback};
const int NumRelocateId= 37;

void relocate(char *dp)
{
	iki_relocate(dp, "xsim.dir/FullAdder_tb_behav/xsim.reloc",  (void **)funcTab, 37);
	iki_vhdl_file_variable_register(dp + 7800);
	iki_vhdl_file_variable_register(dp + 7856);


	/*Populate the transaction function pointer field in the whole net structure */
}

void sensitize(char *dp)
{
	iki_sensitize(dp, "xsim.dir/FullAdder_tb_behav/xsim.reloc");
}

void simulate(char *dp)
{
		iki_schedule_processes_at_time_zero(dp, "xsim.dir/FullAdder_tb_behav/xsim.reloc");
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
    iki_set_sv_type_file_path_name("xsim.dir/FullAdder_tb_behav/xsim.svtype");
    iki_set_crvs_dump_file_path_name("xsim.dir/FullAdder_tb_behav/xsim.crvsdump");
    void* design_handle = iki_create_design("xsim.dir/FullAdder_tb_behav/xsim.mem", (void *)relocate, (void *)sensitize, (void *)simulate, 0, isimBridge_getWdbWriter(), 0, argc, argv);
     iki_set_rc_trial_count(100);
    (void) design_handle;
    return iki_simulate_design();
}
