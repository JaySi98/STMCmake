# Add compiler warnings
function(set_project_warnings project_name)
    set(GCC_WARNINGS
        -Wmisleading-indentation    # warn if indentation implies blocks where blocks
                                    # do not exist
        -Wduplicated-cond           # warn if if / else chain has duplicated conditions
        -Wduplicated-branches       # warn if if / else branches have duplicated code
        -Wlogical-op                # warn about logical operations being used where bitwise were
                                    # probably wanted
    )
    target_compile_options(${PROJECT_NAME} PUBLIC ${GCC_WARNINGS})

endfunction()
