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

## Copy the android templates from qt install folder
## This line it should be in qt cmake files
execute_process(COMMAND ${CMAKE_COMMAND} -E copy_directory ${_qt5Core_install_prefix}/src/android/java ${CMAKE_ANDROID_BUILD_FOLDER})

## Sets android files
## This function it should be in qt cmake files
function(add_custom_android_files dir)
    file(WRITE ${CMAKE_CURRENT_BINARY_DIR}/QtAndroid_Custom_AndroidFiles.cmake "SET(ANDROID_CUSTOM_SOURCES \"${dir}\")\n")
endfunction()

## Sets the android qt main application binary
function(set_android_application_binary _target_NAME)
#it seems I'm to stupid how to use $<TARGET_FILE:_target_NAME> thing or the damn thing doesn't work
    cmake_policy(PUSH)
    cmake_policy(SET CMP0026 OLD)
    get_target_property(_var ${_target_NAME} LOCATION)
    cmake_policy(POP)
    file(WRITE ${CMAKE_CURRENT_BINARY_DIR}/QtAndroid_Application_Binary.cmake "set(CMAKE_ANDROID_APPLICATION_BINARY \"${_var}\")\n")
endfunction()

## Sets the android qt main application binary
function(add_android_application_library _target_NAME)
#it seems I'm to stupid how to use $<TARGET_FILE:_target_NAME> thing or the damn thing doesn't work
    cmake_policy(PUSH)
    cmake_policy(SET CMP0026 OLD)
    get_target_property(_var ${_target_NAME} LOCATION)
    cmake_policy(POP)
    file(APPEND ${CMAKE_CURRENT_BINARY_DIR}/QtAndroid_Application_Libraries.cmake "set(CMAKE_ANDROID_APPLICATION_LIBRARIES \${CMAKE_ANDROID_APPLICATION_LIBRARIES} \"${_var}\")\n")
endfunction()

#############################################################################################################################################
#############################################################################################################################################

configure_file(QtAndroid_BuildAPK.cmake.in ${CMAKE_CURRENT_BINARY_DIR}/QtAndroid_BuildAPK.cmake @ONLY)
add_custom_target(build_apk COMMAND ${CMAKE_COMMAND} -P ${CMAKE_CURRENT_BINARY_DIR}/QtAndroid_BuildAPK.cmake)

macro(add_program _targetName _sources)
 add_library(${_targetName} SHARED ${_sources})
endmacro()
