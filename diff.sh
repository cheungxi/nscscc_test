#!/bin/bash

path=./team_submission/
teamSet=$(ls $path)
for team in $teamSet
do
        diff -r $path/$team/soc_axi_func/rtl/myCPU/ $path/$team/soc_axi_perf/rtl/myCPU/
done

