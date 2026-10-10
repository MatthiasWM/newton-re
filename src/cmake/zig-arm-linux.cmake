# Cross-compile for 32-bit ARM Linux with zig (musl, static) - what the
# reconstruction comes to as 32-bit code (docs/host-tdeck-pro.md measures a
# device build's size with it; tools/host/codesize.py reads the result):
#   cmake -G Ninja -S src -B <dir> -DCMAKE_TOOLCHAIN_FILE=src/cmake/zig-arm-linux.cmake
#         -DCMAKE_BUILD_TYPE=MinSizeRel
#         -DNEWTON_HOST_NEWTONSCRIPT=<a newtonscript built for the build machine>
#   cmake --build <dir> --target newton
# ARM code, not Thumb: a Thumb function pointer has bit 0 set, and the
# reconstruction keeps host function pointers where the ROM keeps code
# addresses, whose low bits are clear (src/CMakeLists.txt,
# -falign-functions=4).  Nothing here has run on an ARM board.
set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_SYSTEM_PROCESSOR arm)
set(ZIG_TARGET arm-linux-musleabihf)
include(${CMAKE_CURRENT_LIST_DIR}/zig-toolchain.cmake)
# char is unsigned on ARM Linux and signed on every host the reconstruction
# was written on (docs/host-remarkable.md, "char")
set(CMAKE_C_FLAGS_INIT "-fsigned-char -marm")
set(CMAKE_CXX_FLAGS_INIT "-fsigned-char -marm")
# (above 0x02000000 - frames/NativeFunctions.h's kROMCodeLimit - as
# zig-x86-linux.cmake says why; and stripped, the size being the point)
set(CMAKE_EXE_LINKER_FLAGS_INIT "-static -Wl,--image-base=0x08000000")
set(CMAKE_EXE_LINKER_FLAGS_MINSIZEREL_INIT "-s")
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
