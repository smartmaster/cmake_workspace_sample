


######################
# "${}"
# "${xxx}"

#print cmake directories
function(smlPrintCMakeDirs iName)
	message("${iName} PROJECT_BINARY_DIR        ${PROJECT_BINARY_DIR}")
	message("${iName} PROJECT_SOURCE_DIR        ${PROJECT_SOURCE_DIR}")
	message("${iName} CMAKE_CURRENT_BINARY_DIR  ${CMAKE_CURRENT_BINARY_DIR}")
	message("${iName} CMAKE_CURRENT_SOURCE_DIR  ${CMAKE_CURRENT_SOURCE_DIR}")
	message("${iName} CMAKE_CURRENT_LIST_DIR    ${CMAKE_CURRENT_LIST_DIR}")
endfunction()


#print list items with prefix message
function(smlPrintLists iPrefix iList)
	foreach(ii IN LISTS iList)
		message("${iPrefix} ${ii}")
	endforeach()
endfunction()

#enable assembly language or more
function(smlEnableLanguage)
	if (WIN32)
		# do something for Windows
		enable_language(ASM_MASM)
	elseif (UNIX)
		# do something for Linux
		enable_language(ASM_NASM)
	endif ()
endfunction()

#basic function to collect into the next level of sub dirs
function(smlCollectRootRelativeFiles iRootDirs iRelativeDirs iPatterns oFiles)
	set(oTempFiles "")
	foreach(rootDir IN LISTS iRootDirs)
		foreach(relDir IN LISTS iRelativeDirs)
			foreach(pattn IN LISTS iPatterns)
				set(temp "")
				file(GLOB temp "${rootDir}/${relDir}/${pattn}")
				# smlPrintLists("WWWWWWWWWWW ${rootDir}/${relDir}/${pattn}" "${temp}")
				set(lstLen 0)
				list(LENGTH temp lstLen)
				if(lstLen GREATER 0)
					list(APPEND oTempFiles "${temp}")
				endif()
			endforeach()
		endforeach()
	endforeach()
	set(${oFiles} "${oTempFiles}" PARENT_SCOPE)
endfunction()

#################################################
# to define the directory pattern in one place
macro(smlSetIncDirPatterns)
	set(incDirPatterns 
		"local_inc"
		"local_gen"
		"LocalInterfaces"
		"LocalGenerated"
		"private_inc"
		"private_gen"
		"PrivateInterfaces"
		"PrivateGenerated"
		"protected_inc"
		"protected_gen"
		"ProtectedInterfaces"
		"ProtectedGenerated"
		"public_inc"
		"public_gen"
		"PublicInterfaces"
		"PublicGenerated"
	)
endmacro()


#collect module source and header files
function(smlCollectModuleFiles iModDirs oSrcFiles oHeaderFiles)
	set(srcSubDir 
		"src"
		"src_*"
	)

	set(srcPattern 
		"*.cpp"
		"*.cxx"
		"*.c"
		"*.cc"
		"*.asm"
	)

	set(oTempFiles "")
	smlCollectRootRelativeFiles("${iModDirs}" "${srcSubDir}" "${srcPattern}" oTempFiles)
	set("${oSrcFiles}" "${oTempFiles}" PARENT_SCOPE)
	# smlPrintLists("XXXXXXXXXXX" "${iModDirs}")
	# smlPrintLists("YYYYYYYYYYY" "${srcSubDir}")
	# smlPrintLists("ZZZZZZZZZZZ" "${srcPattern}")
	# smlPrintLists("QQQQQQQQQQQ" "${oTempFiles}")

	#"${incDirPatterns}"
	smlSetIncDirPatterns()
	set(headerSubDir "${incDirPatterns}")

	set(headerPattern 
		"*.h"
		"*.hxx"
		"*.hpp"
		"*.inc"
	)
	set(oTempHFiles "")
	smlCollectRootRelativeFiles("${iModDirs}" "${headerSubDir}" "${headerPattern}" oTempHFiles)
	set("${oHeaderFiles}" "${oTempHFiles}" PARENT_SCOPE)
	# smlPrintLists("XXXXXXXXXXX" "${iModDirs}")
	# smlPrintLists("YYYYYYYYYYY" "${headerSubDir}")
	# smlPrintLists("ZZZZZZZZZZZ" "${headerPattern}")
	# smlPrintLists("QQQQQQQQQQQ" "${oTempHFiles}")

endfunction()

# collect module include directoris
function(smlCollectModuleIncDis iModDirs oModIncs)
	
	#"${incDirPatterns}"
	smlSetIncDirPatterns()
	set(headerSubDir "${incDirPatterns}")

	set(oTempDirs "")
	smlCollectRootRelativeFiles("${iModDirs}" "." "${headerSubDir}" oTempDirs)
	set("${oModIncs}" "${oTempDirs}" PARENT_SCOPE)
