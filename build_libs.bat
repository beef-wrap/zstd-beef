clang -c -g -gcodeview -o zstd-windows.lib -target x86_64-pc-windows -fuse-ld=llvm-lib -Wall zstd\zstd.c

mkdir libs
move zstd-windows.lib libs
