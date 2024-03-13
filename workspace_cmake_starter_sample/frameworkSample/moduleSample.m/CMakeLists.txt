
function(smlCmakeMain)
	
	cmake_minimum_required(VERSION 3.20)

	#####################################################################
	include(${CMAKE_CURRENT_LIST_DIR}/../../smlWorkspaceVar.cmake)
	include(${CMAKE_CURRENT_LIST_DIR}/../smlFrameworkVar.cmake)
	include(${CMAKE_CURRENT_LIST_DIR}/smlModuleVar.cmake)

	include(${CMAKE_CURRENT_LIST_DIR}/smlModuleFunction.cmake)

	include(${CMAKE_CURRENT_LIST_DIR}/smlAddBoost.cmake)

	#####################################################################
	# !!!warning!!! do not do in production release
	smlDisableOptForRelease()

	#####################################################################
	set(smlPrjectName "${smlPrjectNameVar}")
	project(${smlPrjectName})


	if(${smlDebugOn})
		smlPrintCMakeDirs(${smlPrjectName})
	endif()


	#####################################################################
	set(CMAKE_CXX_STANDARD "${sml_CXX_STANDARD_var}")
	set(CMAKE_CXX_STANDARD_REQUIRED ON)

	#####################################################################
	smlEnableLanguage()

	#####################################################################
	set(SrcFiles "")
	set(HeaderFiles "")
	set(ModIncs "")
	set(FxIncs "")


	set(smlModule "${smlModuleVar}")
	set(smlFramworks "${smlFramworksVar}")
	smlCollectModuleFiles("${smlModule}" SrcFiles HeaderFiles)
	smlCollectModuleIncDis("${smlModule}" ModIncs)
	smlCollectFxIncDis("${smlFramworks}" FxIncs)


	if(${smlDebugOn})
		smlPrintLists("CCCCCCC:\t" "${SrcFiles}")
		smlPrintLists("HHHHHHH:\t" "${HeaderFiles}")
		smlPrintLists("MMMIIIIIII:\t" "${ModIncs}")
		smlPrintLists("fffiiiiiii:\t" "${FxIncs}")
	endif()

	#####################################################################
	set(smlTargetType "${smlTargetTypeVar}")
	if("${smlTargetType}" STREQUAL "EXE")
		add_executable(${smlPrjectName} "${SrcFiles}" "${HeaderFiles}")
	elseif("${smlTargetType}" STREQUAL "DLL")
		add_library(${smlPrjectName} SHARED "${SrcFiles}" "${HeaderFiles}")
	else()
		message(FATAL_ERROR "${smlTargetType} is not supported, the valid type is EXE or DLL")
	endif()

	#####################################################################
	set(smlPrjectDefs ${smlPrjectDefsVar})
	target_compile_definitions(${smlPrjectName} PRIVATE "${smlPrjectDefs}")


	#####################################################################
	target_include_directories(${smlPrjectName} PRIVATE "${ModIncs}" "${FxIncs}")

	#####################################################################
	#smlAddBoost(${smlPrjectName})
	smlAdd3rdLibByHand("${t3rdPartyRootDir}" "${t3rdPartyIncDir}" "${t3rdPartyLibDir}" "${t3rdPartyLibPatterns}" "${smlPrjectName}")
	
	#####################################################################
	install(TARGETS "${smlPrjectName}" DESTINATION bin)

endfunction()


#main function
smlCmakeMain()