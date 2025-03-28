mkdir libs
mkdir libs\debug
mkdir libs\release
cd zstd\build\cmake
cmake -DZSTD_BUILD_STATIC:BOOL=ON .
cmake --build .
copy lib\Debug\zstd_static.lib ..\..\..\libs\debug
copy lib\Debug\zstd_static.pdb ..\..\..\libs\debug
cmake --build . --config Release
copy lib\Release\zstd_static.lib ..\..\..\libs\release