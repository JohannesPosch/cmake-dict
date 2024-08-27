function(dict command dict )
    if(command STREQUAL SET)
        set(arg_key ${ARGV2})
        set(arg_value ${ARGV3})

        dict(_IDX ${dict} "${arg_key}" idx)
        if(NOT idx STREQUAL -1)
            list(REMOVE_AT ${dict} ${idx})
        endif()
        
        # Check if the argument is a list, if so, change the ; to a : to store it in the dictionary
        if("${arg_value}" MATCHES ";")
            # Change the ; to a :
            string(REPLACE ";" ":" arg_value "${arg_value}")
        endif()

        list(APPEND ${dict} "${arg_key}=${arg_value}")
        set(${dict} "${${dict}}" PARENT_SCOPE)

    elseif(command STREQUAL GET)
        set(arg_key ${ARGV2})
        set(arg_outvar ${ARGV3})

        dict(_IDX ${dict} "${arg_key}" idx)
        if(idx STREQUAL -1)
            # message(FATAL_ERROR "No key \"${arg_key}\" in dictionary")
            set(${arg_outvar} "" PARENT_SCOPE)
            return()
        endif()

        list(GET ${dict} ${idx} kv)
        string(REGEX REPLACE "^[^=]+=(.*)" "\\1" value "${kv}")
        
        # Check if the value is a list, if so, change the : to a ; to get it from the dictionary
        if("${value}" MATCHES ":")
            # Change the : to a ;
            string(REPLACE ":" ";" value "${value}")
        endif()
        
        set(${arg_outvar} "${value}" PARENT_SCOPE)

    elseif(command STREQUAL _IDX)
        set(arg_key ${ARGV2})
        set(arg_outvar ${ARGV3})
        set(idx 0)
        foreach(kv IN LISTS ${dict})
            string(REGEX REPLACE "^([^=]+)=.*" "\\1" key "${kv}")
            if(arg_key STREQUAL key)
                set(${arg_outvar} "${idx}" PARENT_SCOPE)
                return()
            endif()
            math(EXPR idx ${idx}+1)
        endforeach()
        set(${arg_outvar} "-1" PARENT_SCOPE)

    else()
        message(FATAL_ERROR "dict does not recognize sub-command ${command}")
    endif()
endfunction()
