

##### "${xxxxxx}" "${xxxxxx}" "${xxxxxx}" "${xxxxxx}"

#####################################################################
# C++ standard version
set(sml_CXX_STANDARD_var 17)

#####################################################################
#target name
set(smlPrjectNameVar "cmake_sample")

#EXE or DLL, and will never support other types of target
set(smlTargetTypeVar "EXE")

#####################################################################
# preprocessor definations
set(smlPrjectDefsVar 
"EXPORTED_BY_MODULE_${smlPrjectNameVar}"
"UNICODE"
"_UNICODE"
)


#####################################################################
# helper directory names for easily remember
set(thisModDir "${CMAKE_CURRENT_LIST_DIR}")
set(thisFxDir "${thisModDir}/..")
set(thisWsDir "${thisFxDir}/..")

#####################################################################
# will collect source and header files 
# as well as collect include directories
set(smlModuleVar 
"${thisModDir}"
"${thisFxDir}/moduleAgain.m"
)

# will collect include directories only
set(smlFramworksVar
"${thisFxDir}"
"${thisWsDir}/frameworkAgain"
)


#####################################################################
set(the3rdPartyRootDir "D:/sss-git-repo/vcpkg/installed/x64-windows")
set(the3rdPartyIncDir "include")
set(the3rdPartyLibDir "lib")
set(the3rdPartyLibPatterns 
	"boost_*-vc*-mt.lib"
	"gmp*.lib"
	"mpfr*.lib"
	"tommath.lib"
)