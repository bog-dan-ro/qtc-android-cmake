cmake_minimum_required(VERSION 3.0)

project(TestCMake)

find_package( ZLIB REQUIRED )
find_library( EGL_LIBRARIES EGL )
find_library( ANDROID_LIBRARIES android )
find_library( OPENSLES_LIBRARIES OpenSLES )
find_library( OPENGL_LIBRARIES GLESv3 )
if (NOT OPENGL_LIBRARIES)
    add_definitions(-DOPENGLES2)
    find_library( OPENGL_LIBRARIES GLESv2 )
endif()

include_directories( ${ZLIB_INCLUDE_DIRS} )

add_library(TestCMake SHARED main.cpp)

target_link_libraries( TestCMake ${ZLIB_LIBRARIES} ${EGL_LIBRARIES} ${ANDROID_LIBRARIES} ${OPENSLES_LIBRARIES} ${OPENGL_LIBRARIES} )
# zlib, egl, android, etc. libs goes after CMAKE_MODULE_LINKER_FLAGS_XXXXX, which is very wrong because is one of these libs depends on any library set by CMAKE_MODULE_LINKER_FLAGS_XXXXX the link will fail.
