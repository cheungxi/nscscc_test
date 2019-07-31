set Team_Submission_Dir ../team_submission
set Test_Project_Dir ./test_project
set BitStream_Dir ./axi_bit
set Result_Dir ../test_result
set Test_Item axi_func

foreach team [glob -types d -directory $Team_Submission_Dir/ -tail *] {

    open_project $Test_Project_Dir/$team/run_vivado/mycpu_prj1/mycpu.xpr
    reset_run synth_1
    if {[catch {
    #Synthesis
        launch_runs synth_1 -job 4
        wait_on_run synth_1
        } synth_errorstring]} {
        puts "$team Synth Fail !!! \n
              $synth_errorstring \n"
        close_project
        continue
    } else {if {[catch {
    #Implementation And Generate Bitstream
        launch_runs impl_1 -to_step write_bitstream -job 4
        wait_on_run impl_1 
    } impl_errorstring]} {
        puts "$team Impl Fail !!! \n
              $impl_errorstring \n"
        close_project
        continue
    } else {
    file mkdir $Result_Dir/$team/$Test_Item
    #Copy Bitstream
    file copy -force $Test_Project_Dir/$team/run_vivado/mycpu_prj1/mycpu.runs/impl_1/soc_axi_lite_top.bit $Result_Dir/$team/$Test_Item
    puts "$team Write BitStream Successfully !!!" }}
    
    close_project
    
}