endfunction()

# collect framwwork include directoris
function(smlCollectFxIncDis iFxDirs oFxIncs)

	#"${incDirPatterns}"
	smlSetIncDirPatterns()
	set(headerSubDir "${incDirPatterns}")

	set(oTempDirs "")
	smlCollectRootRelativeFiles("${iFxDirs}" "." "${headerSubDir}" oTempDirs)
	set("${oFxIncs}" "${oTempDirs}" PARENT_SCOPE)
endfunction()


# disable optinazation for release builds
function(smlDisableOptForRelease)

	if("${WIN32}")

		##############################################################
		set(optOffTemp "/FS /MD /Zi /Od /Ob0 /DNDEBUG")
		set(CMAKE_ASM_FLAGS_RELEASE "${optOffTemp}" CACHE STRING "sml_ASM_FLAGS_RELEASE" FORCE)
		set(CMAKE_ASM_MASM_FLAGS_RELEASE "${optOffTemp}" CACHE STRING "sml_ASM_MASM_FLAGS_RELEASE" FORCE)
		set(CMAKE_CXX_FLAGS_RELEASE "${optOffTemp}" CACHE STRING "sml_CXX_FLAGS_RELEASE" FORCE)
		set(CMAKE_C_FLAGS_RELEASE "${optOffTemp}" CACHE STRING "sml_C_FLAGS_RELEASE" FORCE)


		set(linkOptTemp "/debug /INCREMENTAL:NO")
		set(CMAKE_EXE_LINKER_FLAGS_RELEASE "${linkOptTemp}" CACHE STRING "sml_EXE_LINKER_FLAGS_RELEASE" FORCE)
		set(CMAKE_MODULE_LINKER_FLAGS_RELEASE "${linkOptTemp}" CACHE STRING "sml_MODULE_LINKER_FLAGS_RELEASE" FORCE)
		set(CMAKE_SHARED_LINKER_FLAGS_RELEASE "${linkOptTemp}" CACHE STRING "sml_SHARED_LINKER_FLAGS_RELEASE" FORCE)


		##############################################################
		set(CMAKE_ASM_FLAGS_RELWITHDEBINFO "${optOffTemp}" CACHE STRING "sml_ASM_FLAGS_RELWITHDEBINFO" FORCE)
		set(CMAKE_ASM_MASM_FLAGS_RELWITHDEBINFO "${optOffTemp}" CACHE STRING "sml_ASM_MASM_FLAGS_RELWITHDEBINFO" FORCE)
		set(CMAKE_CXX_FLAGS_RELWITHDEBINFO "${optOffTemp}" CACHE STRING "sml_CXX_FLAGS_RELWITHDEBINFO" FORCE)
		set(CMAKE_C_FLAGS_RELWITHDEBINFO "${optOffTemp}" CACHE STRING "sml_C_FLAGS_RELWITHDEBINFO" FORCE)

	endif()

endfunction()



##############################################################
# helper function to extract file names
function(smlGetFilePart iList oFilesPart)
	set(oFilesPartTemp "")
	foreach(ii IN LISTS "${iList}")
		set(fileTemp "")
		get_filename_component(fileTemp "${ii}" NAME)
		list(APPEND oFilesPartTemp "${fileTemp}")
	endforeach()
	set("${oFilesPart}" "${oFilesPartTemp}" PARENT_SCOPE)
endfunction()


# to add 3rd party libs by hand versus find_package
function(smlAdd3rdLibByHand iRootDir iIncDir iLibDir iLibPattern iTarget)

	# "${xxx}"
	set(oIncDirs "")
	smlCollectRootRelativeFiles("${iRootDir}" "." "${iIncDir}" oIncDirs)
	target_include_directories("${iTarget}" PRIVATE "${oIncDirs}")
	
	set(oLibDirs "")
	smlCollectRootRelativeFiles("${iRootDir}" "." "${iLibDir}" oLibDirs)
	target_link_directories("${iTarget}" PRIVATE "${oLibDirs}")

	set(oFullPathFiles "")
	smlCollectRootRelativeFiles("${iRootDir}" "${iLibDir}" "${iLibPattern}" oFullPathFiles)

	set(oLibFiles "")
	smlGetFilePart(oFullPathFiles oLibFiles)


	target_link_libraries("${iTarget}" PRIVATE "${oLibFiles}")

endfunction()


# function(smlAddBoostByHand iBoostRootDir iTarget)
# 	smlAdd3rdLibByHand("${iBoostRootDir}" "include" "lib" "boost_*-vc140-mt.lib" "${iTarget}")
# endfunction()
