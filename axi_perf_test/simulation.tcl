set Team_Submission_Dir ../team_submission
set Test_Project_Dir ./test_project
set Source_Select soc_axi_func
set Result_Dir ../test_result
set Test_Item perf_test

foreach team [glob -types d -directory $Team_Submission_Dir/ -tail *] {
    #open_project
    open_project $Test_Project_Dir/$team/run_vivado/mycpu_prj1/mycpu.xpr

    launch_simulation

    #run simualation
    #run all 
    foreach unit [glob -types d -directory $Test_Project_Dir/soft/perf_func/obj/unit_test/ -tail *] {
        file copy $Test_Project_Dir/soft/perf_func/obj/unit_test/$unit/axi_ram.mif
        restart
        run all 
    }

    close_sim
    file mkdir $Result_Dir/$team/$Test_Item 
    file copy -force $Test_Project_Dir/$team/run_vivado/mycpu_prj1/mycpu.sim/sim_1/behav/xsim/simulate.log $Result_Dir/$team/$Test_Item/simulate.log
    close_project
}
