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

set(CMAKE_INCLUDE_CURRENT_DIR ON)
# Instruct CMake to run moc automatically when needed.
set(CMAKE_AUTOMOC ON)

# Find the QtWidgets     library
find_package(Qt5Widgets)

message("CMAKE_PREFIX_PATH is ${CMAKE_PREFIX_PATH}")

include_directories( ${ZLIB_INCLUDE_DIRS} )


SET(CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR})
include(QtAndroid)

add_custom_android_files(${CMAKE_SOURCE_DIR}/android)

add_executable(TestCMake main.cpp)
target_link_libraries( TestCMake ${ZLIB_LIBRARIES} ${EGL_LIBRARIES} ${ANDROID_LIBRARIES} ${OPENSLES_LIBRARIES} ${OPENGL_LIBRARIES} Qt5::Widgets )

set_android_application_binary(TestCMake)

add_library(TestCMake1 SHARED main.cpp)
target_link_libraries( TestCMake1 ${ZLIB_LIBRARIES} ${EGL_LIBRARIES} ${ANDROID_LIBRARIES} ${OPENSLES_LIBRARIES} ${OPENGL_LIBRARIES} Qt5::Widgets )

add_library(TestCMake2 SHARED main.cpp)
target_link_libraries( TestCMake2 ${ZLIB_LIBRARIES} ${EGL_LIBRARIES} ${ANDROID_LIBRARIES} ${OPENSLES_LIBRARIES} ${OPENGL_LIBRARIES} Qt5::Widgets )

add_android_application_library(TestCMake1)
add_android_application_library(TestCMake2)
