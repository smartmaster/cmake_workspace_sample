
set prefix=framework_1_
for /d %%u IN (*) do (
(echo #pragma once) > "%%u/%prefix%%%u.h"
rem (echo #pragma once) > "%%u/%prefix%%%u.hxx"
)
