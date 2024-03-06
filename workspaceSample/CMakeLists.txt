

function(smlCmakeMain)

	cmake_minimum_required(VERSION 3.20)


	include(${CMAKE_CURRENT_LIST_DIR}/smlWorkspaceVar.cmake)
	include(${CMAKE_CURRENT_LIST_DIR}/smlWorkspaceFunction.cmake)

	set(smlSubDirs "${smlSubDirsVar}")

	set(smlPrjectName ${smlPrjectNameVar})
	project(${smlPrjectName})


	if(${smlDebugOn})
		smlPrintCMakeDirs(${smlPrjectName})
	endif()


	foreach(ii IN LISTS smlSubDirs)
		add_subdirectory("${ii}")
	endforeach()

endfunction()

#main function
smlCmakeMain()
