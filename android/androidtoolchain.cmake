set(CMAKE_SYSTEM_NAME Android)

set(ANDROID_SDK_ROOT $ENV{ANDROID_SDK_ROOT})
if (NOT ANDROID_SDK_ROOT)
  set(ANDROID_SDK_ROOT ~/android/sdk)
endif()

set(ANDROID_NDK_ROOT $ENV{ANDROID_NDK_ROOT})
if (NOT ANDROID_NDK_ROOT)
  set(ANDROID_NDK_ROOT ~/android/ndk)
endif()

set(ANDROID_NDK_TOOLCHAIN_PREFIX $ENV{ANDROID_NDK_TOOLCHAIN_PREFIX})
if (NOT ANDROID_NDK_TOOLCHAIN_PREFIX)
  set(ANDROID_NDK_TOOLCHAIN_PREFIX arm-linux-androideabi)
endif()

set(ANDROID_NDK_TOOLCHAIN_VERSION $ENV{ANDROID_NDK_TOOLCHAIN_VERSION})
if (NOT ANDROID_NDK_TOOLCHAIN_VERSION)
  set(ANDROID_NDK_TOOLCHAIN_VERSION 4.8)
endif()

set(ANDROID_NDK_HOST $ENV{ANDROID_NDK_HOST})
if (NOT ANDROID_NDK_HOST)
  set(ANDROID_NDK_HOST linux-x86_64)
endif()

set(ANDROID_NDK_TOOLS_PREFIX $ENV{ANDROID_NDK_TOOLS_PREFIX})
if (NOT ANDROID_NDK_TOOLS_PREFIX)
  set(ANDROID_NDK_TOOLS_PREFIX arm-linux-androideabi)
endif()

set(ANDROID_NDK_PLATFORM $ENV{ANDROID_NDK_PLATFORM})
if (NOT ANDROID_NDK_PLATFORM)
  set(ANDROID_NDK_PLATFORM android-9)
endif()

set(ANDROID_TARGET_ARCH $ENV{ANDROID_TARGET_ARCH})
if (NOT ANDROID_TARGET_ARCH)
  set(ANDROID_TARGET_ARCH armeabi-v7a)
endif()


if (ANDROID_TARGET_ARCH STREQUAL armeabi-v7a OR ANDROID_TARGET_ARCH STREQUAL armeabi)
  set(ANDROID_SYSROOT_ARCH arch-arm)
else()
  set(ANDROID_SYSROOT_ARCH arch-${ANDROID_TARGET_ARCH})
endif()

set(CMAKE_SYSROOT "${ANDROID_NDK_ROOT}/platforms/${ANDROID_NDK_PLATFORM}/${ANDROID_SYSROOT_ARCH}")

include_directories(SYSTEM
  ${ANDROID_NDK_ROOT}/sources/cxx-stl/gnu-libstdc++/${ANDROID_NDK_TOOLCHAIN_VERSION}/include
  ${ANDROID_NDK_ROOT}/sources/cxx-stl/gnu-libstdc++/${ANDROID_NDK_TOOLCHAIN_VERSION}/libs/${ANDROID_TARGET_ARCH}/include)


set(CMAKE_C_COMPILER "${ANDROID_NDK_ROOT}/toolchains/${ANDROID_NDK_TOOLCHAIN_PREFIX}-${ANDROID_NDK_TOOLCHAIN_VERSION}/prebuilt/${ANDROID_NDK_HOST}/bin/${ANDROID_NDK_TOOLS_PREFIX}-gcc")
set(CMAKE_CXX_COMPILER "${ANDROID_NDK_ROOT}/toolchains/${ANDROID_NDK_TOOLCHAIN_PREFIX}-${ANDROID_NDK_TOOLCHAIN_VERSION}/prebuilt/${ANDROID_NDK_HOST}/bin/${ANDROID_NDK_TOOLS_PREFIX}-g++")

set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE BOTH)

if (ANDROID_TARGET_ARCH STREQUAL armeabi-v7a OR ANDROID_TARGET_ARCH STREQUAL armeabi)
  execute_process(COMMAND "${CMAKE_C_COMPILER}" -mthumb -print-libgcc-file-name OUTPUT_VARIABLE LIBGCC OUTPUT_STRIP_TRAILING_WHITESPACE)
