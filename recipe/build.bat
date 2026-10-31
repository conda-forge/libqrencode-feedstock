@echo on

cmake -G Ninja %CMAKE_ARGS% ^
    -DCMAKE_BUILD_TYPE=Release ^
    -DCMAKE_INSTALL_PREFIX="%LIBRARY_PREFIX%" ^
    -DCMAKE_PREFIX_PATH="%LIBRARY_PREFIX%" ^
    -DBUILD_SHARED_LIBS=ON ^
    -DWITH_TOOLS=ON ^
    -S . -B build
if errorlevel 1 exit 1

cmake --build build
if errorlevel 1 exit 1

cmake --install build
if errorlevel 1 exit 1

:: Upstream installs the library target to lib\, but the DLL has to be next to
:: qrencode.exe in bin\ to be found at runtime.
move "%LIBRARY_PREFIX%\lib\qrencode.dll" "%LIBRARY_PREFIX%\bin\"
if errorlevel 1 exit 1
