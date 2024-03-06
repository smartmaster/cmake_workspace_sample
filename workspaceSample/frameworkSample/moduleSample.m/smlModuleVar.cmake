

set(smlPrjectNameVar "cmake_sample")

#EXE or DLL, and will never support other types of target
set(smlTargetTypeVar "EXE")


set(thisModDir "${CMAKE_CURRENT_LIST_DIR}")
set(thisFxDir "${thisModDir}/..")
set(thisWsDir "${thisFxDir}/..")


set(smlModuleVar 
"${thisModDir}"
"${thisFxDir}/moduleAgain.m"
)


set(smlFramworksVar
"${thisFxDir}"
"${thisWsDir}/frameworkAgain"
)


set(smlPrjectDefsVar 
"EXPORTED_BY_MODULE_${smlPrjectNameVar}"
"UNICODE"
"_UNICODE"
)


set(smlExtraIncVar 
""
)


set(smlExtraLibDirVar 
""
)


set(smlExtraLibVar 
""
)