else()
  execute_process(COMMAND "${CMAKE_C_COMPILER}" -print-libgcc-file-name OUTPUT_VARIABLE LIBGCC OUTPUT_STRIP_TRAILING_WHITESPACE)
endif()

set(CMAKE_MODULE_LINKER_FLAGS_INIT "-Wl,--no-undefined -Wl,-z,noexecstack -shared -L${ANDROID_NDK_ROOT}/sources/cxx-stl/gnu-libstdc++/${ANDROID_NDK_TOOLCHAIN_VERSION}/libs/${ANDROID_TARGET_ARCH} -lgnustl_shared -lm -lc ${LIBGCC}")
set(CMAKE_MODULE_LINKER_FLAGS_DEBUG_INIT "-Wl,--no-undefined -Wl,-z,noexecstack -shared -L${ANDROID_NDK_ROOT}/sources/cxx-stl/gnu-libstdc++/${ANDROID_NDK_TOOLCHAIN_VERSION}/libs/${ANDROID_TARGET_ARCH} -lgnustl_shared -lm -lc ${LIBGCC}")
set(CMAKE_MODULE_LINKER_FLAGS_RELEASE_INIT "-Wl,--no-undefined -Wl,-z,noexecstack -shared -L${ANDROID_NDK_ROOT}/sources/cxx-stl/gnu-libstdc++/${ANDROID_NDK_TOOLCHAIN_VERSION}/libs/${ANDROID_TARGET_ARCH} -lgnustl_shared -lm -lc ${LIBGCC}")

set(CMAKE_SHARED_LINKER_FLAGS_INIT "-Wl,--no-undefined -Wl,-z,noexecstack -shared -L${ANDROID_NDK_ROOT}/sources/cxx-stl/gnu-libstdc++/${ANDROID_NDK_TOOLCHAIN_VERSION}/libs/${ANDROID_TARGET_ARCH} -lgnustl_shared -lm -lc ${LIBGCC}")
set(CMAKE_SHARED_LINKER_FLAGS_DEBUG_INIT "-Wl,--no-undefined -Wl,-z,noexecstack -shared -L${ANDROID_NDK_ROOT}/sources/cxx-stl/gnu-libstdc++/${ANDROID_NDK_TOOLCHAIN_VERSION}/libs/${ANDROID_TARGET_ARCH} -lgnustl_shared -lm -lc ${LIBGCC}")
set(CMAKE_SHARED_LINKER_FLAGS_RELEASE_INIT "-Wl,--no-undefined -Wl,-z,noexecstack -shared -L${ANDROID_NDK_ROOT}/sources/cxx-stl/gnu-libstdc++/${ANDROID_NDK_TOOLCHAIN_VERSION}/libs/${ANDROID_TARGET_ARCH} -lgnustl_shared -lm -lc ${LIBGCC}")

set(CMAKE_EXE_LINKER_FLAGS_INIT "-Wl,--no-undefined -Wl,-z,noexecstack -shared -L${ANDROID_NDK_ROOT}/sources/cxx-stl/gnu-libstdc++/${ANDROID_NDK_TOOLCHAIN_VERSION}/libs/${ANDROID_TARGET_ARCH} -lgnustl_shared -lm -lc ${LIBGCC}")
set(CMAKE_EXE_LINKER_FLAGS_INIT "-Wl,--no-undefined -Wl,-z,noexecstack -shared -L${ANDROID_NDK_ROOT}/sources/cxx-stl/gnu-libstdc++/${ANDROID_NDK_TOOLCHAIN_VERSION}/libs/${ANDROID_TARGET_ARCH} -lgnustl_shared -lm -lc ${LIBGCC}")
set(CMAKE_EXE_LINKER_FLAGS_INIT "-Wl,--no-undefined -Wl,-z,noexecstack -shared -L${ANDROID_NDK_ROOT}/sources/cxx-stl/gnu-libstdc++/${ANDROID_NDK_TOOLCHAIN_VERSION}/libs/${ANDROID_TARGET_ARCH} -lgnustl_shared -lm -lc ${LIBGCC}")

