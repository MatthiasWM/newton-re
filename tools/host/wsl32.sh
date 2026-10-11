#!/bin/bash
# wsl32.sh - build and test the 32-bit x86 Linux flavour of the
# reconstruction (src/cmake/zig-x86-linux.cmake: ILP32, the layout of the
# ESP32-S3 host, docs/host-tdeck-pro.md) under WSL 2 or any x86-64 Linux
# with the 32-bit C library (/usr/lib32, Ubuntu's libc6-i386).
#
#   tools/host/wsl32.sh [step...] [-- ctest options...]
#   e.g. from Windows:  wsl -e bash tools/host/wsl32.sh
#                       wsl -e bash tools/host/wsl32.sh test -- -R sound
#
# Steps (default: all of them, in this order):
#   tools      zig (ZIG_VERSION below, its tarball's SHA-256 checked) into
#              tmp/wsl-zig, cmake and ninja (pip) into tmp/wsl-pip
#   sync       the checkout (less .git, build/ and tmp/) to $W/tree, on
#              WSL's own file system - /mnt/f is case insensitive and slow
#   configure  $W/build with the zig-x86-linux toolchain, if not done yet
#   build      ninja
#   test       ctest; its whole output in $W/ctest.log, the summary printed
#
# Run from anywhere: the repository is the one this script is in.  The
# environment can say:
#   NEWTON_WSL32_DIR  the work directory $W (default ~/newton-x86)
#   NEWTON_ROM_BUILD  the ROM extraction (default build/MP2x00US of the main
#                     checkout - a worktree has none of its own); without
#                     one the tests that read the image are not registered
#   CMAKE_BUILD_TYPE  (default empty, as build/host is)
#   JOBS              ctest's parallelism (default the processor count)
#
# Configured on Linux the build is a cross build that runs its own programs
# (NEWTON_TARGET_RUNS_HERE, set by the toolchain file), so newtonscript
# builds the object file and ctest runs every test as on any other host.
set -e

ZIG_VERSION=0.16.0
ZIG_SHA256=70e49664a74374b48b51e6f3fdfbf437f6395d42509050588bd49abe52ba3d00
ZIG_NAME=zig-x86_64-linux-$ZIG_VERSION

REPO=$(cd "$(dirname "$0")/../.." && pwd)
W=${NEWTON_WSL32_DIR:-$HOME/newton-x86}
if [ -z "$NEWTON_ROM_BUILD" ]; then
	NEWTON_ROM_BUILD=$REPO/build/MP2x00US
	# a worktree's .git file names its git directory, a Windows path when
	# Windows' git made it; that directory's commondir leads to the checkout's
	if [ ! -f "$NEWTON_ROM_BUILD/rom.bin" ] && [ -f "$REPO/.git" ]; then
		gitdir=$(sed -n 's/^gitdir: //p' "$REPO/.git" | tr -d '\r')
		case $gitdir in [A-Za-z]:*) gitdir=$(wslpath -u "$gitdir") ;; esac
		common=$(cd "$gitdir" && cd "$(cat commondir 2>/dev/null || echo .)" && pwd)
		NEWTON_ROM_BUILD=$(dirname "$common")/build/MP2x00US
	fi
fi

export PATH=$REPO/tmp/wsl-zig/$ZIG_NAME:$REPO/tmp/wsl-pip/cmake/data/bin:$REPO/tmp/wsl-pip/bin:$PATH

steps=()
while [ $# -gt 0 ]; do
	[ "$1" = -- ] && { shift; break; }
	steps+=("$1")
	shift
done
[ ${#steps[@]} -gt 0 ] || steps=(tools sync configure build test)

step_tools() {
	if [ ! -x "$REPO/tmp/wsl-zig/$ZIG_NAME/zig" ]; then
		mkdir -p "$REPO/tmp/wsl-zig"
		tarball=$REPO/tmp/wsl-zig/$ZIG_NAME.tar.xz
		[ -f "$tarball" ] || curl -sSfL -o "$tarball" "https://ziglang.org/download/$ZIG_VERSION/$ZIG_NAME.tar.xz"
		echo "$ZIG_SHA256  $tarball" | sha256sum -c -
		tar -xJf "$tarball" -C "$REPO/tmp/wsl-zig"
		rm "$tarball"
	fi
	if [ ! -x "$REPO/tmp/wsl-pip/bin/ninja" ] || [ ! -x "$REPO/tmp/wsl-pip/cmake/data/bin/cmake" ]; then
		python3 -m pip install --target "$REPO/tmp/wsl-pip" cmake ninja
		chmod +x "$REPO"/tmp/wsl-pip/bin/* "$REPO"/tmp/wsl-pip/cmake/data/bin/* "$REPO"/tmp/wsl-pip/ninja/data/bin/* 2>/dev/null || true
	fi
	echo "zig $(zig version), $(cmake --version | head -1), ninja $(ninja --version)"
}

step_sync() {
	mkdir -p "$W/tree"
	rsync -a --delete --exclude /.git --exclude /build --exclude /tmp "$REPO/" "$W/tree/"
}

step_configure() {
	[ -f "$W/build/build.ninja" ] && return
	cmake -G Ninja -S "$W/tree/src" -B "$W/build" \
		-DCMAKE_TOOLCHAIN_FILE="$W/tree/src/cmake/zig-x86-linux.cmake" \
		-DCMAKE_BUILD_TYPE="$CMAKE_BUILD_TYPE" \
		-DNEWTON_ROM_BUILD="$NEWTON_ROM_BUILD" > "$W/configure.log"
	tail -1 "$W/configure.log"
}

step_build() {
	ninja -C "$W/build" > "$W/build.log" 2>&1 || { tail -30 "$W/build.log"; exit 1; }
	tail -1 "$W/build.log"
}

step_test() {
	cd "$W/build"
	set +e
	ctest -j"${JOBS:-$(nproc)}" --timeout 900 "$@" > "$W/ctest.log" 2>&1
	status=$?
	set -e
	grep -E "tests passed|\((Failed|Timeout|SEGFAULT|Subprocess|Not Run|Exception)" "$W/ctest.log" || true
	return $status
}

for s in "${steps[@]}"; do
	case $s in
	tools|sync|configure|build) "step_$s" ;;
	test) step_test "$@" ;;
	*) echo "wsl32.sh: no step '$s' (tools sync configure build test)" >&2; exit 2 ;;
	esac
done
