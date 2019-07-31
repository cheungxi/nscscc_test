set BitStream_Dir  result
set BitStream_File func_test.bit

set Team_Submission_Dir ../team_submission
set Result_Dir ../test_result
set Test_Item perf_test
open_hw
connect_hw_server
open_hw_target
foreach team [glob -types d -directory $Team_Submission_Dir/ -tail *] {
    flush stdout
    puts "$team START Program Devices"
    gets stdin var
    puts $var
    if {$var == {1}} {
    set_property PROBES.FILE {} [get_hw_devices xc7a200t_0]
    set_property FULL_PROBES.FILE {} [get_hw_devices xc7a200t_0]
    set_property PROGRAM.FILE "$Result_Dir/$team/$Test_Item/soc_axi_lite_top.bit" [get_hw_devices xc7a200t_0]
    program_hw_devices [get_hw_devices xc7a200t_0]
    refresh_hw_device [lindex [get_hw_devices xc7a200t_0] 0]
    puts "$team Program Devices Successfully !"
    }
}

close_hw
