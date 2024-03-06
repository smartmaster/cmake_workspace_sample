

function(smlAddBoost iTarget)

    # set(Boost_USE_RELEASE_LIBS       ON)  # only find release libs
    # set(Boost_USE_MULTITHREADED      ON)

    #include(${CMAKE_TOOLCHAIN_FILE})
    
    #find_package(Vcpkg REQUIRED)
    

	# FindBoost module
    find_package(Boost REQUIRED COMPONENTS ALL)

    if(${Boost_FOUND})
        target_include_directories("${iTarget}" PRIVATE ${Boost_INCLUDE_DIRS})
        target_link_libraries("${iTarget}" PRIVATE ${Boost_LIBRARIES})
        # message("BBBBBBBBBBBBB ${Boost_INCLUDE_DIRS}")
        # message("LLLLLLLLLLLLL ${Boost_LIBRARIES}")
    else()
        message(FATAL_ERROR "Boost not found. Please install Boost or specify Boost location manually.")
    endif()

endfunction()