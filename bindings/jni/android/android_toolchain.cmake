################################################################################
#  THIS FILE IS 100% GENERATED BY ZPROJECT; DO NOT EDIT EXCEPT EXPERIMENTALLY  #
#  Read the zproject/README.md for information about making permanent changes. #
################################################################################
#   CMake toolchain script
#
#   Targets Android 8, ARM
#   Called from build.sh via cmake

set (CMAKE_SYSTEM_NAME Linux)  # Tell CMake we're cross-compiling
set (ANDROID True)
set (BUILD_ANDROID True)

include (CMakeForceCompiler)
include (FindPkgConfig)

# where is the target environment
set (ANDROID_NDK_ROOT $ENV{ANDROID_NDK_ROOT})
set (ANDROID_SYS_ROOT $ENV{ANDROID_SYS_ROOT})
set (ANDROID_API_LEVEL $ENV{ANDROID_API_LEVEL})
set (TOOLCHAIN_PATH $ENV{TOOLCHAIN_PATH})
set (TOOLCHAIN_HOST $ENV{TOOLCHAIN_HOST})
set (TOOLCHAIN_ARCH $ENV{TOOLCHAIN_ARCH})

# api level see doc https://github.com/taka-no-me/android-cmake
set (CMAKE_INSTALL_PREFIX /tmp)
set (CMAKE_FIND_ROOT_PATH
    "${TOOLCHAIN_PATH}"
    "${CMAKE_INSTALL_PREFIX}"
    "${CMAKE_INSTALL_PREFIX}/share")

# Prefix detection only works with compiler id "GNU"
# CMake will look for prefixed g++, cpp, ld, etc. automatically
CMAKE_FORCE_C_COMPILER (${TOOLCHAIN_PATH}/arm-linux-androideabi-gcc GNU)

#   Find location of zmq.h file
pkg_check_modules (PC_LIBZMQ "libzmq")
if (NOT PC_LIBZMQ_FOUND)
    pkg_check_modules(PC_LIBZMQ "zmq")
endif (NOT PC_LIBZMQ_FOUND)

if (PC_LIBZMQ_FOUND)
    set (PC_LIBZMQ_INCLUDE_HINTS ${PC_LIBZMQ_INCLUDE_DIRS} ${PC_LIBZMQ_INCLUDE_DIRS}/*)
endif (PC_LIBZMQ_FOUND)

find_path (
    LIBZMQ_INCLUDE_DIR
    NAMES zmq.h
    HINTS ${PC_LIBZMQ_INCLUDE_HINTS}
)

cmake_policy (SET CMP0015 NEW)   #  Use relative paths in link_directories

include_directories (
    ${LIBZMQ_INCLUDE_DIR}
    ../../../include
    ../../../bindings/jni/src/native/include
    ../../../builds/android/prefix/arm-linux-androideabi-4.9/include
    ${ANDROID_SYS_ROOT}/usr/include
)
link_directories (
    ../../../builds/android/prefix/arm-linux-androideabi-4.9/lib
    ${ANDROID_SYS_ROOT}/usr/lib
)
