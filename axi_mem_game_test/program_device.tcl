set BitStream_Dir  result
set BitStream_File func_test.bit

set Team_Submission_Dir ../team_submission
set Result_Dir ../test_result
set Test_Item mem_game
open_hw
connect_hw_server
open_hw_target
foreach team [glob -types d -directory $Team_Submission_Dir/ -tail *] {
    flush stdout
    puts "$team input START Program Devices, \[y/Y/1\] or \[n/N/0\]"
    gets stdin var
    while {1} {
	if {$var == {Y} || $var == {y} ||  $var == {1}} {
    		set_property PROBES.FILE {} [get_hw_devices xc7a200t_0]
    		set_property FULL_PROBES.FILE {} [get_hw_devices xc7a200t_0]
    		set_property PROGRAM.FILE "$Result_Dir/$team/$Test_Item/soc_axi_lite_top.bit" [get_hw_devices xc7a200t_0]
    		program_hw_devices [get_hw_devices xc7a200t_0]
    		refresh_hw_device [lindex [get_hw_devices xc7a200t_0] 0]
    		puts "Program $team !!!"
		break
    	} elseif {$var == {N} || $var == {n} || $var == {0}} {
    		puts "Skip $team !!!"
	        break
       	} else {
		flush stdout
		puts "please input again: \[y/Y/1\] or \[n/N/0\]"
    		gets stdin var
	}	       
    }
}

close_hw

