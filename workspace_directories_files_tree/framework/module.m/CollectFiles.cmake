######################
# "${}"
# "${xxx}"


#print list items with prefix message
function(smlPrintLists iPrefix iList)
	foreach(ii IN LISTS iList)
		message("${iPrefix} ${ii}")
	endforeach()
endfunction()

#basic function to collect files in dirs
function(smlCollectFiles iDirs iPatters oFiles)
	foreach(dd IN LISTS iDirs)
		foreach(pp IN LISTS iPatters)
			file(GLOB temp "${dd}/${pp}")
			list(APPEND tempList "${temp}")
		endforeach()
	endforeach()
	set(${oFiles} "${tempList}" PARENT_SCOPE)
endfunction()


#basic function to collect into the next level of sub dirs
function(smlCollectSubDirFiles iDirs iSubDirs iPatters oFiles)
	foreach(dd IN LISTS iDirs)
		foreach(ss IN LISTS iSubDirs)
			list(APPEND dirs "${dd}/${ss}")
		endforeach()
	endforeach()
	smlCollectFiles("${dirs}" "${iPatters}" oTempFiles)
	set(${oFiles} "${oTempFiles}" PARENT_SCOPE)
endfunction()

#combine parent and sub dirs
function(smlCombineSubDir iDirs iSubDirs oDirs)
	foreach(dd IN LISTS iDirs)
		foreach(ss IN LISTS iSubDirs)
			list(APPEND dirs "${dd}/${ss}")
		endforeach()
	endforeach()
	set(${oDirs} "${dirs}" PARENT_SCOPE)
endfunction()


#collect module source and header files
function(smlCollectModuleFiles iModDirs oSrcFiles oHeaderFiles)
	set(srcSubDir 
	"src"
	"src_gen"
	"SrcGenterated"
	)

	set(srcPattern 
	"*.cpp"
	"*.cxx"
	"*.c"
	"*.cc"
	"*.asm"
	)

	smlCollectSubDirFiles("${iModDirs}" "${srcSubDir}" "${srcPattern}" oTempFiles)
	set("${oSrcFiles}" "${oTempFiles}" PARENT_SCOPE)


	set(headerSubDir 
	"local_inc"
	"local_gen"
	"LocalInterfaces"
	"LocalGenterated"
	"private_inc"
	"private_gen"
	"PrivateInterfaces"
	"PrivateGenterated"
	"protetced_inc"
	"protetced_gen"
	"ProtetcedInterfaces"
	"ProtetcedGenterated"
	"public_inc"
	"public_gen"
	"PublicInterfaces"
	"PublicGenterated"
	)

	set(headerPattern 
	"*.h"
	"*.hxx"
	"*.inc"
	)
	smlCollectSubDirFiles("${iModDirs}" "${headerSubDir}" "${headerPattern}" oTempHFiles)
	set("${oHeaderFiles}" "${oTempHFiles}" PARENT_SCOPE)

endfunction()


function(smlCollectModuleIncDis iModDirs oModIncs)
	set(headerSubDir 
	"local_inc"
	"local_gen"
	"LocalInterfaces"
	"LocalGenterated"
	"private_inc"
	"private_gen"
	"PrivateInterfaces"
	"PrivateGenterated"
	"protetced_inc"
	"protetced_gen"
	"ProtetcedInterfaces"
	"ProtetcedGenterated"
	"public_inc"
	"public_gen"
	"PublicInterfaces"
	"PublicGenterated"
	)
	smlCombineSubDir("${iModDirs}" "${headerSubDir}" oTempDirs)
	set("${oModIncs}" "${oTempDirs}" PARENT_SCOPE)
endfunction()

function(smlCollectFxIncDis iFxDirs oFxIncs)
	set(headerSubDir 
	"private_inc"
	"private_gen"
	"PrivateInterfaces"
	"PrivateGenterated"
	"protetced_inc"
	"protetced_gen"
	"ProtetcedInterfaces"
	"ProtetcedGenterated"
	"public_inc"
	"public_gen"
	"PublicInterfaces"
	"PublicGenterated"
	)
	smlCombineSubDir("${iFxDirs}" "${headerSubDir}" oTempDirs)
	set("${oFxIncs}" "${oTempDirs}" PARENT_SCOPE)
endfunction()