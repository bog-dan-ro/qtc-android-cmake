#!/bin/bash

export ANDROID_SDK_ROOT=~/necessitas/android-sdk
export ANDROID_NDK_ROOT=~/necessitas/android-ndk

rm -fr build
mkdir build
cd build
/usr/local/cmake/bin/cmake -DCMAKE_PREFIX_PATH=~/work/qt/qt5-android/qtbase/ -DCMAKE_TOOLCHAIN_FILE=../android/androidtoolchain.cmake "-GCodeBlocks - Unix Makefiles" ..
VERBOSE=1 make
cd ..
