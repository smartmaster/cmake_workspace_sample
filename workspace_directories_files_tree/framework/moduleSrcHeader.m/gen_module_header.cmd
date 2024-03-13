
setlocal

set prefix=module_test_

set header="#pragma once"
set func="static void foo(){}"

for /d %%u IN (*) do (
(echo #pragma once) > "%%u/%prefix%%%u.h"
rem (echo #pragma once) > "%%u/%prefix%%%u.hxx"
(echo #include "iostream") > "%%u/%prefix%%%u.cpp"
rem (echo #include "iostream") > "%%u/%prefix%%%u.cxx"
rem (echo #include "iostream") > "%%u/%prefix%%%u.c"
rem (echo #include "iostream") > "%%u/%prefix%%%u.cc"
)

endlocal