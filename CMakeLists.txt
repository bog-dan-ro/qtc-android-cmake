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



#############################################################################################################################################
#############################################################################################################################################

## these lines should go to Qt5CoreConfigExtras.cmake next to moc, rcc, etc.
if (NOT TARGET Qt5::androiddeployqt)
    add_executable(Qt5::androiddeployqt IMPORTED)

    set(imported_location "${_qt5Core_install_prefix}/bin/androiddeployqt")
    _qt5_Core_check_file_exists(${imported_location})

    set_target_properties(Qt5::androiddeployqt PROPERTIES
        IMPORTED_LOCATION ${imported_location}
    )
    # For CMake automoc feature
    get_target_property(QT_ANDROIDDEPLOYQT_EXECUTABLE Qt5::androiddeployqt LOCATION)
endif()
## these lines should go to Qt5CoreConfigExtras.cmake next to moc, rcc, etc.

## Fill android-deployment-settings.json with qt folder
## This line it should be in qt cmake files
file(APPEND ${CMAKE_ANDROID_BUILD_FOLDER}/android-deployment-settings.json "  \"qt\" : \"${_qt5Core_install_prefix}\",\n")

## Copy the android templates from qt install folder
## This line it should be in qt cmake files
execute_process(COMMAND ${CMAKE_COMMAND} -E copy_directory ${_qt5Core_install_prefix}/src/android/java ${CMAKE_ANDROID_BUILD_FOLDER})

## Copy users android files
## This function it should be in qt cmake files
function(add_custom_android_files dir)
    execute_process(COMMAND ${CMAKE_COMMAND} -E copy_directory ${dir} ${CMAKE_ANDROID_BUILD_FOLDER})
endfunction()

## Sets the android qt main application binnary
function(set_android_application_binary application)
    file(APPEND ${CMAKE_ANDROID_BUILD_FOLDER}/android-deployment-settings.json "  \"application-binary\" : \"${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/lib${application}.so\"\n}\n")
endfunction()

#############################################################################################################################################
#############################################################################################################################################


add_custom_android_files(${CMAKE_SOURCE_DIR}/android)

function (saySomething)
    message("LOCATION IS : ${QT_ANDROIDDEPLOYQT_EXECUTABLE}")
endfunction()

message(" ######### ${MAIN_BIN_FILE}")

#add_custom_command(OUTPUT ${CMAKE_ANDROID_BUILD_FOLDER}/bin/Qt-${CMAKE_BUILD_TYPE}.apk COMMAND ${QT_ANDROIDDEPLOYQT_EXECUTABLE} --help WORKING_DIRECTORY ${CMAKE_ANDROID_BUILD_FOLDER})
add_custom_target(run_androiddeployqt COMMAND ${QT_ANDROIDDEPLOYQT_EXECUTABLE} --output ${CMAKE_ANDROID_BUILD_FOLDER} --input ${CMAKE_ANDROID_BUILD_FOLDER}/android-deployment-settings.json --deployment ministro WORKING_DIRECTORY ${CMAKE_ANDROID_BUILD_FOLDER})
add_custom_target(build_apk COMMAND ${CMAKE_ANDROID_BUILD_FOLDER}/gradlew --help DEPENDS run_androiddeployqt WORKING_DIRECTORY ${CMAKE_ANDROID_BUILD_FOLDER})

add_library(TestCMake SHARED main.cpp)
#add_executable(TestCMake main.cpp)

set_android_application_binary(TestCMake)

# zlib, egl, android, etc. libs goes after CMAKE_MODULE_LINKER_FLAGS_XXXXX, which is very wrong because is one of these libs depends on any library set by CMAKE_MODULE_LINKER_FLAGS_XXXXX the link will fail.
target_link_libraries( TestCMake ${ZLIB_LIBRARIES} ${EGL_LIBRARIES} ${ANDROID_LIBRARIES} ${OPENSLES_LIBRARIES} ${OPENGL_LIBRARIES} Qt5::Widgets )
#target_link_libraries( CevaTestCMake ${ZLIB_LIBRARIES} ${EGL_LIBRARIES} ${ANDROID_LIBRARIES} ${OPENSLES_LIBRARIES} ${OPENGL_LIBRARIES} Qt5::Widgets )
