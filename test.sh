#!/bin/bash
cd ./axi_func_test
vivado -mode batch -source init.tcl
vivado -mode batch -source generate_bit.tcl
cd ../axi_mem_game_test
vivado -mode batch -source init.tcl
vivado -mode batch -source generate_bit.tcl
cd ../axi_perf_test
vivado -mode batch -source init.tcl
vivado -mode batch -source generate_bit.tcl
