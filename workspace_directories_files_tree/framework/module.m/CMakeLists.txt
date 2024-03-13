

cmake_minimum_required(VERSION 3.20)


include(${CMAKE_CURRENT_LIST_DIR}/../../smlWorkspaceVar.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/../smlFrameworkVar.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/smlModuleVar.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/CollectFiles.cmake)

set(smlPrjectName ${smlPrjectNameVar})
project(${smlPrjectName})


set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)



smlCollectModuleFiles("${smlModuleVar}" SrcFiles HeaderFiles)
smlCollectModuleIncDis("${smlModuleVar}" ModIncs)
smlCollectFxIncDis("${smlFramworksVar}" FxIncs)



if(${smlDebugOn})
	message("DDDDDDDDDDDDDDDDDDDDD PROJECT_BINARY_DIR        ${PROJECT_BINARY_DIR}")
	message("DDDDDDDDDDDDDDDDDDDDD PROJECT_SOURCE_DIR        ${PROJECT_SOURCE_DIR}")
	message("DDDDDDDDDDDDDDDDDDDDD CMAKE_CURRENT_BINARY_DIR  ${CMAKE_CURRENT_BINARY_DIR}")
	message("DDDDDDDDDDDDDDDDDDDDD CMAKE_CURRENT_SOURCE_DIR  ${CMAKE_CURRENT_SOURCE_DIR}")
	message("DDDDDDDDDDDDDDDDDDDDD CMAKE_CURRENT_LIST_DIR    ${CMAKE_CURRENT_LIST_DIR}")
	smlPrintLists("CCCCCCCCCCCCCCCCCCCC:\t" "${SrcFiles}")
	smlPrintLists("HHHHHHHHHHHHHHHHHHHH:\t" "${HeaderFiles}")
	smlPrintLists("IIIIIIIIIIIIIIIIIIII:\t" "${ModIncs}")
	smlPrintLists("iiiiiiiiiiiiiiiiiiii:\t" "${FxIncs}")
endif()

add_executable(${smlPrjectName} "${SrcFiles}" "${HeaderFiles}")

target_include_directories(${smlPrjectName} PRIVATE "${ModIncs}" "${FxIncs}")


set(smlPrjectDefs ${smlPrjectDefsVar})
target_compile_definitions(${smlPrjectName} PRIVATE "${smlPrjectDefs}")

install(TARGETS ${smlPrjectName} DESTINATION bin)

