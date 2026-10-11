# Cross-compile for 32-bit x86 Linux with zig - the reconstruction as a
# 32-bit (ILP32), little-endian program, which is what a microcontroller
# host such as the ESP32-S3 is (docs/host-tdeck-pro.md); it runs on any
# x86-64 Linux that has the 32-bit C library, WSL 2's Ubuntu among them:
#   cmake -G Ninja -S src -B <dir> -DCMAKE_TOOLCHAIN_FILE=src/cmake/zig-x86-linux.cmake
#         -DCMAKE_BUILD_TYPE=MinSizeRel
#         -DNEWTON_HOST_NEWTONSCRIPT=<a newtonscript built for the build machine>
#   cmake --build <dir> --target newton
#   <dir>/host/newton --objects <a build's romsrc-objects.bin> ...
# The object file is the same on every host, so the build machine's own
# (build/host/romsrc-objects.bin) serves.  Configured on x86-64 Linux the
# build runs its own programs - newtonscript for the object file, and the
# tests: tools/host/wsl32.sh builds and tests it under WSL 2
# (docs/host-lp64.md, "The 32-bit build under WSL").
set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_SYSTEM_PROCESSOR i386)
if(NOT DEFINED ZIG_GLIBC)
    set(ZIG_GLIBC 2.31)
endif()
set(ZIG_TARGET x86-linux-gnu.${ZIG_GLIBC})
if(CMAKE_HOST_SYSTEM_NAME STREQUAL "Linux" AND CMAKE_HOST_SYSTEM_PROCESSOR MATCHES "^(x86_64|amd64|i.86)$")
    set(NEWTON_TARGET_RUNS_HERE ON)
endif()
include(${CMAKE_CURRENT_LIST_DIR}/zig-toolchain.cmake)
set(CMAKE_C_FLAGS_INIT "-fsigned-char")
set(CMAKE_CXX_FLAGS_INIT "-fsigned-char")
# zig places a 32-bit program at 0x10000, where every function's address
# falls below 0x02000000 and is taken for a ROM jump-table address
# (frames/NativeFunctions.h's kROMCodeLimit) - every host native then "not
# reconstructed"; the traditional base keeps them above it
set(CMAKE_EXE_LINKER_FLAGS_INIT "-Wl,--image-base=0x08000000")
# programs and libraries of the build machine's, never the target's
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
