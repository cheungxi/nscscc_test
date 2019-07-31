# Reference From StackOverFlow https://stackoverflow.com/questions/11104940/tcl-deep-recursive-file-search-search-for-files-with-c-extension
# findFiles
# basedir - the directory to start looking in
# pattern - A pattern, as defined by the glob command, that the files must match
proc findFiles { basedir pattern } {

    # Fix the directory name, this ensures the directory name is in the
    # native format for the platform and contains a final directory seperator
    set basedir [string trimright [file join [file normalize $basedir] { }]]
    set fileList {}

    # Look in the current directory for matching files, -type {f r}
    # means ony readable normal files are looked at, -nocomplain stops
    # an error being thrown if the returned list is empty
    foreach fileName [glob -nocomplain -type {f r} -path $basedir $pattern] {
        lappend fileList $fileName
    }

    # Now look for any sub direcories in the current directory
    foreach dirName [glob -nocomplain -type {d  r} -path $basedir *] {
        # Recusively call the routine on the sub directory and append any
        # new files to the results
        set subDirList [findFiles $dirName $pattern]
        if { [llength $subDirList] > 0 } {
            foreach subDirFile $subDirList {
                lappend fileList $subDirFile
            }
        }
    }
    return $fileList
 }

set Team_Submission_Dir ../team_submission
set Test_Project_Dir ./test_project
set Source_Select soc_sram_func

foreach team [glob -types d -directory $Team_Submission_Dir/ -tail *] {
    #copy init project
    file copy -force $Test_Project_Dir/template $Test_Project_Dir/$team

    #open_project
    open_project $Test_Project_Dir/$team/run_vivado/mycpu_prj1/mycpu.xpr

    #import_files
    import_files  -force $Team_Submission_Dir/$team/$Source_Select/rtl/myCPU
    import_files  -force -quiet [findFiles $Team_Submission_Dir/$team/$Source_Select/rtl/myCPU *.xci]
    import_files  -force -quiet [findFiles $Team_Submission_Dir/$team/$Source_Select/rtl/myCPU *.bd]
    update_compile_order -fileset sources_1
    #close project
    close_project
}