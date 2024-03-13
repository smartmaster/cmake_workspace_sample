######################
# "${}"
# "${xxx}"

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
				list(APPEND oTempFiles "${temp}")
			endforeach()
		endforeach()
	endforeach()
	set(${oFiles} "${oTempFiles}" PARENT_SCOPE)
endfunction()


#collect module source and header files
function(smlCollectModuleFiles iModDirs oSrcFiles oHeaderFiles)
	set(srcSubDir 
		"."
		"src"
		"src_gen"
		"SrcGenerated"
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


	set(headerSubDir 
		"."
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

	set(headerPattern 
		"*.h"
		"*.hxx"
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


function(smlCollectModuleIncDis iModDirs oModIncs)
	set(headerSubDir 
		"."
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
	set(oTempDirs "")
	smlCollectRootRelativeFiles("${iModDirs}" "." "${headerSubDir}" oTempDirs)
	set("${oModIncs}" "${oTempDirs}" PARENT_SCOPE)
endfunction()

function(smlCollectFxIncDis iFxDirs oFxIncs)
	set(headerSubDir 
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
	set(oTempDirs "")
	smlCollectRootRelativeFiles("${iFxDirs}" "." "${headerSubDir}" oTempDirs)
	set("${oFxIncs}" "${oTempDirs}" PARENT_SCOPE)
endfunction()