if (ANDROID_TARGET_ARCH STREQUAL armeabi-v7a)
  set(CMAKE_C_FLAGS "-Wno-psabi -march=armv7-a -mfloat-abi=softfp -mfpu=vfp -ffunction-sections -funwind-tables -fstack-protector -fno-short-enums -DANDROID -Wa,--noexecstack" CACHE STRING "Qt on Android" FORCE)
  set(CMAKE_CXX_FLAGS "${CMAKE_C_FLAGS} -std=gnu++0x" CACHE STRING "Qt on Android" FORCE)
  set(CMAKE_CXX_FLAGS_RELEASE "-mthumb -Os -fomit-frame-pointer -fno-strict-aliasing -finline-limit=64" CACHE STRING "Qt on Android" FORCE)
  set(CMAKE_CXX_FLAGS_DEBUG "-g -gdwarf-2 -marm -O0 -fno-omit-frame-pointer" CACHE STRING "Qt on Android" FORCE)
elseif(ANDROID_TARGET_ARCH STREQUAL armeabi)
  set(CMAKE_C_FLAGS "-Wno-psabi -march=armv5te -mtune=xscale -msoft-float   -ffunction-sections -funwind-tables -fstack-protector -fno-short-enums -DANDROID -Wa,--noexecstack" CACHE STRING "Qt on Android" FORCE)
  set(CMAKE_CXX_FLAGS "${CMAKE_C_FLAGS} -std=gnu++0x" CACHE STRING "Qt on Android" FORCE)
  set(CMAKE_CXX_FLAGS_RELEASE "-mthumb -Os -fomit-frame-pointer -fno-strict-aliasing -finline-limit=64" CACHE STRING "Qt on Android" FORCE)
  set(CMAKE_CXX_FLAGS_DEBUG "-g -gdwarf-2 -marm -O0 -fno-omit-frame-pointer" CACHE STRING "Qt on Android" FORCE)
elseif(ANDROID_TARGET_ARCH STREQUAL x86)
  set(CMAKE_C_FLAGS "-ffunction-sections -funwind-tables -O2 -fomit-frame-pointer -fstrict-aliasing -funswitch-loops -finline-limit=300 -DANDROID -Wa,--noexecstack" CACHE STRING "Qt on Android" FORCE)
  set(CMAKE_CXX_FLAGS "${CMAKE_C_FLAGS} -std=gnu++0x" CACHE STRING "Qt on Android" FORCE)
  set(CMAKE_CXX_FLAGS_RELEASE "-O2" CACHE STRING "Qt on Android" FORCE)
  set(CMAKE_CXX_FLAGS_DEBUG "-g -gdwarf-2" CACHE STRING "Qt on Android" FORCE)
elseif(ANDROID_TARGET_ARCH STREQUAL mips)
  set(CMAKE_C_FLAGS "-fno-strict-aliasing -finline-functions -ffunction-sections -funwind-tables -fmessage-length=0 -fno-inline-functions-called-once -fgcse-after-reload -frerun-cse-after-loop -frename-registers -O2 -fomit-frame-pointer -funswitch-loops -finline-limit=300 -DANDROID -Wa,--noexecstack" CACHE STRING "Qt on Android" FORCE)
  set(CMAKE_CXX_FLAGS "${CMAKE_C_FLAGS} -std=gnu++0x" CACHE STRING "Qt on Android" FORCE)
  set(CMAKE_CXX_FLAGS_RELEASE "-mthumb -Os -fomit-frame-pointer -fno-strict-aliasing -finline-limit=64" CACHE STRING "Qt on Android" FORCE)
  set(CMAKE_CXX_FLAGS_DEBUG "-g -gdwarf-2" CACHE STRING "Qt on Android" FORCE)
endif()

set(CMAKE_ANDROID_BUILD_FOLDER ${PROJECT_BINARY_DIR}/android-build)
set(CMAKE_ANDROID_NATIVE_LIBS_FOLDER ${CMAKE_ANDROID_BUILD_FOLDER}/libs/${ANDROID_TARGET_ARCH})
